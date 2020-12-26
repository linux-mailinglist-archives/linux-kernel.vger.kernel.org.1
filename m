Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945CE2E2F4E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 23:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgLZWlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 17:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgLZWlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 17:41:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ABCC061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 14:40:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s26so16163599lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 14:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5xV1Uwr5QvPwGAEEhmKQuNt1ecyJlCF/DYUO0nnGbJA=;
        b=SSDOvkJaPZLQbLl1/R2yfC0vD8pNo/R7kwvwiR0BP96LI5plYaxX1qyeGTF5DDBAle
         Mo8kLCOdwcA3MLI3xds9N6DR0mR8YcPh8435LV12lTkVb7z8s/jFxu8aCFrWAzzJUUAx
         g/GK5Fi4t9MRDLYmUWaK9rgbfXgMXKSeAXeUa+bfRcHPK8APDNC8EGbShpG7KAI36SdC
         atxEb/OH8TBUcAyQcr1NCjzL/tS0AG1dM0/L+sQKDNLwl6XDx36uavQQdFqhRjWxZVXd
         E2OjzaZCA2OX8/82QsmFQLLMRPEVEBZN1TaKU3eQST1GmGun+pNtH/lyfbsbsWIW0YOH
         Nrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5xV1Uwr5QvPwGAEEhmKQuNt1ecyJlCF/DYUO0nnGbJA=;
        b=TtsjOIaNCkneArMLYvx0jMH49rYeTvA5Pv3vEfKXh7H89/ARWpXYR4inzVMnxK/Uj6
         4deByjkrNz9kRY2tzcAyu8GZL9XJ57Wrf92K+qIG+TNTcqZC+PcKvDeN8gQIMrM9b+vT
         MPJVLXJSj3INKojhnoctqwoDyc3rjcvnsf0jGQHBY2cfGEGNVlA9jskBCTFcibwKqje1
         MhR3K3/NOqBn2uoVCn+kFHghRu/E2LcbUCa6gsWlp7pXZoJVSP4+JpqacXk910JNn9V7
         KETE0nRGde1ppUvQPWdYPo3SRITkBRJgfKT2V798CJbU+CgoDOwrkoDMXt/88tphJ93S
         Ux8w==
X-Gm-Message-State: AOAM532arp+x2BoJLu2UMZpYoK9E+eB0noTaVWqrSyre3mWNP15EmCFs
        FlqBhrBNmTE9hCg28N8UPa2QqQ==
X-Google-Smtp-Source: ABdhPJy9c7fz+61qQ39Hm9FQ6OMVPp5gAk3EtmrlxqSIgqfg7pTj+frNOUo4gc5k5Hr9EwE043FbPA==
X-Received: by 2002:a05:651c:1063:: with SMTP id y3mr17737679ljm.431.1609022417964;
        Sat, 26 Dec 2020 14:40:17 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y26sm5596811ljh.63.2020.12.26.14.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 14:40:17 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9EEEC1026FB; Sun, 27 Dec 2020 01:40:16 +0300 (+03)
Date:   Sun, 27 Dec 2020 01:40:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20201226224016.dxjmordcfj75xgte@box>
References: <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box>
 <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
 <20201222100047.p5zdb4ghagncq2oe@box>
 <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box>
 <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box>
 <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 01:16:09PM -0800, Linus Torvalds wrote:
> On Sat, Dec 26, 2020 at 1:04 PM Hugh Dickins <hughd@google.com> wrote:
> >
> >
> > Hold on. I guess this one will suffer from the same bug as the previous.
> > I was about to report back, after satisfactory overnight testing of that
> > version - provided that one big little bug is fixed:
> >
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2919,7 +2919,7 @@ static bool filemap_map_pmd(struct vm_fa
> >
> >         if (pmd_none(*vmf->pmd) &&
> >             PageTransHuge(page) &&
> > -           do_set_pmd(vmf, page)) {
> > +           do_set_pmd(vmf, page) == 0) {
> >                 unlock_page(page);
> >                 return true;
> >         }
> 
> I missed that entirely, because when just reading the patch it looks
> fine and I didn't look at what do_set_pmd() function returns outside
> the patch.
> 
> And maybe it would be better to write it as
> 
>         if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
>                 vm_fault_t ret = do_set_pmd(vmf, page);
>                 if (!ret) {
>                         ...
> 
> instead to make it a bit more explicit about how that return value is
> a vm_fault_t there...
> 
> And see my other email about how I suspect there is still a leak in
> that patch for the previous test-case.

Ughh...

Here's the fixup I have so far. It doesn't blow up immediately, but please
take a closer look. Who knows what stupid mistake I did this time. :/

diff --git a/mm/filemap.c b/mm/filemap.c
index 3a92aaa59b9b..c4b374678e7d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2837,16 +2837,21 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	struct mm_struct *mm = vmf->vma->vm_mm;
 
 	/* Huge page is mapped? No need to proceed. */
-	if (pmd_trans_huge(*vmf->pmd))
-		return true;
-
-	if (pmd_none(*vmf->pmd) &&
-	    PageTransHuge(page) &&
-	    do_set_pmd(vmf, page)) {
+	if (pmd_trans_huge(*vmf->pmd)) {
 		unlock_page(page);
+		put_page(page);
 		return true;
 	}
 
+	if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
+	    vm_fault_t ret = do_set_pmd(vmf, page);
+	    if (!ret) {
+		    /* The page is mapped successfully, reference consumed. */
+		    unlock_page(page);
+		    return true;
+	    }
+	}
+
 	if (pmd_none(*vmf->pmd)) {
 		vmf->ptl = pmd_lock(mm, vmf->pmd);
 		if (likely(pmd_none(*vmf->pmd))) {
@@ -2867,7 +2872,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
 	return false;
 }
 
-static struct page *next_stable_page(struct page *page, struct vm_fault *vmf,
+static struct page *next_uptodate_page(struct page *page, struct vm_fault *vmf,
 				     struct xa_state *xas, pgoff_t end_pgoff)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
@@ -2914,15 +2919,16 @@ static inline struct page *first_map_page(struct vm_fault *vmf,
 					  struct xa_state *xas,
 					  pgoff_t end_pgoff)
 {
-	return next_stable_page(xas_find(xas, end_pgoff), vmf, xas, end_pgoff);
+	return next_uptodate_page(xas_find(xas, end_pgoff),
+				  vmf, xas, end_pgoff);
 }
 
 static inline struct page *next_map_page(struct vm_fault *vmf,
 					  struct xa_state *xas,
 					  pgoff_t end_pgoff)
 {
-	return next_stable_page(xas_next_entry(xas, end_pgoff),
-				vmf, xas, end_pgoff);
+	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
+				  vmf, xas, end_pgoff);
 }
 
 void filemap_map_pages(struct vm_fault *vmf,
-- 
 Kirill A. Shutemov
