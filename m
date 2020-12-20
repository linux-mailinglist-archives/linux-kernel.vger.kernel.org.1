Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738C42DF282
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 01:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgLTAXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 19:23:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgLTAXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 19:23:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609DC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 16:22:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t16so6992687wra.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 16:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=veEGZkmRRU+6E+UwbrDFrTo1q54Pe0TuW7IheShsqgA=;
        b=MAVOTwEQw8QbqgDyQ46hHNZrl6HqZHhF7eH/57yIAv2P2FfzIK5ddlSCeqtJs+SRhE
         KIrPzqVY/xTn1cbwo4Qp6RXhapIy+O0MJzYrDdAcENKglMxRuoVzHl0Q25tGY6wkAnJe
         pOykfWDvLZSelj7XD+F67fiJ1V8bUaDGG4nP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veEGZkmRRU+6E+UwbrDFrTo1q54Pe0TuW7IheShsqgA=;
        b=YCCq7Uwfx3ayxeDtQ/AqhxeHRYcdLb+4fgMOBzcy7k8EztO8aEQ4p5LRwQnQQhXPe2
         H1cSgOC9D0k5OALM7p0VCPcfwtH2Vw98eASOJkY1grx+uOdFD9btsJtylZaFYd/9sp7c
         ryVKHRSCTM7I1j3bZpclltjwuXJm34821QQ1Qa2pCWdZuplhk34JDIkowi7mRZjrW3kC
         7Tb4wYNX8qMmta/SwUVZUl6cEInn8rEF++Q3CjnfFAzv+Yjeyaof0igSs87msJQTtCC/
         V1Dkk1TQd6WyarV9QMnaNmgHynmhdyyzN1rql5sAT2TwGU6I9WN/YFAGJWwGglJskR6r
         twIw==
X-Gm-Message-State: AOAM530UQO7S7bkA6XLqpZY07c32twwoNcseMBksBkB37e2a51C6nu9A
        pH9jPqrYThEO/3Q5Vmtgk+rOVnSBHTw702EcsCo=
X-Google-Smtp-Source: ABdhPJyeafvDyYyRQYfUxsG6iRQp0MQssaNwO8Q3S3gSvjF7fMxIUBR3ATGnkzE/TykBNVBdTLh3yQ==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr11324606wrb.357.1608423762138;
        Sat, 19 Dec 2020 16:22:42 -0800 (PST)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id x13sm20635830wrp.80.2020.12.19.16.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 16:22:41 -0800 (PST)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] zsmalloc: do not use bit_spin_lock
Date:   Sun, 20 Dec 2020 02:22:28 +0200
Message-Id: <20201220002228.38697-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zsmalloc takes bit spinlock in its _map() callback and releases it
only in unmap() which is unsafe and leads to zswap complaining
about scheduling in atomic context.

To fix that and to improve RT properties of zsmalloc, remove that
bit spinlock completely and use a bit flag instead.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 mm/zsmalloc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7289f502ffac..ff26546a7fed 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -876,22 +876,25 @@ static unsigned long obj_to_head(struct page *page, void *obj)
 
 static inline int testpin_tag(unsigned long handle)
 {
-	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
+	return test_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
 }
 
 static inline int trypin_tag(unsigned long handle)
 {
-	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
+	return !test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
 }
 
-static void pin_tag(unsigned long handle) __acquires(bitlock)
+static void pin_tag(unsigned long handle)
 {
-	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
+	preempt_disable();
+	while(test_and_set_bit(HANDLE_PIN_BIT, (unsigned long *)handle))
+		cpu_relax();
+	preempt_enable();
 }
 
 static void unpin_tag(unsigned long handle) __releases(bitlock)
 {
-	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
+	clear_bit(HANDLE_PIN_BIT, (unsigned long *)handle);
 }
 
 static void reset_page(struct page *page)
-- 
2.20.1

