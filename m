Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4C22C79E0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 17:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbgK2QIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 11:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387406AbgK2QIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 11:08:05 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B2C061A48;
        Sun, 29 Nov 2020 08:07:02 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w187so8727570pfd.5;
        Sun, 29 Nov 2020 08:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iH1BJ1F9uJ1BMhbbV1cemuGWuqAz6DqF3K+Ndw2I+uI=;
        b=mI3gsHCRjiEpdKUznoqVS44zHCKsFy4tJB2YY3ib+9pFtibn9jX/3KU91YEpACCGtB
         8Y0ffLlq8EUnuaQVmseg1mIBj8h4VlO3Lx4YXYCKThmPa+esGPd4BEVhWp4/nsYdS92i
         57mXEm+1kSB+1ejIV3eXl5RxwRoBWnF5jfsMlH5RHMbnMBsRKPuI/w59D4DDZbdDFVaf
         E0XNjfrHh5h29TFC0NaBEb9zJw9hZ+RqKfq+Feh1WDG4Op9M8vcgYiW1USkKkRgQPrxr
         LElVNNBWUU1vDMZ2ytMhYW4O/DKVv0ix69hG8iYZnCdo0VSjRyByDhFadHwzPLTerSAz
         LBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iH1BJ1F9uJ1BMhbbV1cemuGWuqAz6DqF3K+Ndw2I+uI=;
        b=oWgTsFfagOq6imTykudZfQxaD2/iBqvR9z9EFtoaysmfKkR2eFHObx9YUnGG36tMTA
         JgEwc9KGn8hL1OTVD+7D3YG10MrIEGatHWJFYRDZySwbKzA0j7ewonoxm4GniHAfhFk2
         Kz2QRNH+QEB/HT/zR9vZkBg6WDJdTVAYoLKtsNOaYucSgSEDscL5qPlPv8FmDaN3NfgA
         k7ZhcrkYlC2mM0Pj5Tpt7+NRjisYbqOttY7fI6PqUHCF8wZqeR3486BidONGpYiS/mtl
         9MIXIiG6Fu046NzaRQUlf3zu6Xtb4sXFU4ky+PthzXZEsLsCjZWfDah+K23QoBQFJJzO
         ERHA==
X-Gm-Message-State: AOAM5300JlRHorofi8uab8piBXN1qTQKr5lb+oYFIO/8lcr0d+CVm30F
        U2OxCJRb+dg0d7PRGkRYbG0=
X-Google-Smtp-Source: ABdhPJz3Y9dF4RuAj6pT9vsa393RwkrvauNg+pEhUpJwxK177xnekWw9Tv1tbPbi3COV8jkmhvD8lQ==
X-Received: by 2002:a63:3841:: with SMTP id h1mr6836784pgn.380.1606666021634;
        Sun, 29 Nov 2020 08:07:01 -0800 (PST)
Received: from localhost.localdomain ([49.207.196.188])
        by smtp.gmail.com with ESMTPSA id u3sm13496837pfu.47.2020.11.29.08.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:07:00 -0800 (PST)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] usb: misc: emi62: update to use usb_control_msg_send()
Date:   Sun, 29 Nov 2020 21:36:03 +0530
Message-Id: <20201129160612.1908074-7-anant.thazhemadam@gmail.com>
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
 drivers/usb/misc/emi62.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/misc/emi62.c b/drivers/usb/misc/emi62.c
index 3eea60437f56..de984e91085c 100644
--- a/drivers/usb/misc/emi62.c
+++ b/drivers/usb/misc/emi62.c
@@ -48,18 +48,8 @@ static int emi62_writememory(struct usb_device *dev, int address,
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
+	return usb_control_msg_send(dev, 0, request, 0x40, address,
+				    0, data, length, 300, GFP_KERNEL);
 }
 
 /* thanks to drivers/usb/serial/keyspan_pda.c code */
-- 
2.25.1

