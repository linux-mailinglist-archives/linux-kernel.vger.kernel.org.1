Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6886258B16
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 11:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIAJK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 05:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIAJK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:10:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AC1C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 02:10:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8515728C318
Subject: Re: [PATCH] platform: cros_ec: Add fields to command traces
To:     Gwendal Grignou <gwendal@chromium.org>, rrangel@chromium.org,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20200815033908.3108730-1-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <68cb4466-4c56-130b-d8ee-314354a7a07b@collabora.com>
Date:   Tue, 1 Sep 2020 11:10:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200815033908.3108730-1-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

On 15/8/20 5:39, Gwendal Grignou wrote:
> In ftrace, add more fields to the cros_ec command event:
> - Add size of commands to check if they are properly set.
> - Add offset (in case an EC is cascaded being another EC),
> to allow proper command output
> 
> With:
> echo 1 > events/cros_ec/cros_ec_cmd/enable
> We now have (on samus)
> 
> invalid command for the sensor stack:
> ectool-6942  [002] ....  3082.783116: cros_ec_request_done: version: 3,
>  offset: 0, command: EC_CMD_MOTION_SENSE_CMD, outsize: 2, insize: 19,
>  ec result: EC_RES_INVALID_PARAM, retval: 0
> 
> powerd accessing PD EC being the main EC:
> powerd-1272  [002] ....    40.644026: cros_ec_request_done: version: 0,
>  offset: 1, command: EC_CMD_USB_PD_POWER_INFO, outsize: 1, insize: 16,
>  ec result: EC_RES_SUCCESS, retval: 16
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---

Applied for 5.10.

Thanks,
 Enric


>  drivers/platform/chrome/cros_ec_trace.h | 27 +++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_trace.h b/drivers/platform/chrome/cros_ec_trace.h
> index e9fb05f89ef07..f744b21bc655f 100644
> --- a/drivers/platform/chrome/cros_ec_trace.h
> +++ b/drivers/platform/chrome/cros_ec_trace.h
> @@ -23,14 +23,22 @@ TRACE_EVENT(cros_ec_request_start,
>  	TP_ARGS(cmd),
>  	TP_STRUCT__entry(
>  		__field(uint32_t, version)
> +		__field(uint32_t, offset)
>  		__field(uint32_t, command)
> +		__field(uint32_t, outsize)
> +		__field(uint32_t, insize)
>  	),
>  	TP_fast_assign(
>  		__entry->version = cmd->version;
> -		__entry->command = cmd->command;
> +		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(1);
> +		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(1);
> +		__entry->outsize = cmd->outsize;
> +		__entry->insize = cmd->insize;
>  	),
> -	TP_printk("version: %u, command: %s", __entry->version,
> -		  __print_symbolic(__entry->command, EC_CMDS))
> +	TP_printk("version: %u, offset: %d, command: %s, outsize: %u, insize: %u",
> +		  __entry->version, __entry->offset,
> +		  __print_symbolic(__entry->command, EC_CMDS),
> +		  __entry->outsize, __entry->insize)
>  );
>  
>  TRACE_EVENT(cros_ec_request_done,
> @@ -38,19 +46,26 @@ TRACE_EVENT(cros_ec_request_done,
>  	TP_ARGS(cmd, retval),
>  	TP_STRUCT__entry(
>  		__field(uint32_t, version)
> +		__field(uint32_t, offset)
>  		__field(uint32_t, command)
> +		__field(uint32_t, outsize)
> +		__field(uint32_t, insize)
>  		__field(uint32_t, result)
>  		__field(int, retval)
>  	),
>  	TP_fast_assign(
>  		__entry->version = cmd->version;
> -		__entry->command = cmd->command;
> +		__entry->offset = cmd->command / EC_CMD_PASSTHRU_OFFSET(1);
> +		__entry->command = cmd->command % EC_CMD_PASSTHRU_OFFSET(1);
> +		__entry->outsize = cmd->outsize;
> +		__entry->insize = cmd->insize;
>  		__entry->result = cmd->result;
>  		__entry->retval = retval;
>  	),
> -	TP_printk("version: %u, command: %s, ec result: %s, retval: %d",
> -		  __entry->version,
> +	TP_printk("version: %u, offset: %d, command: %s, outsize: %u, insize: %u, ec result: %s, retval: %u",
> +		  __entry->version, __entry->offset,
>  		  __print_symbolic(__entry->command, EC_CMDS),
> +		  __entry->outsize, __entry->insize,
>  		  __print_symbolic(__entry->result, EC_RESULT),
>  		  __entry->retval)
>  );
> 
