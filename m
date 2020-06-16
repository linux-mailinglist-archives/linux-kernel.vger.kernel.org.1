Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417931FAB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 10:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgFPIbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFPIbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:31:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CADC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:31:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so19758489wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jaN1YSp7LZkDAge8c4wsn3ghBgplCfBlNLVxBmZ75EA=;
        b=bZJl1RxZOxEthuticY8IolQiYgEQBVGKn4aC6+AwgR14q/IV72DFH1ixxpypBQ9DHr
         MySjbGs7Ra7yacgcSOqQzy9oqsZugfQGXU9d6n9UNFDZQUYw05RZm1hqS8iMNrXsyaCj
         x4Wjxadc9rcacTs5YpXKDcN6e/5TB/g9eeDZ//Z4s1pW/+Ou8F5Jb/fD1ziH/X/S2Gf1
         56K5vLBFqy1faXQ5KaM4tOUiaatYrWMu6yY3AtyWzmHpgyeMdOzX/j17OX00Q6gJRLjv
         jLN3n30hspv5cF4MdbghhvdF/6dXH/vDUlVIELLlX99JnrUX4kvxWXi/yirFuojgz2bD
         EWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jaN1YSp7LZkDAge8c4wsn3ghBgplCfBlNLVxBmZ75EA=;
        b=kWcJASuWru+2vz3SMQjkO5uD1Ipp1euHGasbF4gu4my9N2jC7JdI97y1vfAxBYnHxX
         kySadjOvn0d/dZUr3yVu8axElzR7UGkOLMzNUfwbHpOX4hFAFcQdJkHt24NuMioOpGFi
         oTNG4pnYCP+EjIAf1h2HkeUc8uIje6nWo/thqvEQOGGXcwB4cEnHMjpQgCZaKAdAxdxC
         YbtlIFrHA5h26yHq2fBreMD3T1AOSGYBuaV9fvlZwy+kFHnZR1fbRzThbcTXPsxGuyJ+
         74rzqbu6ZNAcVuTIJp5qhVHszj74hIMl9QxblV3bIrD6inshhBS2mOWjehg+mw7DXROc
         DObw==
X-Gm-Message-State: AOAM531hdi90IvUFsAkCe2kRM616A81Hs4QCfeWpVMu8AC0FoqwjiA/G
        90mJi2TAlv2fwj6SmF54YkurBg==
X-Google-Smtp-Source: ABdhPJynT54R2+ECAa7/ZqX4VA4v9ObDCNGSoNKSEGPY2JLMe1/yTyG/HcLhOuklMUkTMP2w8XNcRg==
X-Received: by 2002:adf:9163:: with SMTP id j90mr1770497wrj.65.1592296292489;
        Tue, 16 Jun 2020 01:31:32 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id u4sm2957273wmb.48.2020.06.16.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 01:31:31 -0700 (PDT)
Date:   Tue, 16 Jun 2020 09:31:28 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 1/2] cpufreq: Register governors at core_initcall
Message-ID: <20200616083128.GB122049@google.com>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-2-qperret@google.com>
 <20200616042831.3kazrpvvjhbahoaj@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616042831.3kazrpvvjhbahoaj@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 Jun 2020 at 09:58:31 (+0530), Viresh Kumar wrote:
> On 15-06-20, 17:55, Quentin Perret wrote:
> > Currently, most CPUFreq governors are registered at core_initcall time
> > when used as default, and module_init otherwise. In preparation for
> > letting users specify the default governor on the kernel command line,
> > change all of them to use core_initcall unconditionally, as is already
> > the case for schedutil and performance. This will enable us to assume
> > builtin governors have been registered before the builtin CPUFreq
> > drivers probe.
> > 
> > And since all governors now have similar init/exit patterns, introduce
> > two new macros cpufreq_governor_{init,exit}() to factorize the code.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> > Note: I couldn't boot-test the change to spudemand, by lack of hardware.
> > But I can confirm cell_defconfig compiles just fine.
> > ---
> >  .../platforms/cell/cpufreq_spudemand.c        | 26 ++-----------------
> >  drivers/cpufreq/cpufreq_conservative.c        | 22 ++++------------
> >  drivers/cpufreq/cpufreq_ondemand.c            | 24 +++++------------
> >  drivers/cpufreq/cpufreq_performance.c         | 14 ++--------
> >  drivers/cpufreq/cpufreq_powersave.c           | 18 +++----------
> >  drivers/cpufreq/cpufreq_userspace.c           | 18 +++----------
> >  include/linux/cpufreq.h                       | 14 ++++++++++
> >  kernel/sched/cpufreq_schedutil.c              |  6 +----
> >  8 files changed, 36 insertions(+), 106 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
Quentin
