Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9189A2C79DC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgK2QHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgK2QHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:07:53 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D65BC061A47;
        Sun, 29 Nov 2020 08:06:59 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so8706728pfb.9;
        Sun, 29 Nov 2020 08:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LVhruWIY/P2/Y+4I2ixxsPAsvIG1kQjrmNo/r2JNhsk=;
        b=MsjsA7nr0iuTWYGF0aBVjMK0svUlyAox0Z2XKhCOUkszW/4DkkpS2UwWPXlJ212cmD
         iF2FKJzqqm36BbOFzk9ZQU6f77afKYYe5fvrS16UM+NqU863W9lswrnkAoKjaxhn25K6
         2evXWmOkLO8gF2ivRWPDLJcpJvy5jKGNTOCFmeIWz8hNZenmxLByRBvPo9x1v0HoSjUv
         ozVLiJNTCHrmONpu3SnTlgPfvKW1NQEPsx91kW8Cpb6ESQxcEMSh2cG1Go4pi8RNGND2
         GBHC1Pf4OIccBCKCiMIRgwCSPZJ3dS3I53mvLHUfmVGUG/aTn4VWYEuYfd09LBQBnel7
         Fj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LVhruWIY/P2/Y+4I2ixxsPAsvIG1kQjrmNo/r2JNhsk=;
        b=Hor2Z629FiT+3pheiFsMIgtenrGaHZ6oBhXcMlBdX+YmM0Bh6KyuPy0xenvAyS2XOl
         3osCK5y8u1rfX0Y7RNOvUMaM/HiTEEfytPjmLEnB1rPw2TzjN6jF36W6QZrRNsXQucdN
         IfmUeY4W+3EzGTDR6ezRqkBqcqYoUl7LQpxNG6T6MEjJfVEKb6DUd4oFtoxsRVZAWj7u
         qVtE8F3i6qb1+Q7LcrJ8wGH5E+zdZr960gji5focaHpMXlVR8NggKwgQDdpB9qH0+vkW
         AT9y7cy7rxIRMnKpxhGyvJp46Lv0olhBYQnTzJCtUTXsdJq31iBn2e7UIge9mCJ+zdka
         plWQ==
X-Gm-Message-State: AOAM532bcQcSeBZWfpO7lDj7Jv6WpTuCf81hrtqMFNfhmzLFsVU2JYL5
        lFMp5v/lQA1jJQalLCp1OZa+0hn8btj6RxfOOes=
X-Google-Smtp-Source: ABdhPJyXXlH513p7X0Vc34qO5ZRXu+ARNpnEZ6sraOo8Eg71GpBS9ac50eM/PDUtheBrzlT8b7u6LQ==
X-Received: by 2002:a17:90a:aa0e:: with SMTP id k14mr22086638pjq.153.1606666018593;
        Sun, 29 Nov 2020 08:06:58 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:06:57 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] usb: misc: emi26: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:02 +0530
Message-Id: <20201129160612.1908074-6-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
References: <20201129160612.1908074-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API are an improvement on the
existing usb_control_msg() as it ensures that a short read/write is treated
as an error, data can be used off the stack, and raw usb pipes need not be
created in the calling functions.
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/usb/misc/emi26.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/misc/emi26.c b/drivers/usb/misc/emi26.c
index 24d841850e05..1093809d34ad 100644
--- a/drivers/usb/misc/emi26.c
+++ b/drivers/usb/misc/emi26.c
@@ -39,18 +39,8 @@ static int emi26_writememory (struct usb_device *dev, int address,
 			      const unsigned char *data, int length,
 			      __u8 request)
 {
-	int result;
-	unsigned char *buffer =  kmemdup(data, length, GFP_KERNEL);
-
-	if (!buffer) {
-		dev_err(&dev->dev, "kmalloc(%d) failed.\n", length);
-		return -ENOMEM;
-	}
-	/* Note: usb_control_msg returns negative value on error or length of the
-	 * 		 data that was written! */
-	result = usb_control_msg (dev, usb_sndctrlpipe(dev, 0), request, 0x40, address, 0, buffer, length, 300);
-	kfree (buffer);
-	return result;
+	return usb_control_msg_send(dev, 0, request, 0x40, address, 0,
+				    data, length, 300, GFP_KERNEL);
 }
 
 /* thanks to drivers/usb/serial/keyspan_pda.c code */
-- 
2.25.1

