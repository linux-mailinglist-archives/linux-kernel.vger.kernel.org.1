Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CFC26AC85
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgIOStt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgIORZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:25:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C22C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 10:22:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e42006096e946d741c4e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:6096:e946:d741:c4e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CD321EC0268;
        Tue, 15 Sep 2020 19:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600190513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JO/BJln6+VhiNncCauMkRlCcTkl9Kn6f84sTOpoazpg=;
        b=YcyLUqDxMPbtOgMA9A5nqkYPUS1MKbmMrWICT8LAHBhA7+QWojjLGDb9ZoGixwS6bSVb1q
        2dJqfHErHJBosB3C5tF89YkTnIJoWdITggy3bcKuiCarola0d4ApkBtLdF0bfFqeIpCCLi
        wK0HysijJfK6c8qhW627xg8wVycblwE=
Date:   Tue, 15 Sep 2020 19:21:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915172152.GR14436@zn.tnic>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915170248.gcv54pvyckteyhk3@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:02:48PM -0500, Josh Poimboeuf wrote:
> If somebody can share the .o file, I can take a look.

If only I could reproduce...

So I built:

/home/share/src/llvm/tc-build/install/bin/clang-12 --version
ClangBuiltLinux clang version 12.0.0 (https://github.com/llvm/llvm-project 74a9c6d7e1c49cd0e3a8e8072b8aa03f7a84caff)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /home/share/src/llvm/tc-build/install/bin

and I don't trigger that warning even with that compiler.

What I do get is a lot of those pairs:

init/calibrate.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
init/calibrate.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
init/version.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
init/version.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
certs/system_keyring.o: warning: objtool: asan.module_ctor()+0xc: call without frame pointer save/setup
certs/system_keyring.o: warning: objtool: asan.module_dtor()+0xc: call without frame pointer save/setup
...

and a link fail at the end.

ld: arch/x86/events/core.o: in function `events_sysfs_show':
core.c:(.text+0x469b): undefined reference to `stpcpy'
ld: arch/x86/events/core.o: in function `events_ht_sysfs_show':
core.c:(.text+0x46f7): undefined reference to `stpcpy'
ld: drivers/tty/tty_io.o: in function `alloc_tty_struct':
tty_io.c:(.text+0x2da5): undefined reference to `stpcpy'
ld: drivers/tty/tty_io.o: in function `tty_register_device_attr':
tty_io.c:(.text+0x6a09): undefined reference to `stpcpy'
ld: drivers/tty/tty_io.o: in function `show_cons_active':
tty_io.c:(.text+0xa819): undefined reference to `stpcpy'
ld: drivers/scsi/scsi_transport_sas.o:scsi_transport_sas.c:(.text+0x6139): more undefined references to `stpcpy' follow
make: *** [Makefile:1166: vmlinux] Error 1


I'm thinking clang12 is too unstable to take it seriously...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
