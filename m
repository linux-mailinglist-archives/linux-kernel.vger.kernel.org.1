Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27912039E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgFVOtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 10:49:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgFVOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:49:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jnNkg-00080Q-Se; Mon, 22 Jun 2020 14:48:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mm: cma: remove redundant null check of the array cma->name
Date:   Mon, 22 Jun 2020 15:48:50 +0100
Message-Id: <20200622144850.45952-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An earlier commit changed name from a pointer to an array so the
cma->name null check is now redundant and can be removed.

Addresses-Coverity: ("Array compared against 0")
Fixes: e7f0557d7de9 ("mm: cma: fix the name of CMA areas")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 mm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 31a61d410c59..6cf08817bac6 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -52,7 +52,7 @@ unsigned long cma_get_size(const struct cma *cma)
 
 const char *cma_get_name(const struct cma *cma)
 {
-	return cma->name ? cma->name : "(undefined)";
+	return cma->name;
 }
 
 static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
-- 
2.27.0

