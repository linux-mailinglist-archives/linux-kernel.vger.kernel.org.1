Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944E1290F50
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411769AbgJQFeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411738AbgJQFem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:34:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB1CC0613E9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:44:56 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y14so2413831pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 17:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=fOY8pCe4BExTNIzE1YqD2/+0j/NDPLa39mJxSSIibQQ=;
        b=qrLITqbWx3BJEn34iKbdFRBICW6vQIpxadVwOjcumPPW5trO6B9NA9P7jAGevdYRDX
         hI4aqxktJz2srvDx1PdW732KrMmQC+5nhTLIwADcMVIthSo9JFYQJgqiGmNAcJu6N4Tn
         /s1YRCOHN3Mdxdk+CUokC55b+jXCYjTITtWR75WnIsviEcLIIsksrdjo9tZrBjp7M/MK
         CglCKLM9z45BNDc1T9B487SORIJHOyN6IDjcTCboX5wJnAnAnKdR/BOB2ApcScvsSi39
         jr6vbPXf3NpG78V9VQ4qwUrTwcB5FAfs1oXTk6vaNAX00UeNfpSwbsovbXVHiu93e3mw
         0b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=fOY8pCe4BExTNIzE1YqD2/+0j/NDPLa39mJxSSIibQQ=;
        b=PONr2AIgS+CniF+GRElU/3sP8yIFj8eZTBWyoehLL08X8pHJTIW4t6Xe+/nZA79q34
         lPNcwuTkfcIVuK2N4z+ZjElrCLtEIgp+Jd5LABWjsVeE+rgG+bchj/B7LHfEzkjaPZ/w
         S6RzJA70CXk4aYtY47UsgZpBmwcjORriSpTgQhMnyzLCSy+yXy3rt9TNSCwE6+UNvbfu
         xdtYDfkO9eX/SD9VXCrGuRSoEV0lNDBOLVlAeN3PeZObDifOfbX8NvwPHCXDVbi5taRZ
         m7AvD4fJDyXkzHkvHOLUHrimP6l4J3tuaMIKK0xleKZAX9NibHgM9h6WYU0wL5A9meQQ
         amBQ==
X-Gm-Message-State: AOAM530rC6ynk66uIgqtI+5TJmc7WPdz+oUEJDG/S1w4IFFbER7stoWB
        zExyJfed+nSPcJXFH+XNSDHpQw==
X-Google-Smtp-Source: ABdhPJyZgsR57QFkFPKa+s+9rcHuTfC031C9QX/cdWr/mSNmsS1l50JvnHuZXG3qDwSTwbs7+Y4EqA==
X-Received: by 2002:a63:5005:: with SMTP id e5mr5461994pgb.236.1602895495494;
        Fri, 16 Oct 2020 17:44:55 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a19sm4008158pjq.29.2020.10.16.17.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 17:44:54 -0700 (PDT)
Subject: [PATCH] arm64: Fix a broken copyright header in gen_vdso_offsets.sh
Date:   Fri, 16 Oct 2020 17:26:37 -0700
Message-Id: <20201017002637.503579-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     catalin.marinas@arm.com, will@kernel.org, nickhu@andestech.com,
        green.hu@gmail.com, deanbo422@gmail.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Will Deacon <willdeacon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I was going to copy this but I didn't want to chase around the build
system stuff so I did it a different way.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/arm64/kernel/vdso/gen_vdso_offsets.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/gen_vdso_offsets.sh b/arch/arm64/kernel/vdso/gen_vdso_offsets.sh
index 0664acaf61ff..8b806eacd0a6 100755
--- a/arch/arm64/kernel/vdso/gen_vdso_offsets.sh
+++ b/arch/arm64/kernel/vdso/gen_vdso_offsets.sh
@@ -8,7 +8,7 @@
 # Doing this inside the Makefile will break the $(filter-out) function,
 # causing Kbuild to rebuild the vdso-offsets header file every time.
 #
-# Author: Will Deacon <will.deacon@arm.com
+# Author: Will Deacon <will.deacon@arm.com>
 #
 
 LC_ALL=C
-- 
2.29.0.rc1.297.gfa9743e501-goog

