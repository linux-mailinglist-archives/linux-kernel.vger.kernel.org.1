Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497A92D7077
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436640AbgLKG4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436609AbgLKGzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:55:45 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333F9C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 22:55:05 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id e2so6503734pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 22:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtrdIWHf0l79DvI8uc1Iscj77P/+6pPa3TMd8+VMU9Q=;
        b=ZLsBaj030AG9Jd2Wql+Z67a/Whr7yxh1QxDSlPOvUlzYYAFrseeRVMUf9XDx+0m2Dt
         h37H8qLOaBvDzHqedMPLL7OtLkihWNk8uPpA2Ic+5l3uYgSVzUcAuc8djacrwQfjSsYc
         PwSn0kGuI9KTzsRtA47X82AjIrz6nK9RYxWGVva6GzfC+9pOnA8xIw+OUL/XVNW5gX6t
         QbOPY/DSfdYyaNpmSq5kidYanddewxmfdcbpczC+oRbaTeTpXQplXA+bSeMsEHEyBoDG
         9/5YsYcC7VF1BsgtVUlTOFDxW6YrDjWuEDQ8rtmiS01+M3tEHikQybBZXjKY+so/ryvU
         UnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtrdIWHf0l79DvI8uc1Iscj77P/+6pPa3TMd8+VMU9Q=;
        b=YW6Nom0T0WQo3n2bFGDimPfB/EkbElYuzhLRvZGt2QKT250nWoqy8j8Dli6M68X9C8
         MLIWE5zbYOj34M4YNU1UkGJ/AhPaZr0CwB4N8zpQfVY1A4zji12fgTqpmIC3iUqZZ+Se
         VQyvwqB8y2mppcP039pHi03vBV5DSVldQvnpfCEidg42mAjqOGwtOPZ6BNCzB0hZq9TA
         DJxBX5sANEqvOYMDTgsl/FgXSZ34VG5YXqBwXB7WPhZeyrJ0QXldIilt6fEtL2hbz+LF
         ey2Z91ba4npyUnx6Mwd0lqyqWYLcR8w6Ec4ZNxUs0Mcs7ZPWW9/yen3j/8SKhvTl7Mts
         cXvA==
X-Gm-Message-State: AOAM53285gFQUnM0WQUUIR2ctvQtX/gToeLVjNuv8mXmdzOkgjoi8QCt
        FYjIhQfDbrjCua+ZWndLg7E7Sw==
X-Google-Smtp-Source: ABdhPJwnuq4yl3DgTCz7YGdMgNP5ou5xBAC1KAsUJKEkSeaV6Wu7QcesQ7TJ6K5XbKGGuA37oST4Nw==
X-Received: by 2002:a63:170f:: with SMTP id x15mr10167670pgl.157.1607669704694;
        Thu, 10 Dec 2020 22:55:04 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id s29sm8242252pgn.65.2020.12.10.22.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 22:55:04 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH] nvmet: fix mismatched serial
Date:   Fri, 11 Dec 2020 14:54:56 +0800
Message-Id: <20201211065456.826822-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Target side uses 'bin2hex' to convert u64 serial number to a hex
string, saving serial number as be64 to keep right byte order.

Test on x86 server, config '0123456789abcdef' to 'attr_serial' on
target side, and run 'nvme id-ctrl /dev/nvme0' on initiator side,
then we can get the same SN string.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/configfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..e7808a86ccef 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -997,7 +997,7 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
+	return snprintf(page, PAGE_SIZE, "%llx\n", be64_to_cpu(subsys->serial));
 }
 
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
@@ -1009,7 +1009,7 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->serial = serial;
+	to_subsys(item)->serial = cpu_to_be64(serial);
 	up_write(&nvmet_config_sem);
 
 	return count;
-- 
2.25.1

