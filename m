Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF62B4A51
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbgKPQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgKPQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:08:16 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C06C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:08:16 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id n5so15750426ile.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYESStGAKtRivaI7ala7/9w4Y1E5hiFC107ZMldjdA0=;
        b=PIME04S2yuh00xcv/ew8BoRWNXcxwwXikY/oKGMYfQDfOhKMKqxbvI5zE0XEojzmIL
         fP1Dq2ACY8i0tSuOowJ0pXcrqHpbNcMx/7cXaq1E4CQiYgHyOU0mW2oJo4D6jw4uEw0r
         0YNdhoVexSnnIcnaiVgn8WuUjZqFa/8MlpLIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYESStGAKtRivaI7ala7/9w4Y1E5hiFC107ZMldjdA0=;
        b=Y10mONzl/WLg+vu3o08U3tTPY+kAlilOIsrTUaKva3DyXDtkcyD/tJwt9hMSvuXCAM
         deFp7KXLhBwxiyd8glJPpAQh3GpkZK8cgP4AtJvJA4cuJFAW6qfNExe2Z2HXHkqMjIyZ
         kt983d/A8Pvy4sw4CDQ/5hA+QOUWSB9PN07iY6HNDqS66VAbKAoYHN8qia3cuOlcWvin
         IAlh5owb61lMO3o9SX+avPajWynNYwNiAKWLTNzW0rxQ3JVYmGfduUgVeDOxDcQbMaKv
         jksMDUcNOAqYEVQt9YXY5pfsF6DdNZWVbqvW7PvwchDZ4207JLRQm01YfXSe+49MMJpS
         tHkA==
X-Gm-Message-State: AOAM532Sdc78iflksm6AZfY5KqhejJdHjNANH1Lr2EZridXdRtFaKztb
        Ydp5/qEWRiuPIzjt7pcxmxYNXU+XWPMkQkonSqXR
X-Google-Smtp-Source: ABdhPJzUUHJyuXJ1duZZEAnozYsMbeM2qHFZmyqTe/AtJl9ylg9U5pPO43vAy8+qk+4tC/qsYULKaca4u7Xyar01sAs=
X-Received: by 2002:a92:512:: with SMTP id q18mr8655253ile.147.1605542895690;
 Mon, 16 Nov 2020 08:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20201113202550.3693323-1-atish.patra@wdc.com> <20201113202550.3693323-3-atish.patra@wdc.com>
 <20201116150129.GA1643948@bogus>
In-Reply-To: <20201116150129.GA1643948@bogus>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 16 Nov 2020 08:08:04 -0800
Message-ID: <CAOnJCULj2F1ZMsWwA8KT-6yVi2bK7usw1EUJfrxTiVtrDqYAXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] dt-bindings: riscv: microchip: Add YAML
 documentation for the PolarFire SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, Cyril.Jean@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Anup Patel <anup.patel@wdc.com>, Conor.Dooley@microchip.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ivan.Griffin@microchip.com, Rob Herring <robh+dt@kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:23 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 13 Nov 2020 12:25:48 -0800, Atish Patra wrote:
> > Add YAML DT binding documentation for the Microchip PolarFire SoC.
> > It is documented at:
> >
> > https://www.microsemi.com/products/fpga-soc/polarfire-soc-icicle-quick-start-guide
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  .../devicetree/bindings/riscv/microchip.yaml  | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
> >
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/riscv/microchip.yaml: $id: relative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/riscv/microchip.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/riscv/sifive.yaml: duplicate '$id' value 'http://devicetree.org/schemas/riscv/sifive.yaml#'
>
>

Thanks for catching this. It was a copy paste error. I will fix it next version.

> See https://patchwork.ozlabs.org/patch/1400088
>
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
