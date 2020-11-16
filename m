Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA52B4BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbgKPQ6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730972AbgKPQ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:58:06 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE9720773
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605545886;
        bh=KOGjRKPGbnzDzVIg9XNDhKJ8ongjL1ugga2Rlj6rxog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ioM/3kO6hyROic0HWymF4H3Z4IRU8ib8PFiWVN0/NaINHj57JaWWngi8wall79DUl
         VKO4ovZkE8fxPuToWDDRsm2rX3NgPplnErCN9AMsLSgRcaZMnWJgIupEXumAAFiaRc
         34ChdBq+L8j+M/phfBYo6U6u53oYHtc6She3stTU=
Received: by mail-wr1-f45.google.com with SMTP id s8so19424181wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:58:05 -0800 (PST)
X-Gm-Message-State: AOAM533M3tvYHQiW0A8A3WhWRTES2WcwI0Bqj0Hf8KAcl8EAmszuwpja
        WAuxwB0/Ebz1YWNdSUKBkfia9Lc6oKK/stUS0u4TcQ==
X-Google-Smtp-Source: ABdhPJwd3890gWiisar4fac5B27EkuXFjOdoCHodxShBLap/S/jznZIJyo8v2ta5ZPufZkkcTOZEPM7XrWf5EJs9jqM=
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr20060044wrs.75.1605545884456;
 Mon, 16 Nov 2020 08:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com> <20201116144757.1920077-13-alexandre.chartre@oracle.com>
In-Reply-To: <20201116144757.1920077-13-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 08:57:51 -0800
X-Gmail-Original-Message-ID: <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
Message-ID: <CALCETrUSCwtR41CCo_cAQf_BwG7istH6fM=bxWh_VfOjSNFmSw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 12/21] x86/pti: Use PTI stack instead of
 trampoline stack
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        jan.setjeeilers@oracle.com, Junaid Shahid <junaids@google.com>,
        oweisse@google.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Alexander Graf <graf@amazon.de>, mgross@linux.intel.com,
        kuzuno@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 6:47 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> When entering the kernel from userland, use the per-task PTI stack
> instead of the per-cpu trampoline stack. Like the trampoline stack,
> the PTI stack is mapped both in the kernel and in the user page-table.
> Using a per-task stack which is mapped into the kernel and the user
> page-table instead of a per-cpu stack will allow executing more code
> before switching to the kernel stack and to the kernel page-table.

Why?

I can't immediately evaluate how nasty the page table setup is because
it's not in this patch.  But AFAICS the only thing that this enables
is sleeping with user page tables.  Do we really need to do that?
