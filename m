Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B92E0B97
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgLVOSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgLVOSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:18:22 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30664C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:17:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r7so14673053wrc.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wHA7WXGOL2zkCUojHptt6INoc65BByl7E6rlCw2sxA=;
        b=giumZz5lWfQ6wDWtD+QCrYmrw+MG7A5NmanW/wuHomvTLKCY5aRw36EL4yNmcrQSQh
         R9LnV3xvALyoi802pQJwaDJddUR464t9UJgcWGdKIKBjtpdaUEGNMx7VSjL2GfZFxQ6E
         PY8OySYW1sMc8tC9gnujIxNFVz9Iawyzt8/Vx+Dgy8Q7O4jomR2E76bH/DJoWzIsDvS3
         6RK7nLICLqxZdbx/YaSiPaz3Izd/MBIoFHG2p1Z2c8qQo9hTy8nvyjqCzTxhCKkAZB38
         fcX5NDsYwEs306jyDh9m0ILgTWoB+bJ9j6HFJE63rLjH7WlieNPdNzOGmrOGN+STjmc4
         R5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wHA7WXGOL2zkCUojHptt6INoc65BByl7E6rlCw2sxA=;
        b=do1CFQ10ahgRzJbyvoHJ0M5TXlb2nwVq/9OfbEHpM75s5p1OD6as9VBQshZdUPQc8M
         nYeXTE7aFb8NikwKRa7L44IKAT0tDHsNV+X5+fqc0vmE23pyIsPAWGbxgE55nB+NyQfw
         5vFn8cLP2rhNGlNn8OC1mRaw2fswSyVAWRH0BAN9H+OA2NMc3wYEzwVI3AkYvBPjzEQE
         nkGovvysXus8qT0jHEGAp3L9gXxh8ONrY0pZvqxkFrVype06ombGJsv7KSPjxEJ6jwX8
         S5k3a0yM/28AwkaLSbVvOous2NCB3eXuUx4tWAZdLquCXZ3l1BVRtgC1RcpE9tkqQAfg
         wJtw==
X-Gm-Message-State: AOAM531a/8sjLReup8S9g9/S77y5CANhhfNARnYY1mkTn/ArEftbm3Vg
        G9rmiofCNKzSa5sTOXAArhg=
X-Google-Smtp-Source: ABdhPJzTIHuJ7tMEv2l3nlo7ir99sq6qaFsEI3BElB3lbgqYzQ30tA5GzaOCa9Ysqq4m5ZVaU08DgQ==
X-Received: by 2002:a5d:4b4c:: with SMTP id w12mr24136139wrs.402.1608646660863;
        Tue, 22 Dec 2020 06:17:40 -0800 (PST)
Received: from tumbleweed.fritz.box (dslb-002-204-143-153.002.204.pools.vodafone-ip.de. [2.204.143.153])
        by smtp.gmail.com with ESMTPSA id l20sm35597178wrh.82.2020.12.22.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 06:17:40 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: clean up brace coding style issues
Date:   Tue, 22 Dec 2020 15:17:07 +0100
Message-Id: <20201222141707.31972-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing braces around else arm of if else statement to clear
style issues reported by checkpatch.

CHECK: braces {} should be used on all arms of this statement
CHECK: Unbalanced braces around else statement

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 32ca10f01413..a6c43bc4f62a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -245,8 +245,9 @@ u16 	Address)
 				break;
 		}
 		return rtw_read8(Adapter, EFUSE_CTRL);
-	} else
+	} else {
 		return 0xFF;
+	}
 
 } /* EFUSE_Read1Byte */
 
-- 
2.29.2

