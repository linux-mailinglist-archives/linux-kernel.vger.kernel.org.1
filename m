Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE22B7EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgKRNvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgKRNvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:51:00 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB5B2078D;
        Wed, 18 Nov 2020 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605707460;
        bh=getiHBrDdIRlm0UsQaElrXSKyYuSfDOeLthlpxwUvBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GqqQZjpKVdqj6Tr8zuWC+Z39XOHhjY7bYzSaEMT4ZTk0GQVe2u3t5kVAl8cN8ecyb
         1olP7EOfvZ7iG+FoszXBEuL1FFSW5dY6cR0twEW2mkNVSzz9JPlNQmu0KLAJgq3wOw
         SWr71J6+86pgmYS0gOTcZDzNM6MKPE0QsbdaUBo0=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: print CS type when it is stuck
Date:   Wed, 18 Nov 2020 15:50:50 +0200
Message-Id: <20201118135050.19621-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201118135050.19621-1-ogabbay@kernel.org>
References: <20201118135050.19621-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have several types of command submissions and the user wants to know
which type of command submission has not finished in time when that
event occurs. This is very helpful for debug.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 28 +++++++++++++++++--
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 516cbaacc03e..6ca77abf7f8a 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -418,9 +418,31 @@ static void cs_timedout(struct work_struct *work)
 
 	hdev = cs->ctx->hdev;
 
-	dev_err(hdev->dev,
-		"Command submission %llu has not finished in time!\n",
-		cs->sequence);
+	switch (cs->type) {
+	case CS_TYPE_SIGNAL:
+		dev_err(hdev->dev,
+			"Signal command submission %llu has not finished in time!\n",
+			cs->sequence);
+		break;
+
+	case CS_TYPE_WAIT:
+		dev_err(hdev->dev,
+			"Wait command submission %llu has not finished in time!\n",
+			cs->sequence);
+		break;
+
+	case CS_TYPE_COLLECTIVE_WAIT:
+		dev_err(hdev->dev,
+			"Collective Wait command submission %llu has not finished in time!\n",
+			cs->sequence);
+		break;
+
+	default:
+		dev_err(hdev->dev,
+			"Command submission %llu has not finished in time!\n",
+			cs->sequence);
+		break;
+	}
 
 	cs_put(cs);
 
-- 
2.17.1

