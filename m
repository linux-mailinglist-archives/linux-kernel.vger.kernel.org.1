Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95617286BEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgJHAHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJHAHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:07:51 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762492177B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 00:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602115670;
        bh=SFKYXAM/6wL1kNkLhG1rEA3Coy5dc1T0O5EbE8h9jL0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zP7G0tPKMtP8RwB8+wKwEIHVMmHCJBKZ6E5BBRqDAauDdxfvd6R7VC6TkLPNI2sYE
         xBNqxgr3RZl2V7i/Vo85dnMWYGsfEKLXK2DjpN68u2wzfXST8XK7R9vM8wOCroLRo1
         4cQMSDkF6in5wC63IQN4auejf6KkO7D65pF2OP4c=
Received: by mail-wr1-f42.google.com with SMTP id n6so4036736wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 17:07:50 -0700 (PDT)
X-Gm-Message-State: AOAM531DtnRiYIt7dLkVuYEj4Ymo2k0uqaaz35/8EQfAW9d0eUF3kf19
        aO3Tjz1tdw9MpXdWbYyALDxyjGoCuoX22lacKolvqA==
X-Google-Smtp-Source: ABdhPJzPEErmo9+52LOeopgEfoPAEh5KoqjqpZ7S/kUMvmxhl0Zxzz7pKAMbiycOB2wSHtHMnMEKycPFqySCCQFpB+U=
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr6011139wrb.70.1602115668829;
 Wed, 07 Oct 2020 17:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20201004032536.1229030-1-krisman@collabora.com> <20201004032536.1229030-10-krisman@collabora.com>
In-Reply-To: <20201004032536.1229030-10-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 7 Oct 2020 17:07:37 -0700
X-Gmail-Original-Message-ID: <CALCETrVVii5+d1xDiFX03wdS1XhxmezemhHTG7FArF50uVAJRw@mail.gmail.com>
Message-ID: <CALCETrVVii5+d1xDiFX03wdS1XhxmezemhHTG7FArF50uVAJRw@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] x86: Convert mmu context ia32_compat into a
 proper flags field
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 8:26 PM Gabriel Krisman Bertazi
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

Acked-by: Andy Lutomirski<luto@kernel.org>

There are still issues with vsyscall control, but they were
pre-existing and I'll try to get them fixed up.

--Andy
