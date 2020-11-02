Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC242A353E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 21:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgKBUhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 15:37:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:32814 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgKBUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 15:37:02 -0500
Received: by mail-oi1-f193.google.com with SMTP id s21so16065189oij.0;
        Mon, 02 Nov 2020 12:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSe0Eyg4T+VVxvIrbRKcVjoJlAgtXIYs2ZOG69Hyme4=;
        b=dVZ7F8beIJOxv4Nij3DsmMBV2Ok1MJAD8qBQ8wYTCPgfIfNQZmx8r2VT/Et0jr+Eug
         knG7m1BG2mmZ7bhIkSZokSc1qZ28V3K8s4PHqDOjDVoajMB5f8Lj4N5MLZtoYOfl3lYI
         bt5bNIDzgPT0ejKSRoem0ved2lXBDJIq8FWZdrzPEbr2i2CPXl078m/GU3LNfnS41nF2
         gflwubhQ6QLf5x1wDKvN33tppUi+fYlKdJQVLGx5kE/r5n2RglNWRO1kCU6Qt3VJ6cTE
         LPnUfo/sSlXh4+TJoG87wAbqjmatWwljh+8RIkZXNFJvR+2QlH1a95PS+wlBOi1dnKYx
         +VAw==
X-Gm-Message-State: AOAM533vOAwbkrXYp/2mS+AdTb7MxSXiYd8GCAZOKPrW4FkWTDMHKjYp
        8nqH2xRMnsY1+BQL9fqVY6s9GNTd1w==
X-Google-Smtp-Source: ABdhPJx6uroqdLoV5D8UzKlIH+axYRNJV35FHtiXCCA2TytPvvByeT1flj+DmvIAJWnKLmiKDTEkiA==
X-Received: by 2002:aca:3a46:: with SMTP id h67mr11418122oia.21.1604349421291;
        Mon, 02 Nov 2020 12:37:01 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id z8sm3839151otm.45.2020.11.02.12.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:37:00 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        kuninori.morimoto.gx@renesas.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Subject: [PATCH v3 3/3] dt-bindings: panel: common: Add reference to graph schema
Date:   Mon,  2 Nov 2020 14:36:56 -0600
Message-Id: <20201102203656.220187-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102203656.220187-1-robh@kernel.org>
References: <20201102203656.220187-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a graph schema, reference it from the common panel
schema.

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v3: new patch

 .../devicetree/bindings/display/panel/panel-common.yaml    | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
index cd6dc5461721..a3a72c574213 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -68,16 +68,15 @@ properties:

   # Connectivity
   port:
-    type: object
+    $ref: /schemas/graph.yaml#/properties/port

   ports:
-    type: object
+    $ref: /schemas/graph.yaml#/properties/ports
     description:
       Panels receive video data through one or multiple connections. While
       the nature of those connections is specific to the panel type, the
       connectivity is expressed in a standard fashion using ports as specified
-      in the device graph bindings defined in
-      Documentation/devicetree/bindings/graph.txt.
+      in the device graph bindings.

   ddc-i2c-bus:
     $ref: /schemas/types.yaml#/definitions/phandle
--
2.25.1
