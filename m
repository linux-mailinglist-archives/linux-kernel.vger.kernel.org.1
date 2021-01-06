Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B612EBF66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbhAFOV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbhAFOVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:21:22 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF8FC06135F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:20:34 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v3so1592235plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 06:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFckZYXk5VQEfKdlEUTc3knPt3y+LwjjdeKAGdt5ryA=;
        b=1KjT9ONUSkyF8Q1RWhUDzyXagTQvMQxF3tHWlpN5tFIt2pusDvBLLkYSk3Lovkz/Il
         k+2+NRiIQrvJOAS+q2qGB+hzntRKjUSKB5yhr5o+mCGs2T9/8fABKARb7vUSKS95WTU2
         kbiqhHSm/W7zmWSw2jw7A65jmkI8jxUSK+ms2va0bTqi37CBPz7m55qO9fOwxlovDSFV
         yJn8XyYsXcUIioz1XtNyJLHV7vbNh9gs5uH26Rc6bPiylChTV77xi0tL8pc6cylwkO6D
         8Uinq1HsZkoHX/uKgLD2BLl6nTCOHDhBHYXzuNDibN8f6Z8L+cuG9/ONcNkqw3RwrIyi
         IUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFckZYXk5VQEfKdlEUTc3knPt3y+LwjjdeKAGdt5ryA=;
        b=mSmGM8h0lw9e1ke8z16zG2J15PPi7ikqwydxp8nz+8kS8CtI5vvJk85d9UNPwz2bIm
         tIrgDXkA5K8WCKAtywPYSNHGd3ybVGR05PARP2iETepr5cZJgLwI/h8xSJUogsKiPCfP
         cKvcL0m/PGCnOZbaVUh+/ETMdBUBOsIA1/pNQ5izlmDrLRBwF9FEarzlDgmLS99XpCBs
         6ymkvtH6tegk8o6u9Nc0iSeWvXpdiVIDz15l3YXjAjxdm7nFHdZvGXXDut/F4tdqzmBz
         UQfOkOvckwq2/YcYYQ/ROIF30JK123HgajDb62YkEclIOJEVb5pMjLiGYibWVBvFlx+Z
         Yp1Q==
X-Gm-Message-State: AOAM533GMRX0vfOjFNW5Z+WnWey/DakS/p6DF8IhfH2jkezs6OnbQVIf
        5mDQcuJSmmqofwTEyPISyzykWQ==
X-Google-Smtp-Source: ABdhPJzYMxPuRWTM9wvccPSLGfRwc9NiMVeQnq957E/QCw6/MNSjnEUNjdHh37k1a0rYnQvIEl4eHg==
X-Received: by 2002:a17:902:9686:b029:dc:3372:6e14 with SMTP id n6-20020a1709029686b02900dc33726e14mr4482382plp.24.1609942834226;
        Wed, 06 Jan 2021 06:20:34 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id a29sm2831730pfr.73.2021.01.06.06.20.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 06:20:33 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v12 03/13] mm: Introduce VM_WARN_ON_PAGE macro
Date:   Wed,  6 Jan 2021 22:19:21 +0800
Message-Id: <20210106141931.73931-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106141931.73931-1-songmuchun@bytedance.com>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very similar to VM_WARN_ON_ONCE_PAGE and VM_BUG_ON_PAGE, add
VM_WARN_ON_PAGE macro.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/mmdebug.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
index 5d0767cb424a..eff5b13a6945 100644
--- a/include/linux/mmdebug.h
+++ b/include/linux/mmdebug.h
@@ -37,6 +37,13 @@ void dump_mm(const struct mm_struct *mm);
 			BUG();						\
 		}							\
 	} while (0)
+#define VM_WARN_ON_PAGE(cond, page)					\
+	do {								\
+		if (unlikely(cond)) {					\
+			dump_page(page, "VM_WARN_ON_PAGE(" __stringify(cond)")");\
+			WARN_ON(1);					\
+		}							\
+	} while (0)
 #define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
 	static bool __section(".data.once") __warned;			\
 	int __ret_warn_once = !!(cond);					\
@@ -60,6 +67,7 @@ void dump_mm(const struct mm_struct *mm);
 #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
 #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
+#define VM_WARN_ON_PAGE(cond, page) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
 #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
-- 
2.11.0

