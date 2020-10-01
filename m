Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37522809E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733104AbgJAWJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgJAWJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:09:46 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1265220872
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 22:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601590186;
        bh=JD0QD/5GZj9VsMPcG0jt6vOmXJdCO47p4iuLta8SrMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IumYpTmSDtvVAZtx6ucDnf6I9x3ZZycuk3RnNuBzoUsarUGvbG2d0ylXo/4rSHO8B
         lkN+XhztGQLDB8C8p8vgIytKy/a1SbuCgd0kAbp4l9TP6zsqODd+f+JHzQPHwFNOp9
         7t6KZ8ME4w06dyO6M+YVlUY3u7paz/hiqoKZQgL8=
Received: by mail-wm1-f49.google.com with SMTP id e11so3153854wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 15:09:45 -0700 (PDT)
X-Gm-Message-State: AOAM5310b+vqeEt2noyI+3WpEZdGcTwzwR7K5esKSW3QIE9wyVMGp7wC
        wRlfR5L2dIVAmuTZzBpohnpLvEXAFnMIePF/w0NCLw==
X-Google-Smtp-Source: ABdhPJxNerLFrNoSEFgaH3xNb7S1tiL7x7QuxPKHgklHcZWsvN5ibwkigJ3+CcjZ47N4GrCB+VN5sLWQzLHrX2OgPv0=
X-Received: by 2002:a1c:63c1:: with SMTP id x184mr2153711wmb.138.1601590184619;
 Thu, 01 Oct 2020 15:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201001205819.27879-1-krisman@collabora.com> <20201001205819.27879-9-krisman@collabora.com>
In-Reply-To: <20201001205819.27879-9-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 1 Oct 2020 15:09:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXPXxGZBGOf_DnYogamnkp29u8EqY33zDZb-HD+fj9ugg@mail.gmail.com>
Message-ID: <CALCETrXPXxGZBGOf_DnYogamnkp29u8EqY33zDZb-HD+fj9ugg@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] x86: Convert mmu context ia32_compat into a proper
 flags field
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:59 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> The ia32_compat attribute is a weird thing.  It mirrors TIF_IA32 and
> TIF_X32 and is used only in two very unrelated places: (1) to decide if
> the vsyscall page is accessible (2) for uprobes to find whether the
> patched instruction is 32 or 64 bit.  In preparation to remove the TI
> flags, we want new values for ia32_compat, but given its odd semantics,
> I'd rather make it a real flags field that configures these specific
> behaviours.  So, set_personality_x64 can ask for the vsyscall page,
> which is not available in x32/ia32 and set_personality_ia32 can
> configure the uprobe code as needed.
>
> uprobe cannot rely on other methods like user_64bit_mode() to decide how
> to patch, so it needs some specific flag like this.

I like this quite a bit, but can you rename MM_CONTEXT_GATE_PAGE to
MM_CONTEXT_HAS_VSYSCALL?

--Andy
