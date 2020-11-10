Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AF2ADB17
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgKJQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:02:06 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:53077 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730859AbgKJQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:02:05 -0500
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
        by plasma.jpberlin.de (Postfix) with ESMTP id 080C5AAF9B;
        Tue, 10 Nov 2020 17:02:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([91.198.250.140])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id VE4u6V1FvHwf; Tue, 10 Nov 2020 17:01:59 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 68595A90B5;
        Tue, 10 Nov 2020 17:01:59 +0100 (CET)
Subject: Re: [PATCH v2 6/6] firmware: arm_scmi: add SCMIv3.0 Sensor
 notifications
To:     Cristian Marussi <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mikhail.golubev@opensynergy.com>, <Igor.Skalkin@opensynergy.com>,
        <jbhayana@google.com>, <sudeep.holla@arm.com>,
        <peter.hilber@opensynergy.com>, <james.quinlan@broadcom.com>,
        <Jonathan.Cameron@Huawei.com>, <egranata@google.com>,
        <lukasz.luba@arm.com>
References: <20201026201007.23591-1-cristian.marussi@arm.com>
 <20201026201007.23591-7-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Autocrypt: addr=peter.hilber@opensynergy.com; prefer-encrypt=mutual; keydata=
 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
 lbekkuPTQs/m
Message-ID: <8f8e171e-03eb-f818-48e5-f542d1ab9061@opensynergy.com>
Date:   Tue, 10 Nov 2020 17:01:57 +0100
MIME-Version: 1.0
In-Reply-To: <20201026201007.23591-7-cristian.marussi@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.73 / 15.00 / 15.00
X-Rspamd-Queue-Id: 080C5AAF9B
X-Rspamd-UID: 248ee4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.10.20 21:10, Cristian Marussi wrote:
> Add support for new SCMIv3.0 SENSOR_UPDATE notification.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/sensors.c | 124 ++++++++++++++++++++++++----
>  include/linux/scmi_protocol.h       |   9 ++
>  2 files changed, 116 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 372a3592e99b..51921e279c9f 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -24,6 +24,7 @@ enum scmi_sensor_protocol_cmd {
>  	SENSOR_LIST_UPDATE_INTERVALS = 0x8,
>  	SENSOR_CONFIG_GET = 0x9,
>  	SENSOR_CONFIG_SET = 0xA,
> +	SENSOR_CONTINUOUS_UPDATE_NOTIFY = 0xB,
>  };
>  
>  struct scmi_msg_resp_sensor_attributes {
> @@ -133,10 +134,10 @@ struct scmi_msg_resp_sensor_list_update_intervals {
>  	__le32 intervals[];
>  };
>  
> -struct scmi_msg_sensor_trip_point_notify {
> +struct scmi_msg_sensor_request_notify {
>  	__le32 id;
>  	__le32 event_control;
> -#define SENSOR_TP_NOTIFY_ALL	BIT(0)
> +#define SENSOR_NOTIFY_ALL	BIT(0)
>  };
>  
>  struct scmi_msg_set_sensor_trip_point {
> @@ -198,6 +199,17 @@ struct scmi_sensor_trip_notify_payld {
>  	__le32 trip_point_desc;
>  };
>  
> +struct scmi_msg_sensor_continuous_update_notify {
> +	__le32 id;
> +	__le32 event_control;
> +};

This struct appears unused and redundant to struct
scmi_msg_sensor_request_notify.

[...]

> @@ -850,20 +892,58 @@ static void *scmi_sensor_fill_custom_report(const struct scmi_handle *handle,
>  					    const void *payld, size_t payld_sz,
>  					    void *report, u32 *src_id)
>  {
> +	void *rep = NULL;
>  	const struct scmi_sensor_trip_notify_payld *p = payld;
>  	struct scmi_sensor_trip_point_report *r = report;

Above two variables should be moved into the first case block.

Best regards,

Peter

>  
> -	if (evt_id != SCMI_EVENT_SENSOR_TRIP_POINT_EVENT ||
> -	    sizeof(*p) != payld_sz)
> -		return NULL;
> +	switch (evt_id) {
> +	case SCMI_EVENT_SENSOR_TRIP_POINT_EVENT:
> +	{
> +		if (sizeof(*p) != payld_sz)
> +			break;
>  
> -	r->timestamp = timestamp;
> -	r->agent_id = le32_to_cpu(p->agent_id);
> -	r->sensor_id = le32_to_cpu(p->sensor_id);
> -	r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
> -	*src_id = r->sensor_id;
> +		r->timestamp = timestamp;
> +		r->agent_id = le32_to_cpu(p->agent_id);
> +		r->sensor_id = le32_to_cpu(p->sensor_id);
> +		r->trip_point_desc = le32_to_cpu(p->trip_point_desc);
> +		*src_id = r->sensor_id;
> +		rep = r;
> +		break;
> +	}
> +	case SCMI_EVENT_SENSOR_UPDATE:
> +	{
> +		int i;
> +		struct scmi_sensor_info *s;
> +		const struct scmi_sensor_update_notify_payld *p = payld;
> +		struct scmi_sensor_update_report *r = report;
> +		struct sensors_info *sinfo = handle->sensor_priv;
> +
> +		/* payld_sz is variable for this event */
> +		r->sensor_id = le32_to_cpu(p->sensor_id);
> +		if (r->sensor_id >= sinfo->num_sensors)
> +			break;
> +		r->timestamp = timestamp;
> +		r->agent_id = le32_to_cpu(p->agent_id);
> +		s = &sinfo->sensors[r->sensor_id];
> +		/*
> +		 * The generated report r (@struct scmi_sensor_update_report)
> +		 * was pre-allocated to contain up to SCMI_MAX_NUM_SENSOR_AXIS
> +		 * readings: here it is filled with the effective @num_axis
> +		 * readings defined for this sensor or 1 for scalar sensors.
> +		 */
> +		r->readings_count = s->num_axis ?: 1;
> +		for (i = 0; i < r->readings_count; i++)
> +			scmi_parse_sensor_readings(&r->readings[i],
> +						   &p->readings[i]);
> +		*src_id = r->sensor_id;
> +		rep = r;
> +		break;
> +	}
> +	default:
> +		break;
> +	}
>  
> -	return r;
> +	return rep;
>  }

