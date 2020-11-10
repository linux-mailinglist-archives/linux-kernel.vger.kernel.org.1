Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278972ADCCB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgKJRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:21:25 -0500
Received: from foss.arm.com ([217.140.110.172]:58886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbgKJRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:21:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8361396;
        Tue, 10 Nov 2020 09:21:23 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B5A13F7BB;
        Tue, 10 Nov 2020 09:21:22 -0800 (PST)
Date:   Tue, 10 Nov 2020 17:21:20 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Mailing Lists <mailing-lists@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v2 2/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 descriptors extensions
Message-ID: <20201110172120.GF42652@e120937-lin>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
 <20201026201007.23591-3-cristian.marussi@arm.com>
 <d4c3fe2f-831b-da04-792d-18650471cd60@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4c3fe2f-831b-da04-792d-18650471cd60@mailbox.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 05:00:05PM +0100, Mailing Lists wrote:
> On 26.10.20 21:10, Cristian Marussi wrote:
> > Add support for new SCMIv3.0 Sensors extensions related to new sensors'
> > features, like multiple axis and update intervals, while keeping
> > compatibility with SCMIv2.0 features.
> > While at that, refactor and simplify all the internal helpers macros and
> > move struct scmi_sensor_info to use only non-fixed-size typing.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v1 --> v2
> > - restrict segmented intervals descriptors to single triplet
> > - add proper usage of scmi_reset_rx_to_maxsz
> > ---
> >  drivers/firmware/arm_scmi/sensors.c | 391 ++++++++++++++++++++++++++--
> >  include/linux/scmi_protocol.h       | 219 +++++++++++++++-
> >  2 files changed, 584 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> > index 6aaff478d032..5a18f8c84bef 100644
> > --- a/drivers/firmware/arm_scmi/sensors.c
> > +++ b/drivers/firmware/arm_scmi/sensors.c
> > @@ -7,16 +7,21 @@
> >  
> >  #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/scmi_protocol.h>
> >  
> >  #include "common.h"
> >  #include "notify.h"
> >  
> > +#define SCMI_MAX_NUM_SENSOR_AXIS	64
> 
> IMHO the related 6 bit wide fields, like SENSOR_DESCRIPTION_GET "Number
> of axes", should determine the maximum value, so 64 -> 63.
> 

Yes, bits [21:16] 'Number of Axes' in sensor_attributes_high, but this
#define was meant to represent the maximum number of sensor axis (64...ranging
from 0 to 63) not the highest possible numbered (63).

> [...]
> 
> > +
> > +/**
> > + * struct scmi_sensor_info - represents information related to one of the
> > + * available sensors.
> > + * @id: Sensor ID.
> > + * @type: Sensor type. Chosen amongst one of @enum scmi_sensor_class.
> > + * @scale: Power-of-10 multiplier applied to the sensor unit.
> > + * @num_trip_points: Number of maximum configurable trip points.
> > + * @async: Flag for asynchronous read support.
> > + * @update: Flag for continuouos update notification support.
> > + * @timestamped: Flag for timestamped read support.
> > + * @tstamp_scale: Power-of-10 multiplier applied to the sensor timestamps to
> > + *		  represent it in seconds.
> > + * @num_axis: Number of supported axis if any. Reported as 0 for scalar sensors.
> > + * @axis: Pointer to an array of @num_axis descriptors.
> > + * @intervals: Descriptor of available update intervals.
> > + * @sensor_config: A bitmask reporting the current sensor configuration as
> > + *		   detailed in the SCMI specification: it can accessed and
> > + *		   modified through the accompanying macros.
> > + * @name: NULL-terminated string representing sensor name as advertised by
> > + *	  SCMI platform.
> > + * @extended_scalar_attrs: Flag to indicate the presence of additional extended
> > + *			   attributes for this sensor.
> > + * @sensor_power: Extended attribute representing the average power
> > + *		  consumed by the sensor in microwatts (uW) when it is active.
> > + *		  Reported here only for scalar sensors.
> 
> Above line should go to @resolution below.
> 

Ah, right.

Regards

Cristian

> Best regards,
> 
> Peter
> 
> > + *		  Set to 0 if not reported by this sensor.
> > + * @resolution: Extended attribute representing the resolution of the sensor.
> > + *		Set to 0 if not reported by this sensor.
> > + * @exponent: Extended attribute representing the power-of-10 multiplier that is
> > + *	      applied to the resolution field.
> > + *	      Reported here only for scalar sensors.
> > + *	      Set to 0 if not reported by this sensor.
> > + * @scalar_attrs: Extended attributes representing minimum and maximum
> > + *		  measurable values by this sensor.
> > + *		  Reported here only for scalar sensors.
> > + *		  Set to 0 if not reported by this sensor.
> > + */
> >  struct scmi_sensor_info {
> > -	u32 id;
> > -	u8 type;
> > -	s8 scale;
> > -	u8 num_trip_points;
> > +	unsigned int id;
> > +	unsigned int type;
> > +	int scale;
> > +	unsigned int num_trip_points;
> >  	bool async;
> > +	bool update;
> > +	bool timestamped;
> > +	int tstamp_scale;
> > +	unsigned int num_axis;
> > +	struct scmi_sensor_axis_info *axis;
> > +	struct scmi_sensor_intervals_info intervals;
> >  	char name[SCMI_MAX_STR_SIZE];
> > +	bool extended_scalar_attrs;
> > +	unsigned int sensor_power;
> > +	unsigned int resolution;
> > +	int exponent;
> > +	struct scmi_range_attrs scalar_attrs;
> >  };
