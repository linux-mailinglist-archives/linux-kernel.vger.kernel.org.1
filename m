Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7D304FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhA0D0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:26:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390725AbhAZVDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:03:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3A2F22B3F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 21:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611694941;
        bh=rHRNutmlEmgrZ8aqrylIF+L7pevf8h4K6iR+3Y37aWM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TjONyEMCdSv1Fi64JAIkpDIX4xtwhoEFcPQlC4oPzTQR7XGTIgzH42oNXt6I4k4Wb
         eedQ1VJxgAQYVODc5ENCozk/2ybNTEG20rpVovqWru/sqWpOqBdia6GjrsxdA/7lhQ
         0wgg4SW2x7mEbUhx29r+DSM0mI3RZJoO/PgVN81y02Yh5Gss4n5PDtzodz+eTpP4zw
         o7rr8jmHAFcwcNgaart3JgAHYbB5hsWwj10s9YYDjOpS397wD7R6NBod0EZky0tSQC
         sat5fG1cZvleTTRCml/qQxsZOkjFVf9Ink6G1bhxwKf/fXDt+q7aF715gJCL5oCv42
         YZtHvK75X1RYA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] habanalabs/gaudi: unmask HBM interrupts after handling
Date:   Tue, 26 Jan 2021 23:02:14 +0200
Message-Id: <20210126210215.4892-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126210215.4892-1-ogabbay@kernel.org>
References: <20210126210215.4892-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the driver does with all interrupts, we need to tell F/W to unmask
the HBM interrupts after the driver handled them.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a9bd5aef6c02..52fcaf25531a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7377,6 +7377,7 @@ static void gaudi_handle_eqe(struct hl_device *hdev,
 		gaudi_hbm_read_interrupts(hdev,
 				gaudi_hbm_event_to_dev(event_type),
 				&eq_entry->hbm_ecc_data);
+		hl_fw_unmask_irq(hdev, event_type);
 		break;
 
 	case GAUDI_EVENT_TPC0_DEC:
-- 
2.25.1

