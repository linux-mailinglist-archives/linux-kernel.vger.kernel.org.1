Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399192D839D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437850AbgLLAsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgLLArw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:47:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5DAC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:47:12 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id iq13so3042356pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PamJb6v/nzXAYIWeQwRsVjH70oEHhC4JSEBOe7vfIGk=;
        b=TPT8/EC6xR3utlWN1CSX4roLav2nLurdzX8715ddu6JZe57CdhZl6ok9WESuGubDZE
         zXop1RdPxzP7yVg69h59WAggmiz4RovCvduP0Xl1Oiz2NjKuZOX7sldhqnvCWMdRgPcV
         gvTtlz3OKpq3RGUrTrh7+5AsPJwNMn8HQ33JcH4aff6n7rCVT6CI3CPR6LH/4k9GDL2e
         0uxVI/875eO7k0naLxIV4AIRgLInt+016gk7g0ahJ5EgXbIg3ccx3xwpmMe3hjmb2jLt
         luEe6ugafZJxjEPDgoJnqh09VRGELUjJQdXwnG2IIzHgOLN1cvY6xDpy0627lYHKYDPO
         mU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PamJb6v/nzXAYIWeQwRsVjH70oEHhC4JSEBOe7vfIGk=;
        b=E+U0JaPvBzhsF5UE+BCgfMs0WtRjvBesMAp1XJ0MQ46Oa+OfochKyZzZKO3LKbSluC
         4KrvnBen2Dj1ZRj8iZGK3qMp7nuWiZe8PSbCyfE94DE8Sp28ngQtgZLgFLxpxo4OaevR
         n4tZVb8YPKfXZsSyXWhGX24bnVbqj8i/F/zGk92b9rvOzbnAV251a2d2dBxF8hZaxqFI
         +vyYhXw0jK8wH2TQKz+ZFptRSAXpKvEdeeevo+ozz232YBS9FLgFc27XQrwkILqk/2B7
         wjE8nMueX0q7+qeEI+hVMRX+ww4MKDwMNazmcztMm7gy7ojCED+97ha5ICJ8GQOuy0RK
         JGsw==
X-Gm-Message-State: AOAM533G7GNCCBjeamFrR+lW5DilgjzSaMdw/PaySST1FxlUTzBRYYzu
        4kdt1OpdSttE9KIDlgN1jiDeFHXIsT7b4HVLWVCorw==
X-Google-Smtp-Source: ABdhPJy9ghvTzOVcPHO4wB/0v5sAwngJhKZuKdnPhOcDEpsjc823Z7NoCKbXluA2UU9qYj79RcR7F7P2J8PkTJ+OY3I=
X-Received: by 2002:a17:902:ed14:b029:da:9da4:3091 with SMTP id
 b20-20020a170902ed14b02900da9da43091mr13198016pld.29.1607734031484; Fri, 11
 Dec 2020 16:47:11 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a20LXgEQkYSpbFFrJs1mdg19W72dp3pbebH9Pkpib2g-g@mail.gmail.com>
 <CAKwvOdn79V-jaTH0mEtKyc-O+=Hj22bGtjKkZ1jriY2YABj-Lw@mail.gmail.com>
 <20201211093205.GU2414@hirez.programming.kicks-ass.net> <20201211163748.b37gashl6an6misu@treble>
 <20201211164915.GA2414@hirez.programming.kicks-ass.net> <20201211174610.2bfprpvrrlg66awd@treble>
 <CAKwvOdkWU3qQ_m3v1xn1Mm6+obC202NWEaF8g_gz3oqeeLkMQA@mail.gmail.com> <CAKwvOdmVq2StZbKZ0eaLEZmrPMgRUJMZFso+2G8tLJA_Nd-swA@mail.gmail.com>
In-Reply-To: <CAKwvOdmVq2StZbKZ0eaLEZmrPMgRUJMZFso+2G8tLJA_Nd-swA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 11 Dec 2020 16:47:00 -0800
Message-ID: <CAKwvOdkdBxucLOf-9a+PK7K+yFLjjPWgncGrXwtE5BHK=uevDA@mail.gmail.com>
Subject: Re: objtool crashes with some clang produced .o files
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000d8361605b639bfdb"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d8361605b639bfdb
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 11, 2020 at 4:42 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Dec 11, 2020 at 12:57 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Thanks for the patch!
> >
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1207
>
> Arnd reported another objtool warning/error from another randconfig in
> https://github.com/ClangBuiltLinux/linux/issues/1209 and CrOS just hit
> this as well.
>
> I haven't been able to isolate the configs yet (Arnd has posted the
> full config: https://pastebin.com/wwwhUL8L
>
> $ ./tools/objtool/objtool orc generate  --no-fp --no-unreachable
> --retpoline arch/x86/entry/thunk_64.o
> arch/x86/entry/thunk_64.o: warning: objtool: missing symbol for insn
> at offset 0x3e
>
> Is the offset 0x3e referring to the final `ret` instruction in
> preempt_schedule_notrace_thunk?  Observing insn_to_reloc_sym_addend()
> (with your patch applied), it looks like both calls to
> find_symbol_containing() with offset and offset-1 returns NULL.  I'm
> curious if there's another quirk going on here, or possibly a config
> from the randconfig that's messing up the special case? I don't follow
> the comment about:
> 119        * Hack alert.  This happens when we need to reference
> 120        * the NOP pad insn immediately after the function.
> 121        */
>
> Attached the object file FWIW.

Resending with the attachment renamed; I just got a bounceback from
Josh's mailer daemon.
-- 
Thanks,
~Nick Desaulniers

--000000000000d8361605b639bfdb
Content-Type: text/plain; charset="x-binaryenc"; name="thunk_64.o.txt"
Content-Disposition: attachment; filename="thunk_64.o.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kikzam8x0>
X-Attachment-Id: f_kikzam8x0

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
--000000000000d8361605b639bfdb--
