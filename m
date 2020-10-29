Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E202B29F20A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgJ2Qqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgJ2QqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:46:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C796AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:46:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j18so2835261pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Np2c0Q4BDShbRLU/V5l//Z0ajqNMYgtNQNvz5k3aXQ0=;
        b=dw6uRNa5JlCe+v2CzEKP9981nPUUpS0430nUVSDjOsCMan7OPxQ+l2+Ijcyhs9j7Ye
         vGDxJiij3l6yx3ENZkBy1zpjYW6pbNFJR6/M4yrIGiNIMSiMQ+5SMFHxvgSyVo/245KT
         N1oFjncGsVdYH2g130qJhQXyoJPfUF8Kk2FiC1A68OwyikSSS+hdtPm7Bm3O6Q59iizi
         bySBDnhNTITUAdyKQfSU4mzhcy4g8m189ujExL5OOZCZILg9EFFHVpoQ5YpeuxVI4a4L
         kB5ieKFRKBZ0LI55isPmqNkQkoDYkOfTiFb/d8nlQtpCrsByOr6zH1ANhCNgxvzgAzlf
         FbGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Np2c0Q4BDShbRLU/V5l//Z0ajqNMYgtNQNvz5k3aXQ0=;
        b=JRv66aFO7fkJbzn1HeU+HEL1IxSYWoH3rIHhcxppNbkq7JTes4DSTJHl/jHbUNBGPi
         MPAE+yLTnxXeyiwXNMndjGtPktUR9goDb4CyIEwmfMul/gfvgI8qyhSPmWlTc1imqOhk
         S8bQ6TI7s+RiJNSEsE2qf2tLdwQ5vkYOVU+t/rY5CDInY6Q4sct7KeTixEtbLXVwx9OM
         BHiRZCgHAoIkwWYcoGuyMnYBE0MSA10MwVhyjtxc55Nq4lOd6Isi6jIRQJiKTDLkzzQ+
         AU4dQXRXyUVy0Xfs9R5xtC8fI3UqazxUoxDuhh0sdyBEnEDmoRhBD9GK0IU6Ww18xHfP
         hiZw==
X-Gm-Message-State: AOAM532262NyVBRu2bSG3cum769R4KzH9btWIa09q/NikcFvZ152Wkgx
        uxDOtEf0HC3koLysHm0oVoDjBlwIIArf4A==
X-Google-Smtp-Source: ABdhPJzbyjuBN6oiLpw/o7n3U+L8YKB69Mc7zWaZrJeQRHfTiiAnESi+lfspOUgbhXl4svSQLX17eA==
X-Received: by 2002:a17:90a:ec11:: with SMTP id l17mr25563pjy.104.1603989962354;
        Thu, 29 Oct 2020 09:46:02 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b7sm3625415pfr.171.2020.10.29.09.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:46:01 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] coresight: cti: Initialize dynamic sysfs attributes
Date:   Thu, 29 Oct 2020 10:45:58 -0600
Message-Id: <20201029164559.1268531-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201029164559.1268531-1-mathieu.poirier@linaro.org>
References: <20201029164559.1268531-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

With LOCKDEP enabled, CTI driver triggers the following splat due
to uninitialized lock class for dynamically allocated attribute
objects.

[    5.372901] coresight etm0: CPU0: ETM v4.0 initialized
[    5.376694] coresight etm1: CPU1: ETM v4.0 initialized
[    5.380785] coresight etm2: CPU2: ETM v4.0 initialized
[    5.385851] coresight etm3: CPU3: ETM v4.0 initialized
[    5.389808] BUG: key ffff00000564a798 has not been registered!
[    5.392456] ------------[ cut here ]------------
[    5.398195] DEBUG_LOCKS_WARN_ON(1)
[    5.398233] WARNING: CPU: 1 PID: 32 at kernel/locking/lockdep.c:4623 lockdep_init_map_waits+0x14c/0x260
[    5.406149] Modules linked in:
[    5.415411] CPU: 1 PID: 32 Comm: kworker/1:1 Not tainted 5.9.0-12034-gbbe85027ce80 #51
[    5.418553] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    5.426453] Workqueue: events amba_deferred_retry_func
[    5.433299] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
[    5.438252] pc : lockdep_init_map_waits+0x14c/0x260
[    5.444410] lr : lockdep_init_map_waits+0x14c/0x260
[    5.449007] sp : ffff800012bbb720
...

[    5.531561] Call trace:
[    5.536847]  lockdep_init_map_waits+0x14c/0x260
[    5.539027]  __kernfs_create_file+0xa8/0x1c8
[    5.543539]  sysfs_add_file_mode_ns+0xd0/0x208
[    5.548054]  internal_create_group+0x118/0x3c8
[    5.552307]  internal_create_groups+0x58/0xb8
[    5.556733]  sysfs_create_groups+0x2c/0x38
[    5.561160]  device_add+0x2d8/0x768
[    5.565148]  device_register+0x28/0x38
[    5.568537]  coresight_register+0xf8/0x320
[    5.572358]  cti_probe+0x1b0/0x3f0

...

Fix this by initializing the attributes when they are allocated.

Fixes: 3c5597e39812 ("coresight: cti: Add connection information to sysfs")
Reported-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 392757f3a019..7ff7e7780bbf 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -1065,6 +1065,13 @@ static int cti_create_con_sysfs_attr(struct device *dev,
 	}
 	eattr->var = con;
 	con->con_attrs[attr_idx] = &eattr->attr.attr;
+	/*
+	 * Initialize the dynamically allocated attribute
+	 * to avoid LOCKDEP splat. See include/linux/sysfs.h
+	 * for more details.
+	 */
+	sysfs_attr_init(con->con_attrs[attr_idx]);
+
 	return 0;
 }
 
-- 
2.25.1

