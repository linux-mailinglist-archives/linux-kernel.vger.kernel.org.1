Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8950F271E6E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIUIzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIUIzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:55:47 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A1AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 01:55:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5F022296585
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: Drop
 cros_ec_cmd_xfer()
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200903095415.2572049-1-pmalani@chromium.org>
 <20200903095415.2572049-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <115a7ae9-9285-d6c4-df85-f9395c67d86f@collabora.com>
Date:   Mon, 21 Sep 2020 10:55:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200903095415.2572049-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 3/9/20 11:54, Prashant Malani wrote:
> Since cros_ec_cmd_xfer_status() now returns Linux error codes and all
> other files use that command, remove the now-unused function
> cros_ec_cmd_xfer().
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Applied for 5.10

Thanks,
 Enric

> ---
>  drivers/platform/chrome/cros_ec_proto.c | 44 +++++++------------------
>  1 file changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 2cb1defcdd13..0ecee8b8773d 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -549,19 +549,22 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>  EXPORT_SYMBOL(cros_ec_query_all);
>  
>  /**
> - * cros_ec_cmd_xfer() - Send a command to the ChromeOS EC.
> + * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
>   * @ec_dev: EC device.
>   * @msg: Message to write.
>   *
> - * Call this to send a command to the ChromeOS EC.  This should be used
> - * instead of calling the EC's cmd_xfer() callback directly.
> + * Call this to send a command to the ChromeOS EC. This should be used instead of calling the EC's
> + * cmd_xfer() callback directly. It returns success status only if both the command was transmitted
> + * successfully and the EC replied with success status.
>   *
> - * Return: 0 on success or negative error code.
> + * Return:
> + * >=0 - The number of bytes transferred
> + * <0 - Linux error code
>   */
> -static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> +int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  			    struct cros_ec_command *msg)
>  {
> -	int ret;
> +	int ret, mapped;
>  
>  	mutex_lock(&ec_dev->lock);
>  	if (ec_dev->proto_version == EC_PROTO_VERSION_UNKNOWN) {
> @@ -598,42 +601,17 @@ static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  			return -EMSGSIZE;
>  		}
>  	}
> +
>  	ret = send_command(ec_dev, msg);
>  	mutex_unlock(&ec_dev->lock);
>  
> -	return ret;
> -}
> -
> -/**
> - * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> - * @ec_dev: EC device.
> - * @msg: Message to write.
> - *
> - * This function is identical to cros_ec_cmd_xfer, except it returns success
> - * status only if both the command was transmitted successfully and the EC
> - * replied with success status. It's not necessary to check msg->result when
> - * using this function.
> - *
> - * Return:
> - * >=0 - The number of bytes transferred
> - * <0 - Linux error code
> - */
> -int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> -			    struct cros_ec_command *msg)
> -{
> -	int ret, mapped;
> -
> -	ret = cros_ec_cmd_xfer(ec_dev, msg);
> -	if (ret < 0) {
> -		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> -		return ret;
> -	}
>  	mapped = cros_ec_map_error(msg->result);
>  	if (mapped) {
>  		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n",
>  			msg->result, mapped);
>  		ret = mapped;
>  	}
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> 
