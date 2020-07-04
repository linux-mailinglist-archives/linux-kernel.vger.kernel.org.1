Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88492148DF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jul 2020 23:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgGDV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jul 2020 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgGDV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 17:29:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1F3C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 14:29:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so35351763wmj.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LjzcBI79sxOJxzVQKPCIyuJutTNEiW0H8TnQRgGGRK4=;
        b=TSPLSa/SqaaFWtHntF2Lqxj4Epnb3XvDw+B8/Iz+n5XmPOr2m8MPVcV/U6bO/E1xTS
         oCzw9uzS0Luvc39FhMezKjfB0NQO7Kr6ijsd6D3cKMyXhMTCU9PmAEk6EBEOvGM7B8kP
         Gqs7wvUWrnuWeDS3Fv2x/i6Iusvea9ufcLuRzC9F0ks78KAHCs+alg4KwTIN9eYDdCHo
         wW4asd0ZwAkhyMNTYIpv3sI/hbPuJX+m5r98EmXvmZ4rbYMp58Vt76EJgHKH+8sG2yCX
         RxU1/LHm/tvzNu+Lc9MtqJipqcxrA/mOlZeIA2oFspgp0hHi1AHJH+SGjPjAE7bxQCtp
         /gRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LjzcBI79sxOJxzVQKPCIyuJutTNEiW0H8TnQRgGGRK4=;
        b=D/IEAs5zmKdo33xn3F6K0XaAp8gu+o+w8qhO4Q3qh6rV6AZH2VByCBxIXJikmXY8b2
         EWhUHL8iPKlorKCcO1jYRm09WBAyrvVtETU0/1QF4SXSqdxhmcKUClbBSNeZlAXeApq0
         fKLy40eacBWlvgg1sxnzUtIM70Z4qHhKAlhbGh/NiHz2L3qoSIt075oJDLYrcIJ0E6xH
         D5hTK9nH0+3Evgh+TgNk1Cl4XGQZ/mk0kysMFFOKnqPe4f6CbtEC+vQqUI2vEfUkT+os
         TaFDBcwx9Slv6M6H7GOBQSx23FFU66bMpdTbyXEkGaO4g8PrtMrIpmgyL5f8ThvtKH3D
         Lj6w==
X-Gm-Message-State: AOAM530tx30spaqQO8W/SQhFszUODWi9Wlgax/IEkGZA1S2Ppuj4m00W
        rFK19I3Tc3SHOtb1kxKDwHnrQeZz
X-Google-Smtp-Source: ABdhPJz+LiyFBgkM+BSs7zqzubcag3N6rgnyEYsIO4l/X2FcQ2FSjhNlFn4d920wgSZcAbqT80Fy/A==
X-Received: by 2002:a1c:1fd1:: with SMTP id f200mr41233994wmf.162.1593898189107;
        Sat, 04 Jul 2020 14:29:49 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id x7sm18397141wrr.72.2020.07.04.14.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 14:29:47 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 1/2] habanalabs: block WREG_BULK packet on PDMA
Date:   Sun,  5 Jul 2020 00:29:50 +0300
Message-Id: <20200704212951.20062-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WREG_BULK is a special packet that has a variable length. Therefore, we
can't parse it when validating CBs that go to the PCI DMA queue. In case
the user needs to use it, it can put multiple WREG32 packets instead.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 834470d10b46..e22206527164 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3865,6 +3865,12 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 			rc = -EPERM;
 			break;
 
+		case PACKET_WREG_BULK:
+			dev_err(hdev->dev,
+				"User not allowed to use WREG_BULK\n");
+			rc = -EPERM;
+			break;
+
 		case PACKET_LOAD_AND_EXE:
 			rc = gaudi_validate_load_and_exe_pkt(hdev, parser,
 				(struct packet_load_and_exe *) user_pkt);
@@ -3880,7 +3886,6 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 			break;
 
 		case PACKET_WREG_32:
-		case PACKET_WREG_BULK:
 		case PACKET_MSG_LONG:
 		case PACKET_MSG_SHORT:
 		case PACKET_REPEAT:
-- 
2.17.1

