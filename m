Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646D130128C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhAWDOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:14:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbhAWDNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:13:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C44C23B17;
        Sat, 23 Jan 2021 03:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611371591;
        bh=nZHgv2nUuFKopFOOphwNw1ODfPUXgYPsrYhaWPfr8nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6Z5ExX5lOVEhpwtu94ztt8y08nfGtLDHNKsHdknGaadxrB6hdETQCWhu80fPnLQX
         h7XPZ3C3yWNuaLFA2MWx5+D7WSzvOURRwE+/uiCANnOYdl59LweVxMEPDCL1tlHHB7
         wkzMWCtHBCquQnDLk3aFWrV28yF2FJQN2+WDtx6daEOUkbXZI2JxiccI84i0GRuDrA
         ashzsef+XAD6gLyamW7ZKBzkpou3FfZEYSHHBhSHg4HriDkkL2MqH6k5DVeAgx/jdD
         kKatusWH2RT6pA/NLOwJquF2RBM2pKyXtpwnYkk21DPnrZr67wCQwhF4pBGmbTCt22
         IBLEu1cbwW9Qw==
Date:   Sat, 23 Jan 2021 11:13:26 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: Add support for TI's AM64 SoC
Message-ID: <20210123031326.GB10391@b29397-desktop>
References: <20210119052810.20457-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119052810.20457-1-a-govindraju@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-19 10:58:10, Aswath Govindraju wrote:
> Add support for USB controller present on the AM64x SoC.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index 90e246601537..eccb1c766bba 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -214,6 +214,7 @@ static int cdns_ti_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id cdns_ti_of_match[] = {
>  	{ .compatible = "ti,j721e-usb", },
> +	{ .compatible = "ti,am64-usb", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, cdns_ti_of_match);
> -- 
> 2.17.1
> 

Applied, thanks.

-- 

Thanks,
Peter Chen

