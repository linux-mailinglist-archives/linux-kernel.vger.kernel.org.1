Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A52CE827
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgLDG0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLDG0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:26:15 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B13C061A4F;
        Thu,  3 Dec 2020 22:25:35 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p6so2550596plr.7;
        Thu, 03 Dec 2020 22:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RWUO9HBW83jm6ODmJA+8hyD8R17bJQiOrlPxs4/56dQ=;
        b=m9gwR3icwrA9Pdlb3ADR4lbiG0VoV6mKx4i25K8n6Ts8kZmAWQ7IA5VETsRfbPnb5E
         h5L46hCPRK5b6iGZY/lzagvv4iHaJk3D3GEZ50m7eY+8qBU/+zL2NE9I6GB8dXijBKzS
         LsPNNBnoPkt1RdycNTU/9Jfd3DF06BoIkxSzub/SWmVZcEqPbLaN/4ER34kkZ7FUslQT
         wDGQCzoxAnU34ZVc2gUdClO0oJRIxtYv4UFi9P6h/6O2EouKQnKg3VqGkwEFE7V6XWmZ
         PSMmuwvwBe4vjSGik1Af9HGrRd7n8pCqnW+i+vI+EDcbG9epRGgqAUdnFYBuG4I4gfqT
         0i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RWUO9HBW83jm6ODmJA+8hyD8R17bJQiOrlPxs4/56dQ=;
        b=VO5I32Xff+/EudWdPRRI8LkDSHvW0TZZRLlApUEe5usFi51epJo6KxEwcf2Mx3K3uZ
         uoiTwJQt0SYKoxrjRb8dhF3F2dC8bsrzLhExZoykJiljKUKKncKRsLpek9XODObNuhJP
         UYsTZwEN3+1EkxliOR2YsXSGev2c8xRCD3hrwF7IA+lsVBlDGSNeUZFSRj6Bl1Sre2dj
         nop81gszn4m5wgCHEcjjtwafjbnBf1ghcLod3iGMkd/z/BTrmCdc6Na1rjraS8RpcVtv
         c++/3IWHmlC/T11ndafndMs1udy5u99vErjTso7oPOa37QJDaGidUEFg+D/GqB2FvaLN
         OYLA==
X-Gm-Message-State: AOAM533P6TjT0s0KFn7t9HBLqN8+upgmqJL0bLcezIoSMhF4kCzF75yW
        iwgIKW6Ta2OfyzLTfxPTMow=
X-Google-Smtp-Source: ABdhPJw2hzaf3E+5KCxRnDaO1zbKdsFZCQg2BUCwEWGpLw1FLGNxjGc/GQMsV3oINvkwX/lMsbrITw==
X-Received: by 2002:a17:902:5985:b029:da:c737:5842 with SMTP id p5-20020a1709025985b02900dac7375842mr2710651pli.21.1607063135099;
        Thu, 03 Dec 2020 22:25:35 -0800 (PST)
Received: from kernel-4-19.asia-east2-a.c.savvy-summit-295307.internal (53.207.96.34.bc.googleusercontent.com. [34.96.207.53])
        by smtp.googlemail.com with ESMTPSA id 24sm3344368pgy.45.2020.12.03.22.25.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 22:25:34 -0800 (PST)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
Cc:     Bui Quang Minh <minhquangbui99@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jules Irenge <jbi.octave@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: dummy-hcd: Fix uninitialized array use in init()
Date:   Fri,  4 Dec 2020 06:24:49 +0000
Message-Id: <1607063090-3426-1-git-send-email-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This error path

	err_add_pdata:
		for (i = 0; i < mod_data.num; i++)
			kfree(dum[i]);

can be triggered when not all dum's elements are initialized.

Fix this by initializing all dum's elements to NULL.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 0eeaead..a2cf009 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2734,7 +2734,7 @@ static int __init init(void)
 {
 	int	retval = -ENOMEM;
 	int	i;
-	struct	dummy *dum[MAX_NUM_UDC];
+	struct	dummy *dum[MAX_NUM_UDC] = {};
 
 	if (usb_disabled())
 		return -ENODEV;
-- 
2.7.4

