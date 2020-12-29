Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147852E74DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgL2ViZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:38:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:43716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgL2ViW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:38:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA13022262;
        Tue, 29 Dec 2020 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609277826;
        bh=Ioxp7wqUO0XKXvrhMQ5/GzYm3MrrkCV0Kkao8lpa2/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfOVCFcbUHAZ/mR5ZYaeOIMUc/Q6fCLx3uMA1RuEZ9ppNEZsoZBqQDKEpJibJgUTx
         kTFdPPNMzenO30hj/jlEGH0BmT3zfgCghFh1q0U00gvqcpKPfa50cV6CskRzcbXLTS
         kK9nfwrjQ+12FeAQfiWJuybZBuyxUcZ28IoNKDMh9OEN8p0IRZZjZCO4rHkygoIujk
         LHCaDEKjUhFHAf4TzkdG/k6KymUb0bndGjTCNhq5nn8FDL3/zpnvQwnFtZGZ7xit00
         IQE8ddtByYJUGT2pLEUKJEpxO1Cbx588AA5Z9Gk7TVIxXEKM8dXs8twA/CQxHWh+uO
         r26w1xlTpoLiQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 8/8] habanalabs/gaudi: set uninitialized symbol
Date:   Tue, 29 Dec 2020 23:36:53 +0200
Message-Id: <20201229213653.29749-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229213653.29749-1-ogabbay@kernel.org>
References: <20201229213653.29749-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Initialize local variable that is returned by the function, in
case it is never assigned.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 712d40bea107..af49a855d7d6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1248,7 +1248,7 @@ static int gaudi_collective_wait_create_jobs(struct hl_device *hdev,
 	u32 queue_id, collective_queue, num_jobs;
 	u32 stream, nic_queue, nic_idx = 0;
 	bool skip;
-	int i, rc;
+	int i, rc = 0;
 
 	/* Verify wait queue id is configured as master */
 	hw_queue_prop = &hdev->asic_prop.hw_queues_props[wait_queue_id];
-- 
2.25.1

