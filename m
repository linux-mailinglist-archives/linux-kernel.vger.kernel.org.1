Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C85267B12
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 16:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgILOxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 10:53:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34599 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725969AbgILOra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 10:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599922048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=vhedvMNzaUEDcUuhwo/iLfGVABBNwD7Ffu7xTey6+9c=;
        b=gYt53RMHtTRRKwLyBlIJ02gqjMsJM9NWKCJ81juj7fGS2ntTwXJSdsIX3v5GSQq3H1rDv2
        5Trq0z25gCrvmQMOJEDjPN8u5z+UfpYKty5UmUvizkdhfeUntvuiUvl8XiiveQQKsyoZtz
        9bcskbttFIg1YKLkHz62IwXA6YVaDr0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-6C1luu21NxKuh3f_IJthFw-1; Sat, 12 Sep 2020 10:47:26 -0400
X-MC-Unique: 6C1luu21NxKuh3f_IJthFw-1
Received: by mail-qv1-f71.google.com with SMTP id di5so4428990qvb.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vhedvMNzaUEDcUuhwo/iLfGVABBNwD7Ffu7xTey6+9c=;
        b=MECNuTjB1iHggLjCXJEdtUN7dullBrWZSynbnQltC0p9nG7j7M/ZL+CBXbbc8tyybY
         NhBY06gb1BqU5TeGuMjpQxQkn7LpPqeG5+KL16aI4qHya6kEdoUrZl8jeP17B5DQGt8d
         E8sWpUAoPUlVmSWRJ63638HywHla//Kx1S7lykCXJmyFWs0WHyiVyZgUlAFrri9ab1gw
         GwJ7H+S1Tze1oCRa4DO1iypRX4MtL5qpaXz/hBaAGrHCaZORwsEMz2lhaeI9JjMx89PP
         zvb9lzhpD8Pz5Lu1yHlRBupqv3PqDeYj6s17BDvUlqsJBE+2H6ZE8LYlRyh495baXMb7
         KqLQ==
X-Gm-Message-State: AOAM532nbyIV6pRfwVs4kn3dVCE9fFDosKSppFt8aK04Q2/dvWhLaWw2
        j3wImtx2KIB6mKNVIXRltvP3Wy4bJ4/WY+mAOG9JJardO+lr+oQkFAQbe8nqsxIRDtQ4OC6y0KB
        rymplLpr4d6Wb9aaUzrzTW+hO
X-Received: by 2002:a0c:e989:: with SMTP id z9mr6441208qvn.81.1599922045828;
        Sat, 12 Sep 2020 07:47:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwly9+TI3qlwz43wKPoJau1E8RyrgfhK9Hk6G2EG0hVy9Xgse6md8eIDmPt0UBEDtJtU63ziQ==
X-Received: by 2002:a0c:e989:: with SMTP id z9mr6441201qvn.81.1599922045640;
        Sat, 12 Sep 2020 07:47:25 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u2sm7425387qkf.61.2020.09.12.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 07:47:25 -0700 (PDT)
From:   trix@redhat.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] staging: wfx: simplify virt_addr_valid call
Date:   Sat, 12 Sep 2020 07:47:19 -0700
Message-Id: <20200912144719.13929-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Reviewing sram_write_dma_safe(), there are two
identical calls to virt_addr_valid().  The second
call can be simplified by a comparison of variables
set from the first call.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/staging/wfx/fwio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/fwio.c b/drivers/staging/wfx/fwio.c
index 22d3b684f04f..c99adb0c99f1 100644
--- a/drivers/staging/wfx/fwio.c
+++ b/drivers/staging/wfx/fwio.c
@@ -94,7 +94,7 @@ static int sram_write_dma_safe(struct wfx_dev *wdev, u32 addr, const u8 *buf,
 		tmp = buf;
 	}
 	ret = sram_buf_write(wdev, addr, tmp, len);
-	if (!virt_addr_valid(buf))
+	if (tmp != buf)
 		kfree(tmp);
 	return ret;
 }
-- 
2.18.1

