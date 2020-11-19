Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D62B91FB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgKSMBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:01:55 -0500
Received: from foss.arm.com ([217.140.110.172]:54922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727026AbgKSMBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:01:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53EF1396;
        Thu, 19 Nov 2020 04:01:54 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AC033F718;
        Thu, 19 Nov 2020 04:01:52 -0800 (PST)
Date:   Thu, 19 Nov 2020 12:01:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v3 5/6] firmware: arm_scmi: add SCMIv3.0 Sensor
 configuration support
Message-ID: <20201119120150.kzerzz465ojgyunn@bogus>
References: <20201118162905.10439-1-cristian.marussi@arm.com>
 <20201118162905.10439-6-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118162905.10439-6-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:29:04PM +0000, Cristian Marussi wrote:
> Add SCMIv3.0 Sensor support for CONFIG_GET/CONFIG_SET commands.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/sensors.c | 75 +++++++++++++++++++++++++++++
>  include/linux/scmi_protocol.h       | 37 ++++++++++++++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 0adc545116a4..fa3385045361 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -22,6 +22,8 @@ enum scmi_sensor_protocol_cmd {
>  	SENSOR_READING_GET = 0x6,
>  	SENSOR_AXIS_DESCRIPTION_GET = 0x7,
>  	SENSOR_LIST_UPDATE_INTERVALS = 0x8,
> +	SENSOR_CONFIG_GET = 0x9,
> +	SENSOR_CONFIG_SET = 0xA,
>  };
>  
>  struct scmi_msg_resp_sensor_attributes {
> @@ -150,6 +152,19 @@ struct scmi_msg_set_sensor_trip_point {
>  	__le32 value_high;
>  };
>  
> +struct scmi_msg_sensor_config_get {
> +	__le32 id;
> +};
> +
> +struct scmi_resp_sensor_config_get {
> +	__le32 sensor_config;
> +};
> +

Same comment about single element structure as in previous patch.

-- 
Regards,
Sudeep
