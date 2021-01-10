Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53122F073C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAJMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 07:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 07:42:05 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2BC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:24 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g15so10779207pgu.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 04:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGxCcrxh54+vPfh3fs1S1PZ/SzgrrSbJ2Q0Nc+3EuUs=;
        b=IwVBgHapflIcDSeNj0zPo8Tm7lwZLA+1MxcCqdhLHnwIPqvTQPW89aBzjSn39DUsW3
         JiugI3PTNVmVygbTSordkL5/6NsQN0iIWqvpbUSsJ18pwLBeP83GTqwF5cUq6bgImBC4
         N7yTJAGXF7l1DYxRyj6AEyVylPa/aE7pY40J9pp/WzyaVDHiQKChvzmv226Vm9OIzJVD
         zm1E/2hOKFb2LCJL3OiYms6NiO0RQ/luhF4iy9Pzs8AWcJb8td90eVnavX7bo4YoHyrH
         vfQnHpK8EMcPsX24pNwAbLgxM3w5Fh7IDfDw1s4DTMHgurGZmgT0xZWo/P6+EA1j83rh
         HlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGxCcrxh54+vPfh3fs1S1PZ/SzgrrSbJ2Q0Nc+3EuUs=;
        b=nJiT4esi0ATXAKjbdPx4Iv33WuZ2j9pXXUn5WPfybNzk65shzxOdgOBtUcqxadRQ6p
         Kus0JNrCciyriexzCkEYHOehOwW/dWpZQDwMe/47iajTcf4ali+EXre9XUmFYlaPtOnY
         Jc1CTlKtOazvRR4xpvJ2X3aaEzei7JyKC5Y0t9mkdxIGrBqqFYpLobA0MqcsrNaZ3qW9
         XYRS1/E5+v2FfHL90giAzBoqTbaXbTQiPX+flAgE6Lk+jhsSWd5nhPYNQz87adKVdxoY
         numWVjuFYjHeckVylmQhlJXsoFnR5gFk+FCg3isjpNuO77busI/eL0VkYJjHpQh4t9T6
         f6qw==
X-Gm-Message-State: AOAM530bCsJycnL5b826iQAhGLbvuay1Mc2T70c/NR7Amp3JEtTaFiFc
        4p9jGvfdJIuzoNai9N/4z33fOw==
X-Google-Smtp-Source: ABdhPJzJjWQkqBYxHgJ/to1raXIAPjeBoRyD7EwUD82uVDv3de0Gfek6s7XWrA0pqe6vgvcmfVHuCQ==
X-Received: by 2002:a62:384b:0:b029:19d:a5c6:d76 with SMTP id f72-20020a62384b0000b029019da5c60d76mr12391113pfa.16.1610282484286;
        Sun, 10 Jan 2021 04:41:24 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id p9sm16176960pfq.136.2021.01.10.04.41.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jan 2021 04:41:23 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/6] Fix some bugs about HugeTLB code
Date:   Sun, 10 Jan 2021 20:40:11 +0800
Message-Id: <20210110124017.86750-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to fix some bugs and add some improvements.

Changelog since v2 -> v3:
  - Update commit log.
  - Using head[3].private to indicate the page is freed in patch #3.

Changelog since v1 -> v2:
  - Export set_page_huge_active() in patch #2 to fix.
  - Using head[3].mapping to indicate the page is freed in patch #3.
  - Flush @free_hpage_work in patch #4.

Muchun Song (6):
  mm: migrate: do not migrate HugeTLB page whose refcount is one
  mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
  mm: hugetlb: fix a race between freeing and dissolving the page
  mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
  mm: hugetlb: fix a race between isolating and freeing page
  mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active

 fs/hugetlbfs/inode.c    |  3 ++-
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 59 +++++++++++++++++++++++++++++++++++++++++--------
 mm/migrate.c            |  6 +++++
 4 files changed, 60 insertions(+), 10 deletions(-)

-- 
2.11.0

