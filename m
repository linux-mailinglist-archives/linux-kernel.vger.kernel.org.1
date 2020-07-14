Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0521FF80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 23:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgGNVBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 17:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgGNVBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:01:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD2FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:01:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z15so175086wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UgHePzwDWkj9USOlRyqZl2fpeHBfUUnRLMgbgOfnUNw=;
        b=XcralwfLeQ7zj7+U3F2rSAPGT3V8zamxaPPIYWkdnVcg1eqJTtcBIzvMHPoh9SZOlN
         P+OH+yjrTB/h8zYJDIOIwKL2Uab/VJC2d7uLCgECqsDHk/RuOurQx/rlbdRiQlI1cdXH
         b77V2g6/Fp8ue7H6AeTCP5hxb8i8yFxzvwf/VYlt3Czd8VIQbplQ/KHogvebw3BARvGA
         g/Rwirjizpgq7QoRm2E6MGGFZEj0oEU4o/gRnJcoHdQk0/Atr12T1jWx70vifMvObnQ4
         R8EbHOurRCPlsJb5mU5p/My0E3ftHvacHOGbXQwL4o2ntH76gHDdOrKYJUObO3jiLYD6
         ordg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UgHePzwDWkj9USOlRyqZl2fpeHBfUUnRLMgbgOfnUNw=;
        b=nCoWSAgGwKKdSS+cz7UVurGllsxCv6Dxe/5oSpyyqpxv2kofzY39ct+LAqNRXdwcLA
         DEDG1x5uIVp0eePxTLH9SNkHL9THZLd4QBlhWu6TwPbjDpOJAV5wtWc/IY+lUI82S5xT
         bw7pR1b4++iZYgEwXx5FDGxUd3TEvGt5SAGGsstsznZa8KxJ7jEWEIqUCCRiUReY9qZ7
         bJO2mbujetpbkmSkg+rsCogZn4FU6eobGRYKgwImuGSvSPntB6PUEM9BynfD43iRC/cl
         88v1tqTuRiFcn0Ue/3MPLEfvuZiQoPfd48bjwbYVe6pJAuUetSi17yWU2N5TlF+o98lF
         jgnw==
X-Gm-Message-State: AOAM530DbmKcaVZU1gipQhhfHJRzH/9gZtwiD4PxaFMNke7VWsSd2Ygt
        viIzL0kVRfpzLSKm2lloUaaqug==
X-Google-Smtp-Source: ABdhPJxrP4msc1UWDW+tsY/mSi27FFkqHu34o0CYWRyeqHZuSTP+UmUSIKZrgJtsQIqST40ul+ICCQ==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr7773895wrr.364.1594760458999;
        Tue, 14 Jul 2020 14:00:58 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id b184sm15426wmc.20.2020.07.14.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:00:58 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:00:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Sadykov <denis.m.sadykov@intel.com>,
        Andy Grover <andrew.grover@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH 08/13] cpufreq: acpi-cpufreq: Take 'dummy' principle one
 stage further
Message-ID: <20200714210056.GF1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-9-lee.jones@linaro.org>
 <CAJZ5v0igiz-VmmDC2qsZ3AhqjGhM54LHMLeLdZ7Dr=h5Dm9Rrg@mail.gmail.com>
 <8b2f7674-9e33-e09c-cf99-84c59edb9779@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b2f7674-9e33-e09c-cf99-84c59edb9779@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020, Robin Murphy wrote:

> On 2020-07-14 17:03, Rafael J. Wysocki wrote:
> > On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > 
> > > If we fail to use a variable, even a 'dummy' one, then the compiler
> > > complains that it is set but not used.  We know this is fine, so we
> > > set it to its own value here.
> > 
> > Which is kind of ugly in my personal view.  I hope that the compiler
> > will actually optimize the extra code away ...
> > 
> > > Fixes the following W=1 kernel build warning(s):
> > 
> > Well, "Makes the following ... warning(s) go away:" rather ...
> 
> Isn't that what we have __maybe_unused and __always_unused for?

Yes, that would be better.

I didn't know you could do that with standard variables.

Will fix.

> > >   drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_intel’:
> > >   drivers/cpufreq/acpi-cpufreq.c:247:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
> > >   drivers/cpufreq/acpi-cpufreq.c: In function ‘cpu_freq_read_amd’:
> > >   drivers/cpufreq/acpi-cpufreq.c:265:11: warning: variable ‘dummy’ set but not used [-Wunused-but-set-variable]
> > > 
> > > Cc: Andy Grover <andrew.grover@intel.com>
> > > Cc: Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
> > > Cc: Dominik Brodowski <linux@brodo.de>
> > > Cc: Denis Sadykov <denis.m.sadykov@intel.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/cpufreq/acpi-cpufreq.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > > index 429e5a36c08a9..d38a693b48e03 100644
> > > --- a/drivers/cpufreq/acpi-cpufreq.c
> > > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > > @@ -247,6 +247,7 @@ static u32 cpu_freq_read_intel(struct acpi_pct_register *not_used)
> > >          u32 val, dummy;
> > > 
> > >          rdmsr(MSR_IA32_PERF_CTL, val, dummy);
> > > +       dummy &= dummy; /* Silence set but not used warning */
> > >          return val;
> > >   }
> > > 
> > > @@ -264,6 +265,7 @@ static u32 cpu_freq_read_amd(struct acpi_pct_register *not_used)
> > >          u32 val, dummy;
> > > 
> > >          rdmsr(MSR_AMD_PERF_CTL, val, dummy);
> > > +       dummy &= dummy; /* Silence set but not used warning */
> > >          return val;
> > >   }
> > > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
