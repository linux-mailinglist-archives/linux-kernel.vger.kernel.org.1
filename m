Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFE922FCA3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 01:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgG0XIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 19:08:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40615 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgG0XIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:08:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id h7so16981810qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRzoFnv3X6rZZ58A9nfh58By1q+3T1zxEck+xIJrMo0=;
        b=rI3362hRbHQkdRqx6WPDswx/Q3y6X16JrG1UEoZOQo+Ww2if6chHlyfi8Tt+mTuwrX
         zTS+Rty30tUhcB6BNoH3daNJyURa/XEdcl7PJvPUe2au2Sje6wQkAKmmQuhfsAQ0+n5U
         MDOh9R5BJsoRaH+c3Z5Dfekj+p2CNYFh7QnStJk7xsyO0tLcyrKsGac1bgKEq5lDb/mI
         e7rjdDaQOlxwnxHGwTwwxbQI2RQeVXrv/tLYYSTC8d4+H5ghwpdYIUW/3Gur5jMFsZBp
         BNtsGDlWoTmYmcfU+cST1mTraqB0eb0GvvxKY4ZbJZF+lG7qvMRQrk7Uo2/bJ4lr7UuU
         WDuA==
X-Gm-Message-State: AOAM530TxJleXR7UFMkHf0nCEF2yp+kzdfTfgx0NDyuympn36AaZw5Sd
        zh09lKMWmb6SJtLbaeypKz8=
X-Google-Smtp-Source: ABdhPJyX0ca2NrSgYn5enJuUMbgOdp/UNdCrYLcXYa9StkNntYi8S0u31sYJgO5fSrnIRnsgzi31EA==
X-Received: by 2002:a05:620a:2481:: with SMTP id i1mr5485957qkn.139.1595891289482;
        Mon, 27 Jul 2020 16:08:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j61sm8216984qtd.52.2020.07.27.16.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:08:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] x86/kaslr: Clean up slot handling
Date:   Mon, 27 Jul 2020 19:08:00 -0400
Message-Id: <20200727230801.3468620-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of slots and slot areas can be unsigned int, since on 64-bit,
the maximum amount of memory is 2^52, the minimum alignment is 2^21, so
the slot number cannot be greater than 2^31. The slot areas are limited
by MAX_SLOT_AREA, currently 100. Replace the type used for slot number,
which is currently a mix of int and unsigned long, with unsigned int
consistently.

Drop unnecessary check that number of slots is not zero in
store_slot_info, it's guaranteed to be at least 1 by the calculation.

Drop unnecessary alignment of image_size to CONFIG_PHYSICAL_ALIGN in
find_random_virt_addr, it cannot change the result: the largest valid
slot is the largest n that satisfies

  minimum + n * CONFIG_PHYSICAL_ALIGN + image_size <= KERNEL_IMAGE_SIZE

(since minimum is already aligned) and so n is equal to

  (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN

even if image_size is not aligned to CONFIG_PHYSICAL_ALIGN.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 36 ++++++++++++--------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 91c5f9771f42..eca2acc65e2a 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -511,16 +511,14 @@ static bool mem_avoid_overlap(struct mem_vector *img,
 
 struct slot_area {
 	unsigned long addr;
-	int num;
+	unsigned int num;
 };
 
 #define MAX_SLOT_AREA 100
 
 static struct slot_area slot_areas[MAX_SLOT_AREA];
-
-static unsigned long slot_max;
-
-static unsigned long slot_area_index;
+static unsigned int slot_area_index;
+static unsigned int slot_max;
 
 static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 {
@@ -530,13 +528,10 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
 		return;
 
 	slot_area.addr = region->start;
-	slot_area.num = (region->size - image_size) /
-			CONFIG_PHYSICAL_ALIGN + 1;
+	slot_area.num = 1 + (region->size - image_size) / CONFIG_PHYSICAL_ALIGN;
 
-	if (slot_area.num > 0) {
-		slot_areas[slot_area_index++] = slot_area;
-		slot_max += slot_area.num;
-	}
+	slot_areas[slot_area_index++] = slot_area;
+	slot_max += slot_area.num;
 }
 
 /*
@@ -589,8 +584,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
 
 static unsigned long slots_fetch_random(void)
 {
-	unsigned long slot;
-	int i;
+	unsigned int slot, i;
 
 	/* Handle case of no slots stored. */
 	if (slot_max == 0)
@@ -603,7 +597,7 @@ static unsigned long slots_fetch_random(void)
 			slot -= slot_areas[i].num;
 			continue;
 		}
-		return slot_areas[i].addr + slot * CONFIG_PHYSICAL_ALIGN;
+		return slot_areas[i].addr + (unsigned long)slot * CONFIG_PHYSICAL_ALIGN;
 	}
 
 	if (i == slot_area_index)
@@ -819,28 +813,24 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
 		return 0;
 	}
 
-	if (process_efi_entries(minimum, image_size))
-		return slots_fetch_random();
+	if (!process_efi_entries(minimum, image_size))
+		process_e820_entries(minimum, image_size);
 
-	process_e820_entries(minimum, image_size);
 	return slots_fetch_random();
 }
 
 static unsigned long find_random_virt_addr(unsigned long minimum,
 					   unsigned long image_size)
 {
-	unsigned long slots, random_addr;
-
-	/* Align image_size for easy slot calculations. */
-	image_size = ALIGN(image_size, CONFIG_PHYSICAL_ALIGN);
+	unsigned int slots;
+	unsigned long random_addr;
 
 	/*
 	 * There are how many CONFIG_PHYSICAL_ALIGN-sized slots
 	 * that can hold image_size within the range of minimum to
 	 * KERNEL_IMAGE_SIZE?
 	 */
-	slots = (KERNEL_IMAGE_SIZE - minimum - image_size) /
-		 CONFIG_PHYSICAL_ALIGN + 1;
+	slots = 1 + (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN;
 
 	random_addr = kaslr_get_random_long("Virtual") % slots;
 
-- 
2.26.2

