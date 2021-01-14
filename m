Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4077D2F6867
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbhANRyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbhANRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:54:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AA5C0613C1;
        Thu, 14 Jan 2021 09:53:52 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 23so9220768lfg.10;
        Thu, 14 Jan 2021 09:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLs4ylBJ7K9NgD/fLR2aztrPKsyKv0HfoASFjpZX5pk=;
        b=btn4i3vw54VYbF3Ev16ktYnSGtPGeIPVqogsYgFVUJDevWvRA3CStZkNCtB9rgBq5d
         5dTIVjQgjJ/mzhNJdTf3YcuXft4CJt4aCz7Ynuo3DGX0KOk0s8J6iWWRIs8Q2ONJe4E6
         ROp3uxbk0mtquArsWMNORlagBXrFAAnHgvJnzZPHVDVo558tXMvAsIj6neC1JqU8b3an
         7ytP61Frzr424EvXl5YlpXnAkd8R7MYuDVvYVt6dvXNut2LmiWTWf0zr0QnS9YawCOVL
         6vDp3nMRK7Frx5TBFK89pWtpk0mUfEfk9/uDXBG9sErSKd1+Yj8i4LyocX/0AR56KM3h
         uFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLs4ylBJ7K9NgD/fLR2aztrPKsyKv0HfoASFjpZX5pk=;
        b=hB7LeTvsNvwx+BlT6mIJz2SUtdnPrPfY9nZ17waWQfte/C1kDj2ahcaz4weDFRAmqo
         /FnNkByzyu0xPK7wd3TKSq7IJbf3K/nOj0iW3SRDcpWy/1FZneuxrcbOW2ixfeok1xvd
         wvB11HB41vcA8fabGxQ+itfa+wzHAVErt988b3cNY1hcJhNaVGV8oh1cDkdwRZVKwGOj
         ML72NtNGPE12b1kjbRHMm3DNcernAzVikBjODKoBdzUackCJKQcpLdppKY2Nomaw2SBw
         HUdjWdB3b35Aq2CWi959qibnjVkrGAjDiT1ppwqpsVWlhYyo4Cn595LSNBxijUoheVhv
         XOhA==
X-Gm-Message-State: AOAM532OuOZ8W8AWuF2OAeRiW++iSpmouxPYuGyBVDs9GLpIQf2D+qw5
        5xohcqKcs63U/VadTNw9uNU=
X-Google-Smtp-Source: ABdhPJwcBgk4H2SRjqZxUzpcPPwWZOzgzk06/EK2FLl7xpQmVOudc8WrGLsgvlqzCvf9XYROnGo8ZQ==
X-Received: by 2002:ac2:4437:: with SMTP id w23mr3836737lfl.618.1610646830740;
        Thu, 14 Jan 2021 09:53:50 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a24sm610103lfg.256.2021.01.14.09.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:53:50 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH Broadcom/stblinux 1/2] dt-bindings: power: bcm-pmb: add BCM63138 binding
Date:   Thu, 14 Jan 2021 18:53:38 +0100
Message-Id: <20210114175339.19920-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

PMB can be also found on bcm63xx chipsets. It uses difference device
addresses so a new binding is required.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml b/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
index 40b08d83c80b..f8e7ddbd2705 100644
--- a/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
+++ b/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
@@ -16,6 +16,7 @@ properties:
   compatible:
     enum:
       - brcm,bcm4908-pmb
+      - brcm,bcm63138-pmb
 
   reg:
     description: register space of one or more buses
-- 
2.26.2

