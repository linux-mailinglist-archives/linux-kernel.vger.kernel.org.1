Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 664BB2935FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbgJTHn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:43:29 -0400
Received: from smtp2.axis.com ([195.60.68.18]:37444 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgJTHn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:43:29 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2020 03:43:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1193; q=dns/txt; s=axis-central1;
  t=1603179809; x=1634715809;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D4vkQ2GJkx4mZuE7nm2B26D07QpN2qJtMInPupz2+oY=;
  b=H0SR2qBn1vfh6Pjj7e7l62rSfGC/EvqknjGZksoxOwIlQ6tMrrFV2oSr
   qSBUeTNsBOqu1mxIX8d0u+xI75Yi2rXHQlJ7jPt1WWhY01g+QMfl+YrgX
   orCLtuNkfvHMCQ0Wykb/oYITOoqrvmVTU3tkrF2KlS+lo4fRTT9Y/AZAi
   VVJlzmY05wxIStkI9WRR7pTXHvgGf3f3lWNsWzJcZSC+X7IORh+yPsZwo
   rzPWiOhMGn3/K6/OPdJU+2BGMGaldD5l8VEgWZOzK6nXCjJJxY5IG8mkf
   kWQs+3/ql3luEOOj+jb7d8Gop2XL06Xwh6rC3aUOakI5smcLePgUaqoEA
   Q==;
IronPort-SDR: Lh6NH79QCoUKUcdCH31XtFEYddz0YmPBa9xPR1adP+/FgrHLqanAVZSGbDjZA4DRW/qLkPwj+9
 5ML2FsDCl9R882Zir4hXxQNwnyO4lBRoZ25dUNxRvuVIUirB+pZkRXAaECACPyacKg+apS/+kX
 rt0V/4XQnMTMjO2dsQxp6LfeWHOR2j+E3J8sjOUfufLEpnU095bdSHkig88/cC6g8r8ckk0eLS
 qlWRbTN3QzQ2bdk1+efD9+S49FPcj9v4b2g7fnCVDSnWtFRzaYkJ9EqHGHcqAmPBbouEv2eLo2
 tM8=
X-IronPort-AV: E=Sophos;i="5.77,396,1596492000"; 
   d="scan'208";a="13696999"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <kernel@axis.com>, <mitchelh@codeaurora.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] of: Fix reserved-memory overlap detection
Date:   Tue, 20 Oct 2020 09:35:58 +0200
Message-ID: <20201020073558.3582-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved-memory overlap detection code fails to detect overlaps if
either of the regions starts at address 0x0.  For some reason the code
explicitly checks for and ignores such regions, but this check looks
invalid.  Remove the check and fix this detection.

For example, no overlap is currently reported for this case:

	foo@0 {
		reg = <0x0000 0x2000>;
	};

	bar@1000 {
		reg = <0x1000 0x1000>;
	};

but it is after this patch:

 OF: reserved mem: OVERLAP DETECTED!
 foo@0 (0x00000000--0x00002000) overlaps with bar@1000 (0x00001000--0x00002000)

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/of/of_reserved_mem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 46b9371c8a33..1c5259e3e81f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -217,8 +217,7 @@ static void __init __rmem_check_for_overlap(void)
 
 		this = &reserved_mem[i];
 		next = &reserved_mem[i + 1];
-		if (!(this->base && next->base))
-			continue;
+
 		if (this->base + this->size > next->base) {
 			phys_addr_t this_end, next_end;
 
-- 
2.28.0

