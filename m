Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C063C2B29CE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 01:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKNAXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 19:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKNAXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:23:10 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:23:10 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s201so7845043pfs.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 16:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=pwf+1H1spJ2Rr8VRwYyjf+vFmwvZi0E13IJUljcvllc=;
        b=wUMjAYpWBtfqklXt3gJJIspzp5S/Rr8QpFyDsmA6S8375rQ9f3UUOEF70GCjdrpEga
         0TyaUUesZS8omOBfhLNEGxaJi0up0cG6sNefFpP/YxGCRMl8jsPkFMiU/i6eMn7BQwdG
         4fcvABlL6QE4s831dEjVICfIOxqfglL1SK0j2/ydmDR9VS/jXIPRunLZboGADW3wQTf4
         CsjdqrFakkEQad1p0ZMPtnIC68E5GWaMccV5UFNZvvFhlSa4jfRX+1i/WFN2SNiY4Y86
         H3nXD/rWSA48hlst/CWTiV+4IVvWgv6bh82S+fAvM5YWe1kSeD7jCHI5wi6RpgUgphij
         XgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=pwf+1H1spJ2Rr8VRwYyjf+vFmwvZi0E13IJUljcvllc=;
        b=LjjtTPMzHZeZlICrPmquTgLgm1xdJZVv0Sx0cV3FQDSYkaaxp4AQ730jD/kfY+Atal
         chFziwkEeLqdHFjgpOy1SaXHrCztNONY00SmMy6IFZ1ML0wsL4JxWG4wdjmYO5AwxH5y
         PIgaO8lTInD2ot8Eu0CHPGV0OMZyr7Fak/uKu+bZxPdWz8jSw8Y4GooZzUhk1S/KeywA
         CZKRVidmMNJY3jOiTFJFSFDZT7baCRO8Q8deZEGZBsoHC8MNVUVN8Ibl4k0QG46x5quj
         0Z3Db3jO3X2NQ4sHTlEDDrcPl6mnWXthLxIbeMbHfeIn6LosgZ8TGDT6NcN59oWCZkB+
         wKFA==
X-Gm-Message-State: AOAM532Sof4omhoppdmRmME5t29puF1KfokmwYcQ+eJmVv3/9xddaevY
        lv83GBoh4ctWPdMKgKOa8FSfX232Find6dFv3qo=
X-Google-Smtp-Source: ABdhPJxHDBtKLh5633H9Zn7oTkuXrsr63ktjSN8my8TjHG8pX7syzOce5tGTtFF2vuvkWdwStyiRiz5S1So3jILPoVs=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:902:7488:b029:d7:e80f:2e45 with
 SMTP id h8-20020a1709027488b02900d7e80f2e45mr3825531pll.72.1605313389602;
 Fri, 13 Nov 2020 16:23:09 -0800 (PST)
Date:   Fri, 13 Nov 2020 16:23:05 -0800
Message-Id: <20201114002306.4166604-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 1/2] x86/pci: use unsigned int in check_reserved_t
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use unsigned int instead of raw unsigned in check_reserved_t to follow
the kernel's style guidelines.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/pci/mmconfig-shared.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 6fa42e9c4e6f..37f31dd7005a 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -425,7 +425,7 @@ static acpi_status find_mboard_resource(acpi_handle handle, u32 lvl,
 	return AE_OK;
 }
 
-static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
+static bool is_acpi_reserved(u64 start, u64 end, unsigned int not_used)
 {
 	struct resource mcfg_res;
 
@@ -442,7 +442,7 @@ static bool is_acpi_reserved(u64 start, u64 end, unsigned not_used)
 	return mcfg_res.flags;
 }
 
-typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned type);
+typedef bool (*check_reserved_t)(u64 start, u64 end, unsigned int type);
 
 static bool __ref is_mmconf_reserved(check_reserved_t is_reserved,
 				     struct pci_mmcfg_region *cfg,

base-commit: 9e6a39eae450b81c8b2c8cbbfbdf8218e9b40c81
-- 
2.29.2.299.gdc1121823c-goog

