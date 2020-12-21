Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8B2DFEFA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 18:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgLUR2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 12:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725825AbgLUR2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 12:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608571635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/3qhlYqC6VGQL9wnW9i+UqvdaTUht8Sy4ZaQE3Fzns4=;
        b=MuTTAiJ2PW3YuHRGCpSpweCO1QAYvUslaLtiLiWCfQY5uSeNqvCYcShK1im1m4lFHkQCkA
        w/gYTrkDQU0xjzyF/s2r/Roy8N+U6aywZ9/UlhUgN1K31Qz5WtL4eGkDvAIpGyMcyxbXlN
        6RDUuSUrSd8joMcLkYo2rw7HU0y4fmU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-QEyV_vPvOSWFWHRbCeCPSw-1; Mon, 21 Dec 2020 12:27:14 -0500
X-MC-Unique: QEyV_vPvOSWFWHRbCeCPSw-1
Received: by mail-qt1-f200.google.com with SMTP id i13so8239028qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 09:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/3qhlYqC6VGQL9wnW9i+UqvdaTUht8Sy4ZaQE3Fzns4=;
        b=dsRbfdu6KTGD4geD3Jiv41tzB3B3gyYUin9QtEQ1za6f9xp0+K47Mliv93fBlnauUa
         cCZnkjYqySeaDHmLHc78qUZP7YYJROniOsI/LTvqntH9V3efxeQRDQqZ6Vy+yUhZ++Mn
         YmZa0yBUv9k4Bls5puCVK6rUl7/vc0uQPpZBytzLTPLgNUoZNRNbdjHboBbqz7vRm0qL
         nFU1vgoyT9yW9KdHK2+qlLfelqto6HiX3aCDwmJro+XxJZ17Fdxjy5PZDmj8EZPqbbBF
         BOjtBxiHsbrUzpDlXRZExv+tJQ+gAlVmijwBcenpxjTetDaXbRnq2e8cfkhQBpVPjvHK
         ZJ4Q==
X-Gm-Message-State: AOAM530TNEE+Axc7Z9B5uqgHXWLMUPfUKMiA0hb/ZtlYur8cIunHotgl
        Cks9Z/FGgAU4ofS1jdPzijTCTWSO3KECjy3Gczd6b3CmvzqP3zdWg/VyNWAEjBX4IJeqt1IT3f3
        B6mJhCqazE0bNWve5h/4WiMbD
X-Received: by 2002:a37:5d07:: with SMTP id r7mr17796063qkb.49.1608571633934;
        Mon, 21 Dec 2020 09:27:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRezkkdZJQqhTaV/VXrXr9yGTbdPr9iCSWsPfRzg1xntyEjAwIP+7+QmyC+aeWppFhXqNnDA==
X-Received: by 2002:a37:5d07:: with SMTP id r7mr17796036qkb.49.1608571633671;
        Mon, 21 Dec 2020 09:27:13 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id c20sm10922199qtj.29.2020.12.21.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 09:27:12 -0800 (PST)
Date:   Mon, 21 Dec 2020 12:27:11 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable@vger.kernel.org, minchan@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
Message-ID: <20201221172711.GE6640@xz-x1>
References: <20201219043006.2206347-1-namit@vmware.com>
 <X95RRZ3hkebEmmaj@redhat.com>
 <EDC00345-B46E-4396-8379-98E943723809@gmail.com>
 <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nadav,

On Sun, Dec 20, 2020 at 12:06:38AM -0800, Nadav Amit wrote:

[...]

> So to correct myself, I think that what I really encountered was actually
> during MM_CP_UFFD_WP_RESOLVE (i.e., when the protection is removed). The
> problem was that in this case the “write”-bit was removed during unprotect.
> Sorry for the strange formatting to fit within 80 columns:

I assume I can ignore the race mentioned in the commit message but only refer
to this one below.  However I'm still confused.  Please see below.

> 
> 
> [ Start: PTE is writable ]
> 
> cpu0				cpu1			cpu2
> ----				----			----
> 							[ Writable PTE 
> 							  cached in TLB ]

Here cpu2 got writable pte in tlb.  But why?

If below is an unprotect, it means it must have been protected once by
userfaultfd, right?  If so, the previous change_protection_range() which did
the wr-protect should have done a tlb flush already before it returns (since
pages>0 - we protected one pte at least).  Then I can't see why cpu2 tlb has
stall data.

If I assume cpu2 doesn't have that cached tlb, then "write to old page" won't
happen either, because cpu1/cpu2 will all go through the cow path and pgtable
lock should serialize them.

> userfaultfd_writeprotect()				
> [ write-*unprotect* ]
> mwriteprotect_range()
> mmap_read_lock()
> change_protection()
> 
> change_protection_range()
>  ...
>  change_pte_range()
>  [ *clear* “write”-bit ]
>  [ defer TLB flushes]
> 				[ page-fault ]
> 				…
> 				wp_page_copy()
> 				 cow_user_page()
> 				  [ copy page ]
> 							[ write to old
> 							  page ]
> 				…
> 				 set_pte_at_notify()
> 
> [ End: cpu2 write not copied form old to new page. ]

Could you share how to reproduce the problem?  I would be glad to give it a
shot as well.

> [1] https://lore.kernel.org/patchwork/patch/1346386

PS: Sorry to not have read the other series of yours.  It seems to need some
chunk of time so I postponed it a bit due to other things; but I'll read at
least the fixes very soon.

Thanks,

-- 
Peter Xu

