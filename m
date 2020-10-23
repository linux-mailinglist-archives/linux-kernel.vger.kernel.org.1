Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33988296DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S463108AbgJWLhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:37:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38086 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463013AbgJWLhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:37:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id bc23so1215254edb.5;
        Fri, 23 Oct 2020 04:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q0GPhn5JJBs3wXewaUlciqVNVuKfom97w1uHr11IvCY=;
        b=aJiM60jgb+rZXZgepqYNjJReB78BZk1p+2SLILcfhoBciOJ9bNh0hp6PkuzMxy8zzA
         jUNygnWTsi9ArfQK/P1cqs+OGpRFrlVUUlLdKhsx6s/vMeeHMtjz1WYj+u+pRAo0Zt90
         sw9CoCGfFBrbit495gxH+lbg0JAXPlXG9pAS4FFsXcaqWL/cBqAUdI5LmzMPwuXDfsu+
         J9ag5T5DvhUNa7ynHtqhHwMoNCiOwzIYbVmplchoT6M2Z9HHgWoNnau4qeo7RWv9s6iy
         XWImxVGOgX2XjckyvZCf7dv4NLHZIfuP8k0ZyS6iXyWmyle/UIiYyIOKL4jNgymQhspD
         WaFg==
X-Gm-Message-State: AOAM533/eZ5Ws6nifm5QcqRf6hnHa2wPHcL/Tk0n71M5qBRdQFdR0gKJ
        0vaY4nwnoLEE+vqPYQ9uYjU=
X-Google-Smtp-Source: ABdhPJw9zngAw3CwF0fnguGqxY1LBxTD9/TdNghCNKTeVN5b6ziJtWm1/KvaF81UKjnAWX9pBQ3yEQ==
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr1757401edb.274.1603453054564;
        Fri, 23 Oct 2020 04:37:34 -0700 (PDT)
Received: from kozik-lap ([194.230.155.171])
        by smtp.googlemail.com with ESMTPSA id p18sm185618edt.23.2020.10.23.04.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 04:37:33 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:37:28 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 1/2] soc: samsung: exynos-pmu: instantiate clkout driver
 as MFD
Message-ID: <20201023113728.GA61748@kozik-lap>
References: <20201001165646.32279-1-krzk@kernel.org>
 <20201001165646.32279-2-krzk@kernel.org>
 <32d3faaf-1631-3ebe-6d73-fe565c39639d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32d3faaf-1631-3ebe-6d73-fe565c39639d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 01:34:19PM +0200, Sylwester Nawrocki wrote:
> Hi,
> 
> On 10/1/20 18:56, Krzysztof Kozlowski wrote:
> > The Exynos clock output (clkout) driver uses same register address space
> > (Power Management Unit address space) as Exynos PMU driver and same set
> > of compatibles.  It was modeled as clock provider instantiated with
> > CLK_OF_DECLARE_DRIVE().
> > 
> > This however brings ordering problems and lack of probe deferral,
> > therefore clkout driver should be converted to a regular module and
> > instantiated as a child of PMU driver to be able to use existing
> > compatibles and address space.
> 
> It might have been cleaner to have the CLKOUT device as a PMU subnode in DT, 
> then device instantiation would be already covered by devm_of_platform_populate().
> But it gets a bit complicated to make such a change in a backward compatible way.

Yes, I agree, but the backward compatibility would be here a pain.
Optionally the driver could check for new DTB and skip adding MFD
children... but this is just simpler.

> 
> I have tested both patches on Trats2, where CLKOUT provides master clock for
> the audio codec.
> 
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Thanks!

Best regards,
Krzysztof
