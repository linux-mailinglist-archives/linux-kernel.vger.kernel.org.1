Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BEE1CFC56
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 19:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgELRiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 13:38:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 13:38:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jYYqv-0003bJ-JX; Tue, 12 May 2020 17:38:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] pstore/zone: remove redundant initializations to variable ret
Date:   Tue, 12 May 2020 18:38:01 +0100
Message-Id: <20200512173801.222666-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is never read and it
is being updated later with a new value.  The initialization is redundant
and can be removed.  In one of the cases, ret can also be moved inside a
for-loop to reduce the scope.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/pstore/zone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 3cf7d6762c76..419de481c69c 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -600,7 +600,7 @@ static int psz_recover_zones(struct psz_context *cxt,
  */
 static inline int psz_recovery(struct psz_context *cxt)
 {
-	int ret = -EBUSY;
+	int ret;
 
 	if (atomic_read(&cxt->recovered))
 		return 0;
@@ -746,13 +746,13 @@ static void psz_write_kmsg_hdr(struct pstore_zone *zone,
 static inline int notrace psz_kmsg_write_record(struct psz_context *cxt,
 		struct pstore_record *record)
 {
-	int ret = -EBUSY;
 	size_t size, hlen;
 	struct pstore_zone *zone;
 	unsigned int i;
 
 	for (i = 0; i < cxt->kmsg_max_cnt; i++) {
 		unsigned int zonenum, len;
+		int ret;
 
 		zonenum = (cxt->kmsg_write_cnt + i) % cxt->kmsg_max_cnt;
 		zone = cxt->kpszs[zonenum];
-- 
2.25.1

