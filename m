Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791D62DE842
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733043AbgLRRex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732903AbgLRRec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:34:32 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9BC0619E2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:42 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id n10so1733961pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UE369EIBZVX7NEKYpAqFRWbqVEboyiDmoTqg7mEP3ho=;
        b=CjxlpfgFxYohq4V6dQAABJ7LtWFo36J+n71FUwHVblWZg4woCWLtdlLVEda0nM+ykH
         LW8zzer3KscVhQHeDYXyEPQUjcaj8tsmHwlw6jOx9VeoUg9nt0Drmr8CISbSkuSmdght
         huZOgv0vSZ1Sr4JdC5la9BWhQcYL3pM1URaNJYb2eqeti+QiTEKvKQ0RWKcuOKrrxhBH
         X9R9+v2CoHxRjz6UEumU3MCNW8b1gynT1C7RoDlupJ6srcEKXGhuzz7U/vxGWjbNS699
         ZOQE/C50/hIcZR6PgPhS6LWvlPIbxb3BOC11B3abtkswhHEfMniA7RW7Ov5O2WpAqD5v
         CGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UE369EIBZVX7NEKYpAqFRWbqVEboyiDmoTqg7mEP3ho=;
        b=rput+8exAIhrwGxmLQXjgcfHszwxnWLlyLyyLnMJ7+iDl6H3qFsCojTHCTDaZitk9U
         4gB/8cntWgiK/4vg7n3Nd2zi4qE7aTpihOTVxtqcjyBAIGe3e0BrJvDhoGd4jNOkxSHs
         Pb/KfSyqPM5i5TCW0XdBvNmA6SQe5o0rQA48sma+Dk2zKnNX2co13x2VxijKXH+jxLCE
         H/dbwWO/V0aPKd8hqWHgkfdg/X321byYrI9tDYanmTgTnJp8MF/dMExZ0/KEkulZV797
         qRr+vKYhRjqKexAuwa0TSfxvMz71FlyH8dAaWsZIIfW8BLwT+g7AHRTF+pPT7rrdcTNZ
         IUlQ==
X-Gm-Message-State: AOAM532/zL4g0hCg8ZDNCDCK1X/RzoIEMOhlwlZ7eOrLJkhKbVdzKxB/
        mp/aMauM9nvYIERsPdCSqnr8yw==
X-Google-Smtp-Source: ABdhPJxWYQu1xh9x6SeT5oLCldmQ1WomSeYC9AMjEZj5v07RYMoFJGl3QXAxmlWMnISzyZnPS/qXYA==
X-Received: by 2002:aa7:9312:0:b029:19d:fa90:3f42 with SMTP id 18-20020aa793120000b029019dfa903f42mr4887642pfj.18.1608312761769;
        Fri, 18 Dec 2020 09:32:41 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:41 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/17] remoteproc: Add new detach() remoteproc operation
Date:   Fri, 18 Dec 2020 10:32:21 -0700
Message-Id: <20201218173228.2277032-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
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
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/linux/remoteproc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 257a5005f93e..9bb34c3eb847 100644
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
@@ -384,6 +385,7 @@ struct rproc_ops {
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	int (*attach)(struct rproc *rproc);
+	int (*detach)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
 	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
-- 
2.25.1

