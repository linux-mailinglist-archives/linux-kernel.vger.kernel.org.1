Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BDD2EA3D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbhAEDSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:18:00 -0500
Received: from owa.iluvatar.ai ([103.91.158.24]:6093 "EHLO smg.iluvatar.ai"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbhAEDSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:18:00 -0500
X-AuditID: 0a650161-e51ff70000001043-b0-5ff3da38862c
Received: from owa.iluvatar.ai (s-10-101-1-102.iluvatar.local [10.101.1.102])
        by smg.iluvatar.ai (Symantec Messaging Gateway) with SMTP id A4.FB.04163.83AD3FF5; Tue,  5 Jan 2021 11:17:12 +0800 (HKT)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=iluvatar.ai; s=key_2018;
        c=relaxed/relaxed; t=1609816632; h=from:subject:to:date:message-id;
        bh=bh/KlAKtf2is8XgpiGQlUbIlz9Cl49eRRpOLayL9zlI=;
        b=jqNgsXGg612hjuVZr2jcZZfLYgJlk0Q3kQURO63DaAoo5B53K5ZO0mXfQNh+Li7KpodGwuplyTB
        xp4mBZ3nTq9hfeUINe1GW1IfWRnc0G6bMfjuDGxysgrSJpIx+DZfB7sGTmzpbqldGugE00ZVI526L
        AVTcDEHqtdITdqxVrD4=
Received: from hsj-Precision-5520.iluvatar.local (10.101.199.252) by
 S-10-101-1-102.iluvatar.local (10.101.1.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1415.2; Tue, 5 Jan 2021 11:17:12 +0800
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <shijie8@gmail.com>,
        Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH] lib/genalloc: change return type to unsigned long for bitmap_set_ll
Date:   Tue, 5 Jan 2021 11:16:44 +0800
Message-ID: <20210105031644.2771-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.101.199.252]
X-ClientProxiedBy: S-10-101-1-105.iluvatar.local (10.101.1.105) To
 S-10-101-1-102.iluvatar.local (10.101.1.102)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as bitmap_clear_ll(), change return type to unsigned long
for bitmap_set_ll to avoid the possible overflow in future.

Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
---
 This patch is not a bug fix.
 I missed to change it in previous patch.

---
 lib/genalloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index dab97bb69df6..5dcf9cdcbc46 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -81,7 +81,8 @@ static int clear_bits_ll(unsigned long *addr, unsigned long mask_to_clear)
  * users set the same bit, one user will return remain bits, otherwise
  * return 0.
  */
-static int bitmap_set_ll(unsigned long *map, unsigned long start, unsigned long nr)
+static unsigned long
+bitmap_set_ll(unsigned long *map, unsigned long start, unsigned long nr)
 {
 	unsigned long *p = map + BIT_WORD(start);
 	const unsigned long size = start + nr;
-- 
2.17.1

