Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 269922C5D50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391448AbgKZVGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390945AbgKZVGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:51 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B40C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:51 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id b6so2607888pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cn0y91qgOfL4w4qQFVTrLAkaEhIq3ZfS/ulvB63rzoI=;
        b=QlDvjkwik21FijsRtONm2P9qN6a6wBdU/grMzD2J2jiJj/XuQ/aKJmTAUuMakW93Ku
         fo7b+Ok97fnZqfQ+ev5uBT1A8xx/9Jtz83ZxwYRhlOW6YmmcGOBECeDGdS0DZRna4CPT
         IMwXyfPOOGmh29XJPBhfABvPhe7nxMuAfwPbY9JMPbtn814OSdyX6jnOhPlmPsqPsxvJ
         8o43/+W39A6UN2V6CAgf+E+d1aWwiWeubG43kfSnxgCzouK05Ti6vhVugIN9FNGbajWt
         KZd5yKljQPLJ3dzJtPT5yJgTvomsjkm82sw+MnP5wq+YpGHI37Wo0gOD/yGHTqC+7vnm
         VX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cn0y91qgOfL4w4qQFVTrLAkaEhIq3ZfS/ulvB63rzoI=;
        b=ImRTkvbjOrBKRIzjRcMLK4g3W7JJmIS5587T7cYcaYkmQOEBmfX6wpCT2kXX6lZtYL
         hKfOXvqp8cenVTUYw7Df4ENovYpNbQGmYzpuHuFCHrOZPgN6xbu76V8iLip1Xl9374YI
         TSPMiK1CPfB4xb+4ZEwUJ16iiEXgnkLgvg2NwnxXjbXjv0WLMR3t3YUbUdX9pj2FCJBX
         SGkAH1tVs1CPtSozL46oc1ix2Pw80h7oeqNN6+feuaGB6SJXP389sn4cgPEYqaZig3/3
         ubYRTkoN7s7yRq4xDxLW3GGRUISoZ2FMSt0QfSZGsPg/TaNSZg9lxEPuFzB+8T+tAcW9
         3KRA==
X-Gm-Message-State: AOAM533o4BzudQxeNPHHGE8jXlWR5Y6aNg1B1+YJafeySpLGp8QFwlP8
        AON1nn0oXIxtziggufQ1GnHKOEY2o+VQu4dF
X-Google-Smtp-Source: ABdhPJyhivsSapK8gAatVawYRRkUxIj9FAAt+9+tcM5ZiZGitUkHMEuc1SB7OPVJz2qznRoUzYy9kg==
X-Received: by 2002:aa7:93b6:0:b029:197:db02:e31a with SMTP id x22-20020aa793b60000b0290197db02e31amr4049269pff.5.1606424810847;
        Thu, 26 Nov 2020 13:06:50 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:50 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 07/15] remoteproc: Add new detach() remoteproc operation
Date:   Thu, 26 Nov 2020 14:06:34 -0700
Message-Id: <20201126210642.897302-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an new detach() operation in order to support scenarios where
the remoteproc core is going away but the remote processor is
kept operating.  This could be the case when the system is
rebooted or when the platform driver is removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/remoteproc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9be112b5c09d..da15b77583d3 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -361,6 +361,7 @@ enum rsc_handling_status {
  * @start:	power on the device and boot it
  * @stop:	power off the device
  * @attach:	attach to a device that his already powered up
+ * @detach:	detach from a device, leaving it powered up
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
  * @da_to_va:	optional platform hook to perform address translations
  * @parse_fw:	parse firmware to extract information (e.g. resource table)
@@ -382,6 +383,7 @@ struct rproc_ops {
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	int (*attach)(struct rproc *rproc);
+	int (*detach)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
-- 
2.25.1

