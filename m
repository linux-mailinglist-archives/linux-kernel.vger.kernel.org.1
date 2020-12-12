Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25D62D857F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 10:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438504AbgLLJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 04:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388384AbgLLJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 04:54:43 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB4C0619D4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 01:33:41 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id f132so12950254oib.12
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 01:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9kk/CA9nciMRKSKbfZOYYwHqdDh/aOItR7NswTJnPA=;
        b=JCHU3jiL+ADP3ea5Q/5kaowmsJHkSEUZYZoHB1yFpo5BtbV48tTopgYHd607d7xwVI
         xO9tLcgSMBaVSR9qDsUVEO+ux/y2iTKSPsTbV17nmVhsoXTloXHwF7PHtBvjfC7k+EOv
         WgdIUmDAxIM+UrGA909Hw13feAZiiRM9Jrl+x10tp4cn0HsPlcJJHBgqjWKIE946qEA2
         h4SnMqytRKT2LRROOxMG9UT6Vgu96G3ilkL4OdKltIKVoQ64zjl4scWc7Iy6aw+10t+O
         cJxnoDWFkv5T15QIUdlatd3FQwiQ2t1J+zjfjxnFGCywpZ1DhCuxW/mf7T2rKdzpXJrw
         nDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M9kk/CA9nciMRKSKbfZOYYwHqdDh/aOItR7NswTJnPA=;
        b=L7+ruw5VW0LPEssSnSjyqcn3Z/vg8UYRmH+vnEN0Oh4mzfUlKTLQhGNtt8zI3ho0jZ
         /Fu8M7yEtW8AzqTAo1HRQh5auhmmcLe3pfFGr/hJKdZ/pSnMRvrPad/BtBrCY6ZEE2Fk
         soB0Xy4KfPkdxLGjPon4IewNENYlQLexbnOGVQ6OjBPm0ZSwnBP/yJk9lU6MgdhHlC5w
         bZ5fcH89+iimsTvDxzftg290x9HwXivBTyPRHc2nVfdcQ0SU98FB8mBDLBCctih5kuT0
         z12Ao4RyjeDqfOXC/4QWSfMzm3Mxrb0sUPG0jOe7EvIjU7tEX9yNb88bnFQD7Srcl9eC
         mSIw==
X-Gm-Message-State: AOAM530Fr4MK+3b2MPykFV2MKx9YiFOhy/xACsAyyktpCmc2jPcRdl75
        MMu64cMi0h323cnMsQDlNPbdg93Zo4OyNOWB
X-Google-Smtp-Source: ABdhPJyKO0rezQnmsMrUaJxOsLjZoIRlanfnW6UbmKV/W8/74bePm2H6jkc/ekkqlLHRfRdF5OQTow==
X-Received: by 2002:a17:90a:a502:: with SMTP id a2mr12511930pjq.155.1607759889279;
        Fri, 11 Dec 2020 23:58:09 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id i123sm13427824pfb.28.2020.12.11.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 23:58:08 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] nvmet: fix mismatched serial
Date:   Sat, 12 Dec 2020 15:58:01 +0800
Message-Id: <20201212075801.1393924-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Target side uses 'bin2hex' to convert u64 serial number to a hex
string, saving serial number as be64 to keep the right byte order.
Also use format '%016llx' to show the full serial string to avoid
to drop prefixed zero.

Test on x86 server, config '0123456789abcdef' to 'attr_serial' on
target side, and run 'nvme id-ctrl /dev/nvme0' on initiator side,
then we can get the same SN string.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/nvme/target/configfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 37e1d7784e17..6404b9ce09eb 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -996,8 +996,9 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 					     char *page)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
+	u64 serial = be64_to_cpu((__force __be64)subsys->serial);
 
-	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
+	return snprintf(page, PAGE_SIZE, "%016llx\n", serial);
 }
 
 static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
@@ -1009,7 +1010,7 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	to_subsys(item)->serial = serial;
+	to_subsys(item)->serial = (__force u64)cpu_to_be64(serial);
 	up_write(&nvmet_config_sem);
 
 	return count;
-- 
2.25.1

