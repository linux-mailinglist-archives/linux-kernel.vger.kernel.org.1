Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5162C57BC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391215AbgKZPAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391180AbgKZPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:00:18 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:00:18 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id ek7so1029460qvb.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=qfMwSqnk0RUEJvnAIRSVXuZ7QDhIr4/4UMmKVwRvU1s=;
        b=MsCriKm4FptOt1FtMaChBpj/3LGtglhTiAi4+O90pTWyO7QU81pjskN5J5AUFFLU16
         B9xq2054vcAlSHOS+zicJOIArBVbEbzFvb2E3bSTDknXJOTza6hXen2fwFxjWZbE5QKK
         xONEokQ5akmBeY5hZTVcuekdXz/vWQ5LHR/h42pKclX8/uPq6+1AZQMZptpiG4vRIQcA
         e3ZBRm75Z0W7A2/2PzbRp/+Lv5zidqeujKel36qkvN83rZtSVKNUJkBcAEFExuD4O9Hp
         m+sHM4JEKyhXgmJSMgcPx8nlXCyHRU4RZsBj0X1I30TNRgPXUwyw4+wUQby8C91FE/P+
         K1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=qfMwSqnk0RUEJvnAIRSVXuZ7QDhIr4/4UMmKVwRvU1s=;
        b=HJKg77NEHbdED/S0k0kF/HunvAx3sPghUf8rO0zhMeqTCJ+iSpdi2UxCpWtQyo1QMp
         tOCht9QRZOnMjRGwpT8rll39mqkoqZyVzYfYfPbTVs6hKlG3zw6Pkd4lMNdsPXzPpEcu
         pJyX5T7O0lDdyOdKU1e3xLYqyGOQgVGM9asgp6Yfa9n7JAM4H15NxrCBL/+2QqA8wkGT
         HNPc8KEgKzFRM8+/rnnc/I1LOMYKzetsMWRe8MetZ4tQhahOkQPJTI3S5P1jyyHCOPap
         ASqD/dfUjVl/++k/LlR1jp3FluUGpgt7sVR5bI2IjSN1tYnO+COeNNU1cKQK46M0dSJM
         DwtA==
X-Gm-Message-State: AOAM530gBwFtniYqblRVDI5Lsf8GkxJ5+zBN+kfcMSRcjxQiKoTKKSLA
        1FLoIPhL0lvQBsjRRW0f1AlFSQ==
X-Google-Smtp-Source: ABdhPJzFBNneKrhNAMvfZ9IgrxaB93YuXHpdNG1lonKvRFRjgNA49RRp7Lll1CHE/AKh3hdTyi3X5A==
X-Received: by 2002:a0c:fc52:: with SMTP id w18mr3578801qvp.48.1606402817425;
        Thu, 26 Nov 2020 07:00:17 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id z20sm2978067qtb.31.2020.11.26.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 07:00:16 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
cc:     kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kasan, mm: fix build issue with asmlinkage
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Thu, 26 Nov 2020 10:00:15 -0500
Message-ID: <35126.1606402815@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 2df573d2ca4c1ce6ea33cb7849222f771e759211
Author: Andrey Konovalov <andreyknvl@google.com>
Date:   Tue Nov 24 16:45:08 2020 +1100

    kasan: shadow declarations only for software modes

introduces a build failure when it removed an include for linux/pgtable.h
It actually only needs linux/linkage.h

Test builds on both x86_64 and arm build cleanly

Fixes:   2df573d2ca4c ("kasan: shadow declarations only for software modes")
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

---
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 83860aa4e89c..5e0655fb2a6f 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -12,6 +12,7 @@ struct task_struct;
 
 #ifdef CONFIG_KASAN
 
+#include <linux/linkage.h>
 #include <asm/kasan.h>
 
 /* kasan_data struct is used in KUnit tests for KASAN expected failures */


