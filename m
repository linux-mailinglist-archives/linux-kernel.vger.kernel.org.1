Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46DE2AD131
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgKJIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:20:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40302 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbgKJIUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:20:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id e27so16270982lfn.7;
        Tue, 10 Nov 2020 00:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XF58E9LpuHgK3bgwONg+IQpq5rvQT2eMBFliurRDMBY=;
        b=aShRON+7KoBsyzXH9B7efaCm4FyisRwR7+kbdHMOiqWHtjI0eCcBBqFlVsOTrRtul6
         lbLWpJcKafx8iDpzEUP8NwIo7ssuf4HnviNHvGRi9/+/0DGinDIbckL7MTrUcuKOuAs4
         zSBj75EvKpJadSiwQ3TLUXLM1DCdaO80GjpCEyOdx51h+Fo7jnjzN6FeAlIP2h6buQRS
         73mLSC5YBFUttILG3wlZ3NgPGSqXkwX8mOZ1I6u+pMhcd5DPeAgKADj5Jvey00+R/KBe
         FONoSAqQYTz6wZ6Tm7PcJ34Pjm1QeaKwwMCNm+CY2377sUy0JiBiWLk/AKUJD5rC87L8
         GaKw==
X-Gm-Message-State: AOAM531TBgq2WOGWaGvzb4V473fvXlfZaFrAiJU/IMtE0DquSfo3dOc/
        U0GYDlkUWaguv6ZY6gV6tjk=
X-Google-Smtp-Source: ABdhPJyf4K3+aAt5coTznoNgU/gTR8hnm4VuYD1DgzBnkXfHgNc/7+RunSM3v5Zk3oisPAUKbzNe5A==
X-Received: by 2002:a19:8982:: with SMTP id l124mr3050431lfd.368.1604996404361;
        Tue, 10 Nov 2020 00:20:04 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id j127sm1438603lfd.34.2020.11.10.00.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:20:03 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:19:58 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH 2/3] dt-bindings: regulator: BD71847 support commonly
 used feedback connection
Message-ID: <9b6b3d8233071d478f7d1e93b498f5a2141941e6.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BD71847 buck output voltages are in a few cases scaled using external
connection which adds a pull-up to regulator feedback pin. This connection
will adjust output voltage from regulator in a deterministic way.

Add support for describing this HW connection so that driver can adjust
voltage ranges accordingly.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../regulator/rohm,bd71847-regulator.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
index eeac32cd15d6..a1b806373853 100644
--- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
@@ -99,6 +99,55 @@ patternProperties:
           Enable/Disable control of this regulator must be left to the
           PMIC hardware state machine.
         type: boolean
+
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
