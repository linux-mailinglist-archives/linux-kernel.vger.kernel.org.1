Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3986A2FDBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436594AbhATU7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbhATNpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:45:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E66C061796
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:44:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id c12so4623662wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PC2sXSUCVtuCTR4UN7c8iTkNydyknx8hb/BTqhYKVYU=;
        b=OF+20g/AOhPzMiHuDvvPOMYuNdVUXRubpjuj9Djn9oMawVZSIn05C/NOQpo65bF/j4
         VoOKWioLfgMP2fGtWZSxPRLTLa9fMetitoZrOYwn5+5HGobSuL55FRZ28PhF/ZcMJcce
         cOyf/AwuQf/Fi0lVppgk0ibjDIF3+m9f9zi9LKv/8ZprfEMoJqnFfshG4+fUYsf8Tu4F
         aGGvaMJoJLIm7pS27RP2fsLKiAhMdL5B40iFm7+T4IE85Fvn/v9lZF01TS/jZm0sx6T+
         2xT+DL9D82EFxsqAvcsDDR1FN5ABXaf7VYD3WLhMKZRKGzdu4Ty+hN6CFagBm5NAL9IS
         sOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PC2sXSUCVtuCTR4UN7c8iTkNydyknx8hb/BTqhYKVYU=;
        b=OpNpi8OOaUviDpCUSNuqaE2HeezYjxdjJXIyMbFiiMahObUyO6wdgIrrf/NjiBhGmJ
         gg4xKEebh95flSCSe96EnA0uadRQXWKZJbYOhSwimgr+O5LgNqTvMP6/Rr+1/ykuSmCt
         TpTVULCkv97oTSgWPZxpKayENjQPVOR3ee5otqVtiAEOmne1FvtqKWt6eOiy8K3QCx0E
         To4W7w5gHM7T+FlqZJr4mX2FCM4EnYsK9+QlHHO4jB78qdplKp8udm2bt0IowG+ng7P7
         ursetWCOOWvZXx01nXk+vzTn7iZyKT1d7s7M8X9ZD5q2wR/ZKCm4TSjm2++FVKG7daEB
         MISw==
X-Gm-Message-State: AOAM532XIeh12EzEyHgkzXK8BqYkFKYDee+qAFammW8z2wtuEbEsGhlK
        gzJm2FcykIMZq5FXddU/6EM5nw==
X-Google-Smtp-Source: ABdhPJxD+hb0vCaHsREVFpTYiUkhq49dk1PVXKcJul0uJwthT5C2DlTZR9SfSKpYxYVofTDUxmIIXw==
X-Received: by 2002:adf:8503:: with SMTP id 3mr9560207wrh.56.1611150263919;
        Wed, 20 Jan 2021 05:44:23 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:93b3:1f80:ae7b:a5c6])
        by smtp.gmail.com with ESMTPSA id t67sm4224075wmt.28.2021.01.20.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 05:44:23 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        robert.foss@linaro.org, todor.too@gmail.com, mchehab@kernel.org,
        robh+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, leoyang.li@nxp.com, geert+renesas@glider.be,
        vkoul@kernel.org, Anson.Huang@nxp.com, michael@walle.cc,
        agx@sigxcpu.org, max.oss.09@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Azam Sadiq Pasha Kapatrala Syed <akapatra@quicinc.com>,
        Sarvesh Sridutt <Sarvesh.Sridutt@smartwirelesscompute.com>,
        Jonathan Marek <jonathan@marek.ca>
Subject: [PATCH v2 03/22] media: camss: Add CAMSS_845 camss version
Date:   Wed, 20 Jan 2021 14:43:38 +0100
Message-Id: <20210120134357.1522254-3-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210120134357.1522254-1-robert.foss@linaro.org>
References: <20210120134357.1522254-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add enum representing the SDM845 SOC, which incorporates version
170 of the Titan architecture ISP.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 drivers/media/platform/qcom/camss/camss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 3a0484683cd6..46e986452824 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -66,6 +66,7 @@ enum camss_version {
 	CAMSS_8x16,
 	CAMSS_8x96,
 	CAMSS_660,
+	CAMSS_845,
 };
 
 struct camss {
-- 
2.27.0

