Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408012B29E0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgKNA3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:29:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:52833 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKNA3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:29:08 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0AE0Kdnt005533;
        Fri, 13 Nov 2020 18:20:39 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0AE0KbKx005528;
        Fri, 13 Nov 2020 18:20:37 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 13 Nov 2020 18:20:37 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: Error: invalid switch -me200
Message-ID: <20201114002037.GW2672@gate.crashing.org>
References: <202011131146.g8dPLQDD-lkp@intel.com> <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com> <20201113190824.GA1477315@ubuntu-m3-large-x86> <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com> <20201113200444.GA1496675@ubuntu-m3-large-x86> <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:14:18PM -0800, Nick Desaulniers wrote:
> > > > Error: invalid switch -me200
> > > > Error: unrecognized option -me200
> > >
> > > 251 cpu-as-$(CONFIG_E200)   += -Wa,-me200
> > >
> > > Are those all broken configs, or is Kconfig messed up such that
> > > randconfig can select these when it should not?
> >
> > Hmmm, looks like this flag does not exist in mainline binutils? There is
> > a thread in 2010 about this that Segher commented on:
> >
> > https://lore.kernel.org/linuxppc-dev/9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org/
> >
> > Guess this config should be eliminated?

The help text for this config options says that e200 is used in 55xx,
and there *is* an -me5500 GAS flag (which probably does this same
thing, too).  But is any of this tested, or useful, or wanted?

Maybe Christophe knows, cc:ed.


Segher
