Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D2299045
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782758AbgJZO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:56:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37050 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781810AbgJZO4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:56:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id 126so5904616pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y9ZdVN328O2uwwSHT+BoNnojVOi64nld5Tda2i3ROBA=;
        b=woQEvtdrgcTt5KtaGjhWCUPSi5xXh9iNMRclvDRN/w23XTX07a197EfeoZ6etseu0z
         HXL0T0o7N85P/lN88MJhzuImQQEUAV19uolyMnF24miX1HhhOwQN4x1OSwzwcABZippj
         sx5kYtTF7ynotAqfdIaeuIul+5NLTLcNH+hJZ5Zl0QrxrDp9QpufqvYhP/XCDhvx+qKW
         ldXpXuvCHSoxZ3uCWj2AU9BS2PV3x4vWCWEVTSbazHORQVQBMXia8+x+c6Ixdb4bsFrp
         4qa3zzyXPfaUUWH9vKMn/vx/Isj4VcNou4jTwTkZy6REvM7nlsw0BxOwKxHDX80gUb6M
         AqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9ZdVN328O2uwwSHT+BoNnojVOi64nld5Tda2i3ROBA=;
        b=cbBezHRW4570tzHRJfaD/c/6Q0Gfc3f+k9M2tRd/L6UlGjkfTlk6N6SwVQCj6Jtl/O
         j1d5CDHN54t6O0uPVj3lrVu9S0GAr6FJoMlbd3UZzy2m4K5uWNIrANVAfx05e0lAX9Y6
         i1y4hhGrA+nJpLN2lBe7CGihHTN1cUzrdqZ5zhKyVFRrfGwyaaRdy/qUOHlcJEGtMAZ0
         AIMJLIPUmsQsBi6+TkF+FVkgCuyOVso/FWzgashBHH0X97o2vaR6AESh6oLdcYDusW72
         VrnQfRDaGB0jQ0UABPyRZKZE790J/EbbGMIIrKEYpyj73FZDi+cV/P4PNORGLBY96zQ7
         gRpg==
X-Gm-Message-State: AOAM5336mTOZ2v01YBnAJVdnCx1+YCA3bbwYgrnCRmU0eugRXD2RNb97
        BuvJdnWZ4eYVfdPZW/AajMjHkw==
X-Google-Smtp-Source: ABdhPJybtxEw8eg2MrMPnbUEKzS1LAsNT2c0RtK4JcGJiJczRjV0Xm8NBFRBQb7sIRhVCjvqm2TQ+w==
X-Received: by 2002:a65:67d0:: with SMTP id b16mr17133830pgs.335.1603724172489;
        Mon, 26 Oct 2020 07:56:12 -0700 (PDT)
Received: from localhost.localdomain ([103.136.220.89])
        by smtp.gmail.com with ESMTPSA id x123sm12042726pfb.212.2020.10.26.07.56.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:56:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 19/19] mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct page
Date:   Mon, 26 Oct 2020 22:51:14 +0800
Message-Id: <20201026145114.59424-20-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201026145114.59424-1-songmuchun@bytedance.com>
References: <20201026145114.59424-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only `RESERVE_VMEMMAP_SIZE / sizeof(struct page)` struct pages
can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, so add a BUILD_BUG_ON
to catch this invalid usage of tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 029b00ed52ed..b196373a2a39 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3955,6 +3955,8 @@ static int __init hugetlb_init(void)
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 	BUILD_BUG_ON_NOT_POWER_OF_2(sizeof(struct page));
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 #endif
 
 	if (!hugepages_supported()) {
-- 
2.20.1

