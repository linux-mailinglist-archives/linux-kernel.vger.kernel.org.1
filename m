Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A71D2846F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgJFHSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:18:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54696 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgJFHSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:18:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id p15so1785872wmi.4;
        Tue, 06 Oct 2020 00:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ITHR5xjZR9qU+0rYpKhMHSvOMECUC8YhvuIaZkbc094=;
        b=GywvVwXGaNFwG9Yd/RCYeWbh2qp4MjuuBaNpmxhVItCUlnBHVpKHI78FJ9mw4ngFrN
         nWqrqsguZCm8ovFwC2HUA3/aSzitrL9yKo6HfM8T/PB7zMR3pZcs6d3a/gUTujH2TX3H
         uNB73y+mMNh2MjyWlnyBIUIg8CMIuIwa19pN/gwZK4HzqnlZ7Wr0gAOtnjtlmmWhIMAk
         346rYuImiA00jPV3kfTxxlFZY8eIuNdWZsKHSYHPygWnuGMDlsU0gW9hCv1tPgFP8GpQ
         SlEhIB+feU+COtj6V7PAD1064u+1U160C6RrL6L/YGWm/a6kAXP2HP+BHvV8BfpqdxuY
         J2iQ==
X-Gm-Message-State: AOAM531CtsumdiVJ1zaWvkBB+2/47CfIJ0BdioqGJnpLCwPVJaM0UycH
        buIhUdJBlkD3fYpQUEp3w8Y=
X-Google-Smtp-Source: ABdhPJx0yNrHEU7UDvNE8lhlFuoDDRp9Cl+ESLoSIMyNzIen0lPioASqSAe2IV+9r6VqPllxNH0sgA==
X-Received: by 2002:a1c:4604:: with SMTP id t4mr3284322wma.48.1601968722386;
        Tue, 06 Oct 2020 00:18:42 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id p9sm2617wmm.4.2020.10.06.00.18.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 00:18:41 -0700 (PDT)
Date:   Tue, 6 Oct 2020 09:18:38 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 18/24] iommu/mediatek: Support master use iova over
 32bit
Message-ID: <20201006071838.GA5703@kozik-lap>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-19-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930070647.10188-19-yong.wu@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:06:41PM +0800, Yong Wu wrote:
> After extending v7s, our pagetable already support iova reach
> 16GB(34bit). the master got the iova via dma_alloc_attrs may reach
> 34bits, but its HW register still is 32bit. then how to set the
> bit32/bit33 iova? this depend on a SMI larb setting(bank_sel).
> 
> we separate whole 16GB iova to four banks:
> bank: 0: 0~4G; 1: 4~8G; 2: 8-12G; 3: 12-16G;
> The bank number is (iova >> 32).
> 
> We will preassign which bank the larbs belong to. currently we don't
> have a interface for master to adjust its bank number.
> 
> Each a bank is a iova_region which is a independent iommu-domain.
> the iova range for each iommu-domain can't cross 4G.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c  | 12 +++++++++---
>  drivers/memory/mtk-smi.c   |  7 +++++++
>  include/soc/mediatek/smi.h |  1 +
>  3 files changed, 17 insertions(+), 3 deletions(-)


For the memory part:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
