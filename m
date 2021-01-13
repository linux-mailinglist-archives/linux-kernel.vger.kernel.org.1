Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC0C2F5809
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbhANCNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53832 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729219AbhAMV5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 16:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610574973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TcMhDFu40M2vbcmXTpEq5AfXfYVWbjvJciRmB33PZNI=;
        b=aShgT3fgYyh3204GRR1UHMm4H/WffVKP8JgdEOykPeu2mZBEnjQyaUF7eXiFSHKPuso4pQ
        gE+jZNfx9oPn0r4A+lX8ud+2Z7oNuKabUlfQuxP/dFWInCaMUAaiRzOE2EKJ6S+MQcxkVa
        /mm85c9zJ5IoX+oTgIspdKfdFVxJ0WU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-w9L2h0MBNl6qI9nByhBCrQ-1; Wed, 13 Jan 2021 16:56:11 -0500
X-MC-Unique: w9L2h0MBNl6qI9nByhBCrQ-1
Received: by mail-qt1-f198.google.com with SMTP id p20so2612104qtq.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 13:56:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcMhDFu40M2vbcmXTpEq5AfXfYVWbjvJciRmB33PZNI=;
        b=A+8fJL+KiEVW6Cv2yOpw/tgi6mkEM9q6b98UepZrG5PiX68txnokpvks3/BZ4idEnV
         MmdMJ1B96MqZugidqrdEhqiCMRgkwXs4uLrwv8r/Exc9oJACRtjHhZiNMFC2RHpyShKs
         9e2ed8XuqXdGPUFWQzoikYZnajNe3ZSdovrEIcE8il/DuKM9ELEvYGd+JaLSNGWg/g63
         DpyWZ9z3TgPgkLt9P50Nx9mk/qKDJJbtzndMbZhjoJII5ocYbmCigYyHfIeXZ/+0Uask
         sG7cbvEk+FpM7lI80sA0LH/DbhNjt6oXGR5bEEhHNU5zFUhYbw32SAEw8Xdz8cw7OcBv
         HNSQ==
X-Gm-Message-State: AOAM5302JPXbkVQzHKR/bT7cCa9RTn+d88f7f8r1W10Fi8yny/600eEK
        4e+zPhPz81t/HAdhiC0KNneVDnWWD/YZhMKD6o0xgYC/sYQ8fVu5Jn9tmQEyIULVA4l0S1GMoie
        PYHo9X+3+MeiMU1KUzcl3Fzhg
X-Received: by 2002:a05:6214:1230:: with SMTP id p16mr4305619qvv.47.1610574970923;
        Wed, 13 Jan 2021 13:56:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZW1vCbp2lWzBVZ/9CHzZnH8/2XiV+QNphgjQ5RHwl/EwUN+7SzCeUi4g+9Mvjrek/eLuusA==
X-Received: by 2002:a05:6214:1230:: with SMTP id p16mr4305603qvv.47.1610574970679;
        Wed, 13 Jan 2021 13:56:10 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p6sm1803386qtl.21.2021.01.13.13.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 13:56:10 -0800 (PST)
From:   trix@redhat.com
To:     claudiu.manoil@nxp.com, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] gianfar: remove definition of DEBUG
Date:   Wed, 13 Jan 2021 13:56:03 -0800
Message-Id: <20210113215603.1721958-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Defining DEBUG should only be done in development.
So remove DEBUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index d391a45cebb6..541de32ea662 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -58,7 +58,6 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#define DEBUG
 
 #include <linux/kernel.h>
 #include <linux/string.h>
-- 
2.27.0

