Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC652FCCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbhATIov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbhATIn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:43:59 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB204C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:43:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w5so22207206wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UEFPH9coK2WKmOok5QTUqXvgSuctGW8OCPjNZbPUtv4=;
        b=LQQvxnEzDoFZeD2TZSDtzrrWYB6KVnLhaNsGKKtf0TkQX9wKWfyncMCOXbAOTr+CNn
         2gUg7YWbX+m/RUS/tG2AMRVlSsB6/0Ca42ZOQQpFevud8ai5qoCBNtBo3X9pS8btZwHb
         u829LJXSMB3EQdfozC9VwRRzoTZisACt5WeQ4l7GiO+a5+13HSueeBPzPnvyG4BA0bc3
         TKwnbIdYOBHwDA2ttm6AY06FcCXh/FhyzG8Orw5edd8o8SBy5oXJyPjflVoHAfAACo1K
         jS3SmakNpAqQjQrvdfPuTYPQgOukJah8F0CVUFWJS21YJ5Fdc68diopYn0RfvfFD21s9
         gMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UEFPH9coK2WKmOok5QTUqXvgSuctGW8OCPjNZbPUtv4=;
        b=eAK35IccOpLNR3/zWzAkMXJyvbG9kMwNU8RZzYUomREfWic9IPJzbpuzP4dgXzU1t1
         YGFVUXD0xCY88bayRKFBKrEmaBr6O5s8s+dgHeAqjvu19CkCeYed+SFkj4O5BWxAlqR2
         bPpv58PXSip/nKQOFflQENZXvsWl1M5E5V85QqOnzPnV6gdkKK2OUnN8OFkTlmcFwS0/
         y1zLU+1pjtGOAlZxBNy4JGl28T5RgJf9TpJfr+jpf3QBt2X0RpyprS+lN3IqA1Eo6jvj
         BTimrVTSa9uWQ+3xlYTJrP89LReeJGZZ5w+h/rBffz2rYN0868H5WHZGsmj2Bt+NTmWM
         7PGQ==
X-Gm-Message-State: AOAM533JPEHz5r4khxCGEnZ3Re3DbZOZxq2Jv2YydsWb8QBDOeTAgebV
        jB9v3J7Z9hOpolfxShi7/uY+MQ==
X-Google-Smtp-Source: ABdhPJytzuFL2yVqlI3ILnPckCD1aznGeEBbEtszDLsKGDK5KtH8kMOb7sAvbrnTfuI1dxHg3RCsBg==
X-Received: by 2002:adf:bbc1:: with SMTP id z1mr5061150wrg.95.1611132190752;
        Wed, 20 Jan 2021 00:43:10 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id n12sm2859038wrg.76.2021.01.20.00.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:43:10 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:43:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] mfd: iqs62x: Rename regmap_config struct
Message-ID: <20210120084308.GP4903@dell>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
 <1610942228-7275-4-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1610942228-7275-4-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Jeff LaBundy wrote:

> The regmap member of the driver's private data is called 'regmap',
> but the regmap_config struct is called 'iqs62x_map_config'. Rename
> the latter to 'iqs62x_regmap_config' for consistency.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes in v2:
>   - Added Acked-for-MFD-by trailer
> 
>  drivers/mfd/iqs62x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
