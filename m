Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4C92AD12D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgKJITs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:19:48 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46506 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:19:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id v144so16211479lfa.13;
        Tue, 10 Nov 2020 00:19:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UlXbMpsFa244UJuIxjSMkR1LlqiCKu1MwIsUY/puf+k=;
        b=TDVXqybh0Rc2vGrgqqSgCKmbHD94AKd8jvr38BIof3xj9OoF8cJz3XmRRdfP4/qcU2
         4/+OoZKzUjCQ5kr1vfWPr3wKVrOO+hSIBmC7ZSHi3gUIfBUhP+U6d2BHgVQ/CdeSIpw1
         8lpIbU2W5iYgE15MqoP/rA/sDGjawbJqMack4gECXaCGdLpHV3ASA9+32VBMq/oMFCkq
         lcugXeW0os+O0rhnctvZcmovKbMMvmA79z05aCIU3IA7VmPr8MYjT57D4GTxu8WCSWz2
         9x4jEVmKO+JsgZ1IS9rMsybOqb/aO1e/hUwAgTkBNp/peSYNso9T2ncg4grZgLkhWjNo
         uIdg==
X-Gm-Message-State: AOAM531cR0IuvYV2a/g7Lm4cZdtUniSBzrZ9IIn43EX3HIo+Q9SS87jC
        omNniG5zWkl30X4Z5Z0B4gM=
X-Google-Smtp-Source: ABdhPJytIDfg1YooZqoNZODuaWFEQsklBhO+zntVJC+zyChrPvMgicM2aZPNrGfVcfd3B0Dhsu6u2A==
X-Received: by 2002:ac2:5687:: with SMTP id 7mr7047702lfr.149.1604996385134;
        Tue, 10 Nov 2020 00:19:45 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id t5sm2030280lfc.75.2020.11.10.00.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:19:44 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:19:38 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH 1/3] dt-bindings: regulator: BD71837 support commonly
 used feedback connection
Message-ID: <9959924313db7c7165598604f9a07bf227f471a8.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BD71837 buck output voltages are in a few cases scaled using external
connection which adds a pull-up to regulator feedback pin. This connection
will adjust output voltage from regulator in a deterministic way.

Add support for describing this HW connection so that driver can adjust
voltage ranges accordingly.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../regulator/rohm,bd71837-regulator.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
index f5e31196a646..1941b36cf1ef 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
@@ -105,6 +105,54 @@ patternProperties:
           PMIC hardware state machine.
         type: boolean
 
+      # Setups where regulator (especially the buck8) output voltage is scaled
+      # by adding external connection where some other regulator output is
+      # connected to feedback-pin (over suitable resistors) is getting popular
+      # amongst users of BD71837. (This allows for example scaling down the
+      # buck8 voltages to suit lover GPU voltages for projects where buck8 is
+      # (ab)used to supply power for GPU.
+      #
+      # So we allow describing this external connection from DT and scale the
+      # voltages accordingly. This is what the connection should look like:
+      #
+      # |---------------|
+      # |       buck 8  |-------+----->Vout
+      # |               |       |
+      # |---------------|       |
+      #        |                |
+      #        |                |
+      #        +-------+--R2----+
+      #                |
+      #                R1
+      #                |
+      #        V FB-pull-up
+      #
+      # Here the buck output is sifted according to formula:
+      #
+      # Vout_o = Vo - (Vpu - Vo)*R2/R1
+      # Linear_step = step_orig*(R1+R2)/R1
+      #
+      # where:
+      # Vout_o is adjusted voltage output at vsel reg value 0
+      # Vo is original voltage output at vsel reg value 0
+      # Vpu is the pull-up voltage V FB-pull-up in the picture
+      # R1 and R2 are resistor values.
+
+      rohm,fb-pull-up-microvolt:
+        description:
+          Feedback-pin has pull-up connection to adjust voltage range. This is
+          the used pull-up voltage before R1.
+
+      rohm,feedback-pull-up-r1-ohms:
+        description:
+          Feedback-pin has pull-up connection to adjust voltage range. This is
+          the used R1 resistor.
+
+      rohm,feedback-pull-up-r2-ohms:
+        description:
+          Feedback-pin has pull-up connection to adjust voltage range. This is
+          the used R2 resistor.
+
     required:
       - regulator-name
 
-- 
2.21.3


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
