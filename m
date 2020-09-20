Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1404A2711BE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 04:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgITCH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 22:07:58 -0400
Received: from mxout04.lancloud.ru ([89.108.124.63]:55750 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITCH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 22:07:58 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Sep 2020 22:07:57 EDT
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 8C2FA207034A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Date:   Sun, 20 Sep 2020 04:58:57 +0300
From:   Elvira Khabirova <e.khabirova@omprussia.ru>
To:     <op-tee@lists.trustedfirmware.org>
CC:     <jens.wiklander@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tee: fix some comment typos in header files
Message-ID: <20200920045857.34b612bf@akathisia>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.255.69.56]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1904.lancloud.ru (fd00:f066::74)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct tee_param: revc -> recv.
TEE_IOC_SUPPL_SEND: typo introduced by copy-pasting, replace invalid
description with description from the according argument struct.

Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
---
 include/linux/tee_drv.h  | 2 +-
 include/uapi/linux/tee.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index d074302989dd..61557bc0e29f 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -85,7 +85,7 @@ struct tee_param {
  * @close_session:	close a session
  * @invoke_func:	invoke a trusted function
  * @cancel_req:		request cancel of an ongoing invoke or open
- * @supp_revc:		called for supplicant to get a command
+ * @supp_recv:		called for supplicant to get a command
  * @supp_send:		called for supplicant to send a response
  * @shm_register:	register shared memory buffer in TEE
  * @shm_unregister:	unregister shared memory buffer in TEE
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index b619f37ee03e..7546be5ed4f8 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -342,7 +342,7 @@ struct tee_iocl_supp_send_arg {
 };
 
 /**
- * TEE_IOC_SUPPL_SEND - Receive a request for a supplicant function
+ * TEE_IOC_SUPPL_SEND - Send a response to a received request
  *
  * Takes a struct tee_ioctl_buf_data which contains a struct
  * tee_iocl_supp_send_arg followed by any array of struct tee_param
-- 
2.28.0

