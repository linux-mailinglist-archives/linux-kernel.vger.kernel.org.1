Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A444217A82
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgGGVb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 17:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbgGGVbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:31:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7EC08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:31:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d194so17233476pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h12JhHvSO+bmX99ezv3yaLnOJmMzfHeXrbHb3WDJUWc=;
        b=jic4pcGQoE5bbkcXOsIMdiKLSg+ok5snqmEkp5W4cedeKRPsSjWdR8qXyBYYMrKUF0
         GLsR17gvZ6kXQCC0uXBiAtGOhoarH5KfTlv/VetDPfX5sRclATaqgwTDRKqMdXoUhtvm
         mKDrD4/RJ0tTb8iUM4CvT7eh+5Ow7lvNFnioN78naLDRKOFpqSDhse86yKVoR/h2G2JZ
         w1SQ1wm9HBVLvIeUDuRVjPkHwGmr7FTXvs5ki2MMdV8dGNPRIJv2aK2JsupuUCv16Fc2
         /+ZcrQybwx6s/JU5QDnlzcmTtewaZoZuab1BP/DuJM6lJtAv+uLOUy7zdBLvGUDgWVXd
         c+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h12JhHvSO+bmX99ezv3yaLnOJmMzfHeXrbHb3WDJUWc=;
        b=DTa/ExOUHjoHmi1zhcjA8Ck902WqBoumxUfwrO5sdrzBLXniJg66LsflaPLhJBZlN4
         mS+uIMj1r6a4JATJjczbmRDgRCk6CJBu7zugw4+osBiYTS1yUDlBSIUfEuQc7r+LnulQ
         aaJQhdW0fiGQkAE37LZ5dkuCskKYHY0M+H8dxxiCD04LvZhIxlmh1IHHpMJL8nzL0Zoi
         GiTu+aGcLO0t07y5Yor+JvXdycVB8/0+iaXZt2u4qVxt8Qd5iCkGAgxurVfJ09LNOytu
         7lGTTJTXV6OYDomwjtthNJYEdpPyKR5PEGnhmiFX23m9tRSoW/guyiW7wzAE2DcX3caB
         V1lg==
X-Gm-Message-State: AOAM531LvO6wyess+M5O7OOTl53O1FqwXE7boB/732ESkFiKrj4CB9ZR
        Gruo4728c+k6SAgKXhpmWmd9PA==
X-Google-Smtp-Source: ABdhPJxgyaQh4mTEIOmvaKPyRLDgsJvLs8cVkBxus9NiBgbjD9jwfunvRpeoL0T5pYTI5kAYPoc2ow==
X-Received: by 2002:a62:1d0b:: with SMTP id d11mr53080485pfd.1.1594157483189;
        Tue, 07 Jul 2020 14:31:23 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o128sm23560832pfg.127.2020.07.07.14.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 14:31:22 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v5 07/11] remoteproc: Make function rproc_resource_cleanup() public
Date:   Tue,  7 Jul 2020 15:31:08 -0600
Message-Id: <20200707213112.928383-8-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707213112.928383-1-mathieu.poirier@linaro.org>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make function rproc_resource_cleanup() public so that it can be
used by platform drivers when allocating resources to be used by
a detached remote processor.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 3 ++-
 include/linux/remoteproc.h           | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 099c76ab198f..6e0f985e9c9a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1271,7 +1271,7 @@ static void rproc_coredump_cleanup(struct rproc *rproc)
  * This function will free all resources acquired for @rproc, and it
  * is called whenever @rproc either shuts down or fails to boot.
  */
-static void rproc_resource_cleanup(struct rproc *rproc)
+void rproc_resource_cleanup(struct rproc *rproc)
 {
 	struct rproc_mem_entry *entry, *tmp;
 	struct rproc_debug_trace *trace, *ttmp;
@@ -1315,6 +1315,7 @@ static void rproc_resource_cleanup(struct rproc *rproc)
 
 	rproc_coredump_cleanup(rproc);
 }
+EXPORT_SYMBOL(rproc_resource_cleanup);
 
 static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index cf5e31556780..7c0567029f7c 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -610,6 +610,7 @@ void rproc_put(struct rproc *rproc);
 int rproc_add(struct rproc *rproc);
 int rproc_del(struct rproc *rproc);
 void rproc_free(struct rproc *rproc);
+void rproc_resource_cleanup(struct rproc *rproc);
 
 struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
 			       const struct rproc_ops *ops,
-- 
2.25.1

