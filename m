Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243CD2AFA66
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgKKVec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:34:32 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:40858 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:32 -0500
Received: by mail-ej1-f65.google.com with SMTP id oq3so4748132ejb.7;
        Wed, 11 Nov 2020 13:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbSPGqSoajDdzgBXkcQ9pceYyj1fwUocImvC8LVuhnA=;
        b=s+lgVQoyIW0PeKdZKrDWyFxxEpc4DbPh6p+yHWJ/IbtSjdf7cVMKb8FGU2NirNa0Hx
         Me3cVYEXjlQt3A9SjOp4Mdt9d+EaZwIrpQVKaShXGAAtrMhHD0EELryObVxJFjssS7V7
         K8wNAZAfEoUlCkeA1S0Ftt8lleQTdszAodLLIxE2lbohIy4LLYbMxBN9mXOgxnDsTbIX
         yici5A8YYvQ4lK6m4ZdETQVdQSP72bvkRW6FGgjg+GkeYOJ9wyKdDUQ2L535rTidg5mz
         jLGymmRyMoiSIny6FlPdXjiJzDqyXDfRsohSHGnDxPkGF41Akdc0/03lE0/Zhw1vxUmY
         eRFQ==
X-Gm-Message-State: AOAM530JYP3M+AwJ8P/L1nqNV6O+t/Xf2rxT8jo3mJASKb2TR26ZOJ7R
        W3ARGYBmd1DkjB3DB1b5vwI=
X-Google-Smtp-Source: ABdhPJxZ1WBxXRo++KtU6Sg0+JLnVf2CzzVbv4KmTREyVVotlVP7TjUvZ7DBVgSFoHPvAHxci/+JFw==
X-Received: by 2002:a17:906:d7b7:: with SMTP id pk23mr28400140ejb.214.1605130469179;
        Wed, 11 Nov 2020 13:34:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x1sm1437867edl.82.2020.11.11.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:34:27 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:34:26 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 18/24] iommu/mediatek: Support master use iova over
 32bit
Message-ID: <20201111213426.GF287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-19-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-19-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 08:38:32PM +0800, Yong Wu wrote:
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
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org> # memory part
> ---
>  drivers/iommu/mtk_iommu.c  | 12 +++++++++---
>  drivers/memory/mtk-smi.c   |  7 +++++++
>  include/soc/mediatek/smi.h |  1 +
>  3 files changed, 17 insertions(+), 3 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
