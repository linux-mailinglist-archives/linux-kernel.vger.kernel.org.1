Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3B628E2EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgJNPQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbgJNPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:16:25 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F818C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:16:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j7so2184251pgk.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3UjFE7VixEeZAJh7GxqCLEhaM8omnp6TMdVW0d7yYmU=;
        b=tUorpDDNX/i1ngSiAoB01oeylwF9BK3zrNnpc+Kr+HxJPhLgU0Olt1FHb+JyxAuEtV
         ttcPP3meYY3wOnqfoZb4cDAsx2j95M3M93y7eyaqsFOgsp35UqlZDR41pS2jASSHPM8b
         DgPL8f76g92aKCVQoDhG3pcz0GIVlm9maxADqUbEOpa5JAfHYtwjgVcYdlysv4PoZf2i
         b7uoH6GPj6qC2RQh+XU9CLYeICGbphNaOuE5Uk82d/dHJcviDIkHWDyyTRVLIE71N8mt
         7e8izHAUglAj9E9Ob+l99BpQZWv68iJG951u6vaO8SaXVGhqvrAEkL5gQ20zKibQRlXT
         10Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3UjFE7VixEeZAJh7GxqCLEhaM8omnp6TMdVW0d7yYmU=;
        b=RQziFTQIYN99djemsdesQGSZHmF6Cu1docxACfUq/z6ewJq0MUtsrqX5ZR0bNFAdMi
         leL1m7qFyt2m6e3bFJbVEC0/U8iUUFLwt4gfyMrIDvNMnwTCYCpuUBR6c3bXfqkcio4M
         TlRyGcZiukLLz0bhcafuGt+l0pMt2Co08g9BwPzRAHDAnerv7Hl/4FqO7Ystdx4RJTew
         94wGumnMHc5jupih3TeuGseLPtWlTGw9RlVCyjlkZeVBh2+TnmCA6+0dF/kbbnqlK3PP
         ylN1P4gNqXiRmhqlqmfSb5/3CNkeR2LV2kIQrtocUZ9uXqULC3dDnd92Zuf4e19qfw61
         i36A==
X-Gm-Message-State: AOAM530+7eo3et5meGP6/c8TVUE1cch3j/zgLX5oxVgiOhVL4KBMzJBL
        iTW8cGpSb6LI717GE/pW1GaUawfgNMTWnQ==
X-Google-Smtp-Source: ABdhPJxfRXKiYu6c6zxeB43klwL5jPHO6NbX1CB8fPZFwhI8E1vBlGlJX+l9NmIzwezGEEDA3Eh50g==
X-Received: by 2002:a63:24c2:: with SMTP id k185mr4370279pgk.421.1602688584552;
        Wed, 14 Oct 2020 08:16:24 -0700 (PDT)
Received: from localhost ([13.94.42.177])
        by smtp.gmail.com with ESMTPSA id q66sm3740161pfc.109.2020.10.14.08.16.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Oct 2020 08:16:23 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] ring-buffer: Add rb_check_bpage in __rb_allocate_pages
Date:   Wed, 14 Oct 2020 23:16:14 +0800
Message-Id: <20201014151614.29804-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may be better to check each page is aligned by 4 bytes. The 2
least significant bits of the address will be used as flags.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/ring_buffer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 93ef0ab6ea20..9dec7d58b177 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1420,7 +1420,8 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 	return 0;
 }
 
-static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
+static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
+		long nr_pages, struct list_head *pages, int cpu)
 {
 	struct buffer_page *bpage, *tmp;
 	bool user_thread = current->mm != NULL;
@@ -1464,6 +1465,8 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 		if (!bpage)
 			goto free_pages;
 
+		rb_check_bpage(cpu_buffer, bpage);
+
 		list_add(&bpage->list, pages);
 
 		page = alloc_pages_node(cpu_to_node(cpu), mflags, 0);
@@ -1498,7 +1501,7 @@ static int rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(!nr_pages);
 
-	if (__rb_allocate_pages(nr_pages, &pages, cpu_buffer->cpu))
+	if (__rb_allocate_pages(cpu_buffer, nr_pages, &pages, cpu_buffer->cpu))
 		return -ENOMEM;
 
 	/*
@@ -2007,7 +2010,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 			 * allocated without receiving ENOMEM
 			 */
 			INIT_LIST_HEAD(&cpu_buffer->new_pages);
-			if (__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
+			if (__rb_allocate_pages(cpu_buffer, cpu_buffer->nr_pages_to_update,
 						&cpu_buffer->new_pages, cpu)) {
 				/* not enough memory for new pages */
 				err = -ENOMEM;
@@ -2073,7 +2076,7 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 
 		INIT_LIST_HEAD(&cpu_buffer->new_pages);
 		if (cpu_buffer->nr_pages_to_update > 0 &&
-			__rb_allocate_pages(cpu_buffer->nr_pages_to_update,
+			__rb_allocate_pages(cpu_buffer, cpu_buffer->nr_pages_to_update,
 					    &cpu_buffer->new_pages, cpu_id)) {
 			err = -ENOMEM;
 			goto out_err;
-- 
2.17.1

