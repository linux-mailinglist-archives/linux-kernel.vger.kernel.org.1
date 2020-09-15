Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42CA26B038
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgIOWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgIOVN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:13:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986CEC06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:13:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l71so163309pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 14:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNSeN+6ns4NcR6aRqapmefDb08KgJSUKumeh/J+1Z+Y=;
        b=g5wkGJvCJEDe1SMhGpVw9GDV0A0nY5JoA7VASZT1Z3qoRtyPab0IkCh7lIrCK2dQdf
         xEmk0BDhCCmuYKOpWJZet9cLL2kbqB+c/N+HyKetfeYJuuwf/M0iPN1WYuRPxqmj5/8W
         yvCL+E8mbbdYjX4hMSEtTSSG7WXoW8Qv46KvfMn8mkPQonQgjWorME0OLHBiN/d2qvSH
         EkSETVry79QJ90oQtRhKLahgQtaj6PyzZduSEYPWKY2JNw8NhF4M0eRBmH9F8Hda1X3j
         /+YNTiR8AmHj53pD40uo4eQebOtTJxaSCbrvw8hM+MTtOpaQUMteAmbxEh/YYailcmV5
         9IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNSeN+6ns4NcR6aRqapmefDb08KgJSUKumeh/J+1Z+Y=;
        b=dGM/BeMPJNUAUAw5KYk2rFPNpy1X4KoQvhw7LMB1UKXG7dTQiJpB+K89qZHyIw2QuE
         MbsghMWLiAbK4o1ICh6i4yx8HeqQTdvDxlZQ1nj/HJX3tiS4zKAuJpemGu3B8ZEO38O1
         1bmVFZ0o46PI8aVfWk+Y7aeeU5wrulbypqkFftCpds01D0gwFwnxStDiYNO8gf7aKuhy
         VyyN15qqdBq1KtSTjWBv4uEWGcX4UpasF0W9GBj8VxqgfyAuvUqyKkHuWUInaWdvVfKQ
         SE22ntdvsVizLupR3MavJbsPI7qIj1lay6ifec6aqQLir+amH06ih7k6Oiwt6tvZ3xwp
         paWQ==
X-Gm-Message-State: AOAM532xWN647g9loTvbXqDL9XSaQWsvfG1Zbk+hiwENRyBv4MNiBKIW
        oH8LiI79ivJWI6C9fvV/HLPQ52P8Y+OITbPN5vGK/A==
X-Google-Smtp-Source: ABdhPJyfLuK3tcUMJiaFaerq9akmwQeVVIhJt3PZJvdUYoOc12LgUt09WfrbQCVp/n8ciG8+dutvTDYnuJ/+YYes4LY=
X-Received: by 2002:aa7:99c2:0:b029:142:440b:fa28 with SMTP id
 v2-20020aa799c20000b0290142440bfa28mr327604pfi.30.1600204393819; Tue, 15 Sep
 2020 14:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com> <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian> <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble> <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Sep 2020 14:13:01 -0700
Message-ID: <CAKwvOdmNzapwEo26m0soAR2OLFxOoERPKbKgvQ0bfoqjNkEVCg@mail.gmail.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING e6eb15c9ba3165698488ae5c34920eea20eaa38e
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Marco Elver <elver@google.com>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 1:12 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 10:02 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 06:05:54PM +0200, Borislav Petkov wrote:
> > > On Tue, Sep 15, 2020 at 10:18:16PM +0800, Rong Chen wrote:
> > > > On Tue, Sep 15, 2020 at 03:55:19PM +0200, Borislav Petkov wrote:
> > > > > On Tue, Sep 15, 2020 at 09:42:56PM +0800, kernel test robot wrote:
> > > > > > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  x86/seves
> > > > > > branch HEAD: e6eb15c9ba3165698488ae5c34920eea20eaa38e  KVM: nSVM: Avoid freeing uninitialized pointers in svm_set_nested_state()
> > > > > >
> > > > > > Warning in current branch:
> > > > > >
> > > > > > arch/x86/kernel/sev-es.o: warning: objtool: ist_exc_vmm_communication()+0x12: unreachable instruction
> > > > > >
> > > > > > Warning ids grouped by kconfigs:
> > > > > >
> > > > > > clang_recent_errors
> > > > > > `-- x86_64-randconfig-r001-20200913
> > > > > >     `-- arch-x86-kernel-sev-es.o:warning:objtool:ist_exc_vmm_communication():unreachable-instruction
> > >
> > > Ok, I can't trigger this with gcc-9, gcc-10 and clang-10.
> > >
> > > .config below says clang-12 so it could be some experimental
> > > bug^Wfeature :)
> > >
> > > peterz says this has been fixed by:
> > >
> > > 318af7b80b6a ("Revert "kbuild: use -flive-patching when CONFIG_LIVEPATCH is enabled"")
> > >
> > > but that was reportedly for gcc.
> > >
> > > Lemme Cc the people of interest and leave the rest in here for
> > > reference. Note that CONFIG_LIVEPATCH is enabled in that .config.
> >
> > If somebody can share the .o file, I can take a look.
>
> Taking a look at the latest report of unreachable instruction from
> objtool from 0day bot:
> https://groups.google.com/g/clang-built-linux/c/IbF96FeMT8g
>
> $ cd /tmp
> $ git clone --depth=1
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git --branch
> x86/seves
> $ cd tip
> $ gunzip <attached config.gz>
> $ cp config .config
> $ make LLVM=1 -j71 2> log.txt
> $ grep warning: log.txt | cut -d ' ' -f 2- | sort | uniq -c
>    3737 warning: objtool: asan.module_ctor()+0xc: call without frame
> pointer save/setup
>    3737 warning: objtool: asan.module_dtor()+0xc: call without frame
> pointer save/setup
>       1 warning: objtool: early_alloc()+0x6b: unreachable instruction
>       1 warning: objtool: ist_exc_vmm_communication()+0x12:
> unreachable instruction
>       1 warning: objtool: kmem_cache_create_usercopy()+0x286:
> unreachable instruction
>       1 warning: objtool: oops_end()+0xc1: unreachable instruction
>       1 warning: objtool: __register_nosave_region()+0x87: unreachable
> instruction
> $ ag ist_exc_vmm_communication
> arch/x86/kernel/sev-es.c
> 1351:           ist_exc_vmm_communication(regs, error_code);
> $ gzip -9 arch/x86/kernel/sev-es.o
> <attached>
>
> If I remove CONFIG_KASAN=y, I actually get way more unreachable
> instruction failures!  Let me play with
> tools/testing/ktest/config-bisect.pl and see if I can narrow down the
> set of configs from the randconfig.  Also, it's possible that there's
> more than one bug here.

tools/testing/ktest/config-bisect.pl narrowed this down to:

%%%%%%%% FAILED TO FIND SINGLE BAD CONFIG %%%%%%%%
Hmm, can't make any more changes without making good == bad?
Difference between good (+) and bad (-)
 UBSAN_TRAP n -> y
+UBSAN_ALIGNMENT=n
See good and bad configs for details:
good: /tmp/x86/tip/good.config.tmp
bad:  /tmp/x86/tip/bad.config.tmp
%%%%%%%% FAILED TO FIND SINGLE BAD CONFIG %%%%%%%%

(Though confirming this, I only need defconfig+CONFIG_UBSAN to repro)

For folks that know how to run tools/testing/ktest/config-bisect.pl,
skip this next section, more so notes to future self and others on our
mailing list to learn how to run this. Arnd Bergmann taught me about
this.
$ cp config_from_0day bad.config
$ make LLVM=1 -j71 defconfig
$ cp .config good.config
$ ./tools/testing/ktest/config-bisect.pl good.config bad.config
1: $ make LLVM=1 -j71 clean bzImage 2> log.txt
2: $ grep warning: log2.txt | cut -d ' ' -f 2- | sort | uniq -c | grep
"unreachable instruction"
if !$ == 0:
tools/testing/ktest/config-bisect.pl good.config bad.config good
else:
tools/testing/ktest/config-bisect.pl good.config bad.config bad
if not finished:
  goto 1

Triple checking what I wrote above; it looks like the randconfig had
BOTH CONFIG_KASAN=y and CONFIG_UBSAN=y enabled.  Aren't the sanitizers
supposed to be mutually exclusive?  If so, we should ensure that via
kconfig these can't be selected together via randconfig.

Another peculiarity I noticed was that it seems that enabling
CONFIG_UBSAN_TRAP=y doesn't allow me to select
CONFIG_UBSAN_ALIGNMENT=y.  Is that intentional? (Looks like it
lib/Kconfig.ubsan:74).

There was actually another thread about CONFIG_UBSAN_TRAP and Clang
today, related to arm64 virtualization extensions.
https://lore.kernel.org/linux-arm-kernel/CANpmjNPpq7LfTHYesz2wTVw6Pqv0FQ2gc-vmSB6Mdov+XWPZiw@mail.gmail.com/T/#u
-- 
Thanks,
~Nick Desaulniers
