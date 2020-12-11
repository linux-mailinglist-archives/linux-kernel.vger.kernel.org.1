Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFE32D77FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406303AbgLKOeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406255AbgLKOcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:32:20 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A33C0611CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:30:47 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id t22so11133134ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9s2KpvaYSw4t1bCR1j0Xjb/I6S5cN8m0t3IpN4+bDAo=;
        b=kJPwUO5UuwXNyW/ebEs5EvhbjUqSE88TXvhu4eiG8sLKbdu7OKM74z1RwuRjjeHkii
         qavyLXpEpZKdIcu70f4Qfh0M0ctJAaM2Er8ozd93xT7AbXsYrCIlID+8Bk9nI/5zVHQe
         D9e/6zcvjh27WV20GIAIP0a9PQVVyTo5v6udkGqE2v9GN+JqUgFS0+lAZlTr8qZO7Mnw
         eAXID3uJk+ncUCJ3iBAjVfZ3qlcT8OfOpVnXyEGlwDV52a2ztWeIcAle96h387AUQDmj
         zSVoLQLspaeJZc48LdZFKWGXrOy/1jwTK6I7vfAO0/pJ4PoQCMuQ/IdsTdeKD/v9Gf2g
         u/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9s2KpvaYSw4t1bCR1j0Xjb/I6S5cN8m0t3IpN4+bDAo=;
        b=PbTf13QCPdooVNNhaVumFRMlEq8JHa4y8kRWjCcF++UH27In6Hgs+/80YYCzX2gh+R
         9EZtVYYHhLmHMEe+BPYN9D1rO/bfzFUfJvmP41g4Ilaa5WBwEyz+J+KelEI4IbEXp//A
         vlWSKLzJbI8ClIqV8QoxuXD2IxdMrL+lL1Vskxed89FNeU1OSKbmGesTmVTNMbiiofC0
         IfH4/F/bjn4v0YFyCtSWlEoYIYQLS0dR0qCzJXSSkXdniE2qUB51ncGSm4l5ZKFmsMxW
         mFP2m52pwBtD8l9Qm+xenD4/ekwIyB4ZfZBgbmQY1dYdeUW8wkiW/nyjswmHO64Jo7we
         PE+Q==
X-Gm-Message-State: AOAM5327D93ZZa8ZDOW8mp1bkSPi0MiIZqasV520BUOUkyN+t0LLuHsz
        x3npchCs5WlmO9D9x2QxEPCqlg==
X-Google-Smtp-Source: ABdhPJxu2ieL2UMJe+yZjK0vuMFzKjPzYa/gKjQZ3NQtKKKDAMdQw0BwL0n2azu5GmmNfDNZBs1c7w==
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr5454185ljk.358.1607697045950;
        Fri, 11 Dec 2020 06:30:45 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id x26sm906491lfq.112.2020.12.11.06.30.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 06:30:45 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org, s-anna@ti.com,
        ssantosh@kernel.org
Cc:     grzegorz.jaszczyk@linaro.org, linux-remoteproc@vger.kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, praneeth@ti.com,
        rogerq@ti.com
Subject: [PATCH 3/5] remoteproc: pru: Deny rproc sysfs ops for PRU client driven boots
Date:   Fri, 11 Dec 2020 15:29:31 +0100
Message-Id: <20201211142933.25784-4-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201211142933.25784-1-grzegorz.jaszczyk@linaro.org>
References: <20201211142933.25784-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRU remoteproc driver is not configured for 'auto-boot' by default,
and allows to be booted either by in-kernel PRU client drivers or by
userspace using the generic remoteproc sysfs interfaces. The sysfs
interfaces should not be permitted to change the remoteproc firmwares
or states when a PRU is being managed by an in-kernel client driver.
Use the newly introduced remoteproc generic 'deny_sysfs_ops' flag to
provide these restrictions by setting and clearing it appropriately
during the PRU acquire and release steps.

Signed-off-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 drivers/remoteproc/pru_rproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index cc2e585778b1..bfb53967edda 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -228,6 +228,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
 	}
 
 	pru->client_np = np;
+	rproc->deny_sysfs_ops = true;
 
 	mutex_unlock(&pru->lock);
 
@@ -258,6 +259,7 @@ void pru_rproc_put(struct rproc *rproc)
 
 	mutex_lock(&pru->lock);
 	pru->client_np = NULL;
+	rproc->deny_sysfs_ops = false;
 	mutex_unlock(&pru->lock);
 
 	put_device(&rproc->dev);
-- 
2.29.0

