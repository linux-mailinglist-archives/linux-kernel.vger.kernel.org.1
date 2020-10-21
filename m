Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D79294AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 11:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441553AbgJUJyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 05:54:04 -0400
Received: from smtp1.axis.com ([195.60.68.17]:6649 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438305AbgJUJyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=2143; q=dns/txt; s=axis-central1;
  t=1603274042; x=1634810042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NSbevEXTgIx+UMlnZ8PIyoKqiQwTyuCv3R4hhUP++P8=;
  b=nkmC+WSkozn0rOGbtBB7x9k68w5ID1RwAhdyAOT6yYxUVN+munfLHHY2
   uR7o0EuL2FQfUi7+8LUyfIRI/slc/xlVg5NdzLi/WAQ5z83tpOhNvJDa6
   oF9aOEad4CZ2LgpV8WuUz2MaTvLpJ3cG0Tw2z7FRYrLKBkge4XzS8SC2O
   fdRzrSwtTDwyq5BnoEmhtrzsboNVDAuXV1Qsdd4LH89tj9LFxI/U+vUJQ
   YoIY7vap9iFHNT5W+Lz/Z13Hm1CWqTJuiuVaPgSZS77T3IEYC1kUGUGRP
   3de64mcDnue6+pWQrWMgMy58i89L2kdWI9T+nw6hehdkCU+shF94ooFDu
   Q==;
IronPort-SDR: W6IQyZIfg03bY8KZ5uBQP74nsU09xCAsI7+Kos4fsRcuqFadbXwA4vmCmPJ7jO7ncHJWli9GnZ
 FuLAgZvU7/TLbninsMBHA0l5Ge2kLJBljNJ1dnJu5MVobuV5vRTFdi5i3IWsqv7m4TMcu2gW5R
 DjylUgA8Xhni5tz7wKQqOMOPurZOtXdP3IIusIwhcnD6X8vnK+OdnJXE3/63Ukp4XKl9zJPdrU
 pgaQnKlDj8FYGQrpoDwuwJDgY5CvHm4eYkwkKCnbIjC06xq61YTCzv3s98iQEpOE199Xr1SmOa
 mKI=
X-IronPort-AV: E=Sophos;i="5.77,401,1596492000"; 
   d="scan'208";a="14246820"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] of: Fix reserved-memory overlap detection
Date:   Wed, 21 Oct 2020 11:53:59 +0200
Message-ID: <ded6fd6b47b58741aabdcc6967f73eca6a3f311e.1603273666.git-series.vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved-memory overlap detection code fails to detect overlaps if
either of the regions starts at address 0x0.  The code explicitly checks
for and ignores such regions, apparently in order to ignore dynamically
allocated regions which have an address of 0x0 at this point.  These
dynamically allocated regions also have a size of 0x0 at this point, so
fix this by removing the check and sorting the dynamically allocated
regions ahead of any static regions at address 0x0.

For example, there are two overlaps in this case but they are not
currently reported:

	foo@0 {
	        reg = <0x0 0x2000>;
	};

	bar@0 {
	        reg = <0x0 0x1000>;
	};

	baz@1000 {
	        reg = <0x1000 0x1000>;
	};

	quux {
	        size = <0x1000>;
	};

but they are after this patch:

 OF: reserved mem: OVERLAP DETECTED!
 bar@0 (0x00000000--0x00001000) overlaps with foo@0 (0x00000000--0x00002000)
 OF: reserved mem: OVERLAP DETECTED!
 foo@0 (0x00000000--0x00002000) overlaps with baz@1000 (0x00001000--0x00002000)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v2: Fix handling of dynamically allocated regions.

 drivers/of/of_reserved_mem.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46b9371..6530b8b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -200,6 +200,16 @@ static int __init __rmem_cmp(const void *a, const void *b)
 	if (ra->base > rb->base)
 		return 1;
 
+	/*
+	 * Put the dynamic allocations (address == 0, size == 0) before static
+	 * allocations at address 0x0 so that overlap detection works
+	 * correctly.
+	 */
+	if (ra->size < rb->size)
+		return -1;
+	if (ra->size > rb->size)
+		return 1;
+
 	return 0;
 }
 
@@ -217,8 +227,7 @@ static void __init __rmem_check_for_overlap(void)
 
 		this = &reserved_mem[i];
 		next = &reserved_mem[i + 1];
-		if (!(this->base && next->base))
-			continue;
+
 		if (this->base + this->size > next->base) {
 			phys_addr_t this_end, next_end;
 

base-commit: 270315b8235e3d10c2e360cff56c2f9e0915a252
-- 
git-series 0.9.1
