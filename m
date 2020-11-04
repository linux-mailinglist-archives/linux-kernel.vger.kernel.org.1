Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524A92A6604
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgKDOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:10:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:37586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKDOJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:09:22 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B8C22280;
        Wed,  4 Nov 2020 14:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604498960;
        bh=+zBhNR2Wm8IM2KCWPh9z8PAhDKFAiYNN/WyDPKfg+R8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vojoSlYNc1IS3OXxhP8r23UdL2wrvBlfw4hVC0+miDg4Xdhqr7eaAEa9KZ0bfjPgv
         Pg7DGGBcGmAeS4Zkd4S1dDShLMIJ/FcDIQxcpLbIqU625mjEq+IezbXaqLkZw/MKJO
         zTy5MMV/6uB1UqhqOYTaggD9btOj+0Pi0PcAGY0U=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: increase MAX CS to 16K
Date:   Wed,  4 Nov 2020 16:08:59 +0200
Message-Id: <20201104140908.10178-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104140908.10178-1-ogabbay@kernel.org>
References: <20201104140908.10178-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to have the MAX CS be much larger than the size of the
different queues. In GAUDI we have around 8 groups of queues, and each
group has 1K queue size. To prevent head-of-the-line blocking, we need
to make sure there is sufficient number of available CS allocations
even if one or more of those queues are full.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudiP.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 1dcf7c41e698..c3c24e8da4e2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -60,7 +60,7 @@
 
 #define GAUDI_DEFAULT_CARD_NAME		"HL2000"
 
-#define GAUDI_MAX_PENDING_CS		1024
+#define GAUDI_MAX_PENDING_CS		SZ_16K
 
 #if !IS_MAX_PENDING_CS_VALID(GAUDI_MAX_PENDING_CS)
 #error "GAUDI_MAX_PENDING_CS must be power of 2 and greater than 1"
-- 
2.17.1

