Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661D2B6486
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387748AbgKQNrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgKQNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:47:19 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788C9C061A04
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:47:18 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id m65so15516941qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRMDxR1XzzcnMM9BghVE3BSiYKlfFjMEfZKA+FewRzQ=;
        b=LldeBECgjxfNc01pMMqn+TCglP4FaITU11CevOHj/I9uVcZalmI/16VmXDiAzApW72
         CEwDuB1uUo9ywfKlwHDbII4KfKBPxRGrdk2syyTt62rSD6xDuESOWfc7I3pyqhN5qRK/
         R1ePjpLK4Q8yy4EZQkGASIciJo0wwC1lFqRDxK/AR4Wwh4eH2TNySo22ab4GLunSpN2s
         k6dMjBbjqs7jKy3veOGIMWMuwLv8ll6mLpFLeDhZdtSblWqYqe8T0i4FdDKvtqJ43rxi
         iWqyyiJdm3sUh607/tcMien4gRyoLbeu+mKDszFRnB1CHILikrvJKZtUbRscj8SOreTe
         iFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRMDxR1XzzcnMM9BghVE3BSiYKlfFjMEfZKA+FewRzQ=;
        b=j/h6HZd0DBiAJVhgrtq9PKSrANfJjM006f3d1fRaZ6QMgfrCTWhvP42VGZcvR8p8jK
         f30sPkJXQr9e8pzkxjJ9vbwbimyI/4y+3NthhkNS1yXLHA9hpdC/QeMEzXr2Fyi0MPcW
         1cTqm+TEYXbrGPVRdLq8dQut8IHzjxEL9iAykvDn1moljHoII0GJa2e6PZWaSngOkbPq
         p9rqxKAID+FIy5t6+uUQ1Swp8oDFRDIikWPPROn/czpX4+csRARUaMQfRJXQwQV2G+gW
         UCol04qxB/3V7yK2n42TQE6mOCAJ/4z+RmdvZTAqdaiJPuHxHIGJryqEG+HqgUdLzncz
         b9Nw==
X-Gm-Message-State: AOAM533vuhE5NBu5nlsZJj5cS3LXOq4Ju6fryvnnXawqaMZEj7eoHzsT
        e/9nDC81sh/Uz/2VRlweOKQqZw==
X-Google-Smtp-Source: ABdhPJyhLYlf/CcQQnfzErvP3YcpAQEosGNi/jI0FVPEOOX5BfJ1cuI6DZPcB7frnmdp5E/eh0TG+A==
X-Received: by 2002:ac8:668c:: with SMTP id d12mr19127585qtp.352.1605620837750;
        Tue, 17 Nov 2020 05:47:17 -0800 (PST)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id t133sm14607355qke.82.2020.11.17.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 05:47:16 -0800 (PST)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/6] dt-binding:clock: Add entry for crypto engine RPMH clock resource
Date:   Tue, 17 Nov 2020 08:47:09 -0500
Message-Id: <20201117134714.3456446-2-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117134714.3456446-1-thara.gopinath@linaro.org>
References: <20201117134714.3456446-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock id forc CE clock resource which is required to bring up the
crypto engine on sdm845.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 include/dt-bindings/clock/qcom,rpmh.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
index 2e6c54e65455..30111c8f7fe9 100644
--- a/include/dt-bindings/clock/qcom,rpmh.h
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -21,5 +21,6 @@
 #define RPMH_IPA_CLK				12
 #define RPMH_LN_BB_CLK1				13
 #define RPMH_LN_BB_CLK1_A			14
+#define RPMH_CE_CLK				15
 
 #endif
-- 
2.25.1

