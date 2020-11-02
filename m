Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E12E2A353D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgKBUhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:37:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41278 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgKBUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:37:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id m13so6944575oih.8;
        Mon, 02 Nov 2020 12:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBkyOameG65gPdI9hP/LB1y9VakkF5I8ME127+VZVqc=;
        b=hKQsaJTh/ePz2LirYhSA+uojhFKTY0SFSvdy1jw4XCTn+h6Kn32J9zjkgukAleS10l
         jQrId8dWAnADMaHlMBLPGgKKqS8snUnBLMC0qj+Dx4TioTv9yG86ZeiXMFz1Dfr7PNn+
         Cg5UisdI/isuCkU9lG1rJgTKAzx6/beqcleDd+N1WXrmTVMltj88jEJvYxMYadb4y7gY
         FrpyCYNr+0S8HOQqGcsL1WbyWyAOHT1eRk6x/7u82qj3YB8kc5IXP0y2YYQVwNs0tO28
         OkieQZ8YizsoPtHuB58TBb8qMxmu/JQP8yZ/NRStQsWSBvRGZfREYkjoAvmRz+gf8QbG
         hf/w==
X-Gm-Message-State: AOAM533c1pKzhbXDRHt4eWbMu2Synhfz06j4FRabYj0LsPpUdkUzQcc8
        ww4QEAd5DestPIKq66GnN34Ww/VU0g==
X-Google-Smtp-Source: ABdhPJza4LmMMzpz+0LH9Gpao9906cuonotrypVydZeajYy0mOHdV3RtSRdJvM/cXR+aDA22TFg5EA==
X-Received: by 2002:aca:1012:: with SMTP id 18mr11289075oiq.30.1604349420093;
        Mon, 02 Nov 2020 12:37:00 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z8sm3839151otm.45.2020.11.02.12.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:36:59 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        kuninori.morimoto.gx@renesas.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v3 2/3] dt-bindings: usb-connector: Add reference to graph schema
Date:   Mon,  2 Nov 2020 14:36:55 -0600
Message-Id: <20201102203656.220187-3-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102203656.220187-1-robh@kernel.org>
References: <20201102203656.220187-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a graph schema, reference it from the usb-connector
schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3: new patch

 .../devicetree/bindings/connector/usb-connector.yaml   | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 728f82db073d..64f2e1246ddb 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -125,11 +125,13 @@ properties:
       power dual role.

   ports:
-    description: OF graph bindings (specified in bindings/graph.txt) that model
-      any data bus to the connector unless the bus is between parent node and
-      the connector. Since a single connector can have multiple data buses every
-      bus has an assigned OF graph port number as described below.
+    $ref: /schemas/graph.yaml#/properties/ports
     type: object
+    description: OF graph bindings modeling any data bus to the connector
+      unless the bus is between parent node and the connector. Since a single
+      connector can have multiple data buses every bus has an assigned OF graph
+      port number as described below.
+
     properties:
       port@0:
         type: object
--
2.25.1
