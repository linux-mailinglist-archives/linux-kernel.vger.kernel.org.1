Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A737B2FE88D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbhAULSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbhAULPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:15:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5F442389F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611227681;
        bh=ddk3X8hCyMMRHCqndajwhV3XuynJusmedPsa5EFnhHM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZJI75GiydmUOAxuq1KkZi3ZMASu8oAaloUJuz05/n0oDj1uAmyfn1njSKoHClXXGW
         N0Yc36+jNRpViPF9f2+aJth3Tpgc+i5bBrjyiqIbkIiod++rpPPRWi6OfmpwzuM00f
         CwpjJCjII1UTZmMErdeHF1PXG5dv2JjSnLzSgGrNo3/9b3we7LSkhA2txSPoUONOoI
         pe3ELWv5rp5RDUjmh37VX6wBowOv/wmQ/d8zulax6iYEj4Zb0RIdVq0/OR8Uwody5X
         Q3wgtajJfu9RgXK4lYXT8jv5gY954srTr0F5nPYqlvIQ04zaPONE/LDrIHyrYGmOXN
         YXZ9oMFydNloA==
Received: by mail-oo1-f46.google.com with SMTP id o5so385430oop.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:14:41 -0800 (PST)
X-Gm-Message-State: AOAM533s0ZiszxoRhry5IurQB3KbpxnIEbWpeMi9G4pMfJITw4TX1sQc
        uUkU8PJSgpbABB9XwL7FBrfR6Et2e98PjC+4oFI=
X-Google-Smtp-Source: ABdhPJxTmL9XdMSlKdLOo8+neSbqdS7ux2pEcd//HgymdPtaZUakSzssVtcQkqsPe+WtTk3humMNJdS4E5u0wGjnj7I=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr9077143ooj.15.1611227680918;
 Thu, 21 Jan 2021 03:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com> <20210120132717.395873-7-mohamed.mediouni@caramail.com>
In-Reply-To: <20210120132717.395873-7-mohamed.mediouni@caramail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 21 Jan 2021 12:14:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3OjQC_tJ77u+N2UU28N6sgpTmN9cpuB0nX22PFJUx-BQ@mail.gmail.com>
Message-ID: <CAK8P3a3OjQC_tJ77u+N2UU28N6sgpTmN9cpuB0nX22PFJUx-BQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] arm64: kernel: Apple CPU start driver
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hector Martin <marcan@marcan.st>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 2:27 PM Mohamed Mediouni
<mohamed.mediouni@caramail.com> wrote:
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 14cd727d3c4b..a6ff8cb3db1e 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -176,6 +176,7 @@ properties:
>      oneOf:
>        # On ARM v8 64-bit this property is required
>        - enum:
> +          - apple
>            - psci
>            - spin-table
>        # On ARM 32-bit systems this property is optional

This uses a very generic identifier for doing something that may
be very specific to a particular SoC generation. It's going to be hard
to decide what the right abstraction will be for long-term maintenance,
so I'd recommend starting with a boot loader that implements
spin-table for secondary startup, and getting back to this after more
of the basic stuff works.

> +static int cpu_apple_start_prepare(unsigned int cpu)
> +{
> +       struct device_node *node;
> +       struct cpu_apple_start_info *info;
> +
> +       info = per_cpu_ptr(&cpu_apple_start_info, cpu);
> +
> +       if (info->pmgr_start && info->cputrc_rvbar && info->dbg_unlock)
> +               return 0;
> +
> +       node = of_find_compatible_node(NULL, NULL, "apple,startcpu");
> +       if (!node) {
> +               pr_err("%s: missing startcpu node in device tree.\n", __func__);
> +               return -EINVAL;
> +       }

Where is the binding documentation for this? The way you do a separate
of_iomap() for each CPU suggests that this is not a great binding to
start with. Are these perhaps just individual registers within a larger IP
block in the end?

      Arnd
