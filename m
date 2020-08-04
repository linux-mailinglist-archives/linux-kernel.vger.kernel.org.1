Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67723C1E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 00:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHDWYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 18:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHDWYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:24:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0496FC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 15:24:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r11so13603167pfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GsBQzMvXB1iK1BoTFc31oNfXAvShBEBVeWZS60rB78I=;
        b=CG2AII0bmaCsGyPVgFB1gCXac6hS+D4sUd+IktU1hQfOwurwJLK+X3ycG1/ySKrKVH
         jGfi0oZbytKKEru5tBKksCxL9Bp+/iLDm0pYSKTmyrKvusg/p/5P5oCs/5RQQDvzRFm5
         1un1UOyogUND6FKbxfbJ1Z8sj0RvJvcPQJqZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GsBQzMvXB1iK1BoTFc31oNfXAvShBEBVeWZS60rB78I=;
        b=Av8JiOhQK1yXsw1Ey4vpZsIxfRzrBP8LLT4Tn11WK8ala0HXckJzOKc7E9QFveFugY
         OElyKyv67y3j1NvZC9r022LPCmYeaPRrLm4kleS+ph8DqDQu3QrIHYW34atyFqwR6MGp
         qq4Y4DLVj1ZOhI1uRdXU/chQSN19D1uJUiJrn5mGgTce7laLZlNeaelpBJ32lIs+hcV8
         iXCfsSyGoqEzS6GpixoDzGmn/Pyr3phRFEGIfUnZkyL6sCqFg1vqYE/mY1VMfb6EZfU9
         ck5Y15KU2HeJp9GO0EDSNKM4W7GGaVIGdttP8v05Ch279blsObfaELS38+pd9/eko3JJ
         5ZeQ==
X-Gm-Message-State: AOAM533spZEkyc5V3hDE08YP+JXdzN7KKe4+QynwE+H2TK5UQl82CIjG
        1+5lROowbv2Unrj+tuaK17+cidNp4rQ=
X-Google-Smtp-Source: ABdhPJy43SuXX6uHEIAy4z6VHgqogaALPkD6G0ABHCb4t4X4nKL6BbwY4miViUjHY3a4ZjfPtVhbcQ==
X-Received: by 2002:a62:86ca:: with SMTP id x193mr497608pfd.152.1596579879197;
        Tue, 04 Aug 2020 15:24:39 -0700 (PDT)
Received: from bhanumaiya-glaptop.hsd1.ca.comcast.net ([2601:646:9500:590:250:b6ff:fe8e:b459])
        by smtp.gmail.com with ESMTPSA id y23sm76559pfb.66.2020.08.04.15.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 15:24:38 -0700 (PDT)
From:   Bhanu Prakash Maiya <bhanumaiya@chromium.org>
X-Google-Original-From: Bhanu Prakash Maiya <bhanumaiya@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        devicetree@vger.kernel.org, Furquan Shaikh <furquan@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Eric Peers <epeers@google.com>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: mfd: Add DT compatible string "google,cros_ec_uart"
Date:   Tue,  4 Aug 2020 15:24:16 -0700
Message-Id: <20200804151643.v4.2.I8d7530d8372e4ef298ddaaaad612a2cdd24ed93e@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200804151643.v4.1.Ic98067cd92a0b7fed9cd3dfb7b4e736e76551cda@changeid>
References: <20200804151643.v4.1.Ic98067cd92a0b7fed9cd3dfb7b4e736e76551cda@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

Add DT compatible string in
Documentation/devicetree/bindings/mfd/google,cros-ec.yaml

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4:
- Changes in commit message.

Changes in v3:
- Rebased changes on google,cros-ec.yaml

Changes in v2:
- No change

 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 6a7279a85ec1c..552d1c9bf3de4 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -10,11 +10,12 @@ maintainers:
   - Benson Leung <bleung@chromium.org>
   - Enric Balletbo i Serra <enric.balletbo@collabora.com>
   - Guenter Roeck <groeck@chromium.org>
+  - Bhanu Prakash Maiya <bhanumaiya@chromium.org>
 
 description:
   Google's ChromeOS EC is a microcontroller which talks to the AP and
   implements various functions such as keyboard and battery charging.
-  The EC can be connected through various interfaces (I2C, SPI, and others)
+  The EC can be connected through various interfaces (I2C, SPI, UART and others)
   and the compatible string specifies which interface is being used.
 
 properties:
@@ -29,6 +30,9 @@ properties:
       - description:
           For implementations of the EC is connected through RPMSG.
         const: google,cros-ec-rpmsg
+      - description:
+          For implementations of the EC is connected through UART.
+        const: google,cros-ec-uart
 
   google,cros-ec-spi-pre-delay:
     description:
-- 
2.26.2

