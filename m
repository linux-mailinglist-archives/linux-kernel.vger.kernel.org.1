Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1382684B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgINGUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgINGT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:19:59 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA005C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:19:58 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so21453107ejo.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPWNvv2kZKctpbCV5DaDmYimW34Kcud5VzQfi7Xnkyc=;
        b=a0bp8QrNiHY/XDpAKBCEXGpK4nesHUgOvIqiaHQ/49/zhPg9G9bMJrl+0kD50tu+BN
         zJrhlnPXT9LQNjSyVwOF1BZfFMxS7aHAjONIckGM6ssXdV3xR90WKRKmVT72QtMoTHc5
         02iM0zN1sJIwCCHo00jljpmXWbsNYB1LrZA778IywvEN1oU+aVNoYoqLerxRreONkIXw
         7LRwUVGoaOE6L+exYogI4sgqyVR7GbOcnDT9DPb4gAzPBN+vCF80pMrCQZvhPCRZRbiH
         lIxhT9AhuugbMOrH4k144DA2+LivRf9UzfcU+EzCq8nStJ27d8jHjG1G7F/vJEap2AUw
         PSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OPWNvv2kZKctpbCV5DaDmYimW34Kcud5VzQfi7Xnkyc=;
        b=Vh3zYMg4J2tDpExHULf7Y1dwPEI99zvllC21tse1bWP8J2gAVdoNgPObaMEHlyVuBk
         vxDFZ2f97sJtGgroCyFopIe5RGakoTsr3xopPj/1rIpU8y9glwuWtsCgUjGi/Kyjo5c9
         pgDI/Zm/RbY6+iVplxFMFdT9pBeDAJgyn3SRBDn4aVSa+OkbJWFZbNedKEwQNF/L/XV9
         tgcM3LTSEwqB5sg5gUDyXQUZOdu97HHbpIJ2tbQ6kKwRlohAAEhcxXqFIvoH97aNKgdr
         Q6+GGrHMRuDxMm2sydtQ1d+tgJ1CC6yZHZXaFGTa3mbUUI5x5Ngs7x/DI7IolSOSsF2M
         /sbA==
X-Gm-Message-State: AOAM532GZa/xxWb45nRfwUJrFDYGBCVw4AIsHpOFQXsmaIBebj4XYdk+
        /bd4UcVkeEf6gDkR9vMwUUWj7R8Ef1kfZg==
X-Google-Smtp-Source: ABdhPJxTX6eaqt+d7327S219jroTAm/VsVceytUy20ioHotlZJMs5l8aRJUNIYUqEBETCgzQhnqKug==
X-Received: by 2002:a17:906:914b:: with SMTP id y11mr13608778ejw.145.1600064396976;
        Sun, 13 Sep 2020 23:19:56 -0700 (PDT)
Received: from ntb.Speedport_W_921V_1_46_000 (p5b363350.dip0.t-ipconnect.de. [91.54.51.80])
        by smtp.googlemail.com with ESMTPSA id p12sm7024641ejb.42.2020.09.13.23.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 23:19:56 -0700 (PDT)
From:   Petr Malat <oss@malat.biz>
To:     linux-kernel@vger.kernel.org
Cc:     nickrterrell@gmail.com, gustavoars@kernel.org,
        Petr Malat <oss@malat.biz>
Subject: [PATCH] zstd: Fix decompression of large window archives on 32-bit platforms
Date:   Mon, 14 Sep 2020 08:19:31 +0200
Message-Id: <20200914061931.21886-1-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems some optimization has been removed from the code without removing
the if condition which should activate it only on 64-bit platforms and as
a result the code responsible for decompression with window larger than
8MB was disabled on 32-bit platforms.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 lib/zstd/decompress.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
index db6761ea4deb..509a3b8d51b9 100644
--- a/lib/zstd/decompress.c
+++ b/lib/zstd/decompress.c
@@ -1457,12 +1457,8 @@ static size_t ZSTD_decompressBlock_internal(ZSTD_DCtx *dctx, void *dst, size_t d
 		ip += litCSize;
 		srcSize -= litCSize;
 	}
-	if (sizeof(size_t) > 4) /* do not enable prefetching on 32-bits x86, as it's performance detrimental */
-				/* likely because of register pressure */
-				/* if that's the correct cause, then 32-bits ARM should be affected differently */
-				/* it would be good to test this on ARM real hardware, to see if prefetch version improves speed */
-		if (dctx->fParams.windowSize > (1 << 23))
-			return ZSTD_decompressSequencesLong(dctx, dst, dstCapacity, ip, srcSize);
+	if (dctx->fParams.windowSize > (1 << 23))
+		return ZSTD_decompressSequencesLong(dctx, dst, dstCapacity, ip, srcSize);
 	return ZSTD_decompressSequences(dctx, dst, dstCapacity, ip, srcSize);
 }
 
-- 
2.20.1

