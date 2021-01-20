Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0D02FCCF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbhATIpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730812AbhATIob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:44:31 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A7C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:43:50 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id v184so2061246wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SXf4GvdEKbv7dKJxZGyB67zQvG4oiz6mZ9/eN327ukk=;
        b=Lbq6FX1RigB7xQMoRcTXU/4C2bBP8iEZ9TFRrYyw5aS6zOJojXXv3929ylVvKJ7vxH
         S4cUN2wCi6xGC4lmAVKNkOzkNXK7VEw12xk90tVajk/zhgtA++hnDlyz2vrIrsa6cHgr
         1Ux/vRyiDxtSmXZmEx98nUnvXxsjUqcXmSRCGdjsRdRUigN4lyiCdLK/xhqWvfUSu/3A
         30KSUgGkgf4FN+EioocREUn520DYVKSkLdP/LFGXI+icpei+57zyEr2rXZoZ9IfeUexZ
         Dmw6gQ6FSt5I90cN/Bz8xWNL0kYo/Wp/I1jsfEn4/CdnyXAHWk/c1kArkCcmRmIVEDoO
         XLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SXf4GvdEKbv7dKJxZGyB67zQvG4oiz6mZ9/eN327ukk=;
        b=WIRlPJvjQ/SmHFYo0NfvbhszRvujPPGCeb9cGaXkHsW86cr1w27F8O1SZj3uP9lPWd
         dqE8WTwHz+qwk3OidqfmRMPcTWsLj37A9CGhpjkB6ioozXe8+QY2uwPAtsixuRzfJzDm
         yZc6q3kX3uNjq898frLbTiyQp8eJ8maPq5unO6xivreKnE/wipCAlhmxPoBV19tcY3oz
         fUPspBsYaSADcHlrASj5dmq0kv9CErjVZY6gPA2ydz1yxLjmRNcUkHbkGGu8qs95MIJ2
         XFuaCQbdYmx068BYtbevUEYGkp7e1ykxyqTlBNmC9AilVYUuI5sKj9l8AQ09AUtWruO9
         8kLQ==
X-Gm-Message-State: AOAM533EdNeWIyUaaJINTiVskHzllNJWSHtu7GFGIbnACNcpQTvBCPAZ
        GtOO/K2kn/n0LS4Q9GL0EUoZqg==
X-Google-Smtp-Source: ABdhPJwGWDVJl+qri10pH7mQhMo/Th4PqViwU4MKanmT7Zk+uIe/4nSGiVlNPq7noDbwpwMYt4Ku7A==
X-Received: by 2002:a1c:6486:: with SMTP id y128mr3357034wmb.12.1611132229059;
        Wed, 20 Jan 2021 00:43:49 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id q6sm2463132wmj.32.2021.01.20.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:43:48 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:43:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mfd: iqs62x: Do not poll during ATI
Message-ID: <20210120084346.GR4903@dell>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
 <1610942228-7275-6-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1610942228-7275-6-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Jeff LaBundy wrote:

> After loading firmware, the driver triggers ATI (calibration) with
> the newly loaded register configuration in place. Next, the driver
> polls a register field to ensure ATI completed in a timely fashion
> and that the device is ready to sense.
> 
> However, communicating with the device over I2C while ATI is under-
> way may induce noise in the device and cause ATI to fail. As such,
> the vendor recommends not to poll the device during ATI.
> 
> To solve this problem, let the device naturally signal to the host
> that ATI is complete by way of an interrupt. A completion prevents
> the sub-devices from being registered until this happens.
> 
> The former logic that scaled ATI timeout and filter settling delay
> is not carried forward with the new implementation, as it produces
> overly conservative delays at lower clock rates. Instead, a single
> pair of delays that covers all cases is used.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> ---
> Changes in v2:
>   - Removed superfluous newlines throughout all iqs62x_dev_desc structs
> 
>  drivers/mfd/iqs62x.c       | 125 +++++++++++++++++++++++++--------------------
>  include/linux/mfd/iqs62x.h |  11 ++--
>  2 files changed, 73 insertions(+), 63 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
