Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A156027FC3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbgJAJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:11:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22F0C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 02:11:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e11so1787674wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 02:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qVG1crGosGe6WteagSyVUP1/8VNDfCfQGhNS/WTV3K0=;
        b=o7qGrzbmYA7WsOVk5tsMhOn/ogjO7Rwy+3E+DJwzfKTeT4Se1KdQ2tzqeV/arHZtMj
         XQW+iTpC5qgeHDfcC+DQUhGrmXhSnWebuKi4ZRXIagt3VpJbjDvx3De0hxhthF0Z41W4
         3JUPmNWofiKFdchJkQ1l251ycv7ugqqwNi8eIauBj2SBBtXOhCwtGFjmCGB531qliNS+
         2rv6LBCbDd//R4dePNyM2d3/XsugRfa/X76mDyU4Bmmw9pJJGlrwXaYyLNn8Ws6xseWq
         X1yeqC5yrEnvKeVXbRZTU0Pdp/8mJmPmk6AhArAfRy+tKwiz0Wk1cbY7Ivo/R4aMlbL3
         HqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qVG1crGosGe6WteagSyVUP1/8VNDfCfQGhNS/WTV3K0=;
        b=Y/vDCGI6kwMyTlpGbgro9jVssJUckMv+Ug7eyb7qL4+edu5odYlnSJ7SEuA+6iMMr2
         VaO4DT+uqf7ieeuJOQNUP1R0s0ivEjaYKnFpTuTAWFR39P+eFnRmClZJ3uCMXAhGZlE1
         t6V25RXTWzPQH7PU4UB/LKVkVmqN4EjWq4nGLWmXh30zq/FcN37hqr4HAhrCC5hVIurg
         hX2ZXJ8ieL4vCMqSS4AUbIe6j+1mJDzfa6c1HIFgjV8sW+3RcI8vFCUC1HOYxeUXPXLb
         f+kVCNn8dZI1Vh64IgyfTUODPMC0WDmrjyJek7YCn/5Lx4bsK1GOkiWUB7A1xaIvoFKe
         tBAA==
X-Gm-Message-State: AOAM531SwiDzlBanDJI9Y5PgNQJfKEmimDjSfT1MMsogkZYfpHrhmrju
        t1LhFIjMuFSN65aP0qRpeT5YXQ==
X-Google-Smtp-Source: ABdhPJzBPRGBtX689t52KEw8E7IfKXkFOKlUu++drz3PRbwvKtDPB6HUzhAnulJ8OK270nOmXIqozw==
X-Received: by 2002:a1c:5988:: with SMTP id n130mr7691297wmb.95.1601543463453;
        Thu, 01 Oct 2020 02:11:03 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id k22sm8326949wrd.29.2020.10.01.02.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 02:11:02 -0700 (PDT)
Date:   Thu, 1 Oct 2020 10:11:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
Subject: Re: [PATCH v5 09/10] mfd: mt6360: Merge header file into driver and
 remove unuse register define
Message-ID: <20201001091101.GO6148@dell>
References: <1600770019-11585-1-git-send-email-gene.chen.richtek@gmail.com>
 <1600770019-11585-10-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1600770019-11585-10-git-send-email-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Merge header file into driver and remove unuse register define
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c  |  48 ++++++++-
>  include/linux/mfd/mt6360.h | 240 ---------------------------------------------
>  2 files changed, 47 insertions(+), 241 deletions(-)
>  delete mode 100644 include/linux/mfd/mt6360.h

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
