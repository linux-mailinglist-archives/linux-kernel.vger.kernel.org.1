Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8051A2B2A01
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgKNAhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgKNAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:37:51 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF03C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:37:50 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f38so8458095pgm.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2NjKbZuVprfurSTRWSrDJU/we/C3Nu5LpJ6PGwglq8=;
        b=Z9oKPZ575c3gDcwmpE6oh7tqhsVlvfXcKkQMjqIEyhqafJEH0arJjzt6HKxTOeKdIZ
         PJDW9MBWH0bSqoz2543b1j9wEaLcnziidUio4lVlQAKMszkkwEMUmzxaYcN3AIyy4KIJ
         tB7ZVdIpP4PJX3shsLfgYGV7OHoLGHRiPCHK0kSVOt9mIC6i0Wa8bPLJggU+L08ru9PR
         4QiNO+z93vUcvFANoWM8AruWch8OlZsBNAXXetYjh9UXbrkyxyVvTKmvdMkPmvkFkjyI
         gBEAAhWYww7IXW+H5mqqVkkbS0caX87g4Ntp4fPWB/fUaCkE6vxqGz+hfRG4hVvAVhdS
         2pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2NjKbZuVprfurSTRWSrDJU/we/C3Nu5LpJ6PGwglq8=;
        b=YAhGgbGgI776TQzkUHIB2uvInoCZotwzfDYFsVu2lNZT+RSW17gX6N/1No7HjTzyx+
         lIcKQEGGKtvNPNDiJl6XHcwA0AO7zru83FABgWjKFiTjrXHCmbKqobMdLzpoKx/FPi/s
         4xOHEAms2i68E9XhWbAmjj7zUEQonHaEoBeWV6gSufpPISVsC6xRxvzcgzp+qv/rc5vR
         kSSXdZrr8EY85LSDvWhmQ0v958yuLFdg0djB2X6YT/BdzrWgrsfbCiNZwaaFV7SXX+KC
         gT4WsVRsrbgyOKLMqjK8UGc3Cir0Qvu78bAPAM+lOHjRdJ9POm9zmQs6MPvDRDQEhMNe
         aj2w==
X-Gm-Message-State: AOAM532uXvfEAgEDDOl6vq3XEvRN6f6lONzAAWQm0/Rt1malJEXcmwMP
        19Nlewd+Z7Q6btDEd60CFJswa2P4dpNI5voe0bJJ+w==
X-Google-Smtp-Source: ABdhPJytitMVpnlRtstqvDugqyzwNtoNHgcEDb1V+JzjIwJS/H4JKIOfdjbk7bK5aRUy7ob8mKVI6yaK4ULDekZMgyo=
X-Received: by 2002:a62:75c6:0:b029:18a:d510:ff60 with SMTP id
 q189-20020a6275c60000b029018ad510ff60mr4179679pfc.35.1605314269534; Fri, 13
 Nov 2020 16:37:49 -0800 (PST)
MIME-Version: 1.0
References: <202011131146.g8dPLQDD-lkp@intel.com> <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86> <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
 <20201113200444.GA1496675@ubuntu-m3-large-x86> <CAKwvOdkBSGPaKmQY1nERVe4_n19Q=MUtuwdond=FJAAF9N9Zhg@mail.gmail.com>
 <20201114002037.GW2672@gate.crashing.org>
In-Reply-To: <20201114002037.GW2672@gate.crashing.org>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 13 Nov 2020 16:37:38 -0800
Message-ID: <CAFP8O3+NowYwhMAywd=R23HgOYnroWV9ZRkdyAejd08qsOF=6w@mail.gmail.com>
Subject: Re: Error: invalid switch -me200
To:     Alan Modra <amodra@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 4:23 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Nov 13, 2020 at 12:14:18PM -0800, Nick Desaulniers wrote:
> > > > > Error: invalid switch -me200
> > > > > Error: unrecognized option -me200
> > > >
> > > > 251 cpu-as-$(CONFIG_E200)   += -Wa,-me200
> > > >
> > > > Are those all broken configs, or is Kconfig messed up such that
> > > > randconfig can select these when it should not?
> > >
> > > Hmmm, looks like this flag does not exist in mainline binutils? There is
> > > a thread in 2010 about this that Segher commented on:
> > >
> > > https://lore.kernel.org/linuxppc-dev/9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org/
> > >
> > > Guess this config should be eliminated?
>
> The help text for this config options says that e200 is used in 55xx,
> and there *is* an -me5500 GAS flag (which probably does this same
> thing, too).  But is any of this tested, or useful, or wanted?
>
> Maybe Christophe knows, cc:ed.
>
>
> Segher

CC Alan Modra, a binutils global maintainer.

Alan, can the few -Wa,-m* options deleted from arch/powerpc/Makefile ?
The topic started at
http://lore.kernel.org/r/202011131146.g8dPLQDD-lkp@intel.com and
people would like to get rid of some options (if possible).
