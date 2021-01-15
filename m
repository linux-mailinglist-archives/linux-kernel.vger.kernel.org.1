Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FC2F814C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbhAOQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbhAOQ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:56:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8EC061793
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:55:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id a12so9941521wrv.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 08:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpoU5fqNwBrgG+uQnSKsFtoenWMjs1fcRQ3GYXtUAfw=;
        b=JyOzx4Fv8jpmSqjzz6uWttvy15gDpPwhLvBE47Jl3j6+4seX77+kh+s4z7qdkB9XZv
         1m5mBd6QIBVByhFMCsF4auzJ5pFw0xD2bg+jljTwtbDE8dBxE2ak4Z249fFIHrQKqJJq
         fckoWR4/PauSu9ShyA+gryhbfUNV7Nd3M1Po56yCIHeP9DiRjbWkELJP7mt88CNxMi5L
         JJKeO5A/skGVOdJ9K44j1OEM2uSW+hCw5xZMgjt/16rThqkag4TM3TZArH1mV7+GWF5G
         CAEaMR5JUQK9H+FVGM4ggZjFKevYm4RgYBlp7wzKspfqfFNfB2Bc+Ep//R26wR2p+33+
         3MfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpoU5fqNwBrgG+uQnSKsFtoenWMjs1fcRQ3GYXtUAfw=;
        b=J7bU312q6aPYwJhBR24ZNYjYEgBmInEH1hCDAFWnNETU0oYRL8lkhM213pmQtfDp41
         Y8RLXV4eg5q/Uo9A9XIgROdLylNLRaU6ozabQcl+7kElRO5IH22fzFF9RUjlwseKDGWv
         rpzCQ9JpgEbQne9ky5atdQ9NyrAVlcsIEMWUsimmFIBdnIBBbwjfCawfgt7hmEI6CclL
         N4HxupzwHOBAaP9fjstscEbz9hZvRwBCrAbzm3WIvSb6uEiS2FfwpjF5NttA+pfyR+F8
         ZhUVbqUKNRKyCEDZxSBSFb294u2j5AP2vCqF4QXzzpsQgnZ3DTwaOytgHdKaj7qDnmYd
         x2ig==
X-Gm-Message-State: AOAM530tOwB2l8wiDasNfLHHL34uxQqCnsHFNfXiJrwV/yzYFniOkSj/
        wc5e+g4YwFbwDPfqpR9jrQALOjnKRvtYpw==
X-Google-Smtp-Source: ABdhPJyLPxRwkrI+zHOIgoHA0e737MQMy5mIKOsHajXwgWnZq2enQJ0S7G1aMQrecyoNBQzsgdsyAQ==
X-Received: by 2002:adf:bc92:: with SMTP id g18mr13731534wrh.160.1610729733129;
        Fri, 15 Jan 2021 08:55:33 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id b7sm14655045wru.33.2021.01.15.08.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 08:55:32 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     linux-kernel@vger.kernel.org, broonie@kernel.org
Cc:     bgoswami@codeaurora.org, plai@codeaurora.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] MAINTAINERS: update qcom ASoC drivers list
Date:   Fri, 15 Jan 2021 16:55:20 +0000
Message-Id: <20210115165520.6023-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210115165520.6023-1-srinivas.kandagatla@linaro.org>
References: <20210115165520.6023-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add full list of ASoC drivers that are maintained!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1545817c899..7699d9d94a49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14516,6 +14516,14 @@ M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 M:	Banajit Goswami <bgoswami@codeaurora.org>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	sound/soc/codecs/lpass-va-macro.c
+F:	sound/soc/codecs/lpass-wsa-macro.*
+F:	sound/soc/codecs/msm8916-wcd-analog.c
+F:	sound/soc/codecs/msm8916-wcd-digital.c
+F:	sound/soc/codecs/wcd9335.*
+F:	sound/soc/codecs/wcd934x.c
+F:	sound/soc/codecs/wcd-clsh-v2.*
+F:	sound/soc/codecs/wsa881x.c
 F:	sound/soc/qcom/
 
 QCOM IPA DRIVER
-- 
2.21.0

