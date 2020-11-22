Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A12BFC12
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 23:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKVWOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 17:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKVWOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 17:14:50 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CE1C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:14:50 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id k27so20611796ejs.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 14:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+yX6CsGNQbM1v0n4fLwCiOP2202vjWiqw6FCv8piRAk=;
        b=us2dV3RbpS8hX8nmkSvdMorGnrP+/N3Ck1+adQU4aYNz/p0jUTdvXE6XBeFrQAwnKR
         Ybz2HH4YNX4H3EyCXa8NZ+eeXQYytema0UZE3u7F51tPJrpqoleuu3rOITHYdfFJ/tXK
         K7zM6s0YfUWlixl/yQwv8k/YxqMrIBUNTezRfjTUFtQpwAnTCaOC1xON3FThtGQjr7mf
         IfiOmYBpxDQnGQickaPOIPk/kfqWQWbpCB0NMO+MJ7o/NlKH/j9ftGQF4+YC3QkX6Ko6
         iOVEvUZE0PlfdV+e2C3BxVJFjeaWgxe8E8csoPfY2ijVacFZQo+aeuoSbX4zlI3U5K8e
         yAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yX6CsGNQbM1v0n4fLwCiOP2202vjWiqw6FCv8piRAk=;
        b=QCmrWdY/83ctIDXpdQJnuyxMlnWpByHOXl3oiFvBd7rKa63zWfbTT5NZKMC+hs0HB+
         y7DOsgoFaE6QIFLMfS4TTo/M6l5IY5oUgERG3N1sfBxFnnVG/rtzhTZa+Y9xbe0o/CYb
         XbM7xEUARroqpTgKe56FfbXsE3bq57lz2RWEcrA1/THCeo8bzc5PxT5r6GYAg2QdHXwV
         a/+iAoWmrRLttw9aR08O8esL1HunqYj7QxmoButBwU46vkwRfwsTGsH37Rz/id1PBZLj
         8oSaffZ+hBO2pUjyBvqnK0rfgrs8zlmle/hdDP8PUyoP0T/DrHwA0sG7br8cjQBsZAsv
         6O1g==
X-Gm-Message-State: AOAM5334OSBnVvJmoC6nL4pVzOhM2o6V/li2DJmYjy9EW38wb03IpvGh
        oIOsOjA9G/NC2Lg/kcn4zz2J1+MljGgBjIGc5vc=
X-Google-Smtp-Source: ABdhPJy91vmF6noNwrJeQlCEo3WVCRUF5EO22hfLsdERxI3CU1eXejb5kUzUiZ2iWvUkvhEnOsbcIP9ZIR//7CGL144=
X-Received: by 2002:a17:906:bce6:: with SMTP id op6mr41182955ejb.2.1606083288744;
 Sun, 22 Nov 2020 14:14:48 -0800 (PST)
MIME-Version: 1.0
References: <20201120153229.3920123-1-narmstrong@baylibre.com> <20201120153229.3920123-4-narmstrong@baylibre.com>
In-Reply-To: <20201120153229.3920123-4-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 22 Nov 2020 23:14:37 +0100
Message-ID: <CAFBinCDLF2bL6sQFBsNTNZV5i9u+KW01O3SqbR=riRru5d8zRQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: meson-axg: add PCIe nodes
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

(I have to admit that for me the PCI(e) bindings are very complex, so
I may be mixing up things. I am still sending this review mail because
"you're doing it different than in meson-g12-common.dtsi")

On Fri, Nov 20, 2020 at 4:33 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> +               pcieA: pcie@f9800000 {
> +                       compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +                       reg = <0x0 0xf9800000 0x0 0x400000>,
> +                             <0x0 0xff646000 0x0 0x2000>,
> +                             <0x0 0xf9f00000 0x0 0x100000>;
> +                       reg-names = "elbi", "cfg", "config";
> +                       interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +                       bus-range = <0x0 0xff>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       ranges = <0x82000000 0 0xf9c00000 0x0 0xf9c00000 0 0x00300000>;
only PCI IO space here, no PCI MEM space?

[...]
> +               pcieB: pcie@fa000000 {
> +                       compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +                       reg = <0x0 0xfa000000 0x0 0x400000>,
> +                             <0x0 0xff648000 0x0 0x2000>,
> +                             <0x0 0xfa400000 0x0 0x100000>;
> +                       reg-names = "elbi", "cfg", "config";
> +                       interrupts = <GIC_SPI 167 IRQ_TYPE_EDGE_RISING>;
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0>;
> +                       interrupt-map = <0 0 0 0 &gic GIC_SPI 169 IRQ_TYPE_EDGE_RISING>;
> +                       bus-range = <0x0 0xff>;
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       ranges = <0x82000000 0 0xfa500000 0x0 0xfa500000 0 0x00300000>;
same as above: only PCI IO space here, no PCI MEM space?


Best regards,
Martin
