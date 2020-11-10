Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31BC2AD12A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbgKJIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:19:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37017 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJIT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:19:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id l10so13673295lji.4;
        Tue, 10 Nov 2020 00:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BKQW8UjOgNdGF9QoJkxH2Wi6SriSEQS6N7g4O9dC5LY=;
        b=Jbg2il8Xvt/Jz5PlPSLdFx5z4i40qEMJCX9lJsbfOdChAbNrnzBlqD4QKMcLV7Ew1r
         BcwTt6ES6yw2Y6svGJcXhSk1tXh2EFxiVH0BLEcZ+wgMXYrXYJtdCa5PweffBWxnJSks
         fYZMQgbdMav2chgh2i2xDYK/gYBZiPTTb4J1RezgVrv+7At5MqEKDZ6yN/PI/BTDshNP
         KNmbIA2yec+bSfGTjJ6iCdrFH4P9sSKkzR7eKZE/NQiKTH4JBWWZfOteaF1qZD1Zergg
         6OMDy645que5pVjzupayEv3KTlp+SLLJhFeG+L/d174eG1EFGTTUBeArBIMzitAHe5fo
         tttg==
X-Gm-Message-State: AOAM5302F2Y1pPwFR8Jl8EHAjYOBrf9WLhtO8kOTDNXKkfoz1WemJgKz
        ETM1GJ5edh9vcVLeI6mo7Es=
X-Google-Smtp-Source: ABdhPJwp1ygrdKtTzz8ykFX4Z/1Tu5WOcaR31C2BkPnqOX91jQzQFnmAcWBB/Ql+edh48hyn/TZN9g==
X-Received: by 2002:a2e:1556:: with SMTP id 22mr8132700ljv.416.1604996364617;
        Tue, 10 Nov 2020 00:19:24 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id l13sm2391057lje.45.2020.11.10.00.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 00:19:23 -0800 (PST)
Date:   Tue, 10 Nov 2020 10:19:16 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-power@fi.rohmeurope.com
Subject: [RFC PATCH 0/3] regulator: bd718x7: support voltage scaling
Message-ID: <cover.1604994184.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC for adding a support for typical voltage scaling connection

In few occasions there has been a need to scale the voltage output
from bucks on BD71837. Usually this is done when buck8 is used to
power specific GPU which can utilize voltages down to 0.7V. As lowest
the buck8 on BD71837 can go is 0.8V, and external connection is used to
scale the voltages.

The BD71837, BD71847 and BD71850 bucks can be adjusted by pulling up the
feedback pin using suitable voltage/resistors.

	|---------------|
	|       buck 8  |-------+----->Vout
	|               |       |
	|---------------|       |
	       |                |
	       |                |
	       +-------+--R2----+
	               |
	               R1
	               |
	       V FB-pull-up


This will scale the voltage as follows:
 - Vout_o = Vo - (Vpu - Vo)*R2/R1
 - Linear_step = step_orig*(R1+R2)/R1
where:
Vout_o is adjusted voltage output at vsel reg value 0
Vo is original voltage output at vsel reg value 0
Vpu is the pull-up voltage V FB-pull-up in the picture
R1 and R2 are resistor values.

From HW point of view this does not need to be limited to buck 8. This
connection can be used to adjust output from any of the bucks on
BD71837/47/50.

As this seems to be a 'de-facto' way to scale the voltages on BD71837 it
might be a good idea to support computing the new voltage ranges for
bucks based on the V-pull-up and resistor R1/R2 values given from
device-tree. This allows describing the external HW connection using DT
to correctly scale the voltages.

This RFC uses "rohm,feedback-pull-up-r1-ohms" and
"rohm,feedback-pull-up-r2-ohms" to provide the resistor values - but
these names (without the picture) might not be too descriptive. I am
grateful for all suggestions as better and more descriptive names.

This patch series is an RFC because this connection feels somewhat
"hacky". OTOH - when hack becomes widely used, it is less of an hack and
more of a standard - and occasionally supporting HW hacks using SW may
benefit us all, right? :)

The other thing some projects do is allowing the change of BD71837 buck8
voltages when buck8 is enabled. This however will introduce voltage
spikes as buck8 was not originally designed for this. The specific HW
platform must be evaluated to be able to tolerate these spikes. Thus
this patch series does not support buck8 voltage changes when buck8 is
enabled. I wonder if this should be allowed per some config option(?) I
don't want to help people frying their boards... Opinions? Is there
suggested way of allowing this type of features at own risk? Config or
even Some #ifdef which is not listed in Kconfig? Device-tree property?
 If you have (good) suggestions I could add the optional (non default)
DVS support for non DVS bucks on BD71837.


Matti Vaittinen (3):
  dt-bindings: regulator: BD71837 support commonly used feedback
    connection
  dt-bindings: regulator: BD71847 support commonly used feedback
    connection
  regulator: bd718x7: Support external connection to scale voltages

 .../regulator/rohm,bd71837-regulator.yaml     |  48 +++++
 .../regulator/rohm,bd71847-regulator.yaml     |  49 ++++++
 drivers/regulator/bd718x7-regulator.c         | 164 +++++++++++++++++-
 3 files changed, 254 insertions(+), 7 deletions(-)


base-commit: 3cea11cd5e3b00d91caf0b4730194039b45c5891
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
