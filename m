Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D53E2A5FB4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgKDIgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbgKDIgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:42 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AAD020781;
        Wed,  4 Nov 2020 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604479002;
        bh=9r2bTbSzkjI/1caHR/FRV4CdE+MkCdrY9CHmiMPWasQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2wFHuj4Qpb/1EpjQtjBZUBCYoe0IH6E8BotEQVgHPE73AieIBOcuWytDzkju+IYd
         d0lGnkHrU0WH783af0hMIGyQuwgT86AyUL1vfAqgD3EmS41xRWuZeC+ArJmfyBWz0L
         qMZRHF6Qlhs7VGOXdL41SBswr5NLfceCRuzyCnKM=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs/gaudi: remove unreachable code
Date:   Wed,  4 Nov 2020 10:36:27 +0200
Message-Id: <20201104083630.28402-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104083630.28402-1-ogabbay@kernel.org>
References: <20201104083630.28402-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Remove unreachable code in gaudi collective flow.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f73e508cf14c..8b02d6341b4c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1224,10 +1224,8 @@ static int gaudi_collective_wait_create_jobs(struct hl_device *hdev,
 
 	if (collective_engine_id == GAUDI_ENGINE_ID_DMA_5)
 		collective_queue = GAUDI_QUEUE_ID_DMA_5_0 + stream;
-	else if (collective_engine_id == GAUDI_ENGINE_ID_TPC_7)
-		collective_queue = GAUDI_QUEUE_ID_TPC_7_0 + stream;
 	else
-		return -EINVAL;
+		collective_queue = GAUDI_QUEUE_ID_TPC_7_0 + stream;
 
 	num_jobs = NUMBER_OF_SOBS_IN_GRP + 1;
 	nic_queue = GAUDI_QUEUE_ID_NIC_0_0 + stream;
-- 
2.17.1

