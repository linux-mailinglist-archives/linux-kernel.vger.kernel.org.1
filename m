Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A1D2B5347
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgKPU4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:56:16 -0500
Received: from gate.crashing.org ([63.228.1.57]:45402 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgKPU4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:56:15 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0AGKlkSd011280;
        Mon, 16 Nov 2020 14:47:47 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 0AGKlk5a011279;
        Mon, 16 Nov 2020 14:47:46 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 16 Nov 2020 14:47:46 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Scott Wood <oss@buserror.net>
Cc:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Arnd Bergmann <arnd@kernel.org>, kbuild-all@lists.01.org,
        kernel test robot <lkp@intel.com>,
        Brian Cain <bcain@codeaurora.org>,
        Alan Modra <amodra@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Error: invalid switch -me200
Message-ID: <20201116204746.GC2672@gate.crashing.org>
References: <202011131146.g8dPLQDD-lkp@intel.com> <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com> <20201113190824.GA1477315@ubuntu-m3-large-x86> <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com> <20201113200444.GA1496675@ubuntu-m3-large-x86> <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com> <20201114002037.GW2672@gate.crashing.org> <CAFP8O3+NowYwhMAywd=R23HgOYnroWV9ZRkdyAejd08qsOF=6w@mail.gmail.com> <20201114005015.GZ2672@gate.crashing.org> <e19e3a9f47c988b30a19316ee3de2b588e20a641.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e19e3a9f47c988b30a19316ee3de2b588e20a641.camel@buserror.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 02:27:12PM -0600, Scott Wood wrote:
> On Fri, 2020-11-13 at 18:50 -0600, Segher Boessenkool wrote:
> > All the others work fine (and are needed afaics), it is only -me200 that
> > doesn't exist (in mainline binutils).  Perhaps -me5500 will work for it
> > instead.
> 
> According to Wikipedia e200 is from mpc55xx (for which I don't see any
> platform support having ever been added).  e5500 is completely different (64-
> bit version of e500mc).

Ah yes, confusing processor numbers :-(  That explains, sorry.


Segher
