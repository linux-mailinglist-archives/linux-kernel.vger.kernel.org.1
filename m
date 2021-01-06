Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16D92EBB54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbhAFIvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbhAFIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:51:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24776C06135D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:50:03 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r4so1205735pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzyixQGA22PztCHoWMVb3aoY+aYlev25PUQfD61xRIU=;
        b=c1h2czxUSUbpHsdB4iBoOCMv92fTBJlrTNNN8pZTRAkAVXAMpC7mvGeNEujZTSK7ES
         9lVAhDo1svl3YRAnZ8TQ+fL4pj6wKKHoiH4JzVA7TNDRza61TbLNEqODnH1kqlG0SRof
         QkSyY89PQ3YMT8FqXRFF87g1AKBBRor7qUoNTzqnfLYq+1vwBsIimaiyAj6h7YzDDsOl
         wTKSkO/ZE+Md2PT5bw/8f6elxhgmnZNDadXoxnX65sgMOMHhRi29DR0eqQ4KgtKClqWY
         bifB2nrVqj3dgL/Y0j/dfXnF0B4GflTvaXIRMI3hjPbHNl0BFRhfW3+Ekh8LEZ2L3hvV
         umBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzyixQGA22PztCHoWMVb3aoY+aYlev25PUQfD61xRIU=;
        b=KaKOcCoKQHF2kkTLbSBmsdxgzpMc3H9hGf8P1+uldYK2XEVPB6MmpiYwpim7cebxFB
         e6xH5a0qdrc+oKWDdDFBA2kqJ82Qn2yT3IF6hBLBFvXAXbe/Bu8Ct/qntqrlZkKqia9H
         1JZhjyRbSNUE7mLjKSfrij70sNv4gMzgUqvGtmSATGK9QutrCh5kiIwiaYMh/RlnmJf8
         WZyxiENTiujI30VrR+I0pO49eoi2VdY28lhBm6uWmBQ4uU7fRmgvj5gblgNKdI7+0QvG
         Vfk2CEQNCQALuImVsDT0m3MTOkgi2gch4x+QmOZN7Zx3B0FpVETFqqB1IKLWK4Oooan3
         Z4FQ==
X-Gm-Message-State: AOAM532ILN6OaeeUEn2IIL0OuB6A2ujRtD+bBTHBnNT9ZGzPTjvCCdsT
        rov2SSy+Hi/j9g5jasCxoo7p5RMjfcoKi+FjmFA=
X-Google-Smtp-Source: ABdhPJypfVLEzKgsmoKlg4BWX+DeSaJaZcfQVkmc7fId0VbM26E/aLydbaqPJl7gy+SNKpR4XNHETg==
X-Received: by 2002:a17:90a:f194:: with SMTP id bv20mr3315484pjb.11.1609923002773;
        Wed, 06 Jan 2021 00:50:02 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id h8sm1851806pjc.2.2021.01.06.00.49.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2021 00:50:02 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 6/6] mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
Date:   Wed,  6 Jan 2021 16:47:39 +0800
Message-Id: <20210106084739.63318-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210106084739.63318-1-songmuchun@bytedance.com>
References: <20210106084739.63318-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_huge_active() can be called from scan_movable_pages() which
do not hold a reference count to the HugeTLB page. So when we call
page_huge_active() from scan_movable_pages(), the HugeTLB page can
be freed parallel. Then we will trigger a BUG_ON which is in the
page_huge_active() when CONFIG_DEBUG_VM is enabled. Just remove the
VM_BUG_ON_PAGE.

Fixes: 7e1f049efb86 ("mm: hugetlb: cleanup using paeg_huge_active()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 67200dd25b1d..7a24ed28ec4f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1372,7 +1372,6 @@ struct hstate *size_to_hstate(unsigned long size)
  */
 bool page_huge_active(struct page *page)
 {
-	VM_BUG_ON_PAGE(!PageHuge(page), page);
 	return PageHead(page) && PagePrivate(&page[1]);
 }
 
-- 
2.11.0

