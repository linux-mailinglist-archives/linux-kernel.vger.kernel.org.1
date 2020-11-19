Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4592B91C6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgKSLrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:47:35 -0500
Received: from foss.arm.com ([217.140.110.172]:54372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgKSLmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:42:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152051509;
        Thu, 19 Nov 2020 03:42:21 -0800 (PST)
Received: from bogus (unknown [10.57.54.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F7A73F718;
        Thu, 19 Nov 2020 03:42:18 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:42:16 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lukasz.luba@arm.com, Jonathan.Cameron@Huawei.com,
        egranata@google.com, jbhayana@google.com,
        peter.hilber@opensynergy.com, mikhail.golubev@opensynergy.com,
        Igor.Skalkin@opensynergy.com
Subject: Re: [PATCH v3 4/6] firmware: arm_scmi: add SCMIv3.0 Sensors
 timestamped reads
Message-ID: <20201119114216.qqprw2rydmi2wfop@bogus>
References: <20201118162905.10439-1-cristian.marussi@arm.com>
 <20201118162905.10439-5-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118162905.10439-5-cristian.marussi@arm.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:29:03PM +0000, Cristian Marussi wrote:
> Add new .reading_get_timestamped() method to sensor_ops to support SCMIv3.0
> timestamped reads.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> V2 --> v3
> - setting rx_size to 0 in sensor_reading_get to allow fw to send
>   both v2 and v3 replies...even if sensor_reading_get() only handles
>   v2 spec and returns one single value
> - using get_unaligned_le64 in lieu of le64_to_cpu
> - removed refs to v2.1
> ---
>  drivers/firmware/arm_scmi/sensors.c | 137 ++++++++++++++++++++++++++--
>  include/linux/scmi_protocol.h       |  22 +++++
>  2 files changed, 152 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
> index 1c83aaae0012..0adc545116a4 100644
> --- a/drivers/firmware/arm_scmi/sensors.c
> +++ b/drivers/firmware/arm_scmi/sensors.c
> @@ -156,6 +156,27 @@ struct scmi_msg_sensor_reading_get {
>  #define SENSOR_READ_ASYNC	BIT(0)
>  };
>  
> +struct scmi_resp_sensor_reading_get {
> +	__le64 readings;

Generally I have avoided such single element structures so far. Any
particular reasons for having it ?

-- 
Regards,
Sudeep
