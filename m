Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B402FCCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbhATImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbhATImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:42:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8D1C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:42:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id m4so22207921wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8qh8OTFcaMUGBcIZCZgz7GdjbciOfTTUBtebQtxG2j0=;
        b=XpTnPx4p86jiD6AvYNGfEwfzgfqbsXw3yMKhXLX8+rYx3tKzQK3nGAdFumBbgofynC
         W2j1snkbw6y0WLl/11CVFeRLR6bzRntpICA1SSz/lFmvEQAidIvKqdPdiHinq3PmvYqJ
         A0W1r9140X3+Ug/4j9QSpi3+jZ6S3hFYwx1ixfu9iLWwCqdb48DjEGGmnPDDnxPBMxFG
         JctsZ3dpVaX4J/jb8GZTU3T7VxDRUtGsJcehnnsA9gyR2L6uavu3qBhJhHcsXw5cZVQt
         2H2zg+cJaPNlb8Fida8KE7OGttfaSgFljQ+tOzxmVRMaok7ZiehvCMy8a8CSod5VuL2U
         FT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8qh8OTFcaMUGBcIZCZgz7GdjbciOfTTUBtebQtxG2j0=;
        b=Ofa2vtYW82I4VR9ogjQhL/PYIsjry019IsSOaxJOjJwxVD3TscCOJo0mIQJtGP+bOH
         x2YUsBdsOpLUjsfhX5GmBspMGQ8TidFeGqQx/n538QMGHdKvqOVPTo2lc9SE3pcN75vf
         MYhK3I+85a1J/F6XEk9R5wHIZ5t5Yixw3H8+qYgZRO+6GmQdT1LLIFEdIfuVTjVyBpDA
         po49yIhP2fOVjsjkrk193QTKbErSil7liESxKFUbjJUmlGnslmV4XvsQOZE8/niaOrjA
         gleCX/PIPQUtT540CQ7/K3Ttc8nYgWG3yLLR8t4rZ71Bgn+cPu5aOja+Pld3pMaofXCJ
         1z2Q==
X-Gm-Message-State: AOAM533yp6s3aXFDBnsdSx5ncX2emDCCnyy4trhCRYG73rt4RkP5toYQ
        eyHjJi/JeaE/fA7IvwSGRlLuPkEdmk3WtyAQ
X-Google-Smtp-Source: ABdhPJxHM2XYW2LmzWsztZDqIgnq5HctCB9PjDlPJybOjlYD4xOca+8we1FJhao9j1HwkMhgeq3NDA==
X-Received: by 2002:a5d:4243:: with SMTP id s3mr8085229wrr.31.1611132122140;
        Wed, 20 Jan 2021 00:42:02 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id q15sm2479232wrw.75.2021.01.20.00.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:42:01 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:41:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] mfd: iqs62x: Remove superfluous whitespace above
 fallthroughs
Message-ID: <20210120084159.GN4903@dell>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
 <1610942228-7275-2-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1610942228-7275-2-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Jeff LaBundy wrote:

> Previously, all instances of the /* fall through */ comment were
> preceded by a newline to improve readability.
> 
> Now that /* fall through */ comments have been replaced with the
> fallthrough pseudo-keyword, the leftover whitespace looks out of
> place and can simply be removed.
> 
> Fixes: df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes in v2:
>   - Added Acked-for-MFD-by trailer
> 
>  drivers/mfd/iqs62x.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
