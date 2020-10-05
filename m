Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454C02831BB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgJEISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:18:30 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41681 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgJEISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:18:30 -0400
Received: by mail-lf1-f68.google.com with SMTP id d24so5802261lfa.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=019mbCAGw5RcsNW52lHoJTRc3hUMhMKuBdXHk5f3UlQ=;
        b=BMuEvM1qLQTp+jHIniiqJtYkk7I9PeYdW8QI1XMs9HIyM05eAQQoWhi6r9igl34aiF
         ClBgvBs4tnYJy1Y2xkTQfn2snrO6WNS1fi8dWJxror/RVy97SZOEHQXYdipAc5QEMMJk
         cJIQ4+ZS4EpmAMUTa0YYDToVtDOkdX5kAszj+XbGi/+HOlzX5E54XCmAWn35CcJO6Fqr
         emrhD1442i6W+nlr3JRstkcKF9VW1atWWMaqp7AyfEGrNVglIRCnBSK2ho7hfGsqyaME
         2xNHPuzthhgiiNzMdlc1tNn5Uup9MklMeCvw+lDCg5S6SAwX1eJCcJTWUsDRUEpc1Z0m
         49/A==
X-Gm-Message-State: AOAM532PkjLsjmesjqwnfsmR+JtIRiVEXkrgMy40J7m2xiTXheUKxt1Y
        NYrs9c9W8da8yfAkYlMFjUxtqqO/btv3LA==
X-Google-Smtp-Source: ABdhPJyOK5668vARfdxtZ9bPIQha4JOMjltkq/Z6j0luQi4ZhTTYGiGxfhOjQN3WyJ+vQ0XqbOrxaw==
X-Received: by 2002:a19:cc8f:: with SMTP id c137mr5144980lfg.476.1601885906508;
        Mon, 05 Oct 2020 01:18:26 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id t12sm2719110lfk.26.2020.10.05.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:18:25 -0700 (PDT)
Date:   Mon, 5 Oct 2020 11:18:19 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH 1/2] dt_bindings: bd9576: fix regulator binfdings dt node
 names
Message-ID: <3d92de2085f0c074929861a2f791bf4070920e83.1601885841.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator- prefix to allowed regulator node names. Prefix is expected
by the driver and the actual binding yaml description.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/regulator/rohm,bd9576-regulator.yaml   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
index 6df077b0db86..b6515a0cee62 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.yaml
@@ -17,7 +17,8 @@ description: |
   on the device tree.
 
   The valid names for BD9576 regulator nodes are
-  vd50, vd18, vdddr, vd10, voutl1, vouts1
+  regulator-vd50, regulator-vd18, regulator-vdddr, regulator-vd10,
+  regulator-voutl1, regulator-vouts1
 
 patternProperties:
   "regulator-.+":

base-commit: 3015c5d019879e2ef82d002506ee5d9f182f0105
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
