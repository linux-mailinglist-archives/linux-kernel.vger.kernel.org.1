Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268AE21D8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 16:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgGMOtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730139AbgGMOto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:49:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D0C08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so13445132wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 07:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLuyrhW1Ep4UqvYQzgiCgMPgEzGrhSBhnQKWSj6/aQI=;
        b=rodZuMheOaiuJ6ysjx6ilt8n3oIFeHyyJQvyszrQaBH/ZMKq6ZNgOwolHB/N1nLCey
         GDOHdRy2iqJG26wPbpMoZMUVy7vU06RWHv/WhoSXqFiHSF1Kw3kgMc0lLhajbTlG7MMv
         jpnVkEkSM/bKfUdYZLNOAsTOARnhiQkf7HQGA+r/uqY0/fgW6Ps6FTW17gSrRfMZWQem
         zloaHCQcyTMc383ovLgCzPrNQ2+j/JP4aQEe2rBO9ZcMKvwX1rIBoJxSCfAEwJg6JNp6
         tpKpvjjIu3NBSCW9vwwXuawtF+VIEPb2jEhvv3x9vVKsafRumWWxagDQObXQjO79AAx4
         cToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLuyrhW1Ep4UqvYQzgiCgMPgEzGrhSBhnQKWSj6/aQI=;
        b=je94LVS1tARwdDWiExPO0hFMc5tambmQQ0Hy5nmvIi9KUF68/GMNvVoeuVngwfoNuD
         Kez4dAymZWk5PgSn+NMCaNgX5EDwQYI3zZLjadCx3kIXRWZKboW3YJAvFL08NFT4tzdl
         Vh9LXIlHL2083caf/+6QdlzF+b+ruzRKeo5d0XFME9e7U1usEa0/cRwJvFbRaP1/JRrw
         N9yGA+y3zPCFpWrCi/ag5pWZDAp8TCXBv9nSMqGAFGgLRyCw0bnBIcXzWVGSj7QrS+U6
         dLGfboIf0MG7dIx8f4pd9kd95LStEHhODMiEWsng8OFDQPFNEiQk5hfyC2OS7k6IW8rD
         Kmrw==
X-Gm-Message-State: AOAM532Ohbhsy8REIeunDgleGpxN3XYyh2mCHj84EyfbZY3i5ypMYthb
        h1CSYqfUsJI45tVg1axbrAJSfA==
X-Google-Smtp-Source: ABdhPJwNCN9IKrrBQRXxfQyO4DBNoD0hRSiA2S/GsibhAVbnDvY8RU02RNJDtcsp8xzBWa+YyE4XtQ==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr313387wmi.94.1594651782718;
        Mon, 13 Jul 2020 07:49:42 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id o29sm26207756wra.5.2020.07.13.07.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 07:49:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Del Regno <kholk11@gmail.com>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 09/25] pinctrl: qcom: pinctrl-msm8976: Remove unused variable 'nav_tsync_groups'
Date:   Mon, 13 Jul 2020 15:49:14 +0100
Message-Id: <20200713144930.1034632-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713144930.1034632-1-lee.jones@linaro.org>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/pinctrl/qcom/pinctrl-msm8976.c:802:27: warning: ‘nav_tsync_groups’ defined but not used [-Wunused-const-variable=]
 802 | static const char
 const nav_tsync_groups[] = {
 | ^~~~~~~~~~~~~~~~

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Del Regno <kholk11@gmail.com>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm8976.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm8976.c b/drivers/pinctrl/qcom/pinctrl-msm8976.c
index 183f0b2d9f8e8..ec43edf9b660a 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm8976.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm8976.c
@@ -799,9 +799,6 @@ static const char * const pa_indicator_groups[] = {
 static const char * const modem_tsync_groups[] = {
 	"gpio93",
 };
-static const char * const nav_tsync_groups[] = {
-	"gpio93",
-};
 static const char * const ssbi_wtr1_groups[] = {
 	"gpio79", "gpio94",
 };
-- 
2.25.1

