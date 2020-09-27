Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0907427A210
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgI0RkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:40:00 -0400
Received: from m12-14.163.com ([220.181.12.14]:44375 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgI0RkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=xh2Xd
        nKdwEptrNopNjoHo/dM/S0Sl8Wq37Wv6eY6w4c=; b=ceTWmM1IQpUVT1QIV8cXT
        QM9U/eCwcMhYX15ywkZrfc51DomMOHRBgID3+oZW1cHOEHwsK7cyJuZngWimGyq2
        67IWxOB8sJ5PhUluUNcEHB9588JQqpkpKxhpEYAMxPGeVvdkm5VgqowDYKb1ArFq
        PaHyrS6IWhOP1M+6m83P9k=
Received: from localhost (unknown [101.86.214.224])
        by smtp10 (Coremail) with SMTP id DsCowAC3RttLznBfOkAoNQ--.12812S2;
        Mon, 28 Sep 2020 01:39:23 +0800 (CST)
Date:   Mon, 28 Sep 2020 01:39:23 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmscan: fix comments for isolate_lru_page()
Message-ID: <20200927173923.GA8058@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowAC3RttLznBfOkAoNQ--.12812S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4fJw1rWFy3uw1rCr1xKrg_yoW3GrbE9a
        ykKF4xur9YqF9Fqr4Yka1ayF1Igr9ruF48ua17J3yYvFW5Za95XF98Wrs8Gry5Zr45uF9I
        qFWDCrWrW398KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0TGQDUUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIA+sX10TBh4hOwABsR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix comments for isolate_lru_page():
s/fundamentnal/fundamental

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 466fc3144fff..def9d2b3057b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1751,7 +1751,7 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
  * Restrictions:
  *
  * (1) Must be called with an elevated refcount on the page. This is a
- *     fundamentnal difference from isolate_lru_pages (which is called
+ *     fundamental difference from isolate_lru_pages (which is called
  *     without a stable reference).
  * (2) the lru_lock must not be held.
  * (3) interrupts must be enabled.
-- 
2.25.1


