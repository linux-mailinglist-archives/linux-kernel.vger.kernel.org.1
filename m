Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5334D2FE081
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbhAUER4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbhAUEPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:15:01 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:14:21 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id c22so514889pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 20:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/js51H5j8YEkJ1QAw4QUNhESpoDZcZaipkmvSBF3vJ8=;
        b=jnfP/qhXcbEDwzaMplikgATYtZSVhAMgAERfcc+QbcAAHWoiuPaZZwIqTw1GHNSwJi
         YE0BkUGg1NnruNPc23VaSZUq+d/l8ymq1LaCCQXBB4sWgDsEDyofNnfAF1U1BnwhaTli
         tBfRJ9+7mlOtv13cI/s8LErc9jEEjAcboQahMLpCqx4dx+a6aDQ3fMtLXAQN2vNewO/5
         u4y/QM44MVVb9D3Lc47AZCvQgp4gjs9P1zuyqu9y46fQuAnChNnhDf0NmbCTjZ1fyoI/
         IepsQI4PhkGUBdEEa+XsTWjy6p/ZdaJlXncJ4KstLhL4cZ8k3Oi/EGe9KSR6JE2jjjWD
         9S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/js51H5j8YEkJ1QAw4QUNhESpoDZcZaipkmvSBF3vJ8=;
        b=Z3Xfl7BInipqbcNBLe35reqoufyLluKzCVxD8fPnWY1uBF+kpls4I7L+mdbzOnr7A0
         cwV6Fcl4BXAl/VySZEPgTO9aLxZLNQq9Is7hJbxW8vyUVO2VJavfEyQSODDJJuZkRRaE
         IlV76X1Ry4RsVBUaBtYSChCu+XJlMNUUySTzzobbacXdMGBQoTBrj/PWXvEo6IfCSQZT
         tMRWv3igLC4o0pAZM1LEm3fH4vKluphQ5MdU5omMDptDZlovc+MfBXYh9rd2UbxGmApr
         QTQZspFvEhs0m+6BM4738hRl/e6Ar+l6m1IYxJV6nz6s7PGK8dEFdVeaD/J2p+UGaG4T
         InXA==
X-Gm-Message-State: AOAM532azpUGwQjBCLr9ugheTKz/TRwU9Rp2oZf9km4P4/kMIxb7whF7
        bPc9N2g5keLQduO78lW+VOKJ2A==
X-Google-Smtp-Source: ABdhPJyNfu1oKhNTMhCWniKsJbvK5Z/+fGSCjJ0F7YGqkrUuyMSmojyCynTGUOGPqX23gVBM6LLiaQ==
X-Received: by 2002:a63:c54c:: with SMTP id g12mr12427133pgd.449.1611202460901;
        Wed, 20 Jan 2021 20:14:20 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id k141sm1520411pfd.9.2021.01.20.20.14.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jan 2021 20:14:20 -0800 (PST)
Date:   Thu, 21 Jan 2021 09:44:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Bill Mills <bill.mills@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH V5 0/5] dt: build overlays
Message-ID: <20210121041418.jcruqgfxnkblluah@vireshk-i7>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <CAL_JsqLoxHGphf4TbQtGPggq=kEUnpoR2QqCQD77ttjnVNt0wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLoxHGphf4TbQtGPggq=kEUnpoR2QqCQD77ttjnVNt0wg@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-21, 09:43, Rob Herring wrote:
> On Wed, Jan 20, 2021 at 1:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi Frank/Rob,
> >
> > I have picked all the related patches together into a single patchset,
> > so they can be properly reviewed/tested.
> >
> > This patchset makes necessary changes to the kernel to add support for
> > building overlays (%.dtbo) and the required fdtoverlay tool. This also
> > builds static_test.dtb using some of the existing overlay tests present
> > in drivers/of/unittest-data/ for better test coverage.
> >
> > Note that in order for anyone to test this stuff, you need to manually
> > run the ./update-dtc-source.sh script once to fetch the necessary
> > changes from the external DTC project (i.e. fdtoverlay.c and this[1]
> > patch).
> 
> Do we need a fdtoverlay fix for applying root node changes?

I have dropped the overlay files which were updating the root-node as
it looks like it shouldn't be done. Frank suggested (in his patch) to
drop overlay.dtb and I dropped overlay_base.dtb as well.

With that no other fixes are required.

-- 
viresh
