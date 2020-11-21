Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A6A2BBC64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 03:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgKUCt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 21:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgKUCt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 21:49:28 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF64C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:49:28 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id d17so12000855ion.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 18:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mvz49IxaZZPqNywTEM2JqxmrSXX0bTS8hNaYSGV9mS8=;
        b=JF1L744HCa1rP4WPx1a+ayKNZBh2F/BCyJAEslIumSwvm5ty9vnJP8aFohVtDEHUJU
         RFbXh5WPwhbpZqN7KbiRuUY29yBb0C22rci2C3QGIum3MYpP3M5XJYgsm0j25bDxoAoD
         KlOxAAkpagSxh8lsa+kaI5kRJLRXuum5g6nrrxSHCv0y3Bk/2Rxq886cajETP9jlZzrb
         IYYkLqB4NTX9IHzYHwz4/w164uyLkMjMSYtCrA904PPgp/IYDuVjr9aaLJpeTrbprVjk
         kgVSKCw/tyWS51ISnkSr5DlAl+Y5I3xsGErrneT1uzACtJG1eZ6clIA5YxFvbJrUDTVs
         dDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mvz49IxaZZPqNywTEM2JqxmrSXX0bTS8hNaYSGV9mS8=;
        b=Esbmi47CGbB+btZNZkOo/iNo556dzaaaLeor6YPUTEVzmLipSdlDYRCaVWw2eUR8Bw
         m6jV+MMPPD59z1va9jEUpDt3/hpqlmUsdVaRDu0E9XbaXO1iIVe2bDG/wBeCGUFXflAq
         ver/mogUXNgLedc5YVWpAYeeAr586NbCBs3kQfivK8yYLAVwc0Zfpm///BNY9gWUTqHH
         bDEKT8I/KR1w11B2jlU8DwQnrYhx5FjFebCq3GgxFTd68AsVur+QOPF0MjcSDwki4loc
         PyBoNUb708R9m0fQ3jkVLyZYPCmpJIXoiT39DF7ZjEIepc1p+vX2mNzG3sOEtKnLP/Oq
         UXsA==
X-Gm-Message-State: AOAM532x91y9Xp7IGsqoJ+bNNapq2FkGL6yURCWlSlGcgtq3mDnilotq
        F2nJdCCJeUU09v1g7MvpU96jWA==
X-Google-Smtp-Source: ABdhPJw6ueXo4qBnsFh4h8Fkbiky0D6tL4UDAU6/ji4Alb4ombgalKosGbLY07/wglVnX9wiFWTe1w==
X-Received: by 2002:a5e:8206:: with SMTP id l6mr27038082iom.126.1605926967857;
        Fri, 20 Nov 2020 18:49:27 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id o10sm3222867ili.82.2020.11.20.18.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 18:49:27 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:49:22 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] mm: proc: Invalidate TLB after clearing soft-dirty
 page state
Message-ID: <20201121024922.GA1363491@google.com>
References: <20201120143557.6715-1-will@kernel.org>
 <20201120143557.6715-5-will@kernel.org>
 <20201120202253.GB1303870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120202253.GB1303870@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:22:53PM -0700, Yu Zhao wrote:
> On Fri, Nov 20, 2020 at 02:35:55PM +0000, Will Deacon wrote:
> > Since commit 0758cd830494 ("asm-generic/tlb: avoid potential double flush"),
> > TLB invalidation is elided in tlb_finish_mmu() if no entries were batched
> > via the tlb_remove_*() functions. Consequently, the page-table modifications
> > performed by clear_refs_write() in response to a write to
> > /proc/<pid>/clear_refs do not perform TLB invalidation. Although this is
> > fine when simply aging the ptes, in the case of clearing the "soft-dirty"
> > state we can end up with entries where pte_write() is false, yet a
> > writable mapping remains in the TLB.
> 
> I don't think we need a TLB flush in this context, same reason as we
> don't have one in copy_present_pte() which uses ptep_set_wrprotect()
> to write-protect a src PTE.
> 
> ptep_modify_prot_start/commit() and ptep_set_wrprotect() guarantee
> either the dirty bit is set (when a PTE is still writable) or a PF
> happens (when a PTE has become r/o) when h/w page table walker races
> with kernel that modifies a PTE using the two APIs.

After we remove the writable bit, if we end up with a clean PTE, any
subsequent write will trigger a page fault. We can't have a stale
writable tlb entry. The architecture-specific APIs guarantee this.

If we end up with a dirty PTE, then yes, there will be a stale
writable tlb entry. But this won't be a problem because when we
write-protect a page (not PTE), we always check both pte_dirty()
and pte_write(), i.e., write_protect_page() and page_mkclean_one().
When they see this dirty PTE, they will flush. And generally, only
callers of pte_mkclean() should flush tlb; otherwise we end up one
extra if callers of pte_mkclean() and pte_wrprotect() both flush.

Now let's take a step back and see why we got
tlb_gather/finish_mmu() here in the first place. Commit b3a81d0841a95
("mm: fix KSM data corruption") explains the problem clearly. But
to fix a problem created by two threads clearing pte_write() and
pte_dirty() independently, we only need one of them to set
mm_tlb_flush_pending(). Given only removing the writable bit requires
tlb flush, that thread should be the one, as I just explained. Adding
tlb_gather/finish_mmu() is unnecessary in that fix. And there is no
point in having the original flush_tlb_mm() either, given data
integrity is already guaranteed. Of course, with it we have more
accurate access tracking.

Does a similar problem exist for page_mkclean_one()? Possibly. It
checks pte_dirty() and pte_write() but not mm_tlb_flush_pending().
At the moment, madvise_free_pte_range() only supports anonymous
memory, which doesn't do writeback. But the missing
mm_tlb_flush_pending() just seems to be an accident waiting to happen.
E.g., clean_record_pte() calls pte_mkclean() and does batched flush.
I don't know what it's for, but if it's called on file VMAs, a similar
race involving 4 CPUs can happen. This time CPU 1 runs
clean_record_pte() and CPU 3 runs page_mkclean_one().
