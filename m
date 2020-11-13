Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193162B1816
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgKMJVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMJVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:21:24 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215C8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 01:21:24 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so4297518pll.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 01:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Px7FpeMEbhG+PmA8bPjaFCPNydRaVH4/fcSaLV3lHxc=;
        b=UM2+8xst+QMegbwR87o9XecwYRz051MPzFfhi9/c9FGHZHiK2ikGUxcNmGyUvMr9OJ
         OT4v4uHVXFUo+/v6S6YZvQaLAik3P0P/3Qcs9b3E6OIeji2nyZdAqB4pTTn9DjCo3xzE
         Si6jP8BiVRf4voOSrp5ehAlHRM8EycCsgCPhyYKeSXhLofMLcGhAWUsRE5SMVJMC2x5y
         DcYjfml1CsUir1tMgKdw8WVSiTz26x7pPZkRxk6N6UUkXUB9u0yp7z/UcwWtVgoHpiqy
         x46/aC2XUU2YqUT2sDhRz10CV6EVfqA1EF25TP/I6m3c7yt+C6eoY7OXsI128pHavpvQ
         rwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Px7FpeMEbhG+PmA8bPjaFCPNydRaVH4/fcSaLV3lHxc=;
        b=IHXI/b6ZnpZk5fVXwGjbzAfFOQNby7nFv3WcWPdAFNkYcWvcn6l8Ey7gtBqSOeTBfh
         Z/VMVSD/QjlLcoNwr0CcJPiiORi5trnYCQnwul/cHrVmHzOsmzPfb1fDXFLgzAWxAorg
         DvRXjyVBElPwpM9YXVhYFUwiP7vmVOID9RtRF4X4hdS9vSE38qB9LM4UiUMxsfpQH9un
         tkWCw7vesm6yn1ddhZqTpHefUewOC+MbncjTStbgvvEsGtjUJynqrstW0HVKKSa1Kn3k
         voJM3+2e8vY2iBQLBun1ITgZ+FdrKvvglTxbgyydvbAC4EVUsYBdeyJ6hg0zwQ1mYfHw
         BuRw==
X-Gm-Message-State: AOAM531b7iN7MF3r/atmhFP+80iXCPD9TA/SHJs9L2+xNTmNIgDQiecq
        vMrEwVS+pJXSA9SOPAfwCuc8ch8tAxXl
X-Google-Smtp-Source: ABdhPJzEr3pKtwr0xSXF6RAxrYTwE2wZxHaU9sN8by/xXNOrfgvuL8OOLwEfHcuY5UkNmptDlthArg==
X-Received: by 2002:a17:902:b415:b029:d6:ec35:755b with SMTP id x21-20020a170902b415b02900d6ec35755bmr1233353plr.47.1605259283649;
        Fri, 13 Nov 2020 01:21:23 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id d12sm7073999pjs.27.2020.11.13.01.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 01:21:23 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] altera-stapl: remove the unreached switch case
Date:   Fri, 13 Nov 2020 17:21:05 +0800
Message-Id: <1605259265-14129-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of the variable status must be one of the 0, -EIO and -EILSEQ, so
the switch cases -ENODATA and default are unreached. Remove them.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/misc/altera-stapl/altera.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index 5bdf574..8ad1e9e 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2265,19 +2265,10 @@ static int altera_check_crc(u8 *p, s32 program_size)
 				"actual %04x\n", __func__, local_expected,
 				local_actual);
 			break;
-		case -ENODATA:
-			printk(KERN_ERR "%s: expected CRC not found, "
-				"actual CRC = %04x\n", __func__,
-				local_actual);
-			break;
 		case -EIO:
 			printk(KERN_ERR "%s: error: format isn't "
 				"recognized.\n", __func__);
 			break;
-		default:
-			printk(KERN_ERR "%s: CRC function returned error "
-				"code %d\n", __func__, status);
-			break;
 		}
 	}
 
-- 
1.8.3.1

