Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8FE1A4723
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJOAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 10:00:42 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46328 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:00:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id q3so1064320pff.13;
        Fri, 10 Apr 2020 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bKpZhyNf9M3fco/d7pahZ9nCUyoMi6PyXjtRpyxLkuo=;
        b=XsgqYBgsWmv7nByoSGX9qdrqgmdlL8633JtchXERe3MuvZUl1VZ7JDvv8BwPfJ42Et
         NQ7FeeSY1WeHwMN4H9uElUjt+sRq5R3dKEmjkCCpWbJ68oeug0S6KLLlZtn//vhsKEpi
         2v8OFxqwZam3JvRmDfq0GA6wuLW0L8NNjzTtu+ear9KofYwTpg2hPdYZthsXzfweswhd
         /wahoiHj6T9ZwHB6oSUZhx2etO8K0XzUqihY76gwlPEBzpxihjvgdePOeqI4VJY7AFU3
         0GV3LnAIX9Maja1oirTJLQvg7wN6Ja8M73Iw/I2fWJ2Js3gXFZwqMbCjmJI8oZvw1iTY
         jv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bKpZhyNf9M3fco/d7pahZ9nCUyoMi6PyXjtRpyxLkuo=;
        b=OpBs+vLYbPhcVPqosgQsDGsxaw6JlgAdAlbahMiE5KdH3diGKOwiBI/NLO7yTx84vE
         SAfLA+OXhCXuc7G4raTx2Dqwa67/oV1goRnprzXJutBQ7xUuFh7rUmDnH0VApzyZ4ft9
         Cq3JcClg8otnHpkXSE3BBiKs6ugmbMUyjtigoMjIdxS/qQ1MicJ19z5xE/Q+0sJ9z+30
         j3zM38uiQ2d9unJ5UxNSqDCbi0twBxhLGCkr7SaB+IJctgpLQFq3xYBx2JBi5R+fgOxi
         Sbth1P8BG2ESaANKauRkBU+4Tm6kd7moFVDom+o21voWyIg1kV++GLJNFLKYg9W8HuLT
         7qUw==
X-Gm-Message-State: AGi0PuadB3ttvlcKBFjWvjmTWRiVAkb0z4SLF3Ge36FPkBtaDJIfrFrg
        4OYKiLSTZo72kqNEWPI1mnw=
X-Google-Smtp-Source: APiQypKlhCezMdpE/WTFqG2SgtfcAD0gVgpzRi5gKGAXQhMlhx/N/gtX13FAbZaWIE9F9ajJJfDYoQ==
X-Received: by 2002:a63:e60a:: with SMTP id g10mr4555677pgh.51.1586527238767;
        Fri, 10 Apr 2020 07:00:38 -0700 (PDT)
Received: from i7.zsun.org.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n21sm1636860pgd.93.2020.04.10.07.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 07:00:38 -0700 (PDT)
From:   sztsian@gmail.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     sztsian@gmail.com, linux-kernel@vger.kernel.org, icenowy@aosc.io
Subject: [PATCH 1/1] Bluetooth: btrtl: Add support for RTL8761B
Date:   Fri, 10 Apr 2020 22:00:10 +0800
Message-Id: <20200410140010.105317-2-sztsian@gmail.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200410140010.105317-1-sztsian@gmail.com>
References: <20200410140010.105317-1-sztsian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ziqian SUN (Zamir)" <sztsian@gmail.com>

Add new compatible device RTL8761B.

Signed-off-by: Ziqian SUN (Zamir) <sztsian@gmail.com>
---
 drivers/bluetooth/btrtl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 67f4bc21e7c5..1f0fbb3e6286 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -130,12 +130,19 @@ static const struct id_table ic_id_table[] = {
 	  .cfg_name = "rtl_bt/rtl8821c_config" },
 
 	/* 8761A */
-	{ IC_MATCH_FL_LMPSUBV, RTL_ROM_LMP_8761A, 0x0,
+	{ IC_INFO(RTL_ROM_LMP_8761A, 0x0),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
+	/* 8761B */
+	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb),
+	  .config_needed = false,
+	  .has_rom_version = true,
+	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8761b_config" },
+
 	/* 8822C with UART interface */
 	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
 			 IC_MATCH_FL_HCIBUS,
-- 
2.25.2

