Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE672FCE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbhATKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbhATJ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:56:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B67AC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:55:45 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p18so14825386pgm.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VIYjzidVjOUfXvZVNPBo0ITX6aT8Xxm7GMPqLF7Yq6o=;
        b=DYk2cDbWItxBTsbelOBfJ/jCUmStslMqiaIMpID1yGRAsUB/Z5EceuBAYcVIZLvPBX
         iB8G5aNcZvpcXjEUY0qAVCUOaDl1/FjpT4JTvKby0r49RnCJJThtY9+qX/KxzDAuQSZQ
         SdWUuciIDJ3JUnLwc38eINldPpUa5msfc1VHPQ37ksrrQbXG94xow10ltpN9FIWMjc1e
         1kHgoAQoINlAfVVE9klhv4QYh6bwboRnfiFD72EHJr4X12bj2dSYw7e8BShAF8ysmKsq
         79n6bwhPbXDLHmXro0PPIqI/f64Xnna2Hb2gJHtQPH09yais3/1/EFCfHbFXYl7nBOmn
         Q3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VIYjzidVjOUfXvZVNPBo0ITX6aT8Xxm7GMPqLF7Yq6o=;
        b=kODG0yo5Xeb3snv7Ef4HU7K2KM7YltAIMtVx/r+/9DrfuOugmeQBmtz83skcluF4f1
         ngwwLOyUYOeVmecnqk80N8ofWz7/heBtoa3yTftWHZWxihsVM/n/AYIuDmOVIpts89is
         dvARdoesB5CPcH6ioQ2eV9Ded1Dmla/IXcvuxdxZeeb3kwi6rSQfS5YESQzE3IDMrS4h
         ovuqjY7mLCKmk9C7kbdpAZv7eNTsm6OqDOlWuP5Bw9qNJN2AoU7omXmr8PkeySR/+A12
         7eR9KJXfMr5nhuvZeeUOuzHcjwZ/quL5ZRrHL1TwnoCZp5vZr2YN1WXPUAS5AyS893DB
         xz4Q==
X-Gm-Message-State: AOAM532dBeEKEJG79QzscFRofwYCmS+xm7ShtKlR6VVjySqI/dN0DkRC
        IocPc85GwIOnUVvTpKMo05Db3A==
X-Google-Smtp-Source: ABdhPJwoQnHz+OxtbiPdDqydFF5GFBJ0JnL2s70tksWYeMC91Pw4+Bno1qkkE3VD/vMLO7ANn7FIEg==
X-Received: by 2002:a63:e:: with SMTP id 14mr8434233pga.426.1611136544456;
        Wed, 20 Jan 2021 01:55:44 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k8sm1780809pfp.114.2021.01.20.01.55.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 01:55:43 -0800 (PST)
Date:   Wed, 20 Jan 2021 15:25:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Bill Mills <bill.mills@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH V5 4/5] kbuild: Add support to build overlays (%.dtbo)
Message-ID: <20210120095541.f354ml4h36rfc4gx@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <6e57e9c84429416c628f1f4235c42a5809747c4c.1611124778.git.viresh.kumar@linaro.org>
 <CAK7LNATPSBrmSC_if+6sK0pwi1ksBZ7RXK1mndj1AGCX3gkj+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATPSBrmSC_if+6sK0pwi1ksBZ7RXK1mndj1AGCX3gkj+g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 17:58, Masahiro Yamada wrote:
> > +%.dtb %.dtbo: include/config/kernel.release scripts_dtc
> >         $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> 
> 
> No, this is wrong because it does not work
> as grouped targets.
> 
> You need to separate them.
> 
> 
> 
> %.dtb: include/config/kernel.release scripts_dtc
>          $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> 
> %.dtbo: include/config/kernel.release scripts_dtc
>          $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> 
> 
> 
> 
> See GNU make manual.
> 
> 
> "Pattern rules may have more than one target; however, every target
> must contain a % character.
> Pattern rules are always treated as grouped targets"
> 
> https://www.gnu.org/software/make/manual/html_node/Pattern-Intro.html

Hmm, okay I will do that.

I did it this way because I saw similar stuff at some other places. I
am not a regular Makefile hacker, there is every chance I am reading
it wrong.

$ git grep "%.*%.*:" | grep Makefile
Makefile:%/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
scripts/Makefile.build:$(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
scripts/Makefile.host:$(obj)/%.tab.c $(obj)/%.tab.h: $(src)/%.y FORCE
scripts/genksyms/Makefile:$(obj)/pars%.tab.c $(obj)/pars%.tab.h: $(src)/pars%.y FORCE
tools/perf/Documentation/Makefile:$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : %.txt
tools/perf/Documentation/Makefile:$(OUTPUT)%.1 $(OUTPUT)%.5 $(OUTPUT)%.7 : $(OUTPUT)%.xml

-- 
viresh
