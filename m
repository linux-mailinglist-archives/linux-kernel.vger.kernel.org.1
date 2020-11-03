Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C302A46BA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgKCNjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:39:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgKCNjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:39:44 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E20922404
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 13:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604410783;
        bh=sfMqMzyu6k9ENRyV31konN+k8AwCJW9nINoMClEJ8HI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J8g2CPeQ/aDOaq4IXeNQCZc+Rol3ms5i2FX87fYUTXPAd0FVlswBcAIneEiP7il4/
         Wv2wR5H6TGjAr+kTjph6hLlxQD4VcRTVeMEdZGQoBpxA9xYT0uPTgp6hYMZmGfZ+R4
         T77zbKyPW1M7NSaAv3L2WhWKd3al7LbComqnaYOI=
Received: by mail-ot1-f44.google.com with SMTP id j14so5739286ots.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 05:39:43 -0800 (PST)
X-Gm-Message-State: AOAM531ZDrM7D+Rca3aKBdHhmQrmcQEedgOsOEAj7uA9An3MFSUEXTlo
        Q9byNm/zbAO4c7epP0skaOpFkNLGuKvp9xEZUg==
X-Google-Smtp-Source: ABdhPJxUCjwQZQL5G3MpL0TjyvFT/A+mnPfovePtHFKpYyctOppY6fvaTiRQyNO9hrRKRtYHyiwZ9lhATEW/9qiAdQ4=
X-Received: by 2002:a9d:6e0c:: with SMTP id e12mr4740766otr.129.1604410782206;
 Tue, 03 Nov 2020 05:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20201101122223.255806-1-maz@kernel.org>
In-Reply-To: <20201101122223.255806-1-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Nov 2020 07:39:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLp9PRbumKTf0r8+LbFmR740dQPerrQDJF14XtpwxG0Rw@mail.gmail.com>
Message-ID: <CAL_JsqLp9PRbumKTf0r8+LbFmR740dQPerrQDJF14XtpwxG0Rw@mail.gmail.com>
Subject: Re: [GIT PULL] irqchip updates for 5.10, take #1
To:     Marc Zyngier <maz@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Daniel Palmer <daniel@thingy.jp>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greentime Hu <greentime.hu@sifive.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 1, 2020 at 6:22 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Thomas,
>
> Here's a smallish set of fixes for 5.10. Some fixes after the
> IPI-as-IRQ (I expect a couple more next week), two significant bug
> fixes for the SiFive PLIC, and a TI update to handle their "unmapped
> events". The rest is the usual set of cleanups and tidying up.
>
> Please pull,
>
>         M.
>
> The following changes since commit 63ea38a402213d8c9c16e58ee4901ff51bc8fe3c:
>
>   Merge branch 'irq/mstar' into irq/irqchip-next (2020-10-10 12:46:54 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-fixes-5.10-1
>
> for you to fetch changes up to d95bdca75b3fb41bf185efe164e05aed820081a5:
>
>   irqchip/ti-sci-inta: Add support for unmapped event handling (2020-11-01 12:00:50 +0000)
>
> ----------------------------------------------------------------
> irqchip fixes for Linux 5.10, take #1
>
> - A couple of fixes after the IPI as IRQ patches (Kconfig, bcm2836)
> - Two SiFive PLIC fixes (irq_set_affinity, hierarchy handling)
> - "unmapped events" handling for the ti-sci-inta controller
> - Tidying up for the irq-mst driver (static functions, Kconfig)
> - Small cleanup in the Renesas irqpin driver
> - STM32 exti can now handle LP timer events
>
> ----------------------------------------------------------------
> Fabrice Gasnier (1):
>       irqchip/stm32-exti: Add all LP timer exti direct events support
>
> Geert Uytterhoeven (2):
>       irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
>       irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm
>
> Greentime Hu (2):
>       irqchip/sifive-plic: Fix broken irq_set_affinity() callback
>       irqchip/sifive-plic: Fix chip_data access within a hierarchy
>
> Marc Zyngier (4):
>       genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY
>       irqchip/mst: Make mst_intc_of_init static
>       irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY
>       irqchip/bcm2836: Fix missing __init annotation
>
> Peter Ujfalusi (2):
>       dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling

This breaks dt_binding_check in linux-next:

Traceback (most recent call last):
  File "/usr/local/bin/dt-extract-example", line 45, in <module>
    binding = yaml.load(open(args.yamlfile, encoding='utf-8').read())
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/main.py",
line 343, in load
    return constructor.get_single_data()
  File "/usr/local/lib/python3.8/dist-packages/ruamel/yaml/constructor.py",
line 111, in get_single_data
    node = self.composer.get_single_node()
  File "_ruamel_yaml.pyx", line 706, in _ruamel_yaml.CParser.get_single_node
  File "_ruamel_yaml.pyx", line 724, in _ruamel_yaml.CParser._compose_document
  File "_ruamel_yaml.pyx", line 775, in _ruamel_yaml.CParser._compose_node
  File "_ruamel_yaml.pyx", line 891, in
_ruamel_yaml.CParser._compose_mapping_node
  File "_ruamel_yaml.pyx", line 904, in _ruamel_yaml.CParser._parse_next_event
ruamel.yaml.parser.ParserError: while parsing a block mapping
  in "<unicode string>", line 4, column 1
did not find expected key
  in "<unicode string>", line 37, column 2
make[1]: *** [Documentation/devicetree/bindings/Makefile:20:
Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.example.dts]
Error 1
make[1]: *** Deleting file
'Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.example.dts'
./Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml:37:2:
[error] syntax error: expected <block end>, but found '<scalar>'
(syntax)

Looks like it's the block diagram change which needs more indentation.

Rob
