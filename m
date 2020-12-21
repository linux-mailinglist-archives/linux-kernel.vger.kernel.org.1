Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191792DFD08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgLUOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 09:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgLUOuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 09:50:20 -0500
Date:   Mon, 21 Dec 2020 15:49:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608562180;
        bh=RjibE7PG3Dvn4e4r8XrqcqR858sjNjYceU7oTN+r+Qs=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=V/TP6eAEJMdklu8YP9BrGIhbPnCN8Ujwb8dlTSkyoSnCJ0hXgmJCj3vMvz4RjpONz
         cJSOF7juGFow2sjAl2dKnu7vVqt/LUIK+NsN4Po3YdER8PoHsk+BUSTS9CIq0s7FzP
         ObFJHGymW3PYL+TCQp+JryCMyS6P0FL9BksxePJFfwGNVHvWUBAbtQf+VNmTkmGOxi
         DMGLo8FQZyQVG9HKAeglDM4cjYwa5fWMQ+BYJsAN9m4T7eevPRbTCttSsy4yyKoIf3
         Cyixcobceo4Cx2F4Rwi0OuoRupvKUKlI8H8D3tJ9HxlMwFGgy7Kl+kNIprbcXitar3
         hFh7efD4LNcwA==
From:   Johan Hovold <johan@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] greybus/audio_helper: Add missing unlock to avoid
 mismatched lock
Message-ID: <X+C2BwZlPw3tRYyf@hovoldconsulting.com>
References: <20201221130246.1807-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221130246.1807-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 09:02:46PM +0800, Zheng Yongjun wrote:
> Fix a missing unlock in the error branch.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/staging/greybus/audio_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
> index 237531ba60f3..293675dbea10 100644
> --- a/drivers/staging/greybus/audio_helper.c
> +++ b/drivers/staging/greybus/audio_helper.c
> @@ -135,6 +135,7 @@ int gbaudio_dapm_free_controls(struct snd_soc_dapm_context *dapm,
>  		if (!w) {
>  			dev_err(dapm->dev, "%s: widget not found\n",
>  				widget->name);
> +			mutex_unlock(&dapm->card->dapm_mutex);
>  			return -EINVAL;
>  		}
>  		widget++;

This has already been fixed in mainline by your colleague:

	e77b259f67ab ("staging: greybus: audio: Fix possible leak free widgets in gbaudio_dapm_free_controls")

It seems you're all working on reports from your "Hulk Robot" so perhaps
you can try to coordinate that internally.

Johan
