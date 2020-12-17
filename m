Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF12DDA91
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbgLQVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbgLQVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:08:34 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77438C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:07:54 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h186so188298pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 13:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pn64gL1PFy3T6aEaSewOwhAXHuHI8RuWQ88aIPK+DJ0=;
        b=uyu8VTEGuSZJ0tQIowYFWiWOKwtj8ojCTOGEEPNHCr+oMko3vIj0fZovNXF+Nv1bTc
         FNlgWZ3tCl922WpnP24+KDKTMn4LfkkmC9Ns8nlTVkXZUpHszNhSKY2E5m5Ux608etcq
         hE4Yg4C8NzZRbwp9lKUgnt2nxh82PHB1jglyNUIy45lqWzNgoQ41DSKXLVkKYH0VPDE2
         byzdgK7duzdAd6HEfmhoGfzQs8HLXZYTV27g+zQjQfbUBnSnoiOqwUnwQdIuuQHrTj5H
         rlcMivKS17p8O4KTXR991kOqB/0W1Ksk+RXmVQZp9Bb5xacWLEFzhL9TeN4BrV3bpg4E
         C3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pn64gL1PFy3T6aEaSewOwhAXHuHI8RuWQ88aIPK+DJ0=;
        b=YleiYS6xf3NlcSbX7A7mmLswxTIRA7+vLRARqFHU+PIn9ZzOR7Ofj6lMqTGrXiXUEf
         CQWgj4uWBaz41OparWbZDeH8ZH6iTAqRpgPjM7sEZ6f19D7I360GoLDOsXFKIYgpL2ju
         ZhV2QL6Cjn/IdYQUNoxCA0E5uzlqHrkI+vQhKFKNGdbpmLmkrXDM/SlPbRvjTQYIiLDO
         PhNkWi7m2Mp127oDJPcc5yWkfRXOTnO0E3lJd0JxjADSz6juhvgIRYPsobvo1K1FJ4p6
         st4vmc8e42QUXO0UTmfojVvwLJiUd+GG8e0npQkY0AgRGnRiwwumVaPo3qT7LcXz8rVC
         cxuw==
X-Gm-Message-State: AOAM531yDgMPMrLim19F2LTeVq+6B0+tvCQzm0L8L4V84EwQb812iHeH
        XqKfER0T/toojfDtPCYFeTXSlhlnLufahPo3oF+jIQ==
X-Google-Smtp-Source: ABdhPJz3jvfkQ9M2KieaKXlZ+y7+G09Fr99taIeBU736VGaEPEFeJG9VWWIeJZQyHK3N9mXp0nghhrT28HFDshpOaNY=
X-Received: by 2002:a63:1142:: with SMTP id 2mr1079220pgr.263.1608239273686;
 Thu, 17 Dec 2020 13:07:53 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOdkP8vHidFPWczC24XwNHhQaXovQiQ43Yb6Csp_+kPR9XQ@mail.gmail.com>
 <20201217004051.1247544-1-ndesaulniers@google.com> <20201217120118.GC17544@willie-the-truck>
In-Reply-To: <20201217120118.GC17544@willie-the-truck>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Dec 2020 13:07:41 -0800
Message-ID: <CAKwvOd=LZHzR11kuhT2EjFnUdFwu5hQmxiwqeLB2sKC0hWFY=g@mail.gmail.com>
Subject: Re: [PATCH] arm64: link with -z norelro for LLD or aarch64-elf
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team <kernel-team@android.com>,
        Peter Smith <Peter.Smith@arm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Quentin Perret <qperret@google.com>,
        Alan Modra <amodra@gmail.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 4:01 AM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Dec 16, 2020 at 04:40:51PM -0800, Nick Desaulniers wrote:
> > With newer GNU binutils, linking with BFD produces warnings for vmlinux:
> > aarch64-linux-gnu-ld: warning: -z norelro ignored
> >
> Given that, prior to 3b92fa7485eb, we used to pass '-z norelro' if
> CONFIG_RELOCATABLE then was this already broken with the ELF toolchain?

Yes, though it would have been hard to foresee the change to BFD ~6
months later.

Specifically, binutils-gdb
commit 5fd104addfddb ("Emit a warning when -z relro is unsupported")
was committed Fri Jun 19 09:50:20 2020 +0930. The first git tag that
describes this commit was binutils-2_35 which was tagged Fri Jul 24
11:05:23 2020 +0100.

I noticed about a month ago that the version of
binutils-aarch64-linux-gnu installed on my gLinux workstation had auto
updated to version 2.35.1; I was authoring kernel patches for DWARF v5
support, which relied on 2.35 for DWARF v5 assembler support.  I
suspect Quentin's host was auto updated as well, at which point he
noticed and mentioned to me since I had touched `-z norelro` last.

But if we look at
commit 3bbd3db86470 ("arm64: relocatable: fix inconsistencies in
linker script and options")
which was committed at Tue Dec 4 12:48:25 2018 +0000, it was not
possible to foresee that binutils-gdb would change to produce such a
warning for such an emulation mode.

So I'm not sure whether my patch should either:
- have a fixes tag for just the latest commit that touched anything
related to `-z norelro`, mine, 3b92fa7485eb.
- have an additional fixes tag for 3bbd3db86470 which first introduced
`-z norelro`.
- have no fixes tag

I'll respin a v2 folding in Ard's suggestions.  Meanwhile, I've filed:
- https://bugs.llvm.org/show_bug.cgi?id=48549 against LLD
- https://sourceware.org/bugzilla/show_bug.cgi?id=27093 against BFD
-- 
Thanks,
~Nick Desaulniers
