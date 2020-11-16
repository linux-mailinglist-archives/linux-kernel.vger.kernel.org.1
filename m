Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40AB2B4A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbgKPQOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:14:38 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:20605 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbgKPQOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:14:38 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 1BFEB24001F;
        Mon, 16 Nov 2020 16:14:34 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Lars Povlsen <lars.povlsen@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steen.Hegelund@microchip.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: convert icpu intr bindings to json-schema
In-Reply-To: <20201116144631.GA1623670@bogus>
References: <20201112160424.1383051-1-gregory.clement@bootlin.com> <20201112160424.1383051-2-gregory.clement@bootlin.com> <20201116144631.GA1623670@bogus>
Date:   Mon, 16 Nov 2020 17:14:34 +0100
Message-ID: <8736196zyt.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> On Thu, 12 Nov 2020 17:04:20 +0100, Gregory CLEMENT wrote:
>> Convert device tree bindings for Microsemi Ocelot SoC ICPU Interrupt
>> Controller to YAML format
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>  .../mscc,ocelot-icpu-intr.txt                 | 21 -------
>>  .../mscc,ocelot-icpu-intr.yaml                | 59 +++++++++++++++++++
>>  2 files changed, 59 insertions(+), 21 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
>> 
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml:59:4: [error] no new line character at the end of file (new-line-at-end-of-file)
>
> dtschema/dtc warnings/errors:
> make[1]: *** [Documentation/devicetree/bindings/Makefile:59: Documentation/devicetree/bindings/processed-schema-examples.json] Error 123
> make: *** [Makefile:1364: dt_binding_check] Error 2
>
>
> See https://patchwork.ozlabs.org/patch/1399077
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:

I actually ran 'make dt_binding_check' and in the documentation there
was no reference of Documentation/devicetree/writing-schema.rst the need
of 'yamllint' while in the dependencies section of it was mentioned the
need of 'libyaml-dev'.

What do you think about updating the documentation ?

>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.

Sure I am doing it right now.

Gregory


>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
