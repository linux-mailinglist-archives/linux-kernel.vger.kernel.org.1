Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18912EB292
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbhAES2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbhAES2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:28:48 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D9CC061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:08 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id c2so367953qvs.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VRs7dAB+P//KjkP9Cahy8mQRvB3cL9kKzxtAOErS7Qw=;
        b=RE48ZQIZwfMOj+AkhGO6anvwdkXrBxQVgj8nZblRXvhe5GH4a526P74jpgDRFjV28c
         5oFDwhgsmhCAdSpm4Jl8BHqucXqzQGbFI1MO2Ca3Sd5cED98rZKoFwJ2aFQoqvtOlcpX
         P3fAMVY4fhum/BNZLPkVNfbSI8/jnhxrc31oeRFqD27H46T9wfsnDoj+Ieftt5LyHzx+
         ZKBzJLBtVFB6uE1iZMgZr/TVbaIuauem3QVFE3ODS0ATQvTmIHyH9MTLRZcQjvU2Dyhz
         9A2/hi/xaSEQ1s5NN+YQtmGbk2PkuuzxdNkqnM5LirdSwLN9sI2EuoL72W/KuSDCQF/+
         OXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VRs7dAB+P//KjkP9Cahy8mQRvB3cL9kKzxtAOErS7Qw=;
        b=LvroxdNugiMA4sLiYrm6DsT8WDTHG74xpyKk+3fWqU1W9REvnBxsIzgg+wy+AG1GL5
         VVCjSIzKOAcVRLbCd5i4gALkLNDxAiTG1W73IX2sOhmTyIy9G9BOIvdlSzXsKLzAorqe
         xktQIG0ICQ8N/3LXjcQDiM7sN/YKHaqVz2O1Rtzq7Fh8i/5t4LqYc90x4bBSQbYh5PXo
         KinGiioiXvihtBY4gQr6pHRwz0I7+iIrCwMRTIVOfbn/aLO6edq3gxLqVRApLD05HiBm
         H4bam7a6Y8Tc+XzM46QIfq0ZxK6QMzSdD5qhymYPlMIekweSTuwukpoFf2W5uUseevdM
         rlQQ==
X-Gm-Message-State: AOAM531GzEe+/tSKKRn0A7q8EjoZjEuDUAppbnPU6ZHOQx5nCthfXTN5
        mI8ZNCCZ2SKcRXpTz7BYyYiWHNALPRKbBPKS
X-Google-Smtp-Source: ABdhPJxs7jsjH84m07SSwoqwOtTTJLJPT0usU1rxQ6d4O9vZHQndB+TM03WuWDwAEbVn2jHGgQ6EAgLEVWCFhVAp
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:684:: with SMTP id
 r4mr745500qvz.54.1609871287214; Tue, 05 Jan 2021 10:28:07 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:46 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <a5dfc703ddd7eacda0ee0da083c7afad44afff8c.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 02/11] kasan: clarify HW_TAGS impact on TBI
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Iba2a6697e3c6304cb53f89ec61dedc77fa29e3ae
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
2.29.2.729.g45daf8777d-goog

