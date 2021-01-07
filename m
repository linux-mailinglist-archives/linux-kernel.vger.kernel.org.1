Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68442ECC4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbhAGJHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbhAGJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:06:56 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62E6C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:06:15 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id h18so4656966qtr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ax6g/HtSztG4IFRRlChAFWW26f6FAbiNEq7tx3MzI/c=;
        b=UGC0NfIw6VwxqUMytMX/RaseYmVf+EYCOYuEGJX2bcfC8/Hd5tJR+Xk4Su/iCKLgKQ
         QarbJHQtBieOAS+IuBdDZ/Rli6C9mVSXe+UNSqeTdf95Uoo6rV0FZ8Rc9Nmwk7KrqXLP
         e48trSKI3ZRx+vcgEdhXQfp96XeZrYD+rUtA2kim2vcFY2pczfLroJpjl9wFzAuYa4HQ
         cAOMGVuE64gvLaPD2FSLu1S4Sm1Sjvw/SgpgNntqSHlcIT+4JezsOoAaumNVIuzSFuKF
         7ueo/S3ueRzZsyrDnTi4GPzvcNWfe50Tlm/luF1gSgZ3/Re3Z84DmkiqMeuR+HMCER9q
         ZW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ax6g/HtSztG4IFRRlChAFWW26f6FAbiNEq7tx3MzI/c=;
        b=W6mznui9NvBUJ34JffiteJJWhydnAIk7vs73TH2ksWyRrryuT4RcjFIyCoOahJAT3/
         JTmOWoeR0IsRHTgrGT1wcNJWnfXsrCgmn0SOEyLa7nWnwR0GjqQFzzjUkolZoZItpmPp
         um/MpPNipeYroABvg6yohPeJdHb5NiNzA8oCTdEc8fwQ6x4kAlycSgqAYvZXtLBDqTf0
         t67rfaxMTw+Jwf0jJI+0BVxXjT5B56D+yOdOF/B540aAV+7Ki4dXVpkuSPBJoO9W7Sit
         99WoAPj0OiQ+GwK4Yx04eLCXjPjwESX/1sJYsufx5ElCx71OnHmNwOwmq90Uc42jYkBW
         u8jQ==
X-Gm-Message-State: AOAM531RvCAaQv/lRbashZnPi9hdOq1Es+pt24KpLOO2gvY1FmX05gky
        E0rVlUY5YApe/scA0f+ql0TBOB5zqsUwYi8cnCg=
X-Google-Smtp-Source: ABdhPJywUKEB7B2fPgiIHPbveN2HCYf4CJlV4BmTDO77pUl7gycUiiPuDROtbx3i/K4PBp3Akbt+FJWHhZHkvGMCziY=
Sender: "albertccwang via sendgmr" <albertccwang@albertccwang.c.googlers.com>
X-Received: from albertccwang.c.googlers.com ([fda3:e722:ac3:10:3:22c1:c0a8:83d])
 (user=albertccwang job=sendgmr) by 2002:ad4:5b82:: with SMTP id
 2mr7824860qvp.28.1610010374712; Thu, 07 Jan 2021 01:06:14 -0800 (PST)
Date:   Thu,  7 Jan 2021 09:06:04 +0000
Message-Id: <20210107090604.299270-1-albertccwang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] Revert "usb: gadget: Quieten gadget config message"
From:   Albert Wang <albertccwang@google.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Albert Wang <albertccwang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1cbfb8c4f62d667f6b8b3948949737edb92992cc.

The log of USB enumeration result is a useful log and only occupies
one line especially when USB3 enumeration failed and then downgrade
to USB2.

Signed-off-by: Albert Wang <albertccwang@google.com>
---
 drivers/usb/gadget/composite.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index c6d455f2bb92..5b0d6103a63d 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -840,9 +840,9 @@ static int set_config(struct usb_composite_dev *cdev,
 		result = 0;
 	}
 
-	DBG(cdev, "%s config #%d: %s\n",
-	    usb_speed_string(gadget->speed),
-	    number, c ? c->label : "unconfigured");
+	INFO(cdev, "%s config #%d: %s\n",
+	     usb_speed_string(gadget->speed),
+	     number, c ? c->label : "unconfigured");
 
 	if (!c)
 		goto done;
-- 
2.29.2.684.gfbc64c5ab5-goog

