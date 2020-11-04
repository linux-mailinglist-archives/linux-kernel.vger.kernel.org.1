Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30AF2A5FB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgKDIg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgKDIgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:36:44 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA4F1207BB;
        Wed,  4 Nov 2020 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604479003;
        bh=hLfwGDNHfuENg2N9ZxbZWduhHqDqxbVQYn6uBLhVFf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0SGpWNCkmk8AoaOZrnIZE651rjT9nK5Um/vCICQbzdyIs2cbZOptBQvE0qJPPJ3B
         SzMM2MokctIDsyCDrEgMy4ypqEOaCnpRLXJUtBEEnSC5eVAH2sYo25559OBMM7AbUh
         LVKOfQ/BI+iKkplemG29keBL780uUxH/240G8PMc=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: initialize variable before use
Date:   Wed,  4 Nov 2020 10:36:28 +0200
Message-Id: <20201104083630.28402-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104083630.28402-1-ogabbay@kernel.org>
References: <20201104083630.28402-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 7.3.1 20180303 (Red Hat 7.3.1-5) complains that collective_engine_id
might be used uninitialized.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 46c36b385c95..746005f7f991 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -942,7 +942,7 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 	struct hl_cs_compl *sig_waitcs_cmpl;
 	struct hl_cs *cs;
 	enum hl_queue_type q_type;
-	u32 size_to_copy, q_idx, collective_engine_id;
+	u32 size_to_copy, q_idx, collective_engine_id = 0;
 	u64 signal_seq;
 	int rc;
 
-- 
2.17.1

