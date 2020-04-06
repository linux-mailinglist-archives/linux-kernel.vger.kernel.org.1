Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FF919F79B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgDFOIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 10:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728546AbgDFOIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:08:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65414238E1;
        Mon,  6 Apr 2020 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586182085;
        bh=vhgy+ynRxUHpgkk7e+S8dG76pMVg1GKWZpZgWdztIoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IYLzb8Nm+sRiuji67P8mULB1l3aELwXC6jX+mkA4tZKJUI33MBO8HYv729g4sdVBA
         oS5g0++iCERktqPGvNmlezEGY16tvAEQK0ejAt7ewaua1+cpQ2FB1ps3+Z6TAbYuJq
         keh2EWYEPHa/pO4Mln43DeJnnPNDxCZ80IlK/c6s=
Date:   Mon, 6 Apr 2020 16:08:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     puranjay12@gmail.com, robsonde@gmail.com, zhengbin13@huawei.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192e: remove set but not used variable
 'tmpRegC'
Message-ID: <20200406140803.GB26701@kroah.com>
References: <1586262964-4582-1-git-send-email-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586262964-4582-1-git-send-email-wanghai38@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 08:36:04AM -0400, Wang Hai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c: In function rtl92e_start_adapter:
> drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c:693:15: warning: variable ‘tmpRegC’ set but not used [-Wunused-but-set-variable]
> 
> commit 94a799425eee ("rtl8192e: Split into two directories")
> involved this, remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index ddcd788..ff934ae 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -690,7 +690,7 @@ bool rtl92e_start_adapter(struct net_device *dev)
>  	u8 tmpvalue;
>  	u8 ICVersion, SwitchingRegulatorOutput;
>  	bool bfirmwareok = true;
> -	u32 tmpRegA, tmpRegC, TempCCk;
> +	u32 tmpRegA, TempCCk;
>  	int i = 0;
>  	u32 retry_times = 0;
>  
> @@ -889,8 +889,8 @@ bool rtl92e_start_adapter(struct net_device *dev)
>  		if (priv->IC_Cut >= IC_VersionCut_D) {
>  			tmpRegA = rtl92e_get_bb_reg(dev, rOFDM0_XATxIQImbalance,
>  						    bMaskDWord);
> -			tmpRegC = rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance,
> -						    bMaskDWord);
> +			rtl92e_get_bb_reg(dev, rOFDM0_XCTxIQImbalance,
> +					  bMaskDWord);

That is odd, are you sure you aren't supposed to do something with that
value you read?

thanks,

greg k-h
