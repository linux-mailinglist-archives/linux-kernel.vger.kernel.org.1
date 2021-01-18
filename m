Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB0D2FA38A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbhAROsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:48:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405268AbhAROrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:47:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D72E22BE9;
        Mon, 18 Jan 2021 14:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610981212;
        bh=X4TMRn2MR2KgNJ3m8GwsT1nPDP+/FP/X5P/A139kVWc=;
        h=From:To:Cc:Subject:Date:From;
        b=LG3ohvmLxRWMWla2Itu6aVH+ydAwdNPqQY2tcoTVMoRTD0HEkjv8zOk5JoMgdEViP
         OE9Z1NkMrEBZfLfn35958YrbJBYlWq9Ij/DIcvCUa1IsZf7amsQxqHFYllZ0OnGNU5
         tPhGfmgJG5VrY714JH7Jf+QoqYzQAuBGeOgkBv8rJdPQm6x+AZb8LfYL+5PVdQy2uZ
         NJsf8JjkEv33jccR+n/+5C57XSIGEb2T8XsAwxYVZDZL4vebL6rqTk80+zihVJk2VZ
         0L0hoTCMVHwlkMtT+qlpfkexwQTvBSDmyLVwZBLXUcU+xNfs9Kd8I81LWspZZiCW6/
         a9Xe0JXcfdBmw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l1Vo2-0006eb-Mx; Mon, 18 Jan 2021 15:46:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Elder <elder@linaro.org>, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] greybus: es2: drop short control-transfer checks
Date:   Mon, 18 Jan 2021 15:46:29 +0100
Message-Id: <20210118144629.25533-1-johan@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check for short USB control transfers when sending
data using so remove the redundant sanity checks.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/greybus/es2.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
index 1df6ab5d339d..48ad154df3a7 100644
--- a/drivers/greybus/es2.c
+++ b/drivers/greybus/es2.c
@@ -567,12 +567,9 @@ static int cport_enable(struct gb_host_device *hd, u16 cport_id,
 			      USB_DIR_OUT | USB_TYPE_VENDOR |
 			      USB_RECIP_INTERFACE, cport_id, 0,
 			      req, sizeof(*req), ES2_USB_CTRL_TIMEOUT);
-	if (ret != sizeof(*req)) {
+	if (ret < 0) {
 		dev_err(&udev->dev, "failed to set cport flags for port %d\n",
 			cport_id);
-		if (ret >= 0)
-			ret = -EIO;
-
 		goto out;
 	}
 
@@ -961,12 +958,10 @@ static int arpc_send(struct es2_ap_dev *es2, struct arpc *rpc, int timeout)
 				 0, 0,
 				 rpc->req, le16_to_cpu(rpc->req->size),
 				 ES2_USB_CTRL_TIMEOUT);
-	if (retval != le16_to_cpu(rpc->req->size)) {
+	if (retval < 0) {
 		dev_err(&udev->dev,
 			"failed to send ARPC request %d: %d\n",
 			rpc->req->type, retval);
-		if (retval > 0)
-			retval = -EIO;
 		return retval;
 	}
 
-- 
2.26.2

