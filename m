Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6502B41D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgKPK6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgKPK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:58:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:58:22 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so12841238pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=K11Yw6nBHKXqvrOJyt3LbKzXQFWdesl05NnWwxvI+6I=;
        b=SxQbJOldlKIr9x+F+rH95rl4aLkdrwpj1+i0lfhNO0Rkszfm4lw9Mr30cXfi1oOLkB
         rNQuK+s86OTuu9SKwXlt2Wtp/mD0JpHxv4WJFnS+tR2iHne2vuoPai51zpbWeDdg5kwy
         eV1oJnnXEysiL6eq/zdyXA9J1aoSZRlGluG4xkL+keruJsLen94bk15r4RUwp+vDKMdh
         jXEg4tm/s+5oO/0lWDCvdyVo73PD3v2GSECXRWaavr7IK3MozPUD2NGGtgeIL2nN36Nm
         oCiPSRhZR0paMlyjCjqgRE2SAgtTiA1U1v+KBdBzVuC4/fhwoBB1GnezaFadYBIBsAjf
         gENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K11Yw6nBHKXqvrOJyt3LbKzXQFWdesl05NnWwxvI+6I=;
        b=SLPhzjpSwiFFK4YiFDGyPmCsEELRMGgwd/osGmRqkIiU+LPtaWXGMMsDwZvNALN3Q/
         lLYsTv84fu4LtkWnyS7MsidRpVTpwSEpAjVeJltCwSjZJ15GhrewA3EuMM3WM1AUkaiJ
         Bry474lhfg+EyQMB7i+/nijqyH5N//1EUs0amMAKc3Vw3bWFka1gPXlQQbTYTQIACLh0
         W9wCGa2nKQ+l9ohuZnnQUykzr61I98277xhHSPCx7QcGZ8tQ3Pbe9AiwPvOuvtG5/V/m
         2lpBSP+6HJrntlZ3al8P6Iwc+ynN23VlwKUsJaAQEU7s5DXpV3ThGt8c1UeZaVWlU6MY
         mvOA==
X-Gm-Message-State: AOAM533atFBVZJ7H7VBLU/i4JM0mCcr3JuslGkG8r4+3RQ8GwBm9vJFD
        rw1o7CJ0pkCre3ouTeuuuniXtuiD7uDJ
X-Google-Smtp-Source: ABdhPJyvHoBLTk9vkQXl+rArKrx16tHqUJj75Z8t6yG73Ugd0gkxR5dCot/fSb5K7Ao6k8DUWMcVEg==
X-Received: by 2002:a17:90b:14d4:: with SMTP id jz20mr2740024pjb.219.1605524301714;
        Mon, 16 Nov 2020 02:58:21 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id y19sm17401412pfn.147.2020.11.16.02.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 02:58:21 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     kishon@ti.com, vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v3] phy: mapphone-mdm6600: return error when timed out powering up
Date:   Mon, 16 Nov 2020 18:58:16 +0800
Message-Id: <1605524296-20755-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The value of variable error is overwritten by the following call
devm_request_threaded_irq() in phy_mdm6600_device_power_on(), actually
we should return error when timed out powering up.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 5172971f4c36..edbe227f47e8 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -421,8 +421,8 @@ static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
 			dev_info(ddata->dev, "Powered up OK\n");
 	} else {
 		ddata->enabled = false;
-		error = -ETIMEDOUT;
 		dev_err(ddata->dev, "Timed out powering up\n");
+		return -ETIMEDOUT;
 	}
 
 	/* Reconfigure mode1 GPIO as input for OOB wake */
-- 
2.20.0

