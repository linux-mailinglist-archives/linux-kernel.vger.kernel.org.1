Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088F91D15EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbgEMNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387966AbgEMNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:38:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70616C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z72so18928062wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyRGlbI4Ky3Dk3+EyeqNaJIIfLuLQ5HFlEzVPTO9nr4=;
        b=bMtNP9htiHa4g6CO0FhlyLgjdmVg2uoH/JS6A+XeeQjNSsWHJ8U8m0wdZGnw1Y+0aL
         kW8OYvE+eNBeWbbm/5Gab5wkT1yO1e6mIJUToNMcIPXRt7iTR0/vCIetz/nAJn27FLLz
         jhPPpIRzrjCO7NAduITv9ZIwigQhrw9Qrd7XSq6ZHbMgGPCG8DIfXLK4Mz26e6UyQIsC
         kFE/QS0MJpOZwOAHP/JmflUOLkHqqpPF2Ucefo9KzZkVgBFzOPS1UsPF3YxZe44yFlfI
         eGemUuSFNmHex8uVKB8LTn1f6/I4kJhidJrkgjKQ+bDuFwMnHX66Mv8lS/yNh7KxVHHy
         5Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyRGlbI4Ky3Dk3+EyeqNaJIIfLuLQ5HFlEzVPTO9nr4=;
        b=H29xdZXxmYCcimU978ceCG76/j/ILSB12Xjsb7Uw/GG7QrAuM3rDpuer64TdvPFt+I
         WZmBQvreDews2ZXS/ZSwb7tDunTSYyHNFVoJqEVWGGSNWjnujX1uTPzNCvBVHbvWiJQZ
         FmnwOSLgifmHiHLQU1FLtivvD3gP9lKM53x90JSnPuMyLYFF5u+DOkL+bVqd9aVkwFHF
         SDVsrdDZ2C2FH3rElm2ofRmRES8a2Xac+on5TluyMxILxhCJ3MUshpOkOwGEdNMrzFeD
         /g746F1Yza88N1imuAG9kQjKckEVpkccLdreogP/McZptdS2VA/b9S+WFA90jgEp6CUt
         N9EQ==
X-Gm-Message-State: AGi0PuaU7WWC+DkFeN5De1ei1TreRFG0yXImuQ3MD2380mhky4JbgBVE
        NO/xN8kHRPLDS2XIajSsqPjVGQ==
X-Google-Smtp-Source: APiQypIjxnkrTUJVBpGMV8YOgo+iI7d5niRSc7PWL+lVfFV/KjhGlb+A6PRiT5dOGTNyca62+5s28w==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr32473872wma.150.1589377130947;
        Wed, 13 May 2020 06:38:50 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:50 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>, Bob Liu <bob.liu@oracle.com>
Subject: [PATCH v5 01/11] loop: Call loop_config_discard() only after new config is applied
Date:   Wed, 13 May 2020 15:38:35 +0200
Message-Id: <20200513133845.244903-2-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loop_set_status() calls loop_config_discard() to configure discard for
the loop device; however, the discard configuration depends on whether
the loop device uses encryption, and when we call it the encryption
configuration has not been updated yet. Move the call down so we apply
the correct discard configuration based on the new configuration.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bob Liu <bob.liu@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..f1754262fc94 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1334,8 +1334,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		}
 	}
 
-	loop_config_discard(lo);
-
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1359,6 +1357,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	loop_config_discard(lo);
+
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
-- 
2.26.2.645.ge9eca65c58-goog

