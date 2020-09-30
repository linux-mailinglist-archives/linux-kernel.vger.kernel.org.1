Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF78D27E356
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgI3IHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3IHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:07:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C206C061755;
        Wed, 30 Sep 2020 01:07:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 28B3929AF81
Subject: Re: DT warnings in Cros EC
To:     Rob Herring <robh@kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
References: <CAL_JsqJQDgGVwhc9JFuoG7-_cvV3fhLvd95k=0qKgxM+UsMm-g@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1defbf05-33da-c251-7c2c-6f7ec7ec8999@collabora.com>
Date:   Wed, 30 Sep 2020 10:07:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJQDgGVwhc9JFuoG7-_cvV3fhLvd95k=0qKgxM+UsMm-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 28/9/20 18:49, Rob Herring wrote:
> There's a bunch of warnings in the Cros EC schemas. They stem from
> child node names needing to be defined. I started fixing, but it's
> kind of a mess as there's a mixture of no unit addresses and different
> unit address spaces (regulators and codec). And is type-C and extcon
> mutually exclusive? I gave up, so please fix these:
> 
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.example.dt.yaml:
> cros-ec@0: 'extcon0', 'extcon1' do not match any of the regexes:
> 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> bindings/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dt.yaml:
> cros-ec@0: 'ec-pwm' does not match any of the regexes:
> 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.example.dt.yaml:
> ec@0: '#address-cells', '#size-cells', 'regulator@0' do not match any
> of the regexes: 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.example.dt.yaml:
> ec@0: 'typec' does not match any of the regexes: 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dt.yaml:
> cros-ec@0: '#address-cells', '#size-cells', 'ec-codec@10500000' do not
> match any of the regexes: 'pinctrl-[0-9]+'
> From schema: /builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> 

We will take a look soon and send patches to fix it.

Thanks,
  Enric

> 
> Rob
> 
