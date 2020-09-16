Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB0D26CA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgIPTn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgIPTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:18:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D5C06178A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d19so3716018pld.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zqVd5aJCn3jWe+cLGn+cDLVmuUTYejBKrMGwZzLg0eA=;
        b=Y9ZKLVzNc/nkjU1/CyaKQ2tsDuZ0qQO9dBf3jmNBAa/cCQJif4eqy8Jxu69IhNVDJg
         UBOYI1objMHVqMgcvVNtWvxjibaeJklTvMR6wCpGQglJ7ukuDB5kYD7KGDPLPFCJbPQf
         ZjwpBBylRtHkxubA8fHTvzqi2lNMHxTpb+iW/cDAw3Xnhd5tmbOqoryKGpbJHZNO/9gv
         CtQ+fENL3YHadXcs+XoasGrdd3GRDpIsh3UKYZVirD4WyoHOkIausNQ+7NsXSJOAoe/6
         jFXSSfXrPJvWsalQjI1MKsAwScRfkcS8UudrVthiSLmP+H9ONpev/dOaBNfgUB/f9DIZ
         zMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zqVd5aJCn3jWe+cLGn+cDLVmuUTYejBKrMGwZzLg0eA=;
        b=qVdXlzkeV3ZLXk3ukUnb9+VLn0loyP/YS4FBH1WglKMEi5apdBMc6RpwVdL8FupD6R
         dLXfiuzM4Vx04GQ+fbOytB8Ac+bLS2dGcT7mwYwtXwbGjvXpBJH2GDOZEqY/pxVFCsqT
         1RIFpC6sBCvmGCrwijySUaEbi8kMIR2Pob8yHcCnQ/7fZLtjYMoFc/nvhJwNDcxhQOvw
         hTdP+XOYaLRbJamy3QY8ZU4OmOE4pn2ljxvlIHzM1NchwCZQSizNLTfOdnjGccHqolLp
         9P5yTd0SNH7x2iA010Uo+MJTMiKcuj9SFqPeXZii1TuabNWqBYW9JKirfMxXnpzYHanY
         rKeg==
X-Gm-Message-State: AOAM5331yZrDl4oGCV75opGPBE7dluCJORxgc5kRgfxbJc6pp+lS3dde
        WDKojx27nFx9w+b/EXaSKfI0pQ==
X-Google-Smtp-Source: ABdhPJzLYqy0aga5oYoEC1V8aQ1YRhCJMYbaeWrOEjaU8Z2bhDPgdxNoE8d76Iew49j9klf7Dl2C6w==
X-Received: by 2002:a17:902:a70c:b029:d1:e5e7:be56 with SMTP id w12-20020a170902a70cb02900d1e5e7be56mr7873079plq.48.1600283863147;
        Wed, 16 Sep 2020 12:17:43 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:42 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/16] coresight: fix offset by one error in counting ports
Date:   Wed, 16 Sep 2020 13:17:24 -0600
Message-Id: <20200916191737.4001561-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Since port-numbers start from 0, add 1 to port-number to get the port
count.

Fix following crash when Coresight is enabled on ACPI based systems:

[   61.061736] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
...
[   61.135494] pc : acpi_coresight_parse_graph+0x1c4/0x37c
[   61.140705] lr : acpi_coresight_parse_graph+0x160/0x37c
[   61.145915] sp : ffff800012f4ba40
[   61.145917] x29: ffff800012f4ba40 x28: ffff00becce62f98
[   61.159896] x27: 0000000000000005 x26: ffff00becd8a7c88
[   61.165195] x25: ffff00becd8a7d88 x24: ffff00becce62f80
[   61.170492] x23: ffff800011ef99c0 x22: ffff009efb8bc010
[   61.175790] x21: 0000000000000018 x20: 0000000000000005
[   61.181087] x19: ffff00becce62e80 x18: 0000000000000020
[   61.186385] x17: 0000000000000001 x16: 00000000000002a8
[   61.191682] x15: ffff000838648550 x14: ffffffffffffffff
[   61.196980] x13: 0000000000000000 x12: ffff00becce62d87
[   61.202277] x11: 00000000ffffff76 x10: 000000000000002e
[   61.207575] x9 : ffff8000107e1a68 x8 : ffff00becce63000
[   61.212873] x7 : 0000000000000018 x6 : 000000000000003f
[   61.218170] x5 : 0000000000000000 x4 : 0000000000000000
[   61.223467] x3 : 0000000000000000 x2 : 0000000000000000
[   61.228764] x1 : ffff00becce62f80 x0 : 0000000000000000
[   61.234062] Call trace:
[   61.236497]  acpi_coresight_parse_graph+0x1c4/0x37c
[   61.241361]  coresight_get_platform_data+0xdc/0x130
[   61.246225]  tmc_probe+0x138/0x2dc
[   61.246227]  amba_probe+0xdc/0x220
[   61.255779]  really_probe+0xe8/0x49c
[   61.255781]  driver_probe_device+0xec/0x140
[   61.255782]  device_driver_attach+0xc8/0xd0
[   61.255785]  __driver_attach+0xac/0x180
[   61.265857]  bus_for_each_dev+0x78/0xcc
[   61.265859]  driver_attach+0x2c/0x40
[   61.265861]  bus_add_driver+0x150/0x244
[   61.265863]  driver_register+0x80/0x13c
[   61.273591]  amba_driver_register+0x60/0x70
[   61.273594]  tmc_driver_init+0x20/0x2c
[   61.281582]  do_one_initcall+0x50/0x230
[   61.281585]  do_initcalls+0x104/0x144
[   61.291831]  kernel_init_freeable+0x168/0x1dc
[   61.291834]  kernel_init+0x1c/0x120
[   61.299215]  ret_from_fork+0x10/0x18
[   61.299219] Code: b9400022 f9400660 9b277c42 8b020000 (f9400404)
[   61.307381] ---[ end trace 63c6c3d7ec6a9b7c ]---
[   61.315225] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Fixes: d375b356e687 ("coresight: Fix support for sparsely populated ports")
Reported-by: Ruediger Oertel <ro@suse.com>
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-platform.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index bfd44231d7ad..227e234a2470 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -711,11 +711,11 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 			return dir;
 
 		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
-			if (ptr->outport > pdata->nr_outport)
-				pdata->nr_outport = ptr->outport;
+			if (ptr->outport >= pdata->nr_outport)
+				pdata->nr_outport = ptr->outport + 1;
 			ptr++;
 		} else {
-			WARN_ON(pdata->nr_inport == ptr->child_port);
+			WARN_ON(pdata->nr_inport == ptr->child_port + 1);
 			/*
 			 * We do not track input port connections for a device.
 			 * However we need the highest port number described,
@@ -723,8 +723,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 			 * record for an output connection. Hence, do not move
 			 * the ptr for input connections
 			 */
-			if (ptr->child_port > pdata->nr_inport)
-				pdata->nr_inport = ptr->child_port;
+			if (ptr->child_port >= pdata->nr_inport)
+				pdata->nr_inport = ptr->child_port + 1;
 		}
 	}
 
-- 
2.25.1

