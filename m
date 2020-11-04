Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E922A62B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKDK4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgKDK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:56:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:56:06 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w14so21505371wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qPvtX7XpSWWgEgEliDS1hLnbS4qGlILd8aEjgIJY7qA=;
        b=Nx1hpFczL4eb0NS83zX0G2pFPgFpJAc1ejgmynOCDe3qic8LdzZCTyIMBc3hijwHq9
         /GDe50We1+cNa90oXkvsxKRKQI8tbSgNEU8TOLZDC/1QQqKk9JaF/yUpVq8CAbqt+ne7
         G5dQpCEd5UVFoSER9Ms7GAAzU4huyaSOI/EKx2G2WWOk7KQ2Euc6BKvJ4DRvMjOTp0nb
         MCHEX11Hs3hdBF8cQPY7yLMSBPvQfvVQiDZcdjEmDOgtDJ+M5uiORqUFf0HJkbdKX5hR
         HxSIAkHokb3Db3cDIXC9VbypK2g8Hj7QsydWzW3yHaf3AaOXBFNxDROba1MSo+4aGsP4
         O/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qPvtX7XpSWWgEgEliDS1hLnbS4qGlILd8aEjgIJY7qA=;
        b=qQIOf5losAZKzIDLvsvyHGQ/PwFt8UYtWT5wTU6URuD2UiCemESoaea2zE+ItKdsKP
         FFbLpVG6vonhl54YsM8+m1oalzWTZBYmoY+yo1V1M3IbgR+1sMbOrCWnv8XROT99nKkP
         szcD0eBb1l7mX6Ma9uGqw/lBpLKmYaJxVFLRRN1tmbaS0svbj4e9LPxpmbgD2xVMY51d
         iAd/7E4SshAV0MhzR/qrSZSI0U+Zf7EiEmoXoV3mK8GR/ayqCDbnW1YtLD50VINZXgVw
         PX1NxgyPsslxaI/7kXoDBWhFrq5fxySYYjnnpZzr/s8wEUSfzuRYGyWVSnwG84tLTgWY
         VjWA==
X-Gm-Message-State: AOAM532+o2/beHkMPiWlNQF47OTH5Wb/xYjzQqrtgq/pbLayVwCUHs2y
        oP2TAGVlFkNGw0ZM/vhDYVFPGQ==
X-Google-Smtp-Source: ABdhPJw2H9ZB8sjDSKvWzv2cpJgOsjUWx+5gLtKWwhHcymtDBTMmtzAAFtKB80dxRr8rOFkRuLXjjQ==
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr25586236wrx.155.1604487365750;
        Wed, 04 Nov 2020 02:56:05 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id c185sm1688915wma.44.2020.11.04.02.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:56:05 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:56:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH 1/8] mfd: da: Constify static struct resource
Message-ID: <20201104105603.GS4488@dell>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-2-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922192659.14535-2-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Rikard Falkeborn wrote:

> Constify a number of static struct resource. The only usage of the
> structs are to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/da9055-core.c |  8 ++++----
>  drivers/mfd/da9062-core.c | 24 ++++++++++++------------
>  drivers/mfd/da9063-core.c |  8 ++++----
>  drivers/mfd/da9150-core.c |  6 +++---
>  4 files changed, 23 insertions(+), 23 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
