Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB851C3236
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 07:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEDFYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 01:24:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:20123 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgEDFYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:24:18 -0400
IronPort-SDR: lr3IlC+yzNjGtaDVBK6wvJhe3eL8qLqd0xFv+U7S87gZtiR9UyQNEHftmNMSf0CLWaNSqxO2Fn
 fE+fjo7OYyqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 22:24:17 -0700
IronPort-SDR: V2qGDrGup2TxuOj/Zljq8sm2gsxIj/3bGCHw36LXtdYXu2qYmZOxHNQdPO5NraRzoVGhDEWYQW
 zHSz5ChfccrQ==
X-IronPort-AV: E=Sophos;i="5.73,350,1583222400"; 
   d="scan'208";a="368992552"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 22:24:17 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 0/2] kmap cleanup 2
Date:   Sun,  3 May 2020 22:24:13 -0700
Message-Id: <20200504052415.984585-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Continue the kmap clean up with 2 follow on patches

These apply after the kmap cleanup V2 series:

https://lore.kernel.org/lkml/20200504010912.982044-1-ira.weiny@intel.com/

Ira Weiny (2):
  kmap: Remove kmap_atomic_to_page()
  parisc/kmap: Remove duplicate kmap code

 arch/csky/include/asm/highmem.h      |  1 -
 arch/csky/mm/highmem.c               | 13 -------------
 arch/nds32/include/asm/highmem.h     |  1 -
 arch/parisc/include/asm/cacheflush.h | 28 ++--------------------------
 include/linux/highmem.h              | 10 +++++++---
 5 files changed, 9 insertions(+), 44 deletions(-)

-- 
2.25.1

