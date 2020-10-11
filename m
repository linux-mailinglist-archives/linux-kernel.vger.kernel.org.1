Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3328AA52
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbgJKUXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgJKUXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:23:11 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56CBC0613D1;
        Sun, 11 Oct 2020 13:23:10 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h12so10699486qtu.1;
        Sun, 11 Oct 2020 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=rAX9LyBhQRjGuVquLmVQLXPeCqbM+PKvTpqudvQ8odySOCoDSzcLV3hKt+GDznepfJ
         bmA4KDaC4rF1pzAjhPCwKfH6J5pZC4fgHvitjewrVIXZuBY1q5Qe46HcWsWNMv7U0LeA
         oq3Don423DuBS7WMcNwRD1JFfHYnYPS9zNIdElxDMD/9ioFeG5NA9K+/usHSLSKluTc+
         jgT1HqRK5BqqoC+bt622kZRwMJGnxpstA1NbRaJKnQYdQWD78QsHrXBJyecAkq8pVx5O
         IuQ9L3x9/Dks2/kUJSkmWH0ucrpvqpQjy9+SyPBgtlQz9Ugqz3cFIXIteSABTuwS78Bn
         BZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lryb+OP/I/Ms7egySRuAjr25d3wKcdnJ3fbOd1ZGv1M=;
        b=SNEmfVhE31Z6YksmoaH0tew+8Qig+FKNOWIaVlo6K7RNF3o3xnKLePZ9K3QGjP+Sf5
         R+32D8o9coV7DdeJh2Ni0zSkK56WjyRx4LvuG4bCPgHrDeXKjSahD2qZPQBSO9Le9XvR
         9lPo+ZXweTdcnS6IQRLRwIuYXYPV+gqL0HNiGU4pFAc/NyFBGyiaC36l999g7jwCV3sd
         B17Qa+8R3AJA3u3EbqHlWGV59lwcOdoic+dkMkkmWdgXHaLUII2DhW6Yi32ItbFLBZ0e
         RiFvqjIr4VisBlpNGPTJQFKDzTRMIE0JHsPNo+jQbLs6ZM9Wgapwl0eyF2NuJW8+DcWh
         /5NQ==
X-Gm-Message-State: AOAM531z5WyUJ6RshdPjg6Zk7iCIjFJqi3osJnbY4SjuuyD8gMM96YVv
        eSRg9bxmLR1iSdFoCZpisr8=
X-Google-Smtp-Source: ABdhPJxWrxt2WnMT3nzMt+0sTbhfP+3jSHNUCya8daPb6HIY1AaWF6DkniHZhmrpgU6CmjRHq0GB1Q==
X-Received: by 2002:ac8:6945:: with SMTP id n5mr7111000qtr.202.1602447789800;
        Sun, 11 Oct 2020 13:23:09 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:23:09 -0700 (PDT)
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
Subject: [PATCH v7 13/14] dt-bindings: sound: sun4i-i2s: Document H3 with missing RX channel possibility
Date:   Sun, 11 Oct 2020 22:22:23 +0200
Message-Id: <20201011202224.47544-14-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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

