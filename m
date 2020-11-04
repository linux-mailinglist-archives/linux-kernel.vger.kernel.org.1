Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E532A634C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKDL3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:29:50 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07C5C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:29:49 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w1so21697087wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 03:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S98hGeY7ZA73e66abMJQ3IOnnZUlVmbNDaPLBNYGOuU=;
        b=vHn4ezPfj8m+7O0997sBqIAe/nGMNROwTmdd/SB7dvjkPFo62QpCkj2BpeolhDinjc
         VpC1IsLadJEbzmAwSaLDTes2fIUjnZ/gEiEBuj91S/YL+2Q4godxcqdfudYiIfS2bWDj
         3xPqxa9XRl300X2UmOmX0mlDfFFVkKQF/yzRqf8+UyPyhbNMk/x3wMtMlUk7e3E678CN
         jdPL6XKTEHKy5FZO1M+W0OP53pRy18BivtVB/0i7PP/5nfoc+io5q7f0XEC4oDJudyyv
         7ykA0CrKO977ZN2L8a7hbHQlankTUHrwvjkCS9HeU0RBxOeZcc/WVfOzulv+Ne3EokuC
         DCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S98hGeY7ZA73e66abMJQ3IOnnZUlVmbNDaPLBNYGOuU=;
        b=H4kucQB30E0Ozbj6YnNPFfl/xffGvh36P59aBqsBbKSwIQ5599UldVcsVYhKCU+X3k
         u8IktiWc7LTMitglLBXBoiSpO75PtUSaINGDXu2QlkKVfYifYBAKPUiS5VPbuf0Xvo0g
         pfUdJyG2pEt4CwANhaz3GMvnBOHwoeepmAW7t4Fl2xRYoMOZDXEC9efIZLABZ67WQSj2
         6AsAlE0rcGfcKuktWQPStiOLnegPrlVQ8p4mreSjKhF208T9ieMeEdyJs4NAztdNhbZ9
         PpxgVElXJpVCLrxuSbT7G1zo3dBfPFh7bgpRVZ66i6wK9rslI9WgBmIsthvCuExVXsr8
         Ou3Q==
X-Gm-Message-State: AOAM532BOoUHsmlTio1tZwjR20MM5w617C1SjrPDTuSWiEX7Ctu0DFt7
        nZGyqps371UClyrsJqU9bhAUbQ==
X-Google-Smtp-Source: ABdhPJxZnV5Gc2GvHl6mWJJLQRjXccdVJftbSOnJ86NTkhURNkUDhGEgZXRoGxCIxwjN5+XfSM+qWQ==
X-Received: by 2002:a05:6000:104e:: with SMTP id c14mr31356100wrx.329.1604489388190;
        Wed, 04 Nov 2020 03:29:48 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id c64sm1692813wme.29.2020.11.04.03.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 03:29:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org, yung-chuan.liao@linux.intel.com
Cc:     pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        gregkh@linuxfoundation.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: Fix DEBUG_LOCKS_WARN_ON for uninitialized attribute
Date:   Wed,  4 Nov 2020 11:29:41 +0000
Message-Id: <20201104112941.1134-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

running kernel with CONFIG_DEBUG_LOCKS_ALLOC enabled will below warning:

BUG: key ffff502e09807098 has not been registered!
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 5 PID: 129 at kernel/locking/lockdep.c:4623
	lockdep_init_map_waits+0xe8/0x250
Modules linked in:
CPU: 5 PID: 129 Comm: kworker/5:1 Tainted: G
       W         5.10.0-rc1-00277-ged49f224ca3f-dirty #1210
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Workqueue: events deferred_probe_work_func
pstate: 80c00005 (Nzcv daif +PAN +UAO -TCO BTYPE=--)
pc : lockdep_init_map_waits+0xe8/0x250
lr : lockdep_init_map_waits+0xe8/0x250
 [ Trimmed ]

Call trace:
 lockdep_init_map_waits+0xe8/0x250
 __kernfs_create_file+0x78/0x180
 sysfs_add_file_mode_ns+0x94/0x1c8
 internal_create_group+0x110/0x3e0
 sysfs_create_group+0x18/0x28
 devm_device_add_group+0x4c/0xb0
 add_all_attributes+0x438/0x490
 sdw_slave_sysfs_dpn_init+0x128/0x138
 sdw_slave_sysfs_init+0x80/0xa0
 sdw_drv_probe+0x94/0x170
 really_probe+0x118/0x3e0
 driver_probe_device+0x5c/0xc0

 [ Trimmed ]

CPU: 5 PID: 129 Comm: kworker/5:1 Tainted: G
     W         5.10.0-rc1-00277-ged49f224ca3f-dirty #1210
Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
Workqueue: events deferred_probe_work_func
Call trace:
 dump_backtrace+0x0/0x1c0
 show_stack+0x18/0x68
 dump_stack+0xd8/0x134
 __warn+0xa0/0x158
 report_bug+0xc8/0x178
 bug_handler+0x20/0x78
 brk_handler+0x70/0xc8

[ Trimmed ]

Fix this by initializing dynamically allocated sysfs attribute to keep lockdep happy!

Fixes: bcac59029955 ("soundwire: add Slave sysfs support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/sysfs_slave_dpn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/sysfs_slave_dpn.c b/drivers/soundwire/sysfs_slave_dpn.c
index 05a721ea9830..c4b6543c09fd 100644
--- a/drivers/soundwire/sysfs_slave_dpn.c
+++ b/drivers/soundwire/sysfs_slave_dpn.c
@@ -37,6 +37,7 @@ static int field##_attribute_alloc(struct device *dev,			\
 		return -ENOMEM;						\
 	dpn_attr->N = N;						\
 	dpn_attr->dir = dir;						\
+	sysfs_attr_init(&dpn_attr->dev_attr.attr);			\
 	dpn_attr->format_string = format_string;			\
 	dpn_attr->dev_attr.attr.name = __stringify(field);		\
 	dpn_attr->dev_attr.attr.mode = 0444;				\
-- 
2.21.0

