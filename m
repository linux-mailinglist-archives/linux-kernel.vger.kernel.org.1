Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E023026CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbhAYPSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbhAYOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:51:28 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E36C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:50:47 -0800 (PST)
Received: from zn.tnic (p200300ec2f09db0095810f165069682a.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:9581:f16:5069:682a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D2A31EC0572;
        Mon, 25 Jan 2021 15:50:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611586246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+TCaFbdg4KelXLn9SPKHyv4vN7y4Nq66S6xqaowPGy8=;
        b=ps+f1Wg2SvNQilg3jVkxCSoTCcvpurycqzelh9QttRfqxWuJvvPaD8eZlj+9rQucikvV5u
        p7xFwjuO+HAHgbmfAvcTqBsA+fd2tyS0eGSI9G9Zo3fNin8TJwXTQG8Us7mQig5hNKfi3u
        amJy0ribj2w6PnIixh7Q1qOO2slcUIk=
Date:   Mon, 25 Jan 2021 15:50:41 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 1/2] x86/setup: consolidate early memory reservations
Message-ID: <20210125145041.GD23070@zn.tnic>
References: <20210115083255.12744-1-rppt@kernel.org>
 <20210115083255.12744-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115083255.12744-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:32:54AM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The early reservations of memory areas used by the firmware, bootloader,
> kernel text and data are spread over setup_arch(). Moreover, some of them
> happen *after* memblock allocations, e.g trim_platform_memory_ranges() and
> trim_low_memory_range() are called after reserve_real_mode() that allocates
> memory.
> 
> We did not observe corruption of these memory regions because memblock

Make that "We" impersonal, passive voice pls.

> always allocates memory either from the end of memory (in top-down mode) or
> above the kernel image (in bottom-up mode). However, the bottom up mode is
> going to be updated to span the entire memory [1] to avoid limitations
> caused by KASLR.
> 
> Consolidate early memory reservations in a dedicated function to improve
> robustness against future changes. Having the early reservations in one
> place also makes it clearer what memory must be reserved before we allow
> memblock allocations.

Would it make sense to have a check with a WARN or so to catch early
reservations which get added after memblock allocations have been
allowed? To catch people who don't pay attention...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
