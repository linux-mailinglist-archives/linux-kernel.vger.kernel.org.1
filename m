Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3C227E248
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgI3HLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgI3HLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:11:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E0C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:11:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so568770wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/I/KAPNr4cLr7UsPUc0tQoibIIvI7K+uC/bv0mt4+Ws=;
        b=mLCC/dK1CYxPvRMx0+/i/iwaHqlnZEbXj7U66pP5EWiWdEty9n1NH8w56cgQW1y6Ia
         msm1WZ5EMywcl+dNhn8sbmrIPsEJr1+moq5gKIupcA3zrs5dySBE1vtfEnPsx1J7hrJU
         ftxHBesYzB2lhQpM3/1hh2BS7XINxrMMdf8DDUQQp6FzIyJwn5to5UQOGK1CjsBLuUOf
         j8JUVjmi7wn6bThCVbHpIwJ313T6p+hdF/0vW7QwKwDrUH9a4kmMdfPBzAVp9fC1r/LK
         x3NTDitsR+eKj4jMpFNSN7WgtPwodNZixeDFx+sS8PgdtVeBmy46toU80nG1dqdDJtZM
         44yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/I/KAPNr4cLr7UsPUc0tQoibIIvI7K+uC/bv0mt4+Ws=;
        b=RRkhSbzuJt7aJC1lsg5gt1Ru6+i3gIzsqRKqAuQlw0+oNz1yh7vrdM3kJtqT8d+sRL
         MD9BJ2d7fC6iSzfwK7bSKRM5OYNNF2j3a7GPlshaJprScLuW99zFiodRC8bDpyrBlXVY
         wqnuh+Mfvf5V9nBww3E59OjgT8ColP07MNLHVyoN+I/gCNACfxEsDjKIABFd1Y9GOvLq
         Ul2Gj0sXcbpP1qAaeTg57P0/oGoHx0Ea+VhJmtIDrcIpVZA8YW1twn15/VY3aIhhYA1z
         KvvGcCfsUPbaaOl2oaHwGvpZ5VUhYrPbMFY4YM/J+N7vTymLP9zrMOeB7ztdP2CFayOD
         urZg==
X-Gm-Message-State: AOAM533wPp/E4/Ix0tT/VNd8+R3zmoxCKYN1/xO8zdekipFTtCcHL7ai
        dUjp8knQ+IQTCoAOt9gFm5FAgw==
X-Google-Smtp-Source: ABdhPJztEyoO+moG/tKurp3NZWq0hO934Y+qi0MI0nul/M+ilazxtXBJ+9TUl9SDtCw2ym2PqJcWyA==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr1335848wme.188.1601449873200;
        Wed, 30 Sep 2020 00:11:13 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id u186sm1147668wmu.34.2020.09.30.00.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 00:11:12 -0700 (PDT)
Date:   Wed, 30 Sep 2020 08:11:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v6 01/17] dt-bindings: mfd: syscon: add some compatible
 strings for Hisilicon
Message-ID: <20200930071110.GH6148@dell>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200930031712.2365-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020, Zhen Lei wrote:

> Add some compatible strings for Hisilicon controllers:
> hisilicon,hi6220-sramctrl  --> Hi6220 SRAM controller
> hisilicon,pcie-sas-subctrl --> HiP05/HiP06 PCIe-SAS subsystem controller
> hisilicon,peri-subctrl     --> HiP05/HiP06 PERI subsystem controller
> hisilicon,dsa-subctrl      --> HiP05/HiP06 DSA subsystem controller
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This was already applied by the time you re-sent it.

Any reason for sending it again?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
