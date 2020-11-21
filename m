Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAB2BBEFA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgKUMkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbgKUMkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:40:24 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53CB22226;
        Sat, 21 Nov 2020 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605962423;
        bh=A/Edt0dI4t8URTlWlSPln3lBdTPWQplBTfPuD9Wv4XA=;
        h=From:To:Cc:Subject:Date:From;
        b=Cah8aj3LUXabqP6PzvJJs/In2WihXa6xkFEon1dufWk6LQsuksY899mTvq8AAXe4+
         oeASOv0Tt2b+Kz9Yo/F3lY4w+BLEBE6QP9tjht3E81saPJTv6zua1HHiyr9hm8JjsE
         4MEAwbsftAGMhy5Wbg2FNPbF3wX+MhH7pnDUo1NI=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH] habanalabs/gaudi: fix missing code in ECC handling
Date:   Sat, 21 Nov 2020 14:40:19 +0200
Message-Id: <20201121124019.21116-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is missing statement and missing "break;" in the ECC handling
code in gaudi.c
This will cause a wrong behavior upon certain ECC interrupts.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2519a34e25b7..7ea6b4368a91 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5436,6 +5436,8 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
 		params.num_memories = 33;
 		params.derr = true;
 		params.disable_clock_gating = true;
+		extract_info_from_fw = false;
+		break;
 	default:
 		return;
 	}
-- 
2.17.1

