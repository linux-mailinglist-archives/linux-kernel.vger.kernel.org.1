Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2882F0F08
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhAKJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:26:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36709 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbhAKJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:26:39 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kytSV-0005BM-To; Mon, 11 Jan 2021 09:25:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dm integrity: fix spelling mistake "flusing" -> "flushing"
Date:   Mon, 11 Jan 2021 09:25:55 +0000
Message-Id: <20210111092555.6770-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dm_integrity_io_error error
message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/dm-integrity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 11c7c538f7a9..44478744f191 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1390,7 +1390,7 @@ static void flush_notify(unsigned long error, void *fr_)
 {
 	struct flush_request *fr = fr_;
 	if (unlikely(error != 0))
-		dm_integrity_io_error(fr->ic, "flusing disk cache", -EIO);
+		dm_integrity_io_error(fr->ic, "flushing disk cache", -EIO);
 	complete(&fr->comp);
 }
 
-- 
2.29.2

