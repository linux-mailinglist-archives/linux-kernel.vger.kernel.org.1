Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07D927D800
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgI2UYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:24:54 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38804 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2UYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:24:53 -0400
Received: by mail-ot1-f68.google.com with SMTP id y5so5774185otg.5;
        Tue, 29 Sep 2020 13:24:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UcDdbaFq8xgiH8MJ0WsHsIndkHqom/8ozqfg/ZE1A7Q=;
        b=FvFyJQv6UjcIkaGBDyDqOX/TSGLBiMyK/gmiZmuB98jH91CgFvb5wi+KJ8nPHZgu+l
         c0rCSrXp7JzdK/jFpf0Td9eGiLpfb+zEDC4IxPvjrmLetsbZq37XDfBuVOY9V0FJbe4U
         sF81BEXpMCNn5n+vcfUPZQ7/LnPnSQOs4R6m0RzY8shY7CbDKYwe4DIdZop5dHFR5QkB
         EtHWlm+pzK1Y8Yvkw1sTCKo+69sZUTSf5Sj6RNCnsDahsKYBWS+JFqipewC7VR9IlGxS
         U+y6/zEjCrpxcnXnGqUmMB/WVcJdvECadxASB6sA2AG4yGhZ2bfrRENQ6tUO3zU3PqYm
         Idmg==
X-Gm-Message-State: AOAM530oVvDyt4iF3tme9k+DhWzsCFqBSD0AsbxyaHLgJyQDVRItXLWc
        wslN29Ol4NDDgwSdT0teJNDagdfyn+nuGWU=
X-Google-Smtp-Source: ABdhPJxeC09oZyV60VXYUjsCoprJVq6RUxkiw+9po0mU7y5oioPOGCI12UcfOUt6x+yv4NCtRiRuWQ==
X-Received: by 2002:a9d:5550:: with SMTP id h16mr4085402oti.157.1601411092306;
        Tue, 29 Sep 2020 13:24:52 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m22sm1238021otf.52.2020.09.29.13.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:24:51 -0700 (PDT)
Received: (nullmailer pid 1105505 invoked by uid 1000);
        Tue, 29 Sep 2020 20:24:50 -0000
Date:   Tue, 29 Sep 2020 15:24:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>, Libin <huawei.libin@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 01/17] dt-bindings: mfd: syscon: add some compatible
 strings for Hisilicon
Message-ID: <20200929202450.GA1105427@bogus>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141454.2312-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 22:14:38 +0800, Zhen Lei wrote:
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
> 

Applied, thanks!
