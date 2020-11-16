Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967782B54BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 00:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgKPXGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 18:06:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:33152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgKPXGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 18:06:24 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FEA3241A5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605567983;
        bh=0Pqi7azRIWSbLIpOeitvpzKPLJGnjQeCpndMdUmdrAo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2IOvZZPeGDj+Zct6OlvIZod58PJIp3hy9ZWtyPjPTimvJbBJqiku0bu3pKfw2/M1/
         EP2a/7aeAMxXeabBImwfXcm6v+SehUvXkjoVo8wSzxP3eDq3XVahSNr6ha2CyZGNy5
         B7Y2QONNejEe08f7hqYXRPS5CrQNPV7hKsfoCuWw=
Received: by mail-wm1-f44.google.com with SMTP id p19so837711wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 15:06:23 -0800 (PST)
X-Gm-Message-State: AOAM531jUcHB9Bzo3kOup5Zca2l9J1sHGRa0FuUAjqsqyWdDByIL1BqL
        h3n2JJo9/lbaG+kwHNBHa3WvCTuqa7c3Xz/598nc4w==
X-Google-Smtp-Source: ABdhPJzaErYYKYPau7kte9K2Eqgjui//v7T+37VcdCsJfQWFo6yKNCo5wdUrCV2Z/NFPrRMrLA8Ahpoyiep2mKeOWO0=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr1136898wmc.176.1605567982035;
 Mon, 16 Nov 2020 15:06:22 -0800 (PST)
MIME-Version: 1.0
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116144757.1920077-12-alexandre.chartre@oracle.com> <CALCETrXoykRjRPYPfZr6gBKoMnHuRYiJTDOcFYMq8GLef00j1A@mail.gmail.com>
 <820278dc-5f8e-6224-71b4-7c61819f68d1@oracle.com>
In-Reply-To: <820278dc-5f8e-6224-71b4-7c61819f68d1@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 15:06:08 -0800
X-Gmail-Original-Message-ID: <CALCETrXYP13pPcRfDDkwetLgzA3quYOBg7OTo5nbpLpPfSqaLw@mail.gmail.com>
Message-ID: <CALCETrXYP13pPcRfDDkwetLgzA3quYOBg7OTo5nbpLpPfSqaLw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 11/21] x86/pti: Extend PTI user mappings
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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

On Mon, Nov 16, 2020 at 12:18 PM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
>
> On 11/16/20 8:48 PM, Andy Lutomirski wrote:
> > On Mon, Nov 16, 2020 at 6:49 AM Alexandre Chartre
> > <alexandre.chartre@oracle.com> wrote:
> >>
> >> Extend PTI user mappings so that more kernel entry code can be executed
> >> with the user page-table. To do so, we need to map syscall and interrupt
> >> entry code, per cpu offsets (__per_cpu_offset, which is used some in
> >> entry code), the stack canary, and the PTI stack (which is defined per
> >> task).
> >
> > Does anything unmap the PTI stack?  Mapping is easy, and unmapping
> > could be a pretty big mess.
> >
>
> No, there's no unmap. The mapping exists as long as the task page-table
> does (i.e. as long as the task mm exits). I assume that the task stack
> and mm are freed at the same time but that's not something I have checked.
>

Nope.  A multi-threaded mm will free task stacks when the task exits,
but the mm may outlive the individual tasks.  Additionally, if you
allocate page tables as part of mapping PTI stacks, you need to make
sure the pagetables are freed.  Finally, you need to make sure that
the PTI stacks have appropriate guard pages -- just doubling the
allocation is not safe enough.

My intuition is that this is going to be far more complexity than is justified.
