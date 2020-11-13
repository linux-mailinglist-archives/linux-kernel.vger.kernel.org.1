Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00862B1FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgKMQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgKMQOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:14:42 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9574FC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:14:42 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so7971984pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sMLZ4jDZ/hRIbEZ23HQB6WUJGul68cYtw4DE1cA+unQ=;
        b=KwnFafSK69zNzbfY+oCBXTvbAlT7HRHND5x6Nkn/5LWPz03k73Od8YLRSt3QGAO5Ld
         06SiqVCuI/MRj8piJrKt5Vl5sdDl51BOGwGQZaw6qW1gYXXMMCSlaIeX8I9JRIYdiOqC
         VnXBrgUJWe7im7WJKnWCY3tEvM4vz5ofFRAgW28Fm9A3po2NigCuemUslIYI0ZD91evl
         DPGyftAGCglDIn+0sXNaTw8Oylx932RFNtTFssr2390SDNCenpL1LHkytGmPD81M4hXd
         4SZLypskTc8hWrrpmRweBSUl+4jyf8sv7PL9py0v0Kxap0hg4ngL5CkqNYg6AKXdsJUb
         +2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sMLZ4jDZ/hRIbEZ23HQB6WUJGul68cYtw4DE1cA+unQ=;
        b=rh/2zud2xYwKVA28kSB+qu2XseYLIN1O4zU4/4aiZj5Rkd6y/fYJA6/GGaR+exHHSb
         onRI++vg8KuUlod+tL272Qrj/ViF2wp08bpiRli204Vwk87/ERuggJS7kIy1fsDdrT0j
         WhkFwuiBu61g4i2MZprmfPn90IXRBIt4fseZbqF1skV1sXXgsW7J/An/cFiW5319yLvp
         lNKUurdlHUjLkc9ygba8/8NgZagMh8vxCvK/WIm3DAH6eofvojmFjB9xhsOGe/RkJbTV
         GdpbfDgbifTwEZX4ABACFr84VcZJZIiNmzUazdgI3UpbwnLzpVksVqSH+Fe+rhotAAOg
         t0Zw==
X-Gm-Message-State: AOAM532Q1gSOmoZZEzmfZmE/UP8vpujHkYlZWCXiWuHJSwDhhkZWS+9U
        heKCB24hHRB+j/AfkXFy1pI1SpBALUaQ
X-Google-Smtp-Source: ABdhPJzrWcujY62J68LlgdaVp9J0wfvxvvfXTNO3hTbjW/Wee49AXzzjIaQx9s+Vd8qYZgdkQJ8shQ==
X-Received: by 2002:a63:ca0a:: with SMTP id n10mr2583710pgi.326.1605284077250;
        Fri, 13 Nov 2020 08:14:37 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id w63sm2913409pjj.12.2020.11.13.08.14.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:14:36 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org, David.Laight@aculab.com
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2] altera-stapl: remove the unreached switch case
Date:   Sat, 14 Nov 2020 00:14:31 +0800
Message-Id: <1605284071-6901-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of the variable status must be one of the 0, -EIO and -EILSEQ, so
the switch case -ENODATA is unreached. Remove it.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
v2:
 -leave a 'default' case in there.

 drivers/misc/altera-stapl/altera.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/altera-stapl/altera.c b/drivers/misc/altera-stapl/altera.c
index 5bdf57472314..92c0611034b0 100644
--- a/drivers/misc/altera-stapl/altera.c
+++ b/drivers/misc/altera-stapl/altera.c
@@ -2265,11 +2265,6 @@ static int altera_check_crc(u8 *p, s32 program_size)
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
-- 
2.20.0

