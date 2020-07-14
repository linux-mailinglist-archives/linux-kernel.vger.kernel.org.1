Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0F821FE1D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 22:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgGNUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 16:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbgGNUFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:05:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD1C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:05:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so7484269ple.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QJEcAvXCkMubZ5CvQAwW4/233WmH+zu/CCD6+/Cfr60=;
        b=BIyPWwdnQqdLgzRx9cNGys4K4Pu3bhZEesGNSVDGZxDEXs2zbZQQZyhbbHp2epIS96
         J+nEoi/pULu61ZtxPYE3Bfjbka5SW/KZjZIoaA3Y+A/U57Rncged53Djhc3g2bXY6z3H
         +85B5dHbMWroWGxKepDR5lOKxzqOL6RdhTUTPoDSf+nDjkp+uiaB+nd1Iog/bnQsOaqd
         9n5JtYVde8Q6jaFb6CEwdHPRFaHg9v1l06V5Qhs9nPHo4Y1PjxI1jl0iVf8K6pgr/eOM
         FM5kIjQkmEbSCe2XJ5lfaGZhvPlk+0xUNhgTmz4ny67/zx5JSFx8+5ml4S+o9Eq6DRc+
         LOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QJEcAvXCkMubZ5CvQAwW4/233WmH+zu/CCD6+/Cfr60=;
        b=XzzKvJNX3ZSo3Fttver4MSXKJEFYbC4USRm88yHOxAVDf31R/B0viLgI0sUi3KZ0zj
         j7RImTPpCu1Ea5YWjjg+VAypysbh/Qhh/l7DyNTSlj5HElUcK9ODE7gbhWiphqStuLMg
         dlpWmxeDS+HQwp44bBOgHdCklx1cvjnHIj5aMEDi6JVET6b+EY7zGn/oiZeWMChf3Nyg
         798zwxnprm95pUVXJxijC1xhFAjPYpmJ2e5LBHUpzOjGdk/UU0QFpB0gxtknTGRYP87n
         1767E6a/Da2rc71trZN/vsldkJvnAsuFt2Vo5lly2hczUlyha0K02FnJ5xAyJB8fViB/
         jSWw==
X-Gm-Message-State: AOAM531EqZBv79SmKr4w5kqe0SoEbmQLpHojAFewuUeL4gCqcK3JILVN
        1uWoRqeNm4vvUF+xFwbTrycIpw==
X-Google-Smtp-Source: ABdhPJwaKsSwOg/f51cv/yU6D2+O0bNi34srVgzYHBWsLtjgqOy83hgxLW3gTKAwMRf8Q/DDyFSVvQ==
X-Received: by 2002:a17:90a:3684:: with SMTP id t4mr6142014pjb.91.1594757100594;
        Tue, 14 Jul 2020 13:05:00 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t13sm3262959pjs.17.2020.07.14.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:05:00 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        arnaud.pouliquen@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v6 10/11] remoteproc: stm32: Introduce new attach() operation
Date:   Tue, 14 Jul 2020 14:04:44 -0600
Message-Id: <20200714200445.1427257-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new attach function to be used when attaching to a
remote processor.

Mainly based on the work published by Arnaud Pouliquen [1].

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 882229f3b1c9..7145cd49616e 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -460,6 +460,13 @@ static int stm32_rproc_start(struct rproc *rproc)
 	return stm32_rproc_set_hold_boot(rproc, true);
 }
 
+static int stm32_rproc_attach(struct rproc *rproc)
+{
+	stm32_rproc_add_coredump_trace(rproc);
+
+	return stm32_rproc_set_hold_boot(rproc, true);
+}
+
 static int stm32_rproc_stop(struct rproc *rproc)
 {
 	struct stm32_rproc *ddata = rproc->priv;
@@ -525,6 +532,7 @@ static void stm32_rproc_kick(struct rproc *rproc, int vqid)
 static struct rproc_ops st_rproc_ops = {
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
+	.attach		= stm32_rproc_attach,
 	.kick		= stm32_rproc_kick,
 	.load		= rproc_elf_load_segments,
 	.parse_fw	= stm32_rproc_parse_fw,
-- 
2.25.1

