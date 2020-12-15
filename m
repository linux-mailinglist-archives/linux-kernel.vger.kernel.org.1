Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64802DB5EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgLOVdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:33:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730266AbgLOVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608067894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O3IlA/EtAmqXa16y6q/aKRAMxC9/cCCbF/diJvoK8Qk=;
        b=VdYXsquq0aoNiQ60IafyMBDjVORAKJYWNdNJlotjy1BnQNvSy+qRy9N/JWPkeFdsuRhQZx
        VSDi8OaWQW/6qoIBYkRAYXcLB35HuVWknLHVQhM+RySBaKxeNjmDU6bYpCJTOkk7XlrsyG
        NfWf6ZRLu1YM6ZECGZO9L/nAT/F78+I=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-ioq3Q99XNbW-piBB2NF9TQ-1; Tue, 15 Dec 2020 16:31:31 -0500
X-MC-Unique: ioq3Q99XNbW-piBB2NF9TQ-1
Received: by mail-oo1-f70.google.com with SMTP id a29so9913983ook.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O3IlA/EtAmqXa16y6q/aKRAMxC9/cCCbF/diJvoK8Qk=;
        b=rn3dtBkg3AQArE0kx8+uSEvMz+u0x+f7v5vNcyLsatErvY8JEftV2MFKzT6CLvVvNZ
         u3dylvT6kD39pJaK4uUkMSFrpTWWy1CVJsUqX2S+6P8AEWvgbY67qTBVpnzd5Cz1Wqg/
         kRyyHWeB+GpEKRH7vEIWJ7nhbTP0F71UUZLGouePLzzjAo7L1F99uDQoP4Pro3D40Kiv
         cHckNQKiS4nqLuQfNPIWaRsJx+YqQ6+ETV0ZX5pIInEc9m+Iz5wtcAdC2ZAziLqLJQ86
         Wr35QaeJsU80UxNS3KOPx+3ofh731rCzYOMlK9HMiyVTtGgRxXyLPl6iANvIKDUuBi9k
         aGbg==
X-Gm-Message-State: AOAM531aN7ePzEbje8AZ9WOxG0aXacl3IYf+Pn6Dtm1lu+s4xBJdvUKk
        n8I8tZ/cLVUDSDLZM4yRZWNFf//OD1gHG7pk28RlVWyPjCRBAfraPHCl0B0L0ovW3yY0BzI8uG2
        TvsuCetmEqQF2Q7rMQCtKUr5F
X-Received: by 2002:aca:4ec9:: with SMTP id c192mr521527oib.115.1608067890592;
        Tue, 15 Dec 2020 13:31:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTT2aSnaexWFHSJF1Kr3v1WMGB3hbglFJ56ittyEcYbw0OmkvxZUnHYk32RyC9b3ZpJV17pw==
X-Received: by 2002:aca:4ec9:: with SMTP id c192mr521525oib.115.1608067890449;
        Tue, 15 Dec 2020 13:31:30 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h2sm23776otn.15.2020.12.15.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 13:31:29 -0800 (PST)
From:   trix@redhat.com
To:     agk@redhat.com, snitzer@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dm dust: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 13:31:25 -0800
Message-Id: <20201215213125.2091089-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.

commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/md/dm-dust.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-dust.c b/drivers/md/dm-dust.c
index 072ea913cebc..cbe1058ee589 100644
--- a/drivers/md/dm-dust.c
+++ b/drivers/md/dm-dust.c
@@ -130,7 +130,7 @@ static int dust_add_block(struct dust_device *dd, unsigned long long block,
 
 	dd->badblock_count++;
 	if (!dd->quiet_mode) {
-		DMINFO("%s: badblock added at block %llu with write fail count %hhu",
+		DMINFO("%s: badblock added at block %llu with write fail count %u",
 		       __func__, block, wr_fail_cnt);
 	}
 	spin_unlock_irqrestore(&dd->dust_lock, flags);
-- 
2.27.0

