Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C71DFC4F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 03:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388294AbgEXBud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 21:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387589AbgEXBuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 21:50:32 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B34C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 18:50:32 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l6so12831823oic.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 18:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=GTGkis+uD2ofy0cZ775LPyRGKOg7EagKw1kot4jTVqU=;
        b=YXCe6XV0Tu1cYSY+GV19pQoXKE1HdBmMQCMd/UTuxnG6GT7aD5TFD8TPv9jUndpR99
         +c+k73mOQOYzHJtewAQj2N07pQB7MX+FMAFCd9HtxFCSAjWStW5+zRqBDSZLnOZdNfFb
         PdOqMpV57kzRZixu6yTIK1RaJIb5NYxb1BKkM2HLIAk7KuLB/AM96znCr+O/ihS2YiS3
         mf5dN7m5I01Ixu92CEls4QCSlE7r5WGpSSyz4avJIHkFvjoX/tAdu0A8mLR7bfLMPJfn
         JfJgc90iBH3nSoZV/Xv/OVabK1ODNh21wE1vRllEsnPXIr5iKKmqJwFh6sU2XhFNLMmu
         aBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=GTGkis+uD2ofy0cZ775LPyRGKOg7EagKw1kot4jTVqU=;
        b=tUeu+bBzCdMQY6XNzakEyFPIrLUA9VIyb1Og07Z6d59DLq6taxMwFESmAHNzUDzyMu
         nFnKRvD3yxVNdBcGTiE8U/VXllLIAyZbpWj3SRtWeA7+4VA00tGVjN4r04JB7ZIl0ZLo
         65yoWp+r9M0T8CtLEKO0t7bZwZ4BaJDl+wswEa7q0+LCKeA4u9UIB/LzU+bbPYuLyG8E
         BCKuCbMDTHvohd3I7XuqiWhNgLmX5WVymyMgEaxKbV4sOFs0i547ij3ayRXXqGssbuQm
         BNv2OXUP+iozQinqaltewhLIgKYNE2ws7bzEz65XWCPUvVnkV1DLSaBx6zvQy25ovQKE
         XDKQ==
X-Gm-Message-State: AOAM532nNMVlP/rZ+Wc7vvfq4Lw9bmcOx7wsxyYjyQk204JoOaaX9TR0
        mhJWmWdi0Qbt8a/VT6Y0ebNveQ==
X-Google-Smtp-Source: ABdhPJxaHuIb6ZWnBsergKfmo1QTtSLghg3lk2e4mQ4KOB2hMGfsuCM6lg7KfN51p0oEGAZEhcZdWw==
X-Received: by 2002:aca:4852:: with SMTP id v79mr7088402oia.20.1590285031681;
        Sat, 23 May 2020 18:50:31 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h9sm3856461oor.21.2020.05.23.18.50.29
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 23 May 2020 18:50:30 -0700 (PDT)
Date:   Sat, 23 May 2020 18:50:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm,thp: stop leaking unreleased file pages
Message-ID: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When collapse_file() calls try_to_release_page(), it has already
isolated the page: so if releasing buffers happens to fail (as it
sometimes does), remember to putback_lru_page(): otherwise that page is
left unreclaimable and unfreeable, and the file extent uncollapsible.

Signed-off-by: Hugh Dickins <hughd@google.com>
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Cc: stable@vger.kernel.org # v5.4+
---

 mm/khugepaged.c |    1 +
 1 file changed, 1 insertion(+)

--- 5.7-rc6/mm/khugepaged.c	2020-04-12 16:24:37.710999073 -0700
+++ linux/mm/khugepaged.c	2020-05-10 17:06:21.788398646 -0700
@@ -1692,6 +1692,7 @@ static void collapse_file(struct mm_stru
 		if (page_has_private(page) &&
 		    !try_to_release_page(page, GFP_KERNEL)) {
 			result = SCAN_PAGE_HAS_PRIVATE;
+			putback_lru_page(page);
 			goto out_unlock;
 		}
 
