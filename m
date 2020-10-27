Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15C29BD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811819AbgJ0Qml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:42:41 -0400
Received: from aposti.net ([89.234.176.197]:47482 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1802032AbgJ0Qmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:42:37 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [RESEND PATCH 2/4] usb: musb: Fix NULL check on struct musb_request field
Date:   Tue, 27 Oct 2020 16:41:58 +0000
Message-Id: <20201027164200.18602-3-paul@crapouillou.net>
In-Reply-To: <20201027164200.18602-1-paul@crapouillou.net>
References: <20201027164200.18602-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'request' variable is a pointer to the 'request' field of the
struct musb_request 'req' pointer. It only worked until now because
the 'request' field is the first one in the musb_request structure, but
as soon as that changes, the check will be invalid.

Fix it preventively by doing the NULL-check on the 'req' pointer
instead.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/usb/musb/musb_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f62ffaede1ab..ef374d4dd94a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -451,7 +451,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		return;
 	}
 
-	if (request) {
+	if (req) {
 
 		trace_musb_req_tx(req);
 
-- 
2.28.0

