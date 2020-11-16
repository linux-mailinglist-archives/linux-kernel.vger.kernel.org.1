Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4442F2B4BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732346AbgKPQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbgKPQ43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:56:29 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7347222314
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605545788;
        bh=VmJiVNqZJbVKwffI9xWkUt7jsOnWbxcfYoKiArMJAS8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gvFCS4M0xiGbdy5stjQuUHnrSbHAgJP32jUoz64+EbPi0FYUVM74KzpaVjLSvXDZx
         tvtNiPwlPzc+rY/ER5kGFL17uksTXLi3tCYRJ/7yau9VZSZ8w7kLb/Yp9Ys9WzGulu
         LM/9on9c7omar4/aDPSxdPO3SQAxnR+N2P4FBJrU=
Received: by mail-wm1-f54.google.com with SMTP id p19so299438wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:56:28 -0800 (PST)
X-Gm-Message-State: AOAM532IP5wG24Smiym1JVsVXt+6/ANwI1OlwKz2IXXEl/HVtjWqNlmj
        dkVT8ILsjAT937LMHImcA/a8Aw5f3c3/LcAFIIeoGw==
X-Google-Smtp-Source: ABdhPJySuGJ1AbRFUwxH7RRhi7njBZqup99faX8sV0J62hGFZIB38RXZTqilEp7QOp3g+dEb0dQaND1KY6fye9bhiVM=
X-Received: by 2002:a7b:c195:: with SMTP id y21mr16627031wmi.138.1605545786993;
 Mon, 16 Nov 2020 08:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com> <20201116144757.1920077-22-alexandre.chartre@oracle.com>
In-Reply-To: <20201116144757.1920077-22-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 08:56:13 -0800
X-Gmail-Original-Message-ID: <CALCETrU5qnsxgLb6W5UPk8RRbbkFTTbjLxHefkBXCyk-2=uDcQ@mail.gmail.com>
Message-ID: <CALCETrU5qnsxgLb6W5UPk8RRbbkFTTbjLxHefkBXCyk-2=uDcQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 21/21] x86/pti: Use a different stack canary with
 the user and kernel page-table
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

On Mon, Nov 16, 2020 at 6:48 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> Using stack protector requires the stack canary to be mapped into
> the current page-table. Now that the page-table switch between the
> user and kernel page-table is deferred to C code, stack protector can
> be used while the user page-table is active and so the stack canary
> is mapped into the user page-table.
>
> To prevent leaking the stack canary used with the kernel page-table,
> use a different canary with the user and kernel page-table. The stack
> canary is changed when switching the page-table.

Unless I've missed something, this doesn't have the security
properties we want.  One CPU can be executing with kernel CR3, and
another CPU can read the stack canary using Meltdown.  I think that
doing this safely requires mapping a different page with the stack
canary in the two pagetables.
