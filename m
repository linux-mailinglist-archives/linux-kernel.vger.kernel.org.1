Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5E2F8E5D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbhAPRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbhAPRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:38:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78854C061757
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:37:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so17920465lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxEgYGcQCZYKbRq3K2ngs08xWDWh3dTlzcMk23rneeQ=;
        b=ONxNoEUrPCGxB6M5IFJ2CYG1sWXTpgzhj4aK4aqkMTe61PAhVJloH06apvC5JWcFYn
         qQFHhWWe9VTPKnx28O/ZleRGHikVSkzCP+e4+/cYbbLnf/wy3ZZgp0f3ph6YvtxIEksu
         yYmJZTMSpIKT7RagJYoXr1jQ7gMgsYDnSC871szh7d8+3WYjo63Y7PSk4/NsSd3eau2C
         7vGY5Y2VE/0E5rXhD9Mcklt2BcvPfgwNJR3jHrYwrfaS55ry0tWwzLm9/laqA1xawliJ
         E/XKgcnyO1OB4Nd0xu35HGQdMLTIj7k+176Ne6oy4IrSwgqxuTFyow9EZvABxykXEP16
         uS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxEgYGcQCZYKbRq3K2ngs08xWDWh3dTlzcMk23rneeQ=;
        b=ptcg9MA0YW82bPw4dnTw0beM+en51g8p97rSdnbxipxPlkUmMeRiPW2eb9S5SmeOll
         WFFcU1qjY1UKmIzz2Mk1DhQcgQQ+b0ziDEusFXRKsdXrA8X0yIdW+lbdP8dFXFVlidyp
         kVWimO7Qt+KYwfp7+qYaIYId8m4I7rPLVNq/UWDbzmVaGFLqqU1KcC5EIcQBjIyy0y8j
         L+CNvyo98r16zriqURjZMD8i2SJHDuWwCVIyCbFtOVPZQnlBJ1mBHziolPLdFpmWAeeU
         eQoqlhi/yFXtMUBsPBSQgA2vrb7IXV6sOTGii0uqRdtcbLp/Ev1pW9bKr3M/+I7Tk1a/
         uLHg==
X-Gm-Message-State: AOAM531yYSmg5GN1YCwbmPioKTz8bahBtTMzumg3j93Es4XZ3KrGyn3W
        hNzq8bnUjvK8WYlA5cGVd5cl1g==
X-Google-Smtp-Source: ABdhPJzZ2isHzSByM6U4LO4hvKLBiheZz/goKXIzhuOgnnX0KV/FV43e81LoAdS2DlMtgwtKZsxjLg==
X-Received: by 2002:ac2:4431:: with SMTP id w17mr7598763lfl.223.1610818673989;
        Sat, 16 Jan 2021 09:37:53 -0800 (PST)
Received: from xps.lan (238.89-10-169.nextgentel.com. [89.10.169.238])
        by smtp.gmail.com with ESMTPSA id v7sm1134696ljk.60.2021.01.16.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 09:37:53 -0800 (PST)
From:   Odin Ugedal <odin@uged.al>
Cc:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        dschatzberg@fb.com, surenb@google.com, Odin Ugedal <odin@uged.al>
Subject: [PATCH v2 1/2] cgroup: fix psi monitor for root cgroup
Date:   Sat, 16 Jan 2021 18:36:33 +0100
Message-Id: <20210116173634.1615875-2-odin@uged.al>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116173634.1615875-1-odin@uged.al>
References: <20210116173634.1615875-1-odin@uged.al>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix NULL pointer dereference when adding new psi monitor to the root
cgroup. PSI files for root cgroup was introduced in df5ba5be742 by using
system wide psi struct when reading, but file write/monitor was not
properly fixed. Since the PSI config for the root cgroup isn't
initialized, the current implementation tries to lock a NULL ptr,
resulting in a crash.

Can be triggered by running this as root:
$ tee /sys/fs/cgroup/cpu.pressure <<< "some 10000 1000000"

Signed-off-by: Odin Ugedal <odin@uged.al>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 kernel/cgroup/cgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 613845769103..1ea995f801ec 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3564,6 +3564,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 {
 	struct psi_trigger *new;
 	struct cgroup *cgrp;
+	struct psi_group *psi;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
@@ -3572,7 +3573,8 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 	cgroup_get(cgrp);
 	cgroup_kn_unlock(of->kn);
 
-	new = psi_trigger_create(&cgrp->psi, buf, nbytes, res);
+	psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	new = psi_trigger_create(psi, buf, nbytes, res);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
-- 
2.30.0

