Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD362ADCA1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgKJRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:09:27 -0500
Received: from foss.arm.com ([217.140.110.172]:58784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgKJRJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:09:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36A6C1396;
        Tue, 10 Nov 2020 09:09:26 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B095F3F7BB;
        Tue, 10 Nov 2020 09:09:24 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:09:22 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mikhail.golubev@opensynergy.com, Igor.Skalkin@opensynergy.com,
        jbhayana@google.com, sudeep.holla@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, lukasz.luba@arm.com
Subject: Re: [PATCH v2 6/6] firmware: arm_scmi: add SCMIv3.0 Sensor
 notifications
Message-ID: <20201110170922.GE42652@e120937-lin>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
 <20201026201007.23591-7-cristian.marussi@arm.com>
 <8f8e171e-03eb-f818-48e5-f542d1ab9061@opensynergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8e171e-03eb-f818-48e5-f542d1ab9061@opensynergy.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 05:01:57PM +0100, Peter Hilber wrote:
> On 26.10.20 21:10, Cristian Marussi wrote:
> > Add support for new SCMIv3.0 SENSOR_UPDATE notification.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  drivers/firmware/arm_scmi/sensors.c | 124 ++++++++++++++++++++++++----
> >  include/linux/scmi_protocol.h       |   9 ++
> >  2 files changed, 116 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> > index 372a3592e99b..51921e279c9f 100644
> > --- a/drivers/firmware/arm_scmi/sensors.c
> > +++ b/drivers/firmware/arm_scmi/sensors.c
> > @@ -24,6 +24,7 @@ enum scmi_sensor_protocol_cmd {
> >  	SENSOR_LIST_UPDATE_INTERVALS = 0x8,
> >  	SENSOR_CONFIG_GET = 0x9,
> >  	SENSOR_CONFIG_SET = 0xA,
> > +	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
> >  };
> >  
> >  struct scmi_msg_resp_sensor_attributes {
> > @@ -133,10 +134,10 @@ struct scmi_msg_resp_sensor_list_update_intervals {
> >  	__le32 intervals[];
> >  };
> >  
> > -struct scmi_msg_sensor_trip_point_notify {
> > +struct scmi_msg_sensor_request_notify {
> >  	__le32 id;
> >  	__le32 event_control;
> > -#define SENSOR_TP_NOTIFY_ALL	BIT(0)
> > +#define SENSOR_NOTIFY_ALL	BIT(0)
> >  };
> >  
> >  struct scmi_msg_set_sensor_trip_point {
> > @@ -198,6 +199,17 @@ struct scmi_sensor_trip_notify_payld {
> >  	__le32 trip_point_desc;
> >  };
> >  
> > +struct scmi_msg_sensor_continuous_update_notify {
> > +	__le32 id;
> > +	__le32 event_control;
> > +};
> 
> This struct appears unused and redundant to struct
> scmi_msg_sensor_request_notify.
> 

Seems so, I'll remove.

> [...]
> 
> > @@ -850,20 +892,58 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
> >  					    const void *payld, size_t payld_sz,
> >  					    void *report, u32 *src_id)
> >  {
> > +	void *rep = NULL;
> >  	const struct scmi_sensor_trip_notify_payld *p = payld;
> >  	struct scmi_sensor_trip_point_report *r = report;
> 
> Above two variables should be moved into the first case block.
> 
Yes, not sure why they ended up there.

Regards

Cristian

> Best regards,
> 
> Peter
> 
> >  
> > -	if (evt_id != SCMI_EVENT_SENSOR_TRIP_POINT_EVENT ||
> > -	    sizeof(*p) != payld_sz)
> > -		return NULL;
> > +	switch (evt_id) {
> > +	case SCMI_EVENT_SENSOR_TRIP_POINT_EVENT:
> > +	{
> > +		if (sizeof(*p) != payld_sz)
> > +			break;
> >  
> > -	r->timestamp = timestamp;
> > -	r->agent_id = le32_to_cpu(p->agent_id);
> > -	r->sensor_id = le32_to_cpu(p->sensor_id);
> > -	r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
> > -	*src_id = r->sensor_id;
> > +		r->timestamp = timestamp;
> > +		r->agent_id = le32_to_cpu(p->agent_id);
> > +		r->sensor_id = le32_to_cpu(p->sensor_id);
> > +		r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
> > +		*src_id = r->sensor_id;
> > +		rep = r;
> > +		break;
> > +	}
> > +	case SCMI_EVENT_SENSOR_UPDATE:
> > +	{
> > +		int i;
> > +		struct scmi_sensor_info *s;
> > +		const struct scmi_sensor_update_notify_payld *p = payld;
> > +		struct scmi_sensor_update_report *r = report;
> > +		struct sensors_info *sinfo = handle->sensor_priv;
> > +
> > +		/* payld_sz is variable for this event */
> > +		r->sensor_id = le32_to_cpu(p->sensor_id);
> > +		if (r->sensor_id >= sinfo->num_sensors)
> > +			break;
> > +		r->timestamp = timestamp;
> > +		r->agent_id = le32_to_cpu(p->agent_id);
> > +		s = &sinfo->sensors[r->sensor_id];
> > +		/*
> > +		 * The generated report r (@struct scmi_sensor_update_report)
> > +		 * was pre-allocated to contain up to SCMI_MAX_NUM_SENSOR_AXIS
> > +		 * readings: here it is filled with the effective @num_axis
> > +		 * readings defined for this sensor or 1 for scalar sensors.
> > +		 */
> > +		r->readings_count = s->num_axis ?: 1;
> > +		for (i = 0; i < r->readings_count; i++)
> > +			scmi_parse_sensor_readings(&r->readings[i],
> > +						   &p->readings[i]);
> > +		*src_id = r->sensor_id;
> > +		rep = r;
> > +		break;
> > +	}
> > +	default:
> > +		break;
> > +	}
> >  
> > -	return r;
> > +	return rep;
> >  }
> 
