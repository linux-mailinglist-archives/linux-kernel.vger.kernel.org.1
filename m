Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED862EA3EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbhAED3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAED3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:29:46 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23DC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 19:29:00 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 11so28069872oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 19:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OEQnDTznOGYsd4YHvLb6vOtcCs/bnrzDWIdTBTUiU18=;
        b=jEJuw02+cKDBcQiPTMADdbhHvV6HX1IJI38RLFq7Tn0R42H0BP7etevU8MW0aLiiL6
         Q4mVT0dsNv8jIDXlC8TClitAFEaT2fng7enIR4PQ6UZce+iPjAi9Vy6PeMbdFUDYOIWK
         bKM8dVq9jl+BwjiRkPLVylVYsMBhLjIqyEPCNxzVhizRyG/FirVXxtBB7u/uBEjHT2UU
         owELxlgxbh4JFta7xpIFUlyg8dtVIniinqgw2T6Q3Bm/Ym6C8PrmO5YAkVJadPqYlowM
         alTyVYdPD3cDlf+VFhpWba+ptd+8LQc5OcD9J+ezy6el7lafHEpGGOLgCXaPfH1kxTbh
         MzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OEQnDTznOGYsd4YHvLb6vOtcCs/bnrzDWIdTBTUiU18=;
        b=NlMmrBuiR4vZTDsaQ506M/961ERaolmeRLUtj64lCT682q2RX/XFrBOwOsa3oQXT7f
         zlqda//KdDQgdu7AOFAn5ytEOqDm+1VFAMbyOiD9Yo2fmo2INw5R3xayecOCQcv6JEAH
         Zj5+CCv9t7+UADDcuEAL6vrggmIyqESu5eFE6KWLeXhf0YeNlVBV/3jtxwQtZNEuLdp2
         A5+/zajjrCn9+x5Mqq2bdibG2PMnTU+gSOOrW2hgKG5Cvd1GTFueMPIiRnXP5u6ZAD8Q
         2osm0NdR+UxhEHhANxeOtoGrVQepSz8mDHWcYyjmlQZJixoUfDZXq735ktnKs83W562J
         vMGA==
X-Gm-Message-State: AOAM532kXe0NFzFML5tqf8fWImikuUti/Xrp7AigQYNRw0XnXCybzb9/
        8iDeScha5U4yQSNwp2lLqewOBw==
X-Google-Smtp-Source: ABdhPJwh0aMxLLKxE7YmMrJGD1soh3D8RnvC1nfhApH2eMkBM8cgvEatE7RKHbs7WjTDvNCm7kdy2A==
X-Received: by 2002:a9d:7e8c:: with SMTP id m12mr55198788otp.38.1609817339717;
        Mon, 04 Jan 2021 19:28:59 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l21sm14741927otd.0.2021.01.04.19.28.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 04 Jan 2021 19:28:59 -0800 (PST)
Date:   Mon, 4 Jan 2021 19:28:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
In-Reply-To: <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2101041839440.3466@eggly.anvils>
References: <000000000000886dbd05b7ffa8db@google.com> <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org> <CAHk-=wi6hd8ATJ1W90goTxjgyvuoFsf0xZdAJmZ2c0dx5wcJSg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jan 2021, Linus Torvalds wrote:
> On Mon, Jan 4, 2021 at 12:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > Linus, how confident are you in those wait_on_page_bit_common()
> > changes?
> 
> Pretty confident. The atomicity of the bitops themselves is fairly simple.
> 
> But in the writeback bit? No. The old code would basically _loop_ if
> it was woken up and the writeback bit was set again, and would hide
> any problems with it.
> 
> The new code basically goes "ok, the writeback bit was clear at one
> point, so I've waited enough".
> 
> We could easily turn the "if ()" in wait_on_page_writeback() into a "while()".
> 
> But honestly, it does smell to me like the bug is always in the caller
> not having serialized with whatever actually starts writeback. High
> figured out one such case.
> 
> This code holds the page lock, but I don't see where
> set_page_writeback() would always be done with the page lock held. So
> what really protects against PG_writeback simply being set again?
> 
> The whole BUG_ON() seems entirely buggy to me.
> 
> In fact, even if you hold the page lock while doing
> set_page_writeback(), since the actual IO does *NOT* hold the page
> lock, the unlock happens without it. So even if every single case of
> setting the page writeback were to hold the page lock,

I did an audit when this came up before, and though not 100% confident
in my diligence, it certainly looked that way; and others looked too
(IIRC Matthew had a patch to add a WARN_ON_ONCE or whatever, but that
didn't go upstream).

> what keeps this from happening:
> 
> CPU1 = end previous writeback
> CPU2 = start new writeback under page lock
> CPU3 = write_cache_pages()
> 
>   CPU1          CPU2            CPU3
>   ----          ----            ----
> 
>   end_page_writeback()
>     test_clear_page_writeback(page)
>     ... delayed...
> 
> 
>                 lock_page();
>                 set_page_writeback()
>                 unlock_page()
> 
> 
>                                 lock_page()
>                                 wait_on_page_writeback();
> 
>     wake_up_page(page, PG_writeback);
>     .. wakes up CPU3 ..
> 
>                                 BUG_ON(PageWriteback(page));
> 
> IOW, that BUG_ON() really feels entirely bogus to me. Notice how it
> wasn't actually serialized with the waking up of the _previous_ bit.

Well.  That looks so obvious now you suggest it, that I feel very
stupid for not seeing it before, so have tried hard to disprove you.
But I think you're right.

> 
> Could we make the wait_on_page_writeback() just loop if it sees the
> page under writeback again? Sure.
> 
> Could we make the wait_on_page_bit_common() code say "if this is
> PG_writeback, I won't wake it up after all, because the bit is set
> again?" Sure.
> 
> But I feel it's really that end_page_writeback() itself is
> fundamentally buggy, because the "wakeup" is not atomic with the bit
> clearing _and_ it doesn't actually hold the page lock that is
> allegedly serializing this all.

And we won't be adding a lock_page() into end_page_writeback()!

> 
> That raciness was what caused the "stale wakeup from previous owner"
> thing too. And I think that Hugh fixed the page re-use case, but the
> fundamental problem of end_page_writeback() kind of remained.
> 
> And yes, I think this was all hidden by wait_on_page_writeback()
> effectively looping over the "PageWriteback(page)" test because of how
> wait_on_page_bit() worked.
> 
> So the one-liner of changing the "if" to "while" in
> wait_on_page_writeback() should get us back to what we used to do.

I think that is the realistic way to go.

> 
> Except I still get the feeling that the bug really is not in
> wait_on_page_writeback(), but in the end_page_writeback() side.
> 
> Comments? I'm perfectly happy doing the one-liner. I would just be
> _happier_ with end_page_writeback() having the serialization..
> 
> The real problem is that "wake_up_page(page, bit)" is not the thing
> that actually clears the bit. So there's a fundamental race between
> clearing the bit and waking something up.
> 
> Which makes me think that the best option would actually be to move
> the bit clearing _into_ wake_up_page(). But that looks like a very big
> change.

I'll be surprised if that direction is even possible, without unpleasant
extra locking.  If there were only one wakeup to be done, perhaps, but
potentially there are many.  When I looked before, it seemed that the
clear bit needs to come before the wakeup, and the wakeup needs to come
before the clear bit.  And the BOOKMARK case drops q->lock.

It should be possible to rely on the XArray's i_pages lock rather than
the page lock for serialization, much as I did in one variant of the
patch I sent originally.  Updated version appended below for show
(most of it rearrangement+cleanup rather than the functional change);
but I think it's slightly incomplete (__test_set_page_writeback()
should take i_pages lock even in the !mapping_use_writeback_tags case);
and last time around you were worried by the NULL mapping case - which
I believe just comes from an abundance of caution (who writes back
without any backing? and truncation/eviction wait_on_page_writeback()).

But I expect you to take one look and quickly opt instead for the "while"
in wait_on_page_writeback(): which is not so bad now that you've shown a
scenario which justifies it.

--- 5.11-rc2/include/linux/page-flags.h	2020-12-27 20:39:36.819923814 -0800
+++ linux/include/linux/page-flags.h	2021-01-04 17:27:32.771920607 -0800
@@ -549,7 +549,6 @@ static __always_inline void SetPageUptod
 
 CLEARPAGEFLAG(Uptodate, uptodate, PF_NO_TAIL)
 
-int test_clear_page_writeback(struct page *page);
 int __test_set_page_writeback(struct page *page, bool keep_write);
 
 #define test_set_page_writeback(page)			\
--- 5.11-rc2/include/linux/pagemap.h	2020-12-13 14:41:30.000000000 -0800
+++ linux/include/linux/pagemap.h	2021-01-04 17:27:32.775920636 -0800
@@ -660,6 +660,7 @@ static inline int lock_page_or_retry(str
  */
 extern void wait_on_page_bit(struct page *page, int bit_nr);
 extern int wait_on_page_bit_killable(struct page *page, int bit_nr);
+extern void wake_up_page_bit(struct page *page, int bit_nr);
 
 /* 
  * Wait for a page to be unlocked.
--- 5.11-rc2/kernel/sched/wait_bit.c	2020-03-29 15:25:41.000000000 -0700
+++ linux/kernel/sched/wait_bit.c	2021-01-04 17:27:32.779920665 -0800
@@ -90,9 +90,8 @@ __wait_on_bit_lock(struct wait_queue_hea
 			ret = action(&wbq_entry->key, mode);
 			/*
 			 * See the comment in prepare_to_wait_event().
-			 * finish_wait() does not necessarily takes wwq_head->lock,
-			 * but test_and_set_bit() implies mb() which pairs with
-			 * smp_mb__after_atomic() before wake_up_page().
+			 * finish_wait() does not necessarily take
+			 * wwq_head->lock, but test_and_set_bit() implies mb().
 			 */
 			if (ret)
 				finish_wait(wq_head, &wbq_entry->wq_entry);
--- 5.11-rc2/mm/filemap.c	2020-12-27 20:39:37.659932212 -0800
+++ linux/mm/filemap.c	2021-01-04 17:28:59.464560914 -0800
@@ -1093,7 +1093,7 @@ static int wake_page_function(wait_queue
 	return (flags & WQ_FLAG_EXCLUSIVE) != 0;
 }
 
-static void wake_up_page_bit(struct page *page, int bit_nr)
+void wake_up_page_bit(struct page *page, int bit_nr)
 {
 	wait_queue_head_t *q = page_waitqueue(page);
 	struct wait_page_key key;
@@ -1147,13 +1147,6 @@ static void wake_up_page_bit(struct page
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
-static void wake_up_page(struct page *page, int bit)
-{
-	if (!PageWaiters(page))
-		return;
-	wake_up_page_bit(page, bit);
-}
-
 /*
  * A choice of three behaviors for wait_on_page_bit_common():
  */
@@ -1466,40 +1459,6 @@ void unlock_page(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page);
 
-/**
- * end_page_writeback - end writeback against a page
- * @page: the page
- */
-void end_page_writeback(struct page *page)
-{
-	/*
-	 * TestClearPageReclaim could be used here but it is an atomic
-	 * operation and overkill in this particular case. Failing to
-	 * shuffle a page marked for immediate reclaim is too mild to
-	 * justify taking an atomic operation penalty at the end of
-	 * ever page writeback.
-	 */
-	if (PageReclaim(page)) {
-		ClearPageReclaim(page);
-		rotate_reclaimable_page(page);
-	}
-
-	/*
-	 * Writeback does not hold a page reference of its own, relying
-	 * on truncation to wait for the clearing of PG_writeback.
-	 * But here we must make sure that the page is not freed and
-	 * reused before the wake_up_page().
-	 */
-	get_page(page);
-	if (!test_clear_page_writeback(page))
-		BUG();
-
-	smp_mb__after_atomic();
-	wake_up_page(page, PG_writeback);
-	put_page(page);
-}
-EXPORT_SYMBOL(end_page_writeback);
-
 /*
  * After completing I/O on a page, call this routine to update the page
  * flags appropriately
--- 5.11-rc2/mm/page-writeback.c	2020-12-13 14:41:30.000000000 -0800
+++ linux/mm/page-writeback.c	2021-01-04 17:28:59.464560914 -0800
@@ -589,7 +589,7 @@ static void wb_domain_writeout_inc(struc
 
 /*
  * Increment @wb's writeout completion count and the global writeout
- * completion count. Called from test_clear_page_writeback().
+ * completion count. Called from end_page_writeback().
  */
 static inline void __wb_writeout_inc(struct bdi_writeback *wb)
 {
@@ -2719,49 +2719,69 @@ int clear_page_dirty_for_io(struct page
 }
 EXPORT_SYMBOL(clear_page_dirty_for_io);
 
-int test_clear_page_writeback(struct page *page)
+/**
+ * end_page_writeback - end writeback against a page
+ * @page: the page
+ */
+void end_page_writeback(struct page *page)
 {
-	struct address_space *mapping = page_mapping(page);
+	struct address_space *mapping;
 	struct mem_cgroup *memcg;
 	struct lruvec *lruvec;
-	int ret;
+	unsigned long flags;
+	int writeback;
+
+	/*
+	 * TestClearPageReclaim could be used here but it is an atomic
+	 * operation and overkill in this particular case. Failing to
+	 * shuffle a page marked for immediate reclaim is too mild to
+	 * justify taking an atomic operation penalty at the end of
+	 * every page writeback.
+	 */
+	if (PageReclaim(page)) {
+		ClearPageReclaim(page);
+		rotate_reclaimable_page(page);
+	}
 
+	mapping = page_mapping(page);
+	WARN_ON_ONCE(!mapping);
 	memcg = lock_page_memcg(page);
 	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
+	dec_lruvec_state(lruvec, NR_WRITEBACK);
+	dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
+	inc_node_page_state(page, NR_WRITTEN);
+
+	if (mapping)
+		xa_lock_irqsave(&mapping->i_pages, flags);
+
+	writeback = TestClearPageWriteback(page);
+	/* No need for smp_mb__after_atomic() after TestClear */
+	if (PageWaiters(page))
+		wake_up_page_bit(page, PG_writeback);
+
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
 		struct backing_dev_info *bdi = inode_to_bdi(inode);
-		unsigned long flags;
 
-		xa_lock_irqsave(&mapping->i_pages, flags);
-		ret = TestClearPageWriteback(page);
-		if (ret) {
-			__xa_clear_mark(&mapping->i_pages, page_index(page),
+		__xa_clear_mark(&mapping->i_pages, page_index(page),
 						PAGECACHE_TAG_WRITEBACK);
-			if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
-				struct bdi_writeback *wb = inode_to_wb(inode);
+		if (bdi->capabilities & BDI_CAP_WRITEBACK_ACCT) {
+			struct bdi_writeback *wb = inode_to_wb(inode);
 
-				dec_wb_stat(wb, WB_WRITEBACK);
-				__wb_writeout_inc(wb);
-			}
+			dec_wb_stat(wb, WB_WRITEBACK);
+			__wb_writeout_inc(wb);
 		}
+		if (inode && !mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
+			sb_clear_inode_writeback(inode);
+	}
 
-		if (mapping->host && !mapping_tagged(mapping,
-						     PAGECACHE_TAG_WRITEBACK))
-			sb_clear_inode_writeback(mapping->host);
-
+	if (mapping)
 		xa_unlock_irqrestore(&mapping->i_pages, flags);
-	} else {
-		ret = TestClearPageWriteback(page);
-	}
-	if (ret) {
-		dec_lruvec_state(lruvec, NR_WRITEBACK);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		inc_node_page_state(page, NR_WRITTEN);
-	}
 	__unlock_page_memcg(memcg);
-	return ret;
+	BUG_ON(!writeback);
 }
+EXPORT_SYMBOL(end_page_writeback);
 
 int __test_set_page_writeback(struct page *page, bool keep_write)
 {
