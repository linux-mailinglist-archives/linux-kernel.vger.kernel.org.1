Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA52E2E6DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 05:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgL2EgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 23:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2EgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 23:36:02 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 20:35:22 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s2so13603210oij.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 20:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hqQREaNq+NNAv75fe43F01kJKyRrA6N95gs0RKLBLQM=;
        b=HKp1B9SaJ4tN+WlMO/Qg9gpOOi6ZDpwz4xG4OzPcWYuJu1lWBDnwSx77dfIPumeGBt
         6xCVrpoH6RqQL5DEDV5mduzxLMDfvMG0oGAd50jUFEvL3Z5Bsx/LwqU5WP9JG4ZvhopB
         uSfSicQt/SklehWvKfm08VlMl0WGiv9Mhpp/VszvsmacTClXzXnVUpM2whqiErC0hn/Z
         alqFshOjTj3PaOHMuDSLeO+aIexc3M/a99on4A9KqSkwRBn4od3ypNmOnHk0eX8n2TwZ
         YzCaL4nGke7Y0FkGjnG1psXFjOxzTmej5ESsnXpIQ4iu4vgYXK9ZwoujSntqcILYI7X9
         bfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hqQREaNq+NNAv75fe43F01kJKyRrA6N95gs0RKLBLQM=;
        b=KpXRKIw3P90o9BX1YNU9mSCxfw8UA+cjKWyg0yGrtl2QaghXOnrbzWSN7JUO4fBUUK
         EhDVy2aYV6Bjan5JJgPIZQ2+IFLsZIA789kxCZLvsS9ahokr7NyPWsYz3Ap9hN3doCcp
         mww7KErZ3DQ8n1YKlt4nwDIPDJENt0qllX0mbd7CdebU9leRi1rfpjkKp829bSFv72Uc
         dB+T45/7CpmWyVtNd8gjoKsHu+4uzQzZ3fyCfcvtZyibBDv3fGXy1A4IYEpNZd5npaR+
         nE4qz287VS3rKBm8PmQvExX1V9d9m+s4gphi1zmCM4SN4HyCbxDrm+dDAHYvIydz+fo6
         w6/A==
X-Gm-Message-State: AOAM532AX0SBvpLau7G0eG5jhAhE6SUmxufo3dhxePCPPOpI64jndL+3
        I2W5hdjI6F4rQUP916RWh4iFEQ==
X-Google-Smtp-Source: ABdhPJxnuGvedWExGwmna/yXsnxS3rwe/jtCvuhc/XFABPncfq3GbCaJ7VJgaAJnEVbAa24+fa1bNg==
X-Received: by 2002:a05:6808:3c9:: with SMTP id o9mr1301842oie.103.1609216521313;
        Mon, 28 Dec 2020 20:35:21 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j2sm9666576otq.78.2020.12.28.20.35.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 28 Dec 2020 20:35:20 -0800 (PST)
Date:   Mon, 28 Dec 2020 20:35:06 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
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
In-Reply-To: <20201228221237.6nu75kgxq7ikxn2a@box>
Message-ID: <alpine.LSU.2.11.2012281925420.1028@eggly.anvils>
References: <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils> <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com> <20201227234853.5mjyxcybucts3kbq@box>
 <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com> <alpine.LSU.2.11.2012272233170.24487@eggly.anvils> <20201228125352.phnj2x2ci3kwfld5@box> <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com> <20201228220548.57hl32mmrvvefj6q@box>
 <20201228221237.6nu75kgxq7ikxn2a@box>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it at last, sorry it's taken so long.

On Tue, 29 Dec 2020, Kirill A. Shutemov wrote:
> On Tue, Dec 29, 2020 at 01:05:48AM +0300, Kirill A. Shutemov wrote:
> > On Mon, Dec 28, 2020 at 10:47:36AM -0800, Linus Torvalds wrote:
> > > On Mon, Dec 28, 2020 at 4:53 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >
> > > > So far I only found one more pin leak and always-true check. I don't see
> > > > how can it lead to crash or corruption. Keep looking.

Those mods look good in themselves, but, as you expected,
made no difference to the corruption I was seeing.

> > > 
> > > Well, I noticed that the nommu.c version of filemap_map_pages() needs
> > > fixing, but that's obviously not the case Hugh sees.
> > > 
> > > No,m I think the problem is the
> > > 
> > >         pte_unmap_unlock(vmf->pte, vmf->ptl);
> > > 
> > > at the end of filemap_map_pages().
> > > 
> > > Why?
> > > 
> > > Because we've been updating vmf->pte as we go along:
> > > 
> > >                 vmf->pte += xas.xa_index - last_pgoff;
> > > 
> > > and I think that by the time we get to that "pte_unmap_unlock()",
> > > vmf->pte potentially points to past the edge of the page directory.
> > 
> > Well, if it's true we have bigger problem: we set up an pte entry without
> > relevant PTL.
> > 
> > But I *think* we should be fine here: do_fault_around() limits start_pgoff
> > and end_pgoff to stay within the page table.

Yes, Linus's patch had made no difference,
the map_pages loop is safe in that respect.

> > 
> > It made mw looking at the code around pte_unmap_unlock() and I think that
> > the bug is that we have to reset vmf->address and NULLify vmf->pte once we
> > are done with faultaround:
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> 
> Ugh.. Wrong place. Need to sleep.
> 
> I'll look into your idea tomorrow.
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 87671284de62..e4daab80ed81 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2987,6 +2987,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf, unsigned long address,
>  	} while ((head = next_map_page(vmf, &xas, end_pgoff)) != NULL);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	rcu_read_unlock();
> +	vmf->address = address;
> +	vmf->pte = NULL;
>  	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
>  
>  	return ret;
> -- 

And that made no (noticeable) difference either.  But at last
I realized, it's absolutely on the right track, but missing the
couple of early returns at the head of filemap_map_pages(): add

--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3025,14 +3025,12 @@ vm_fault_t filemap_map_pages(struct vm_f
 
 	rcu_read_lock();
 	head = first_map_page(vmf, &xas, end_pgoff);
-	if (!head) {
-		rcu_read_unlock();
-		return 0;
-	}
+	if (!head)
+		goto out;
 
 	if (filemap_map_pmd(vmf, head)) {
-		rcu_read_unlock();
-		return VM_FAULT_NOPAGE;
+		ret = VM_FAULT_NOPAGE;
+		goto out;
 	}
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
@@ -3066,9 +3064,9 @@ unlock:
 		put_page(head);
 	} while ((head = next_map_page(vmf, &xas, end_pgoff)) != NULL);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+out:
 	rcu_read_unlock();
 	vmf->address = address;
-	vmf->pte = NULL;
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 
 	return ret;
--

and then the corruption is fixed.  It seems miraculous that the
machines even booted with that bad vmf->address going to __do_fault():
maybe that tells us what a good job map_pages does most of the time.

You'll see I've tried removing the "vmf->pte = NULL;" there. I did
criticize earlier that vmf->pte was being left set, but was either
thinking back to some earlier era of mm/memory.c, or else confusing
with vmf->prealloc_pte, which is NULLed when consumed: I could not
find anywhere in mm/memory.c which now needs vmf->pte to be cleared,
and I seem to run fine without it (even on i386 HIGHPTE).

So, the mystery is solved; but I don't think any of these patches
should be applied.  Without thinking through Linus's suggestions
re do_set_pte() in particular, I do think this map_pages interface
is too ugly, and given us lots of trouble: please take your time
to go over it all again, and come up with a cleaner patch.

I've grown rather jaded, and questioning the value of the rework:
I don't think I want to look at or test another for a week or so.

Hugh
