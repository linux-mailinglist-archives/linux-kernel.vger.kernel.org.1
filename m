Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233B922002D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 23:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGNVjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 17:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgGNVjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:39:45 -0400
Received: from embeddedor (unknown [201.162.240.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152C42064C;
        Tue, 14 Jul 2020 21:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594762785;
        bh=IcwyAgDmrYiZARCGLD0f3MGzv0IuApQzk4+xUcZdmu0=;
        h=Date:From:To:Cc:Subject:From;
        b=lB4VlDnlygA2pEVWgQoeFBVs0Gq0vzvLeL7QBNhohPHcraW3FQgK7esV7tOgziQKn
         5ekZKIUFUVyMYnWn7klTRrDzQuGH8B8Lwa7T2dXERXRgyepqbLLpsPGIfnGSIZ5acv
         YODa6H7SsGMysRWWHHfp6+/yx5o5+W0VIaQGPqUQ=
Date:   Tue, 14 Jul 2020 16:45:16 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2] mei: Avoid the use of one-element arrays
Message-ID: <20200714214516.GA1040@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element
arrays with a simple value type u8 reserved, once this is just a
placeholder for alignment.

Also, while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the variable type is changed
but the corresponding sizeof that is passed as argument is not.

[1] https://github.com/KSPP/linux/issues/79

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use a more concise changelog text.

 drivers/misc/mei/hbm.c | 4 ++--
 drivers/misc/mei/hw.h  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index a44094cdbc36..f020d5594154 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -408,14 +408,14 @@ static int mei_hbm_add_cl_resp(struct mei_device *dev, u8 addr, u8 status)
 {
 	struct mei_msg_hdr mei_hdr;
 	struct hbm_add_client_response resp;
-	const size_t len = sizeof(struct hbm_add_client_response);
+	const size_t len = sizeof(resp);
 	int ret;
 
 	dev_dbg(dev->dev, "adding client response\n");
 
 	mei_hbm_hdr(&mei_hdr, len);
 
-	memset(&resp, 0, sizeof(struct hbm_add_client_response));
+	memset(&resp, 0, len);
 	resp.hbm_cmd = MEI_HBM_ADD_CLIENT_RES_CMD;
 	resp.me_addr = addr;
 	resp.status  = status;
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b1a8d5ec88b3..8c0297f0e7f3 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -346,13 +346,13 @@ struct hbm_add_client_request {
  * @hbm_cmd: bus message command header
  * @me_addr: address of the client in ME
  * @status: if HBMS_SUCCESS then the client can now accept connections.
- * @reserved: reserved
+ * @reserved: reserved for alignment.
  */
 struct hbm_add_client_response {
 	u8 hbm_cmd;
 	u8 me_addr;
 	u8 status;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 /**
@@ -461,7 +461,7 @@ struct hbm_notification {
 	u8 hbm_cmd;
 	u8 me_addr;
 	u8 host_addr;
-	u8 reserved[1];
+	u8 reserved;
 } __packed;
 
 /**
-- 
2.27.0

