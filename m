Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E529213B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgJSCqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 22:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729111AbgJSCqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:46:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B95C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 19:46:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i1so9646356wro.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 19:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7V26HkKgGmmx148aRxJJhCJa2HTwJxofxiia5WgrIJ0=;
        b=TADDJSnS6084IlUlij7J+1XwQyf0CDw/res6Hws/81NlI4OPl3m0Y9jwWOvCC3HYy8
         84SuQ3b8ib1pztQo6M7HZyd+LCXS1yQjqDiqgdBdxP1C+ti3xq8BR1zn3FHdS7rOYQKR
         njedkoe5I1akQe/L/2Xs1pqtyRuer6fEUwo/Q4/KUCUT7Lqx8LLE3vNvT8J3mEuCoVJ9
         0hPkPbxDLujM7CdhDctec4OX6BCj2DW6fBSG5FjOuLbVSQaoMft8JipWh+8hTeUQVswo
         eLxl+sZVp0ueEjBaTgBu4nCXzH8ZjX+2K15Pf6dT67an7TMXlaVOv4SdNpXBZ+AXNN9t
         ncxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7V26HkKgGmmx148aRxJJhCJa2HTwJxofxiia5WgrIJ0=;
        b=e/ceUca1STZ5UEkdItxpDG8Sk+jsK2ADGSwjNCw3lHBUmFVR2E2yr9RiQOuYb5S4yA
         PNRCec5KX+FAlXFNNsdtnB6YCIPWNNm2f8iC4CqYAwVwUR49fNi/U2xU2SGM8Ay7Uyee
         R6A8j7zghgAlXN2nED9wr42BugjOJBlCn/eBV6FEFCepFdV6d1JDCLM2uGwjXutr4tHY
         0KosxIQ12m9h07qLVPc/Zg/BVOetheCXvrjcTt9MXBITrUC/ZFQ3nFVillK+End0FZ2P
         NOpzcwiXtds8KYocKZAd4AmQOVZr23Xs7YjhB0pRIYjAfdfNKsjDdI5VYMnC5YCbwLRQ
         b8Yg==
X-Gm-Message-State: AOAM532C/xbKyMOQKG71lj9a8WPkOlKifNqhqqmM8WOlm7rhUztfZOhY
        tjPBgAMpNuH7jYKgyWqY5qg=
X-Google-Smtp-Source: ABdhPJw5OtqTNTNZ7PeRrETTk9CHvwy7bEQaxGCgi/7l3VXUpCcBjOJT3n86PD6BRx/fjyL7f5ThcA==
X-Received: by 2002:adf:8484:: with SMTP id 4mr17741191wrg.334.1603075564377;
        Sun, 18 Oct 2020 19:46:04 -0700 (PDT)
Received: from homer.simpson.net ([185.191.217.9])
        by smtp.googlemail.com with ESMTPSA id c130sm15330601wma.1.2020.10.18.19.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 19:46:03 -0700 (PDT)
Message-ID: <198af4a540faf0c11869894a2f8239cf50701b15.camel@gmail.com>
Subject: Re: [PATCH v3 7/7] zram: Use local lock to protect per-CPU data
From:   Mike Galbraith <umgwanakikbuti@gmail.com>
To:     Yu Zhao <yuzhao@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org
Date:   Mon, 19 Oct 2020 04:46:02 +0200
In-Reply-To: <20201019015252.GA61728@google.com>
References: <20200527201119.1692513-1-bigeasy@linutronix.de>
         <20200527201119.1692513-8-bigeasy@linutronix.de>
         <20201019015252.GA61728@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-18 at 19:52 -0600, Yu Zhao wrote:
> On Wed, May 27, 2020 at 10:11:19PM +0200, Sebastian Andrzej Siewior wrote:
> > From: Mike Galbraith <umgwanakikbuti@gmail.com>
> > 
> > The zcomp driver uses per-CPU compression. The per-CPU data pointer is
> > acquired with get_cpu_ptr() which implicitly disables preemption.
> > It allocates memory inside the preempt disabled region which conflicts
> > with the PREEMPT_RT semantics.
> > 
> > Replace the implicit preemption control with an explicit local lock.
> > This allows RT kernels to substitute it with a real per CPU lock, which
> > serializes the access but keeps the code section preemptible. On non RT
> > kernels this maps to preempt_disable() as before, i.e. no functional
> > change.
> 
> Hi,
> 
> This change seems to have introduced a potential deadlock. Can you
> please take a look?

Hm, looks like I'm getting undeserved credit for uncovering a locking
bug.  In reality, Sebastian was generous with attribution of derivative
work, so he should ge credit.. and it looks like peterz fixed it.

Date: Fri, 16 Oct 2020 14:40:09 +0200
From: Peter Zijlstra <peterz@infradead.org>

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9100ac36670a..c1e2c2e1cde8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1216,10 +1216,11 @@ static void zram_free_page(struct zram *zram, size_t index)
 static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 				struct bio *bio, bool partial_io)
 {
-	int ret;
+	struct zcomp_strm *zstrm;
 	unsigned long handle;
 	unsigned int size;
 	void *src, *dst;
+	int ret;
 
 	zram_slot_lock(zram, index);
 	if (zram_test_flag(zram, index, ZRAM_WB)) {
@@ -1250,6 +1251,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 
 	size = zram_get_obj_size(zram, index);
 
+	if (size != PAGE_SIZE)
+		zstrm = zcomp_stream_get(zram->comp);
+
 	src = zs_map_object(zram->mem_pool, handle, ZS_MM_RO);
 	if (size == PAGE_SIZE) {
 		dst = kmap_atomic(page);
@@ -1257,8 +1261,6 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 		kunmap_atomic(dst);
 		ret = 0;
 	} else {
-		struct zcomp_strm *zstrm = zcomp_stream_get(zram->comp);
-
 		dst = kmap_atomic(page);
 		ret = zcomp_decompress(zstrm, src, size, dst);
 		kunmap_atomic(dst);


