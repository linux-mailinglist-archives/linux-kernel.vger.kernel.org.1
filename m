Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874972C5D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 22:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391784AbgKZVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 16:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390293AbgKZVGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 16:06:48 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20CC061A47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:48 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id s63so2566611pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 13:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0+MlVHgmuEHbWu07QK81WMbFykiKW5F7ZX5m3RIClPg=;
        b=DloWhdhcF0VY/YJfNe8pyQgAA5g3RvjuT+ZivsFLlFJmc1DSt12brBDYYF6K2S9vRs
         bIG3P7cpKQxO95k+uLifbKHxhmdb0bIfmKZcvGM7/JATGLZp7ZROtLA6pBKb0IlKjcF5
         odJYvK/aOenHncUuNuMMAfaNV2SnFWTj7Kl0Q17u//Fa9nLgP4wQ9+nlCS4Y3ImdCr+E
         n0W8QMbll7ZgoZHTFnqjyN+B/KkkPpcU8iBOG0ohtbov03/RPor0xmkKEW6QscjMs2FL
         pkbXBUdL/yHdH4HMo8Mwq1ghyQYshLkyrwWIg5MVTd/47eixwMWfjPjegoRwLKoL3Mdm
         IucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0+MlVHgmuEHbWu07QK81WMbFykiKW5F7ZX5m3RIClPg=;
        b=QF1Hknkr2k7cvq4sKQEFUT6dLpUTfIYK3wXpXyKJUZqC25sh4EziPWfdj4LgFPlCEY
         EIphiaPQ/S4BqkqJbPBHBBZ7h9ugZ7w8QFLqrgkEj3J+5I5hMz3SCwcMkTdKOthxQ4l2
         wsIZzV4d6COKX/ndz4j/95MCd+VxlLGmbvWdOweqJh5/9zsNK4SzFXYzZdPus0mBiecL
         MWL4QLJ+XG8tmwKoS5HK2kRn/TVeycq1hc/yTbiICpPLCmjNRrcDeQ2uyFbBcdj8CNd7
         v/OzhTxsQM8c2TRbrcIpcX76yYh4zUfgqz5tdu2QRBH0nW99cSqDhBO9RX9HmIX+5fMM
         CM+Q==
X-Gm-Message-State: AOAM531/ALdTkv9L3IJ73nzT1S32ntJU5GiI4Ro/x+abN25hPT39vXaW
        jej7CcmM8HKmJYMIXEEwZ6KyRA==
X-Google-Smtp-Source: ABdhPJyWc2vH0J0kxI/PS5ohEzjOtAqAqTB+pwudnVkaIBTw5ila8JTaF/nhtFVMlQY6WuulXbfdUA==
X-Received: by 2002:a63:5322:: with SMTP id h34mr3777724pgb.95.1606424807829;
        Thu, 26 Nov 2020 13:06:47 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c203sm5612676pfc.10.2020.11.26.13.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 13:06:47 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com
Subject: [PATCH v3 04/15] remoteproc: Add new RPROC_ATTACHED state
Date:   Thu, 26 Nov 2020 14:06:31 -0700
Message-Id: <20201126210642.897302-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126210642.897302-1-mathieu.poirier@linaro.org>
References: <20201126210642.897302-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new RPROC_ATTACHED state to take into account scenarios
where the remoteproc core needs to attach to a remote processor
that is booted by another entity.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 include/linux/remoteproc.h            | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 1dbef895e65e..4b4aab0d4c4b 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -172,6 +172,7 @@ static const char * const rproc_state_string[] = {
 	[RPROC_RUNNING]		= "running",
 	[RPROC_CRASHED]		= "crashed",
 	[RPROC_DELETED]		= "deleted",
+	[RPROC_ATTACHED]	= "attached",
 	[RPROC_DETACHED]	= "detached",
 	[RPROC_LAST]		= "invalid",
 };
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e8ac041c64d9..71d531c64dfd 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -403,6 +403,8 @@ struct rproc_ops {
  * @RPROC_RUNNING:	device is up and running
  * @RPROC_CRASHED:	device has crashed; need to start recovery
  * @RPROC_DELETED:	device is deleted
+ * @RPROC_ATTACHED:	device has been booted by another entity and the core
+ *			has attached to it
  * @RPROC_DETACHED:	device has been booted by another entity and waiting
  *			for the core to attach to it
  * @RPROC_LAST:		just keep this one at the end
@@ -419,8 +421,9 @@ enum rproc_state {
 	RPROC_RUNNING	= 2,
 	RPROC_CRASHED	= 3,
 	RPROC_DELETED	= 4,
-	RPROC_DETACHED	= 5,
-	RPROC_LAST	= 6,
+	RPROC_ATTACHED	= 5,
+	RPROC_DETACHED	= 6,
+	RPROC_LAST	= 7,
 };
 
 /**
-- 
2.25.1

