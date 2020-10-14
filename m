Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CEA28DD52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgJNJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbgJNJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:22:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C188C045862;
        Tue, 13 Oct 2020 22:43:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id p21so889885pju.0;
        Tue, 13 Oct 2020 22:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umQbA12maAabp0YAAXx4XmA3wLrlwiRnHw8TQdyxX5I=;
        b=YPkKq/vq/cyOYas+GCNZ+n82XLnWmynO+RbTt96hiDSAaUHA5JOXGOC5DJlzOquj6b
         V9QjjmpwJChcCc+jP4pp6fB6W0l8lljvQHD/UvJS4VAFkBdqBtN9FErvT72kKftNS3fn
         ktRf2pWYwExOGZj+jU++gsYGJ4kf3MTcMDMQzp9wFklvu9UOzjToCEBNcBwRAwx0058X
         MHP8vLnRqivKAZQUYxTmDCjV5LLg24wG4JsqvkPSQAriwp1L4h7hu3u6PtZiaCMvq3is
         0co0g8b7v8FO94OopjRpmw4JNTECsYW8/sLBp3tPmIXue/WaIcr7Hv9cqn9IoIGhNCqn
         ITMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=umQbA12maAabp0YAAXx4XmA3wLrlwiRnHw8TQdyxX5I=;
        b=gTEfjQKFfrdfrllzvrh3ymWcJHUWqBibo9myN+Cak/LtncQtGnS2N3zOyl5TQaXxrM
         LRDZbJiSx1K4eUt/+tgfleX8xloFhbGp9SKq9wytFUr4tfaCUXlFCPSqptToqhwFNinx
         /J+5Emfc+KAzXQKZba+sf5SsUXJthbh6qLtzkzZy5ghD7afBllORAQM7mFjbJWBDogBt
         oq8X/KhwzPoE162I49DjEA5v1MUGTBS4e4aBHla7f6JgqrNz8vFhJSz0eibc/2BrwZkH
         1I1yGEr3JJFZWnbAPVixpynLg8mMzITScND6TJEBVG8hisECGzZdIt9VRcgVO1nMO3wD
         graQ==
X-Gm-Message-State: AOAM5308nlqf+W0PrN4NEah9PN0JbK2eoJMR3AjbFohHOr1UDMBXIP+l
        dOKErNPKxm7VrGWmKOaOKPcdloZjOVrQQvHmNPI=
X-Google-Smtp-Source: ABdhPJxMiR0I/OaV/dSzfo6qytQ3489rmDgA3kk/rlB91+OwFjFgU5+PBWFmOfnf4kPNf/wZ73tUSw==
X-Received: by 2002:a17:902:9a44:b029:d3:f10c:944a with SMTP id x4-20020a1709029a44b02900d3f10c944amr2768047plv.11.1602654230935;
        Tue, 13 Oct 2020 22:43:50 -0700 (PDT)
Received: from HVD6JC2.Broadcom.net ([103.113.142.251])
        by smtp.gmail.com with ESMTPSA id y126sm1768537pgb.40.2020.10.13.22.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 22:43:50 -0700 (PDT)
From:   Amitesh Chandra <amitesh.chandra@gmail.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     amitesh.chandra@broadcom.com, ravi.nagarajan@broadcom.com,
        cheneyni@google.com
Subject: [PATCH 1/3] Bluetooth: hci_bcm: Add compatible string for BCM4389
Date:   Wed, 14 Oct 2020 11:13:25 +0530
Message-Id: <20201014054325.2407-1-amitesh.chandra@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amitesh Chandra <amitesh.chandra@broadcom.com>

Add compatible string match to the serdev driver for the
BCM4389 Bluetooth controller

Signed-off-by: Amitesh Chandra <amitesh.chandra@broadcom.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 94ed734..680478f 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1425,6 +1425,7 @@ static const struct of_device_id bcm_bluetooth_of_match[] = {
 	{ .compatible = "brcm,bcm4345c5" },
 	{ .compatible = "brcm,bcm4330-bt" },
 	{ .compatible = "brcm,bcm43438-bt" },
+	{ .compatible = "brcm,bcm4389-bt" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bcm_bluetooth_of_match);
-- 
2.7.4

