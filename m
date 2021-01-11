Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3812F0FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbhAKKOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:14:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbhAKKOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:14:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74CC022283;
        Mon, 11 Jan 2021 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610360018;
        bh=xPveBl9oJpaTajaPhT68nWD4E5CeEL2CGF/QRffMYsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8BhcTDhH0mxE02xSTzL1NjSpBQXPhT0Yh1rnlj5qgoW0ztZPlYnTA6jAwpYgAsVE
         kAL1AW7HsY6nUpRCNzhAdqZqqSfuKoTiL3+XqIsxvTFybHS/3mRMiGkNGC69HPMAhJ
         d0mMs/Umk2cayrpy70VbxdcqIEvNfa9wSLkpGhx28jPrfvl2i90Zh9RIS0h9ryr5R8
         hkMmgX1gT+AAV3GfdTQYphI0vPrnlGz0rjb5g33muSZcPbJCTVrSWwoSpY8pD4vC71
         F9pImeuSLvlZWn7BDeBpAivbo+mkaZM3VfRCYelpYppM0auCVqafjqgMOxTx9dfZFO
         IjTImBya3x+yg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kyuCl-0004P2-H2; Mon, 11 Jan 2021 11:13:43 +0100
Date:   Mon, 11 Jan 2021 11:13:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     johan@kernel.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] drivers: gnss: simplify the gnss code return
 expression
Message-ID: <X/wk15eOf/gmVbe9@hovoldconsulting.com>
References: <20201210135142.1138-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210135142.1138-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 09:51:42PM +0800, Zheng Yongjun wrote:
> Simplify the return expression at diffrent .c file, fix this all.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/gnss/core.c |  7 +------
>  drivers/gnss/mtk.c  | 14 ++------------
>  drivers/gnss/ubx.c  | 14 ++------------
>  3 files changed, 5 insertions(+), 30 deletions(-)

>  static int __init gnss_module_init(void)
> diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
> index d1fc55560daf..451cb6e66ec3 100644
> --- a/drivers/gnss/mtk.c
> +++ b/drivers/gnss/mtk.c
> @@ -24,25 +24,15 @@ struct mtk_data {
>  static int mtk_set_active(struct gnss_serial *gserial)
>  {
>  	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
> -	int ret;
>  
> -	ret = regulator_enable(data->vcc);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return regulator_enable(data->vcc);
>  }

These functions where written with explicit success paths on purpose so
there's nothing to "fix" here. 

Johan
