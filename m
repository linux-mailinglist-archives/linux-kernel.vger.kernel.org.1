Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B4E2F830B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbhAORxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbhAORxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:53:46 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A24EC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:05 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id u67so555389wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d+lRqXXla6mV/kMKnUzgl/DAB69C3QZUVHCf/SWSD4s=;
        b=KgXsADO6gYG+QvJv8VSvdUb8Ltjmd7v7h/iXf4vB+MUx9Hgoo/jNS+Vf6CaL2wEuKc
         iZx+uRlsmSmChjKZB8PeM+2dY6z/JyFIFLWBbNw1VAx4D2M/iXObjUzCZ7fBSfeX3u0r
         5YfdIu95gEZandu93MmDpCwNWtqhZpPlSmmjfvOZLYE9Sbuujc+aqXC2qj2elqLEJ9VM
         RaDCLzvWaX5/2oD76eVUv0i6nIfmJk8vOryRmLyptUhh9nWI1mtpqlx+Yn/uT4oybi6f
         oNtAzPYrqpulLvHqnis8loKBQl943FBAFrdnh9YV5x3XZP96MO3+h0totSFQGrfhOew9
         8ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d+lRqXXla6mV/kMKnUzgl/DAB69C3QZUVHCf/SWSD4s=;
        b=QalfEh3SK2Yw9vAqQ3Ggi1k1Zcy6PmM2uY6wByNTQ+iybEjSC7jIHVJnX2U5qxjBme
         V7Va+mcMiB6XSsHdNL8CigfBGAyjAiGGB0p2CgpZThyY2QFruzXBkuq50Nn47kLwkF9U
         idgQ6kSf1loK51inIc0FcqC7ZEK4Kxo7F2p4I09+JU6lUHWvgXLfGzPqhdvYmglWgxmS
         kEK1x34CfQVgf606IPCsUAYcoablP/BjQpRhr/7WOB7CAv8BbimaR4yln5NV55OceHL2
         oKLWZpz3tOxIBedy8sYJ2fURGHACes874AK7Dw9qOMqYxfCDQBar7+YdXYUphTc0hSO4
         3Nng==
X-Gm-Message-State: AOAM532nsaVruXxumAbK2htV0IUvYb6KIGzxZgVMnm33NitLZ74Wvxwf
        IXCbayTJaoi8O1reEjI9X9LGsfT6eurl9I54
X-Google-Smtp-Source: ABdhPJxUL79lbHyM9ib1bYpCh98XNU7ltPS1uDYDg7Hf/2+vn3e8C3YxAqL9xZFwJzAt5tybo0F8O9/8zxE6C0yc
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e60f:: with SMTP id
 p15mr14224523wrm.60.1610733184113; Fri, 15 Jan 2021 09:53:04 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:39 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <3b4ea6875bb14d312092ad14ac55cb456c83c08e.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 02/15] kasan: clarify HW_TAGS impact on TBI
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mention in the documentation that enabling CONFIG_KASAN_HW_TAGS
always results in in-kernel TBI (Top Byte Ignore) being enabled.

Also do a few minor documentation cleanups.

Link: https://linux-review.googlesource.com/id/Iba2a6697e3c6304cb53f89ec61dedc77fa29e3ae
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 0fc3fb1860c4..26c99852a852 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -147,15 +147,14 @@ negative values to distinguish between different kinds of inaccessible memory
 like redzones or freed memory (see mm/kasan/kasan.h).
 
 In the report above the arrows point to the shadow byte 03, which means that
-the accessed address is partially accessible.
-
-For tag-based KASAN this last report section shows the memory tags around the
-accessed address (see `Implementation details`_ section).
+the accessed address is partially accessible. For tag-based KASAN modes this
+last report section shows the memory tags around the accessed address
+(see the `Implementation details`_ section).
 
 Boot parameters
 ~~~~~~~~~~~~~~~
 
-Hardware tag-based KASAN mode (see the section about different mode below) is
+Hardware tag-based KASAN mode (see the section about various modes below) is
 intended for use in production as a security mitigation. Therefore it supports
 boot parameters that allow to disable KASAN competely or otherwise control
 particular KASAN features.
@@ -305,6 +304,13 @@ reserved to tag freed memory regions.
 Hardware tag-based KASAN currently only supports tagging of
 kmem_cache_alloc/kmalloc and page_alloc memory.
 
+If the hardware doesn't support MTE (pre ARMv8.5), hardware tag-based KASAN
+won't be enabled. In this case all boot parameters are ignored.
+
+Note, that enabling CONFIG_KASAN_HW_TAGS always results in in-kernel TBI being
+enabled. Even when kasan.mode=off is provided, or when the hardware doesn't
+support MTE (but supports TBI).
+
 What memory accesses are sanitised by KASAN?
 --------------------------------------------
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

