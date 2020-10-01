Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2303B27F9CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgJAG7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 02:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgJAG7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 02:59:33 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF925C0613E2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 23:59:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e2so1811838wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=I7H3+3zuXlnwMTT9uJKAAuFuUpvHKKuLQD0ufEc89Ec=;
        b=X4G8Q/XJypmAtZzInxZclYRa9PxF0zGPQCoePn7yt/JM19orLfLUR194h+ViPYYdmY
         s78PM284RuTmqCT0bJnD+RQu6vgafIGOolyPUA4i/OCRo5q9z0FgXvKyEKGazkoE3Vs7
         dhcosh8V4L9fKKAcrcK6PjvUzMaQiIE3rVcSY1OYmUM1bkahBxrtW6AoSu0auAFB52Mh
         d01z/9QpNHV8lZMY4iBlXaO9mw2WiqgYs2+B8VT+8uTTlgbCIHjeByGRGRrNQQfU2Xs9
         EWJxRdwyhkN0VdybbF5fV2pnZolLxkbvN60uKgkecqIrsRR1exb/4xqWyPVTQ3HAbrJa
         nrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I7H3+3zuXlnwMTT9uJKAAuFuUpvHKKuLQD0ufEc89Ec=;
        b=NS7rd1t2P+DROdQB/+0Ewx+ck8IaGPWGOsT6t8QpGue81Fyez4bACI66X+vXimGeuV
         aNBBz4cyb50BtHe1zL1JV3D1/GFPxNsVaniV2w1ukOYsIjXqaVc2r8TFeOcjnJENS3ys
         tsHOoVN9RRChtMzCLOo6vayiCwPkWRdh3k1o9jC2WoSd58mq2rbfl/T64rmZKlNCA9Of
         9LivrVgAaYYHUcFZpkoGM9jgQ1slIE6HqWF+BfiJRjauOdzeTt/LiNBAe3Tj7hRAz5pf
         O2Rw122z3IhOijmwJwxRKE11f1MquYkwSvmqf8wqBaV3YYzenrMchMgqR7FNL8w+vCeS
         uiiw==
X-Gm-Message-State: AOAM530iwwxwA0NobH/pCsCYOxAbP8/Wia/Yvjautlm0cU/Wi3nenIuk
        cDeK58k0dPp5BTeRzr9wnGC7Yw==
X-Google-Smtp-Source: ABdhPJyJ6sLSqbEYubVG8iWSLoGsRShxYo4Z7aaiVxrytC20EZMrqFnoszXDrW6WnkGhmPIQeNL9GQ==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr6826644wmh.106.1601535571292;
        Wed, 30 Sep 2020 23:59:31 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id 11sm6884601wmi.14.2020.09.30.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 23:59:30 -0700 (PDT)
Date:   Thu, 1 Oct 2020 07:59:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 01/17] dt-bindings: mfd: syscon: add some compatible
 strings for Hisilicon
Message-ID: <20201001065917.GJ6148@dell>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-2-thunder.leizhen@huawei.com>
 <20200930071110.GH6148@dell>
 <3045a295-928a-eae6-c887-e34446a170e0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3045a295-928a-eae6-c887-e34446a170e0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020, Leizhen (ThunderTown) wrote:

> 
> 
> On 2020/9/30 15:11, Lee Jones wrote:
> > On Wed, 30 Sep 2020, Zhen Lei wrote:
> > 
> >> Add some compatible strings for Hisilicon controllers:
> >> hisilicon,hi6220-sramctrl  --> Hi6220 SRAM controller
> >> hisilicon,pcie-sas-subctrl --> HiP05/HiP06 PCIe-SAS subsystem controller
> >> hisilicon,peri-subctrl     --> HiP05/HiP06 PERI subsystem controller
> >> hisilicon,dsa-subctrl      --> HiP05/HiP06 DSA subsystem controller
> >>
> >> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/syscon.yaml | 5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > This was already applied by the time you re-sent it.
> > 
> > Any reason for sending it again?
> 
> Path 15 are modified. The Document patches except Patch 15 are applied,
> but the config/DTS patches are not applied(They are applied after I re-sent).

Could you please only send patches which have not been applied.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
