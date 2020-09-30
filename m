Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73227E5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgI3KCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729225AbgI3KCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:02:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3850CC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:02:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so865657pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 03:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/QT6UypySF4QeQQr1NJ9OfElfsrvGkWJzbgC4+/Alo=;
        b=p4QY1lYxYus8DoK0qaFTT6mMjnoop8EVlOX9itVvWd7xqWub68H73qSHcPtRn6phEt
         yI7QEJfoaU+R0IY6u7InBJ1oAlAfml8zQodUrN5QM2tpVEn75NtvMla5IJ8aqP5g8PKz
         qtV4XjceZdIo53BFoLthMbvzyclquMmhTVutbimWiC37D/RYByHrEMYW8cBw8Gqcx+q6
         UGzjbuI8pqHD/KMa2fZR/HmfnvprUBRmYkvSh9g3dA68R85c4Wh45oUlG9X+xJipE0HI
         Gj8bJ1hR7a2ajHUUCyKylRGTfSbwQWWLTaiWR3c3vJYlkGHDOuvFJP+t7p6whDEZCSkM
         JYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/QT6UypySF4QeQQr1NJ9OfElfsrvGkWJzbgC4+/Alo=;
        b=CISlREnb8FkoEeXMeUkgv2JNX5Gyt44mViKX4WjaXHKjtC86VeRcDTjokGQB5TOvFB
         jrpgebUoS1PqVhjSWUA25BuiJKP9JCR/L0sIYhpp47XCQlC230Sl3YQ65nR0cymlpi0K
         YBWgQEY14ktJ77eSEZ37wW8ksNlGOGzy/BOC31hDHNN7kt8yGvPZzQsumJwqpeaqz9B7
         ufZeMtexJO+QwN+YgGzJNEaIJo0/nrOxXeBzhofdH/aDDiQpNNfkDDuMwnLUOhVKolsG
         rUXDTi2hDWaZ6oeYqxlKeVJXchtxUz7+HzsMZVWXrONnNTBI2w61vRg7rI3ZbbdaM7uh
         JLDw==
X-Gm-Message-State: AOAM531zTdUpNF5SlBoj/1vGxBOuOWidQTHN4E1DCleztfNb4rbO/19L
        Z/Vvoe9hUO650Ks19UOHD3fxCA==
X-Google-Smtp-Source: ABdhPJyvGQ9CBpxV3+QWg19XnalSjj3UeiqYh1rqmQa40CMiUXBXVJIhVxkgqmDzYwF33IWtVYqEEA==
X-Received: by 2002:a63:786:: with SMTP id 128mr1554506pgh.69.1601460139751;
        Wed, 30 Sep 2020 03:02:19 -0700 (PDT)
Received: from localhost.localdomain (li519-153.members.linode.com. [66.175.222.153])
        by smtp.gmail.com with ESMTPSA id b2sm1890002pfp.3.2020.09.30.03.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:02:19 -0700 (PDT)
From:   Jun Nie <jun.nie@linaro.org>
To:     stephan@gerhold.net, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Cc:     shawn.guo@linaro.org, Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 2/2] soc: qcom: rpmpd: Add MSM8939 power-domains
Date:   Wed, 30 Sep 2020 18:01:45 +0800
Message-Id: <20200930100145.9457-3-jun.nie@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930100145.9457-1-jun.nie@linaro.org>
References: <20200930100145.9457-1-jun.nie@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the shared modemcx/cx/mx power-domains found on MSM8939.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/soc/qcom/rpmpd.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index daeea119d48a..3887d57a5a15 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -136,6 +136,32 @@ static const struct rpmpd_desc msm8916_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
+/* msm8939 RPM Power Domains */
+DEFINE_RPMPD_PAIR(msm8939, vddmd, vddmd_ao, SMPA, CORNER, 1);
+DEFINE_RPMPD_VFC(msm8939, vddmd_vfc, SMPA, 1);
+
+DEFINE_RPMPD_PAIR(msm8939, vddcx, vddcx_ao, SMPA, CORNER, 2);
+DEFINE_RPMPD_VFC(msm8939, vddcx_vfc, SMPA, 2);
+
+DEFINE_RPMPD_PAIR(msm8939, vddmx, vddmx_ao, LDOA, CORNER, 3);
+
+static struct rpmpd *msm8939_rpmpds[] = {
+	[MSM8939_VDDMDCX] =	&msm8939_vddmd,
+	[MSM8939_VDDMDCX_AO] =	&msm8939_vddmd_ao,
+	[MSM8939_VDDMDCX_VFC] =	&msm8939_vddmd_vfc,
+	[MSM8939_VDDCX] =	&msm8939_vddcx,
+	[MSM8939_VDDCX_AO] =	&msm8939_vddcx_ao,
+	[MSM8939_VDDCX_VFC] =	&msm8939_vddcx_vfc,
+	[MSM8939_VDDMX] =	&msm8939_vddmx,
+	[MSM8939_VDDMX_AO] =	&msm8939_vddmx_ao,
+};
+
+static const struct rpmpd_desc msm8939_desc = {
+	.rpmpds = msm8939_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8939_rpmpds),
+	.max_state = MAX_CORNER_RPMPD_STATE,
+};
+
 /* msm8976 RPM Power Domains */
 DEFINE_RPMPD_PAIR(msm8976, vddcx, vddcx_ao, SMPA, LEVEL, 2);
 DEFINE_RPMPD_PAIR(msm8976, vddmx, vddmx_ao, SMPA, LEVEL, 6);
@@ -242,6 +268,7 @@ static const struct rpmpd_desc qcs404_desc = {
 
 static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8916-rpmpd", .data = &msm8916_desc },
+	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
 	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
 	{ .compatible = "qcom,msm8998-rpmpd", .data = &msm8998_desc },
-- 
2.17.1

