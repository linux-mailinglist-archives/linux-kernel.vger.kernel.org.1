Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693FC2D8389
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437820AbgLLAnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437795AbgLLAmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:42:53 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D7C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:42:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x12so4996031plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m++FJGCpjdIsgXi9J+g0QKXQurSaVcqOL9EcUIUCaes=;
        b=ri1fHgSK2qZjfwm++ptwyIZ6PUKexoASV4LPMTl4kUyulzxWzj2fPX+uGGtAqfwtcU
         /KBlVRpWEOXufeNfwwqPvXaCa8Dahz3l8qjXrsh/fd07RQhWpGIp36z4EZBnwezUCg9Q
         CiT+liJGxZBpiOlXvsnJeDb+gyXb+5sSY/ygoqX1Hqv8ik3ZSK/HBzXx4X+Nu92Dkllb
         d0aguXh1ld5XJSbw63a5ScSICYWlJWQWRn6W2Pf8iG5sQw4Hpd+estGE3cbTCjk41sa+
         OLxt+NyH5jdU7RwakU1FaOalNr5JsPv8XjzIr2XVqVyQrCKc7CNmSaMB0xsGnDLOQVv1
         UGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m++FJGCpjdIsgXi9J+g0QKXQurSaVcqOL9EcUIUCaes=;
        b=ESjSzgmOEGuZyAtOuzwabAsl2uFEJ4wYsROxcKzcqNu8+8arXSx5RZrSgqa/aSszQ3
         qWJXxLeuHZG/DQYXW+dXvAULXcHHJ6fOaCEgMDekz2z2yoFjIW+jyD8doiWWpmiIlrxa
         NySNmCQCmx11qat3XpuP73e8ilCakXS2yISH9lyVB8rQXBjmA7ABFo6cokOCkH8hDstj
         1HvwF1VUdBK8I3BpMcrr2ksMlE/CKYMl2Dzk6G8TmjU5yBh/Op1xiOzI+pSWhS+xrM0Z
         mCbCbwOphZHJvpZWIe6oQoommjQRihYNJlwKAyGS0qgcBZ5gihQGj6i3Bld+R2+mcPuK
         XjKQ==
X-Gm-Message-State: AOAM530VTjshFlF69rsOSDcdyr+G4vfafOkhBOTUqiGfB2k4J3Niw7o5
        VemSYXHC1zvValU+g6kBMCcPPXqqxGvdsdR2kCJ2sQ==
X-Google-Smtp-Source: ABdhPJxrbrz+E3zaYJEAr/1SNC2EWLs2jVj37kOMKcq4lOAenSQMOZMD40zfM0ppQ/fVchG2Kk9dB0ogVdRCW44RbKU=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr13423128plc.10.1607733733005; Fri, 11
 Dec 2020 16:42:13 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
 <20201211093205.GU2414@hirez.programming.kicks-ass.net> <20201211163748.b37gashl6an6misu@treble>
 <20201211164915.GA2414@hirez.programming.kicks-ass.net> <20201211174610.2bfprpvrrlg66awd@treble>
 <CAKwvOdkWU3qQ_m3v1xn1Mm6+obC202NWEaF8g_gz3oqeeLkMQA@mail.gmail.com>
In-Reply-To: <CAKwvOdkWU3qQ_m3v1xn1Mm6+obC202NWEaF8g_gz3oqeeLkMQA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Dec 2020 16:42:01 -0800
Message-ID: <CAKwvOdmVq2StZbKZ0eaLEZmrPMgRUJMZFso+2G8tLJA_Nd-swA@mail.gmail.com>
Subject: Re: objtool crashes with some clang produced .o files
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: multipart/mixed; boundary="0000000000000e2f0405b639ae57"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000e2f0405b639ae57
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 11, 2020 at 12:57 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Thanks for the patch!
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1207

Arnd reported another objtool warning/error from another randconfig in
https://github.com/ClangBuiltLinux/linux/issues/1209 and CrOS just hit
this as well.

I haven't been able to isolate the configs yet (Arnd has posted the
full config: https://pastebin.com/wwwhUL8L

$ ./tools/objtool/objtool orc generate  --no-fp --no-unreachable
--retpoline arch/x86/entry/thunk_64.o
arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn
at offset 0x3e

Is the offset 0x3e referring to the final `ret` instruction in
preempt_schedule_notrace_thunk?  Observing insn_to_reloc_sym_addend()
(with your patch applied), it looks like both calls to
find_symbol_containing() with offset and offset-1 returns NULL.  I'm
curious if there's another quirk going on here, or possibly a config
from the randconfig that's messing up the special case? I don't follow
the comment about:
119        * Hack alert.  This happens when we need to reference
120        * the NOP pad insn immediately after the function.
121        */

Attached the object file FWIW.
-- 
Thanks,
~Nick Desaulniers

--0000000000000e2f0405b639ae57
Content-Type: application/octet-stream; name="thunk_64.o"
Content-Disposition: attachment; filename="thunk_64.o"
Content-Transfer-Encoding: base64
Content-ID: <f_kikz03r70>
X-Attachment-Id: f_kikz03r70

f0VMRgIBAQAAAAAAAAAAAAEAPgABAAAAAAAAAAAAAAAAAAAAAAAAAKgBAAAAAAAAAAAAAEAAAAAA
AEAABQABAFVIieVXVlJRUEFQQVFBUkFT6AAAAADrGFVIieVXVlJRUEFQQVFBUkFT6AAAAADrAEFb
QVpBWUFYWFlaXl9dwwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABCAAAAEAAAAAAAAAAAAAAAAAAA
AAAAAABTAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAjAAAAEgACABgAAAAAAAAAGAAAAAAAAAAMAAAA
EgACAAAAAAAAAAAAGAAAAAAAAAASAAAAAAAAAAQAAAABAAAA/P////////8qAAAAAAAAAAQAAAAC
AAAA/P////////8ALnJlbGEudGV4dABwcmVlbXB0X3NjaGVkdWxlX3RodW5rAHByZWVtcHRfc2No
ZWR1bGVfbm90cmFjZV90aHVuawBwcmVlbXB0X3NjaGVkdWxlAHByZWVtcHRfc2NoZWR1bGVfbm90
cmFjZQAuc3RydGFiAC5zeW10YWIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABsAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAo
AQAAAAAAAHwAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAABgAAAAEAAAAGAAAAAAAAAAAA
AAAAAAAAQAAAAAAAAAA/AAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAEAAAAEAAAAAAAA
AAAAAAAAAAAAAAAAAPgAAAAAAAAAMAAAAAAAAAAEAAAAAgAAAAgAAAAAAAAAGAAAAAAAAAB0AAAA
AgAAAAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAHgAAAAAAAAAAQAAAAEAAAAIAAAAAAAAABgAAAAA
AAAA
--0000000000000e2f0405b639ae57--
