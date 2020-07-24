Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB6722C86B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgGXOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgGXOv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:51:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B9C0619D3;
        Fri, 24 Jul 2020 07:51:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id q4so3998641edv.13;
        Fri, 24 Jul 2020 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=EKfhrwLSBlpUDSfbwmy+TKVdItuEwUFE+rwpl/BBpHVTunh1HcunYRzV/UAkFOmt4A
         +ZpYGfCaAYqngbG0R7SiTq9t/pLcYQQ7ySNDaiOGnU8SfNGkuUSVdw2yfjIlpxwg2IBI
         K62lCA7typmCS7SuWiAcWyH5Vh6Nw6RqBfhW16lMVG53+Bk1hup9RKNNC/y8DBgAOjuZ
         p4JaoGNkcRqUBKV5iLKpWbHmM8gkgfr0vTVsX9hA1ZyGNmOejtiVzNnhyMX4Gn2QKGyE
         p/pWRyK9w/GwjpKz2v+oeJOlrCbS/i3Ry4F+lZS+6ibl2wcGkQlh9VSXcvhVA6c2vj5y
         K9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnSVvBPLgxOr7Okxa4+yFdbMwIKkVndKbRuepRfY/Zs=;
        b=ke0MzOb7b1RfDrsy7GFhD5NE+fXPTciE8dxbsjs4HIcDgUDFMazLZtRyU0ZrldUeh8
         QR8V543TepHTrkQ742tupY8/L4eCkvYac/PwMVKYH2KxDeaX8hELlH2bXGj5+tU5h0Fh
         eULo+ow3QTwHzvDf/ZvUh6RbRhbHXGdFjnY+kySasrfDbKAtxsYd23WOlADX8fbhGdN3
         vATYRMsHXB1spoO9z7G+whrkmq84kPv+GnX7V1lDkuUN0giZznk5FDMfVoXXCMVII49e
         qeadFztidW637GVhk4yq126TnWGJ+aIGHg02DoUTmZFTFtjsyY4tVY8Vb5Q9cBcYjamS
         WqlA==
X-Gm-Message-State: AOAM533yRPhu4pW4sYy57Cnl/5OJND27X1uVgxmAEhLzz5YT3T4oar40
        ke1rWyiZAwo85kM4bmNPU08=
X-Google-Smtp-Source: ABdhPJwvLYHGjgAuJ7dGovxJ5+5LP8JUWjKsoUMQ6Gld/w48Bq1GyMyLuJ0WRDDnmf7FBWJO/1wKaQ==
X-Received: by 2002:a05:6402:1d97:: with SMTP id dk23mr9525309edb.1.1595602286010;
        Fri, 24 Jul 2020 07:51:26 -0700 (PDT)
Received: from blackhead.home ([2a01:112f:a1c:7900:7316:ce1e:7b0b:6bd7])
        by smtp.gmail.com with ESMTPSA id m6sm788309ejq.85.2020.07.24.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 07:51:25 -0700 (PDT)
From:   Marcin Sloniewski <marcin.sloniewski@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, mani@kernel.org, a.fatoum@pengutronix.de,
        marcin.sloniewski@gmail.com, sam@ravnborg.org,
        linus.walleij@linaro.org, heiko.stuebner@theobroma-systems.com,
        stephan@gerhold.net, lkundrak@v3.sk, broonie@kernel.org,
        allen.chen@ite.com.tw, robh@kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Date:   Fri, 24 Jul 2020 16:51:05 +0200
Message-Id: <20200724145107.35772-1-marcin.sloniewski@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the "seeed" vendor prefix for Seeed Technology Co., Ltd
Website: https://www.seeedstudio.com/

Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..7dd03b3e9d3c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -902,6 +902,8 @@ patternProperties:
     description: Schindler
   "^seagate,.*":
     description: Seagate Technology PLC
+  "^seeed,.*":
+    description: Seeed Technology Co., Ltd
   "^seirobotics,.*":
     description: Shenzhen SEI Robotics Co., Ltd
   "^semtech,.*":
-- 
2.27.0

