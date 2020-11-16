Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA112B5179
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgKPTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:48:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKPTsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:48:23 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8203F20853
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605556102;
        bh=j0pYwt0AIA4fCrM4+sr8Wq32fXRZX/bi+jl+S1U9ZqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aYhtYf8zFcm4mvgGu2jLklF/pe39KVI8mVIzEUbtK3koX84vSqvELK+gw1Ct2KTO3
         wLdWLZXRfYccuMIC/sJFxXzLg7HdaWTNDZ9hHwa2EO4RQAlmf07IApI5I+V6OAvR3+
         NnurZpnRKZJXXY9HNzhxiogolkns+tX/4RdYxStM=
Received: by mail-wr1-f43.google.com with SMTP id s8so20079789wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:48:22 -0800 (PST)
X-Gm-Message-State: AOAM533O69reL/DN+3Yw038bvAcWY97KJJzIKHOT7pJCFrVJn7gZ4L1h
        kaFh7Dp/zqqloUsct9mIZrGog/ejxq7n+wxaOa+erA==
X-Google-Smtp-Source: ABdhPJxO311l5uG/XDtFzkLAThQVXdAVeeL0uQL/pjqgW5KawKG8kHx5tJiZE+v3ii/C3r6MbfFCH/NPihPnB/zpEwA=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr20927599wro.184.1605556101009;
 Mon, 16 Nov 2020 11:48:21 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com> <20201116144757.1920077-12-alexandre.chartre@oracle.com>
In-Reply-To: <20201116144757.1920077-12-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 11:48:06 -0800
X-Gmail-Original-Message-ID: <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com>
Message-ID: <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 11/21] x86/pti: Extend PTI user mappings
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

On Mon, Nov 16, 2020 at 6:49 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> Extend PTI user mappings so that more kernel entry code can be executed
> with the user page-table. To do so, we need to map syscall and interrupt
> entry code, per cpu offsets (__per_cpu_offset, which is used some in
> entry code), the stack canary, and the PTI stack (which is defined per
> task).

Does anything unmap the PTI stack?  Mapping is easy, and unmapping
could be a pretty big mess.

--Andy
