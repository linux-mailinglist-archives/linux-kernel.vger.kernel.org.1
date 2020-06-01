Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C011EA8D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgFAR4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 13:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgFAR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:56:07 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8DEC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:56:07 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id fs4so145434pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89+h/plDTY4mDzCs1rYHBGU3MZW5Lf4AJft/Geveaac=;
        b=UJW1vl1f7dpO7gbFKlkA2zgpME8H2E23tNzkiGS91xT++xLFPjRvKMz/e7Fk6+RiEZ
         SZ/u7rWEuTf5R3lmi0b3QFLZFAPKNAk7QXHlk+frMOiFY3rCKSGekRtMnNnXBlCifqtP
         NDmXSKfTtFPGKM2RnN5jwWvCVdKJHG6QuX2wubSS+lZ1QSDbwpgqa1dlTDoRi7YoU9Eo
         /HJMIhJ+m7oDHSnT9WXZb8NfUvTw8JncNjwxf3jr5Gb4RNaGBAihbRDEFwfQ3/zvtgmM
         wtKgJUJkaxxQk1MX+XnoMHlfFlNc1yadikx5AC9P4nzS9lTncTJpR8CWq3KMEvdz9wmg
         5SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89+h/plDTY4mDzCs1rYHBGU3MZW5Lf4AJft/Geveaac=;
        b=pflA6p30cjy11d5ETbxwUEhndKWOeR3ecYbpDCvOofoAgdjCcXnHZ83n3CmYISxXo/
         NZk0hxOK/xg7q2lsWKp1T7lJEffd9sip/S7ElgCQ6YM/Pns2AXvDLdsgWaP/guLgvpjD
         QIKEoWnDAEk0xjM14gpZ0aD9dA204RhGjzmTRjzyPhzMTTgpv2mA3Yi7xKfbAa7w+hO8
         9tVYq55mfVef+mQIfoRIQR7i/NvL44jWmJz/QdHWYWpZ3Q0mzs23aP82L5DEhYhunE+m
         lBrH8dH1W0k6OkuVKVKa5QRsyL1ugrOmNhNGs5+eZEaaErE6OEaZvRmNnkgr6eg9OmFG
         ZKhg==
X-Gm-Message-State: AOAM533N3JTTCD23PvPThM5PiL0acgVLxZsQigTar7EPKMGI920qLGKI
        bIB0PTuc1FphzU9HaqzmuqKOXQ==
X-Google-Smtp-Source: ABdhPJypHYDsLPAIbS0JYVfQMOvatKvrrQns1EzAP3MAD0yNOfhUMy3DV32cG6rH3piOQuj4WeHadw==
X-Received: by 2002:a17:90b:693:: with SMTP id m19mr590592pjz.125.1591034167244;
        Mon, 01 Jun 2020 10:56:07 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id p7sm64771pfq.184.2020.06.01.10.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:56:06 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     loic.pallardy@st.com, arnaud.pouliquen@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 10/11] remoteproc: stm32: Introduce new attach() operation
Date:   Mon,  1 Jun 2020 11:55:51 -0600
Message-Id: <20200601175552.22286-11-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200601175552.22286-1-mathieu.poirier@linaro.org>
References: <20200601175552.22286-1-mathieu.poirier@linaro.org>
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
index 7c8789164af7..77a20a638e0c 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -459,6 +459,13 @@ static int stm32_rproc_start(struct rproc *rproc)
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
@@ -524,6 +531,7 @@ static void stm32_rproc_kick(struct rproc *rproc, int vqid)
 static struct rproc_ops st_rproc_ops = {
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
+	.attach		= stm32_rproc_attach,
 	.kick		= stm32_rproc_kick,
 	.load		= rproc_elf_load_segments,
 	.parse_fw	= stm32_rproc_parse_fw,
-- 
2.20.1

