Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6459C2A46E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgKCNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:52:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52390 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbgKCNwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:52:05 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3Dpn4a108643;
        Tue, 3 Nov 2020 07:51:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604411509;
        bh=L/e82f7swU3+d1b8kV7l8FO2jyfC9UbSSrjiYERfAO8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZQN8ezDIW/G1zvoWvLUGKMJCrGJtppBlNSeem3MIeY1j4V3HRXife/7kYdSd/ibvq
         9IUuwtDwIziuFONXvmCsTdWWPW+ubqUUaP1q468m5+01J6nz7Hx1y93skBgLGrOc90
         JF1ebcHnInbOk1aneAC/F+V1Wrq8iMQjLVvDC+y8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3DpnEV027602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 07:51:49 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 07:51:48 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 07:51:48 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3DpjW7030507;
        Tue, 3 Nov 2020 07:51:46 -0600
Subject: Re: [GIT PULL] irqchip updates for 5.10, take #1
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greentime Hu <greentime.hu@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <20201101122223.255806-1-maz@kernel.org>
 <CAL_JsqLp9PRbumKTf0r8+LbFmR740dQPerrQDJF14XtpwxG0Rw@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d9c9c1be-022f-3202-d599-26a7baea61c4@ti.com>
Date:   Tue, 3 Nov 2020 15:52:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLp9PRbumKTf0r8+LbFmR740dQPerrQDJF14XtpwxG0Rw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On 03/11/2020 15.39, Rob Herring wrote:
> On Sun, Nov 1, 2020 at 6:22 AM Marc Zyngier <maz@kernel.org> wrote:
>>
>> Hi Thomas,
>>
>> Here's a smallish set of fixes for 5.10. Some fixes after the
>> IPI-as-IRQ (I expect a couple more next week), two significant bug
>> fixes for the SiFive PLIC, and a TI update to handle their "unmapped
>> events". The rest is the usual set of cleanups and tidying up.
>>
>> Please pull,
>>
>>         M.
>>
>> The following changes since commit 63ea38a402213d8c9c16e58ee4901ff51bc8fe3c:
>>
>>   Merge branch 'irq/mstar' into irq/irqchip-next (2020-10-10 12:46:54 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.10-1
>>
>> for you to fetch changes up to d95bdca75b3fb41bf185efe164e05aed820081a5:
>>
>>   irqchip/ti-sci-inta: Add support for unmapped event handling (2020-11-01 12:00:50 +0000)
>>
>> ----------------------------------------------------------------
>> irqchip fixes for Linux 5.10, take #1
>>
>> - A couple of fixes after the IPI as IRQ patches (Kconfig, bcm2836)
>> - Two SiFive PLIC fixes (irq_set_affinity, hierarchy handling)
>> - "unmapped events" handling for the ti-sci-inta controller
>> - Tidying up for the irq-mst driver (static functions, Kconfig)
>> - Small cleanup in the Renesas irqpin driver
>> - STM32 exti can now handle LP timer events
>>
>> ----------------------------------------------------------------
>> Fabrice Gasnier (1):
>>       irqchip/stm32-exti: Add all LP timer exti direct events support
>>
>> Geert Uytterhoeven (2):
>>       irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
>>       irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm
>>
>> Greentime Hu (2):
>>       irqchip/sifive-plic: Fix broken irq_set_affinity() callback
>>       irqchip/sifive-plic: Fix chip_data access within a hierarchy
>>
>> Marc Zyngier (4):
>>       genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY
>>       irqchip/mst: Make mst_intc_of_init static
>>       irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY
>>       irqchip/bcm2836: Fix missing __init annotation
>>
>> Peter Ujfalusi (2):
>>       dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling
> 
> This breaks dt_binding_check in linux-next:
> 
> Traceback (most recent call last):
>   File "/usr/local/bin/dt-extract-example", line 45, in <module>
>     binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py",
> line 343, in load
>     return constructor.get_single_data()
>   File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py",
> line 111, in get_single_data
>     node = self.composer.get_single_node()
>   File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
>   File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
>   File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
>   File "_ruamel_yaml.pyx", line 891, in
> _ruamel_yaml.CParser._compose_mapping_node
>   File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
> ruamel.yaml.parser.ParserError: while parsing a block mapping
>   in "<unicode string>", line 4, column 1
> did not find expected key
>   in "<unicode string>", line 37, column 2
> make[1]: *** [Documentation/devicetree/bindings/Makefile:20:
> Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.example.dts]
> Error 1
> make[1]: *** Deleting file
> 'Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.example.dts'
> ./Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml:37:2:
> [error] syntax error: expected <block end>, but found '<scalar>'
> (syntax)
> 
> Looks like it's the block diagram change which needs more indentation.

Sorry, I have sent a fix:
https://lore.kernel.org/lkml/20201103135004.2363-1-peter.ujfalusi@ti.com/

> 
> Rob
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
