Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE7A2DE841
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbgLRRev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732918AbgLRRee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:34:34 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439EBC0610F1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:49 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p18so1735439pgm.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4WpCps/dmzg/nEPpmlNW78KzWKD4Zyq8EXXFVytS5s=;
        b=qmmI9vTp0A2LE/Vso7i2ivHcoYnFAy8QizlK1mNtLII2LdbDpKQg5kY27MrV9Ls3/Y
         JyNb4oQdv0aiQJnfE7G98FhNqpRsASuQI4IUzozKulAKGc6DiVsC3QuqAAW5MXtF10AJ
         WCvAlTsla+IZKPRiE6zc4BtjDc+6oag1IFC/7zvuQixp0Mbed8knKsbd8iD0Lio97L1E
         b5jyOCsr9zHZakNUZPDatWU+lKkkv8Vtojlt04oZy+yT40wy9jLIV73vRf8G9GiNwIwJ
         JZcIZjeywEqZ3Rchhzf43yBx8HFDCqgL61qhetW/1KdZGja12BnDKd5GQuqzXo23D5/g
         rAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4WpCps/dmzg/nEPpmlNW78KzWKD4Zyq8EXXFVytS5s=;
        b=exo5liP7451Aul2FrdeZe7lepC3U0TBHiCTy3j99QOa1Ls7Xyi3eQ8f2Hs0jXhT1fm
         CnH59lvH8srqTvUweft7ebGNMa0POBvRyW/yJFJ4ymExHuw1ODNykV/gZtH/1TUsodC7
         E7RsZwGZUZf61z8qpnhBqefqNJG5a3a6H1CPTU6NqoTTsyXOcCSust6+2V65xAvMQAiZ
         E5qcwjAwwCsVIKW4w6EV8UZMuf8T+I44yJsu7RaIqPHX4moBgLWM5lQ0p6isugSR1uix
         +E8G5HDqSlxP5PxLUkcopsU56iHzVPgiAJOVNSBXdg7yktOCXPgBs0byYC08oHpJO3YU
         Ur4w==
X-Gm-Message-State: AOAM533TSHrDcWk+xvjgNl2qPAk4V/NTvvMbNCXNFV6IGsbp9kwjJ/i7
        GfC3yg3chxesxSfK+X7W1eyb2Q==
X-Google-Smtp-Source: ABdhPJyHj7Z3LuRnodZ5FhdffYdSVbNG32Tpe3WzUH27PGKZDRQ91X4sBrPpU/k9Pk0GJ4SoCfwfiQ==
X-Received: by 2002:a63:5c18:: with SMTP id q24mr5026246pgb.411.1608312768810;
        Fri, 18 Dec 2020 09:32:48 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:48 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/17] remoteproc: Properly deal with detach request
Date:   Fri, 18 Dec 2020 10:32:27 -0700
Message-Id: <20201218173228.2277032-17-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the capability to detach a remote processor
that has been attached to or booted by the remoteproc core.  For
that to happen a rproc::ops::detach() operation need to be
available.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_cdev.c  | 6 ++++++
 drivers/remoteproc/remoteproc_sysfs.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_cdev.c b/drivers/remoteproc/remoteproc_cdev.c
index 61541bc7d26c..f7645f289563 100644
--- a/drivers/remoteproc/remoteproc_cdev.c
+++ b/drivers/remoteproc/remoteproc_cdev.c
@@ -43,6 +43,12 @@ static ssize_t rproc_cdev_write(struct file *filp, const char __user *buf, size_
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (!strncmp(cmd, "detach", len)) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognized option\n");
 		ret = -EINVAL;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 298052c9d068..ea7b067fe89a 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -236,6 +236,12 @@ static ssize_t state_store(struct device *dev,
 			return -EINVAL;
 
 		ret = rproc_shutdown(rproc);
+	} else if (sysfs_streq(buf, "detach")) {
+		if (rproc->state != RPROC_RUNNING &&
+		    rproc->state != RPROC_ATTACHED)
+			return -EINVAL;
+
+		ret = rproc_detach(rproc);
 	} else {
 		dev_err(&rproc->dev, "Unrecognised option: %s\n", buf);
 		ret = -EINVAL;
-- 
2.25.1

