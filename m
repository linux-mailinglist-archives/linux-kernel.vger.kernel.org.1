Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739162B5572
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgKPX7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKPX7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:59:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E40C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:59:34 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c66so15727549pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=O1xH7v6ktQVn3E0/2gxoBsc75hXO4ialu92ExENyQt8=;
        b=QTvN2GpguC2hbzUk3PxCdzFk0C629djU1wo3x2Ibd6wdD3lYckzgDEYrHVBmZ6QMZ9
         p1ta4LmrHOLI/f8Xh0cbAni39HLqnF6n4HQ32i5tHvB27Wt+5U6ZywQ9YAG19OHm8jSj
         BaCx+PqZQxMVwWq0eNhpgzbNh+DnPskF3ZnN4yacpOJx3K4MymTRijUz4Bz1JLU8mg5q
         QxeBBhtHY10iMYjtYYTvP9nLkndBrArsf8OFcIXqyigNYJ+IsINks4k3AuOoYcCZwEll
         K2ZefLTEbe5W5ra3dOklddEszevKbLqQ4okBDaFC10hBHppyWr4ttQ6OSr8CMVnU1pi/
         NKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=O1xH7v6ktQVn3E0/2gxoBsc75hXO4ialu92ExENyQt8=;
        b=lBGEs8ZkWlE+afBCeE+VaAsD2ryKbMopUeiA/HV9+XRyXjtSlZC5nORp4afLybPsJg
         4wMDdTGsh2mcU6pNi0k8nM5+4h+8Aja4sVPED744oqfxRHJomL0LzjB+1EFvVh3CKrXh
         ihx2fca7md65QFxa5wIvya+gLVk00U2ZY22ggcxZVBUWKvTTNwClxDRNrPuZ6kw2m30F
         y2Hbm8RE4s9BIxbYiQh7H3eIp2tv4EWwIUUQMkE1zF7r8jCmpv4LhBCz8NnBTyeG1wFM
         vs8DPs6MLe5CJD3Z6b4osez9i7bJLufz8nDGnR97TgsuchyKSAss3aGwrUZz129fyONC
         lr3w==
X-Gm-Message-State: AOAM532qu8q8JV1ixet9cNhnJo/G91xAxxUzH1Gc7W9OFyP5H0HlOuVy
        +zFXfO2v/wx4+fsry64gOSY=
X-Google-Smtp-Source: ABdhPJzmOqkplqffAvi8zciJP+9vijXcBirX83BuorVnt/LrPJjmeIByYbr/7xfEAWl5K2if3H7noA==
X-Received: by 2002:a17:90a:5d93:: with SMTP id t19mr1437516pji.220.1605571174368;
        Mon, 16 Nov 2020 15:59:34 -0800 (PST)
Received: from bubble.grove.modra.org ([2406:3400:51d:8cc0:2b49:d8db:361d:de4a])
        by smtp.gmail.com with ESMTPSA id m3sm19708513pfd.217.2020.11.16.15.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 15:59:33 -0800 (PST)
Received: by bubble.grove.modra.org (Postfix, from userid 1000)
        id DFD9B85935; Tue, 17 Nov 2020 10:29:29 +1030 (ACDT)
Date:   Tue, 17 Nov 2020 10:29:29 +1030
From:   Alan Modra <amodra@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: Error: invalid switch -me200
Message-ID: <20201116235929.GT15956@bubble.grove.modra.org>
References: <202011131146.g8dPLQDD-lkp@intel.com>
 <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86>
 <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
 <20201113200444.GA1496675@ubuntu-m3-large-x86>
 <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
 <20201114002037.GW2672@gate.crashing.org>
 <CAFP8O3+NowYwhMAywd=R23HgOYnroWV9ZRkdyAejd08qsOF=6w@mail.gmail.com>
 <20201114005015.GZ2672@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201114005015.GZ2672@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 06:50:15PM -0600, Segher Boessenkool wrote:
> On Fri, Nov 13, 2020 at 04:37:38PM -0800, Fāng-ruì Sòng wrote:
> > On Fri, Nov 13, 2020 at 4:23 PM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > > On Fri, Nov 13, 2020 at 12:14:18PM -0800, Nick Desaulniers wrote:
> > > > > > > Error: invalid switch -me200
> > > > > > > Error: unrecognized option -me200
> > > > > >
> > > > > > 251 cpu-as-$(CONFIG_E200)   += -Wa,-me200
> > > > > >
> > > > > > Are those all broken configs, or is Kconfig messed up such that
> > > > > > randconfig can select these when it should not?
> > > > >
> > > > > Hmmm, looks like this flag does not exist in mainline binutils? There is
> > > > > a thread in 2010 about this that Segher commented on:
> > > > >
> > > > > https://lore.kernel.org/linuxppc-dev/9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org/
> > > > >
> > > > > Guess this config should be eliminated?
> > >
> > > The help text for this config options says that e200 is used in 55xx,
> > > and there *is* an -me5500 GAS flag (which probably does this same
> > > thing, too).  But is any of this tested, or useful, or wanted?
> > >
> > > Maybe Christophe knows, cc:ed.
> > 
> > CC Alan Modra, a binutils global maintainer.
> > 
> > Alan, can the few -Wa,-m* options deleted from arch/powerpc/Makefile ?
> 
> All the others work fine (and are needed afaics), it is only -me200 that
> doesn't exist (in mainline binutils).

Right, and a quick check says it never existed.  There is e200z4,
added to binutils with dfdaec14b0d, 2016-08-01, but the kernel -me200
was added in 2005.  I suspect the toolchain support only existed
inside Freescale and pushing it upstream was too difficult.

-- 
Alan Modra
Australia Development Lab, IBM
