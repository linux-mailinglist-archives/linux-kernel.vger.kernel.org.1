Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86E9262352
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 01:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIHXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 19:01:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34803 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgIHXBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:01:21 -0400
Received: by mail-io1-f68.google.com with SMTP id m17so1203259ioo.1;
        Tue, 08 Sep 2020 16:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m89In9DmPLFvZGgeKa+y2k8098Kswn69VDIHU75w5H4=;
        b=Ksa6pz5rRbVbCBJZLoL3+NGUPRAVaVz79JbJqgXrX0r0iJoDRLNwI6bWDdGNxDGJiq
         XwPN0/2NloTvFtqee2beDG34SlzeieEoi+4xFtPcnRleD+DvxGsqPZbSHaG0wUJMCqQA
         78Xstz5naIswFfwytOjr+aIGfZcgUuwcPENYJBtowlGUz/3y2yyVFmToYGYb8e40BsZX
         JtWUxyI7ovZv+A3kLr9JuEYkqXY2ePFmam1wW2MqwX5rA1MyV2SN/mLHRpGUuCRBt3Nx
         s4ZWeyOBdqEJAUwgArU+3JW9nx4R6ewi32A0uj5NyPNgefbANAn9M0ibcVzgDJoXR3No
         /3BQ==
X-Gm-Message-State: AOAM5305AhiN2KJ1Sf6NsdaLXFfNU3zviT9JnYvgoJuG74aKLhlhbrM9
        NedxQ1oXL6LEp17O2K/Duw==
X-Google-Smtp-Source: ABdhPJzIrAPYwrTxeYyBssMDWjL0nXwlBTgg0SHWrsNuw4AiWN/2RL2jNeBp0V/VAeApkqjiImK6Cw==
X-Received: by 2002:a05:6638:2647:: with SMTP id n7mr1355405jat.9.1599606078731;
        Tue, 08 Sep 2020 16:01:18 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l16sm387039ilc.3.2020.09.08.16.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:01:18 -0700 (PDT)
Received: (nullmailer pid 1102281 invoked by uid 1000);
        Tue, 08 Sep 2020 23:01:16 -0000
Date:   Tue, 8 Sep 2020 17:01:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-clk@vger.kernel.org, m.szyprowski@samsung.com,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/3] clk: samsung: Add clk ID definitions for the CPU
 parent clocks
Message-ID: <20200908230116.GA1102229@bogus>
References: <CGME20200826171539eucas1p2e999972d3e7dd6dd701e312548933e87@eucas1p2.samsung.com>
 <20200826171529.23618-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826171529.23618-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 19:15:27 +0200, Sylwester Nawrocki wrote:
> Add clock ID definitions for the CPU parent clocks for SoCs
> which don't have such definitions yet. This will allow us to
> reference the parent clocks directly by cached struct clk_hw
> pointers in the clock provider, rather than doing clk lookup
> by name.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  include/dt-bindings/clock/exynos5250.h | 4 +++-
>  include/dt-bindings/clock/exynos5420.h | 5 +++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
