Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2016C29C770
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828476AbgJ0ScS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33443 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828442AbgJ0ScJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id b8so3079423wrn.0;
        Tue, 27 Oct 2020 11:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=KHWmTg6iNDzrUklwwoPUYeB3JIWWDKo+WfE3xEOm21ijBsMHfDp0aI6XXbDtue4XaH
         yF0uAVTb/N3UE0kxVcoNUSQePrz1qUYCgERhqUVFas+4XWL00P9Hmtu9HqBv5R4oVP+j
         c0quqR5yhlruMZ1kqMBRXJrD3WZ91qofkjITlAPNS3FBjTiT9ERLIdTTJ1YBcGnRdNfw
         L4sBfxOFuTEqxkMidOBmwJFJZXxEHsghsrEsS5BpZbSp2CNXNzHcG3rR9gLEvd8k3hGd
         N1yNXHh/yq0neAeDIT8ponfii5LZjEWnjSjHBfMCLEgYqbPpmXKyoyPuEN5vAiA5+glm
         PG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=MzkfGlXSASBTyyi9CESHwLKlPdjeuQ6Ty6K057+KjzEWG8tcX3gU+IY2Sf8U6pcRgd
         PZQ+a/tsJ85eylRwHYnluPwQogi1VtZNHrZQerjSRCSPgqDqlPLon2L0rt340J2ToUkH
         BF7zHSkqt+GyPROM+esb7Ou1Ona89c3xXGiKB4P9S+9vzPAG+2nVstZR09ZDTc0Ntuz+
         hxaBJ58tEsdQMw8OpuNHYRpMFZTIs63hHEOdV5SGp271baOjpdMwYSfaIULPKKDGtW2E
         qo3X1lCN+P3b3Kn4CfQT/k+821E2y68MTgfN37JoVHUZwPPdy8KGvEpuHLP5kYya7eHR
         9GjA==
X-Gm-Message-State: AOAM533D97hqF0vJZsPOmGfcYXKYHIaH1iuiJ23MVkyMSAJhaoWUAYC7
        rZR89QPSKBbp3pY0jNlnGfA=
X-Google-Smtp-Source: ABdhPJxafdY3wzwsE3nWndD8a+Tz8AuK8P+cxxtLyIH8fPdH/CbdGOoBaBsh/wxXO/+pPitC+UGQmQ==
X-Received: by 2002:adf:e30e:: with SMTP id b14mr4120044wrj.195.1603823526969;
        Tue, 27 Oct 2020 11:32:06 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:32:06 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v9 13/14] dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel possibility
Date:   Tue, 27 Oct 2020 19:31:48 +0100
Message-Id: <20201027183149.145165-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like A83T the Allwinner H3 doesn't have the DMA reception available for
some audio interfaces.

As it's already documented for A83T convert this to an enum and add the H3
interface.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 606ad2d884a8..a16e37b01e1d 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -70,7 +70,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun8i-a83t-i2s
+            enum:
+              - allwinner,sun8i-a83t-i2s
+              - allwinner,sun8i-h3-i2s
 
     then:
       properties:
-- 
2.25.1

