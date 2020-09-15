Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6066326A5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIOM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgIOMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:48:08 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6E8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:48:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 4F442260B30
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: Support pd_info v2
 format
To:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200909040400.908217-1-swboyd@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <720fcfbb-3f3a-9679-bd33-56d7f65651a5@collabora.com>
Date:   Tue, 15 Sep 2020 14:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200909040400.908217-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Prashant,

On 9/9/20 6:04, Stephen Boyd wrote:
> Let's try to read more information out of more modern cros_ec devices by
> using the v2 format first and then fall back to the v1 format. This
> gives us more information about things such as DP mode of the typec pins
> and the CC state, along with some more things.
> 
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 

I saw some discussion going on in gerrit (a pity the discussion didn't happen in
mainline) Did you end with a conclusion? Can I remove this patch from my backlog?

Thanks,
  Enric

> Should we move read_buf to the heap?
> 
>  drivers/platform/chrome/cros_ec_debugfs.c | 40 +++++++++++++++++------
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 272c89837d74..4f8c902c0de6 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -195,28 +195,31 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>  				   size_t count,
>  				   loff_t *ppos)
>  {
> -	char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
> +	char read_buf[EC_USB_PD_MAX_PORTS * 64], *p = read_buf;
>  	struct cros_ec_debugfs *debug_info = file->private_data;
>  	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
>  	struct {
>  		struct cros_ec_command msg;
>  		union {
> -			struct ec_response_usb_pd_control_v1 resp;
> +			struct ec_response_usb_pd_control_v2 resp_v2;
> +			struct ec_response_usb_pd_control_v1 resp_v1;
>  			struct ec_params_usb_pd_control params;
>  		};
>  	} __packed ec_buf;
>  	struct cros_ec_command *msg;
> -	struct ec_response_usb_pd_control_v1 *resp;
> +	struct ec_response_usb_pd_control_v1 *resp_v1;
> +	struct ec_response_usb_pd_control_v2 *resp_v2;
>  	struct ec_params_usb_pd_control *params;
>  	int i;
>  
>  	msg = &ec_buf.msg;
>  	params = (struct ec_params_usb_pd_control *)msg->data;
> -	resp = (struct ec_response_usb_pd_control_v1 *)msg->data;
> +	resp_v1 = (struct ec_response_usb_pd_control_v1 *)msg->data;
> +	resp_v2 = (struct ec_response_usb_pd_control_v2 *)msg->data;
>  
>  	msg->command = EC_CMD_USB_PD_CONTROL;
> -	msg->version = 1;
> -	msg->insize = sizeof(*resp);
> +	msg->version = 2;
> +	msg->insize = sizeof(*resp_v2);
>  	msg->outsize = sizeof(*params);
>  
>  	/*
> @@ -229,13 +232,30 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
>  		params->mux = 0;
>  		params->swap = 0;
>  
> -		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0)
> +		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0) {
> +			if (i == 0 && msg->version == 2) {
> +				/* Try again with version 1 */
> +				msg->version = 1;
> +				msg->insize = sizeof(*resp_v1);
> +				i = 0;
> +				continue;
> +			}
> +
>  			break;
> +		}
>  
>  		p += scnprintf(p, sizeof(read_buf) + read_buf - p,
> -			       "p%d: %s en:%.2x role:%.2x pol:%.2x\n", i,
> -			       resp->state, resp->enabled, resp->role,
> -			       resp->polarity);
> +			       "p%d: %s en:%.2x role:%.2x pol:%.2x", i,
> +			       resp_v1->state, resp_v1->enabled, resp_v1->role,
> +			       resp_v1->polarity);
> +		if (msg->version == 2) {
> +			p += scnprintf(p, sizeof(read_buf) + read_buf - p,
> +				       " cc:%.2x dp:%.2x ctrl:%.2x cs:%.2x gen:%.2x",
> +				       resp_v2->cc_state, resp_v2->dp_mode,
> +				       resp_v2->control_flags, resp_v2->cable_speed,
> +				       resp_v2->cable_gen);
> +		}
> +		p += scnprintf(p, sizeof(read_buf) + read_buf - p, "\n");
>  	}
>  
>  	return simple_read_from_buffer(user_buf, count, ppos,
> 
