Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E82ADB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbgKJQA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729909AbgKJQA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:00:27 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:00:26 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4CVsyS1T6FzQlWd;
        Tue, 10 Nov 2020 17:00:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id
        :references:subject:subject:from:from:received; s=mail20150812;
         t=1605024008; bh=N9PX16ya4Ghdpo2W5cE71DhxszYEMLR/BL+nYIjj0kU=; b=
        eWMrw5EOao5pG7dsIVT2QZ0+CfGgP6Q3TqqL6ubuN7/zdy83eC9La/jcfii55k+U
        zkEtG9zqzvtzwa2u0xwRrcJi0GaOQLipt28jJ5R5Ypt/zYnpmTaw2cgGNzAzwXvi
        x+DtysIhnJTneNgr6Emb+xfDLf+Xe0CwRyMKQrLfklnhUzpHzW9Dz8CvY9SqGLxy
        DeonQCXJLyBLUaldSd+pTf4i6hcm5M0xCVcG/zpd+VdWrDtJl221bjxietnYUrIe
        7kiF9kxb1agmIFszXGSu84QGnrAN0aDQC91leQikNVKYISngzTAM+amK2L6xNNFl
        mK/RMRkkTj0dbwiBgW1++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1605024014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7RnMHz+jP7JD1JkLTSgDWCwpbu8DgchFA05sk2+IWY8=;
        b=DS37aFyvdPT1LAHQd+gVOdEk35oF0GalIOkAZG5Q/LTpKAWcIaWPYK+JzTjw/oFi3IyhrR
        8M+qyoVKLcl/VwqxCFxvaEl2pDTcY07a2i2u0ra0/e4GE7eV8OVIqu0RWYV51BLJHL5cvG
        dZHLegDWpcdvK75g5VbPsPDxsy00Z2rjPMWLsLDmbkJT0ggUy3oo/Ir3qtAvZvXuif4tFO
        5+qCZzLTpEUGA310Nqz3O833KSkmZcHGWbWCYaosAxukxr4F+YfrQbC7r/qImoXc1qnmXj
        Te2e7O2SOjOIHZViEPNYqima0XFzl2s2+dQybDMO47qOIJcjP1HDXWR3fJXzkw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id PJJGG1Nfw3S2; Tue, 10 Nov 2020 17:00:08 +0100 (CET)
From:   Mailing Lists <mailing-lists@mailbox.org>
Subject: Re: [PATCH v2 2/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 descriptors extensions
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
References: <20201026201007.23591-1-cristian.marussi@arm.com>
 <20201026201007.23591-3-cristian.marussi@arm.com>
Message-ID: <d4c3fe2f-831b-da04-792d-18650471cd60@mailbox.org>
Date:   Tue, 10 Nov 2020 17:00:05 +0100
MIME-Version: 1.0
In-Reply-To: <20201026201007.23591-3-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.86 / 15.00 / 15.00
X-Rspamd-Queue-Id: 80826108B
X-Rspamd-UID: 30686e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.20 21:10, Cristian Marussi wrote:
> Add support for new SCMIv3.0 Sensors extensions related to new sensors'
> features, like multiple axis and update intervals, while keeping
> compatibility with SCMIv2.0 features.
> While at that, refactor and simplify all the internal helpers macros and
> move struct scmi_sensor_info to use only non-fixed-size typing.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v1 --> v2
> - restrict segmented intervals descriptors to single triplet
> - add proper usage of scmi_reset_rx_to_maxsz
> ---
>  drivers/firmware/arm_scmi/sensors.c | 391 ++++++++++++++++++++++++++--
>  include/linux/scmi_protocol.h       | 219 +++++++++++++++-
>  2 files changed, 584 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 6aaff478d032..5a18f8c84bef 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -7,16 +7,21 @@
>  
>  #define pr_fmt(fmt) "SCMI Notifications SENSOR - " fmt
>  
> +#include <linux/bitfield.h>
>  #include <linux/scmi_protocol.h>
>  
>  #include "common.h"
>  #include "notify.h"
>  
> +#define SCMI_MAX_NUM_SENSOR_AXIS	64

IMHO the related 6 bit wide fields, like SENSOR_DESCRIPTION_GET "Number
of axes", should determine the maximum value, so 64 -> 63.

[...]

> +
> +/**
> + * struct scmi_sensor_info - represents information related to one of the
> + * available sensors.
> + * @id: Sensor ID.
> + * @type: Sensor type. Chosen amongst one of @enum scmi_sensor_class.
> + * @scale: Power-of-10 multiplier applied to the sensor unit.
> + * @num_trip_points: Number of maximum configurable trip points.
> + * @async: Flag for asynchronous read support.
> + * @update: Flag for continuouos update notification support.
> + * @timestamped: Flag for timestamped read support.
> + * @tstamp_scale: Power-of-10 multiplier applied to the sensor timestamps to
> + *		  represent it in seconds.
> + * @num_axis: Number of supported axis if any. Reported as 0 for scalar sensors.
> + * @axis: Pointer to an array of @num_axis descriptors.
> + * @intervals: Descriptor of available update intervals.
> + * @sensor_config: A bitmask reporting the current sensor configuration as
> + *		   detailed in the SCMI specification: it can accessed and
> + *		   modified through the accompanying macros.
> + * @name: NULL-terminated string representing sensor name as advertised by
> + *	  SCMI platform.
> + * @extended_scalar_attrs: Flag to indicate the presence of additional extended
> + *			   attributes for this sensor.
> + * @sensor_power: Extended attribute representing the average power
> + *		  consumed by the sensor in microwatts (uW) when it is active.
> + *		  Reported here only for scalar sensors.

Above line should go to @resolution below.

Best regards,

Peter

> + *		  Set to 0 if not reported by this sensor.
> + * @resolution: Extended attribute representing the resolution of the sensor.
> + *		Set to 0 if not reported by this sensor.
> + * @exponent: Extended attribute representing the power-of-10 multiplier that is
> + *	      applied to the resolution field.
> + *	      Reported here only for scalar sensors.
> + *	      Set to 0 if not reported by this sensor.
> + * @scalar_attrs: Extended attributes representing minimum and maximum
> + *		  measurable values by this sensor.
> + *		  Reported here only for scalar sensors.
> + *		  Set to 0 if not reported by this sensor.
> + */
>  struct scmi_sensor_info {
> -	u32 id;
> -	u8 type;
> -	s8 scale;
> -	u8 num_trip_points;
> +	unsigned int id;
> +	unsigned int type;
> +	int scale;
> +	unsigned int num_trip_points;
>  	bool async;
> +	bool update;
> +	bool timestamped;
> +	int tstamp_scale;
> +	unsigned int num_axis;
> +	struct scmi_sensor_axis_info *axis;
> +	struct scmi_sensor_intervals_info intervals;
>  	char name[SCMI_MAX_STR_SIZE];
> +	bool extended_scalar_attrs;
> +	unsigned int sensor_power;
> +	unsigned int resolution;
> +	int exponent;
> +	struct scmi_range_attrs scalar_attrs;
>  };
