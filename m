Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535622ADC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgKJREe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:04:34 -0500
Received: from foss.arm.com ([217.140.110.172]:58696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJREd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:04:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 221A01396;
        Tue, 10 Nov 2020 09:04:33 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986CD3F7BB;
        Tue, 10 Nov 2020 09:04:31 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:04:29 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v2 4/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 timestamped reads
Message-ID: <20201110170429.GD42652@e120937-lin>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
 <20201026201007.23591-5-cristian.marussi@arm.com>
 <69e5ba10-47a5-ca14-103a-03e94f410618@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69e5ba10-47a5-ca14-103a-03e94f410618@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

thanks for the review.

On Tue, Nov 10, 2020 at 05:01:26PM +0100, Peter Hilber wrote:
> On 26.10.20 21:10, Cristian Marussi wrote:
> > Add new .reading_get_timestamped() method to sensor_ops to support SCMIv3.0
> > timestamped reads.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/sensors.c | 134 ++++++++++++++++++++++++++--
> >  include/linux/scmi_protocol.h       |  22 +++++
> >  2 files changed, 151 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> > index 5a18f8c84bef..bdb0ed0df683 100644
> > --- a/drivers/firmware/arm_scmi/sensors.c
> > +++ b/drivers/firmware/arm_scmi/sensors.c
> > @@ -156,6 +156,27 @@ struct scmi_msg_sensor_reading_get {
> >  #define SENSOR_READ_ASYNC	BIT(0)
> >  };
> >  
> > +struct scmi_resp_sensor_reading_get {
> > +	__le64 readings;
> > +};
> > +
> > +struct scmi_resp_sensor_reading_complete {
> > +	__le32 id;
> > +	__le64 readings;
> > +};
> 
> In my understanding the id field is not present in the spec. The
> implementation seems to have introduced it already before this patch.
> 

Well, it is indeed defined in 4.7.3.1 "SENSOR_READING_COMPLETE" both in
SCMI V3.0 and in V2.0: it is the async delayed response and this 'id'
represents the sensor_id: in fact it is used only the in the async path
in the reading funcs; the sync version uses directly sensor_reading_le.
(which has no id n it)

> > +
> > +struct scmi_sensor_reading_le {
> > +	__le32 sensor_value_low;
> > +	__le32 sensor_value_high;
> > +	__le32 timestamp_low;
> > +	__le32 timestamp_high;
> > +};
> > +
> > +struct scmi_resp_sensor_reading_complete_v3 {
> > +	__le32 id;
> > +	struct scmi_sensor_reading_le readings[];
> > +};
> 
> As above, IMHO the id field is not present in the spec.
> 

As said above it is for the delayed_responses, in this case for V3
messages.

> > +
> >  struct scmi_sensor_trip_notify_payld {
> >  	__le32 agent_id;
> >  	__le32 sensor_id;
> > @@ -576,6 +597,21 @@ scmi_sensor_trip_point_config(const struct scmi_handle *handle, u32 sensor_id,
> >  	return ret;
> >  }
> >  
> > +/**
> > + * scmi_sensor_reading_get  - Read scalar sensor value
> > + * @handle: Platform handle
> > + * @sensor_id: Sensor ID
> > + * @value: The 64bit value sensor reading
> > + *
> > + * This function returns a single 64 bit reading value representing the sensor
> > + * value; if the platform SCMI Protocol implementation and the sensor support
> > + * multiple axis and timestamped-reads, this just returns the first axis while
> > + * dropping the timestamp value.
> > + * Use instead the @scmi_sensor_reading_get_timestamped to retrieve the array of
> > + * timestamped multi-axis values.
> > + *
> > + * Return: 0 on Success
> > + */
> >  static int scmi_sensor_reading_get(const struct scmi_handle *handle,
> >  				   u32 sensor_id, u64 *value)
> >  {
> > @@ -593,18 +629,105 @@ static int scmi_sensor_reading_get(const struct scmi_handle *handle,
> 
> How about changing the scmi_xfer_get_init() rx_size to 0 (in the
> immediately preceding, not shown lines)? An SCMI platform might not
> expect to just have room for the first reading, excluding the timestamp.
>

Ah right, because this is the old v2.0 interface which I kept unchanged but
now internally the same v3.0 SENSOR_READING_GET message on a v3.0 platform
could return multiple per-axis timestamped values even if I just return
the first u64 without timestamp. Is this that you mean ?
I'll fix to 0.

> >  
> >  	sensor = t->tx.buf;
> >  	sensor->id = cpu_to_le32(sensor_id);
> > +	if (s->async) {
> > +		sensor->flags = cpu_to_le32(SENSOR_READ_ASYNC);
> > +		ret = scmi_do_xfer_with_response(handle, t);
> > +		if (!ret) {
> > +			struct scmi_resp_sensor_reading_complete *resp;
> > +
> > +			resp = t->rx.buf;
> > +			if (le32_to_cpu(resp->id) == sensor_id)
> > +				*value = le64_to_cpu(resp->readings);
> 
> Maybe this le64_to_cpu() and the one a few lines below should be
> replaced by get_unaligned_le64()?

I'll check.
> 
> > +			else
> > +				ret = -EPROTO;
> > +		}
> > +	} else {
> > +		sensor->flags = cpu_to_le32(0);
> > +		ret = scmi_do_xfer(handle, t);
> > +		if (!ret) {
> > +			struct scmi_resp_sensor_reading_get *resp;
> > +
> > +			resp = t->rx.buf;
> > +			*value = le64_to_cpu(resp->readings);
> > +		}
> > +	}
> >  
> > +	scmi_xfer_put(handle, t);
> > +	return ret;
> > +}
> > +
> 
> [...]
> > +
> >  /**
> >   * scmi_range_attrs  - specifies a sensor or axis values' range
> >   * @min_range: The minimum value which can be represented by the sensor/axis.
> > @@ -387,6 +401,11 @@ enum scmi_sensor_class {
> >   * @info_get: get the information of the specified sensor
> >   * @trip_point_config: selects and configures a trip-point of interest
> >   * @reading_get: gets the current value of the sensor
> > + * @reading_get_timestamped: gets the current value and timestamp, when
> > + *			     available, of the sensor. (as of v2.1 spec)
> 
> Nitpicking: v2.1 -> v3.0
> 

Ok.

> > + *			     Supports multi-axis sensors for sensors which
> > + *			     supports it and if the @reading array size of
> > + *			     @count entry equals the sensor num_axis
> >   */
> >  struct scmi_sensor_ops {
> >  	int (*count_get)(const struct scmi_handle *handle);
> > @@ -396,6 +415,9 @@ struct scmi_sensor_ops {
> >  				 u32 sensor_id, u8 trip_id, u64 trip_value);
> >  	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
> >  			   u64 *value);
> > +	int (*reading_get_timestamped)(const struct scmi_handle *handle,
> > +				       u32 sensor_id, u8 count,
> > +				       struct scmi_sensor_reading *readings);
> >  };
> >  
> >  /**
> > 
> 
> Best regards,
> 
> Peter

Thanks

Cristian
