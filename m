Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B246427B288
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgI1Qtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgI1Qta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:49:30 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFEE32073A;
        Mon, 28 Sep 2020 16:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601311769;
        bh=52/n7J68HPDAfN16/0B5MYZGSzQonargNRaS9RFigj8=;
        h=From:Date:Subject:To:Cc:From;
        b=cID8n1MYrP8RxpQBeFDDEHHMiWGIBrA4CYWbe+QeR1Um+z7lxV29CPQL23Uyy7PHb
         16Z5tcqPlUnPuTH2ttgyuLmv2UfV4+RTrSXw8nkCkX4zrFmq/zi67hGkV8uO7LfEZj
         t8Sk4s5rciPx9fZMyMtEW7IB1w5ywj3OHwMjbKCQ=
Received: by mail-ot1-f54.google.com with SMTP id c2so1583833otp.7;
        Mon, 28 Sep 2020 09:49:29 -0700 (PDT)
X-Gm-Message-State: AOAM533V3qbXD4ecyJpYR+ykCaSVrlXQNhsiKQpHU/QIY7cbtjF5+lVV
        ZRjRsS3nEYD1WZ67K2254rgs4CSy9T5Z80M66A==
X-Google-Smtp-Source: ABdhPJzlaHZTTP0RcmZwhBshVlLKVoC/0ySzAXTwNAFI67yXcKn/h/jeYprll6eabUQY3gY02Zj2CBo1qOyA3Kq4aC8=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr1591275otp.129.1601311769155;
 Mon, 28 Sep 2020 09:49:29 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Sep 2020 11:49:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJQDgGVwhc9JFuoG7-_cvV3fhLvd95k=0qKgxM+UsMm-g@mail.gmail.com>
Message-ID: <CAL_JsqJQDgGVwhc9JFuoG7-_cvV3fhLvd95k=0qKgxM+UsMm-g@mail.gmail.com>
Subject: DT warnings in Cros EC
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bunch of warnings in the Cros EC schemas. They stem from
child node names needing to be defined. I started fixing, but it's
kind of a mess as there's a mixture of no unit addresses and different
unit address spaces (regulators and codec). And is type-C and extcon
mutually exclusive? I gave up, so please fix these:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.example.dt.yaml:
cros-ec@0: 'extcon0', 'extcon1' do not match any of the regexes:
'pinctrl-[0-9]+'
From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
bindings/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dt.yaml:
cros-ec@0: 'ec-pwm' does not match any of the regexes:
'pinctrl-[0-9]+'
From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.example.dt.yaml:
ec@0: '#address-cells', '#size-cells', 'regulator@0' do not match any
of the regexes: 'pinctrl-[0-9]+'
From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.example.dt.yaml:
ec@0: 'typec' does not match any of the regexes: 'pinctrl-[0-9]+'
From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dt.yaml:
cros-ec@0: '#address-cells', '#size-cells', 'ec-codec@10500000' do not
match any of the regexes: 'pinctrl-[0-9]+'
From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml


Rob
