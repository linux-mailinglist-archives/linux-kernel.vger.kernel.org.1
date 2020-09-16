Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FDD26C6B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgIPSAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgIPR7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:59:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D3FC0A3BD1;
        Wed, 16 Sep 2020 05:23:25 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so7871202qkf.4;
        Wed, 16 Sep 2020 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjN1xG5sjWQRqcaRckvacRsUDodaOjx8p9tlYP1iS0o=;
        b=tmpiBjPctPdzvpmVke7u6smlNs4MOxeU11JCl77bUYFGygxvLRERsx0XmaDUb2kv/z
         gxQOFoEbySV4NHe41YoZxaEVQLLbr4p4R1IW89fUXKtDgv74ociGfP3xwqkldZZyPfhk
         j2Mm5qGf0Uu1GJTRNej2C2rH0spFHpztgDS1KQ6Skfjgi1RCpYuXWQlCREU/b+uilX1h
         oY6syD+dTqCv2X/HhQl/cMEb6sTHFX5vTWgLsrenPHPEq9ISWLxu7w3NfVNKfRUdW1R3
         TmifYft6tmIPr740s6I5uj3ecDhA3I6pmWahhqKgvX1W+FP/fVQdz9nU27TUEgzQ6E0G
         bK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjN1xG5sjWQRqcaRckvacRsUDodaOjx8p9tlYP1iS0o=;
        b=nrIesqcuT+O3saE3MTHzMEmlcQDaxd9BOXTcZAxV+e5Eug9Q8v2t52T+VSubprjDY8
         k2U4nicAVJo0Fna+Y9B2RhWihT8kpKzbjqCIffeDgit79uVBpbnKTE+MicAtkpKeGW+b
         sIHjdJ/dFlmsCmji2Ca5gtCDt6ZeHApKH+78EP7W09sPDwD1b4j5+EuoykU1Wdwy9bNY
         yPFEpVjbU513NL6anSlQ1PAQ9xGjTWC/vihRpzz95Oh7jIHWkMiwfGrC+ti4tpHqermO
         4tUOK1/cKTyp5vex3IYxVk9Rw0yq+3YLP9Hp5NoT9KjIGiy9+O7V6ueoKU5y+/6MDxdr
         pb2w==
X-Gm-Message-State: AOAM5335JpxWxfIzkwfp7IBHHPhqDuoUX8lLAVVl27Su6bb2pxtIPO7w
        vodfd9jvM7pez8BGhS1d2DM=
X-Google-Smtp-Source: ABdhPJzpCNHHz9khqC42ReqEOfqbQ8T8oSeAMRELXxY+ooUAOmXlBcMMD/FWWLhVyPP3YrMNGcDlFQ==
X-Received: by 2002:a05:620a:c10:: with SMTP id l16mr21679806qki.245.1600259005118;
        Wed, 16 Sep 2020 05:23:25 -0700 (PDT)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
        by smtp.gmail.com with ESMTPSA id v30sm19916177qtj.52.2020.09.16.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 05:23:24 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bob Ham <rah@settrans.net>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Brougham <jusplainmike@gmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH 3/3] dt-bindings: ARM: tegra: Add Ouya game console
Date:   Wed, 16 Sep 2020 12:22:47 +0000
Message-Id: <20200916122247.534374-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916122247.534374-1-pgwipeout@gmail.com>
References: <20200916122247.534374-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra30-based Ouya game console.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index e0b3debaee9e..a8bafe68315f 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -69,6 +69,9 @@ properties:
           - const: asus,tilapia
           - const: asus,grouper
           - const: nvidia,tegra30
+      - items:
+          - const: ouya,ouya
+          - const: nvidia,tegra30
       - items:
           - enum:
               - nvidia,dalmore
-- 
2.25.1

