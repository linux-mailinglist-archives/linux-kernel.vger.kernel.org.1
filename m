Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256092B4009
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgKPJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgKPJmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:42:32 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219D222265;
        Mon, 16 Nov 2020 09:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605519752;
        bh=UBkv65hfzuuSmQHFZzYeD8z66QZxVVCRfSOPWbrwyJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bcBcroOucNFoUzvWpwbfCGCqlZXWSazKuEKmiLG2zuTYuSS3c6Vlxz3YMwx3LpMRV
         zCm+xxjOdfKdehh8QhEdu9iO7fJ70hyzhontxLelqcswqajVlhRqh64BzOc4HPaz8S
         0d7f3XfL+vkL2TaD2c486jG1wjSDqPQ9eWRM72lQ=
Date:   Mon, 16 Nov 2020 15:12:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH v2] phy: mapphone-mdm6600: return error when timed out
 powering up
Message-ID: <20201116094227.GS7499@vkoul-mobl>
References: <1605517891-20357-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605517891-20357-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-11-20, 17:11, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The value of variable error is overwritten by the following call
> devm_request_threaded_irq() in phy_mdm6600_device_power_on(), actually
> we should return error when timed out powering up.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
> v2:
>  -directly return error when timed out powering.
> 
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> index 5172971f4c36..2f461c0d7276 100644
> --- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> @@ -423,6 +423,7 @@ static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
>  		ddata->enabled = false;
>  		error = -ETIMEDOUT;

or drop this
>  		dev_err(ddata->dev, "Timed out powering up\n");
> +		return error;

and do:
                return -ETIMEDOUT;


>  	}
>  
>  	/* Reconfigure mode1 GPIO as input for OOB wake */
> -- 
> 2.20.0

-- 
~Vinod
