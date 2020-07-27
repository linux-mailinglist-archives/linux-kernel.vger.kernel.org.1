Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4566C22EAE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 13:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG0LJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 07:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG0LJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:09:23 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563D2C061794;
        Mon, 27 Jul 2020 04:09:23 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w126so8712022pfw.8;
        Mon, 27 Jul 2020 04:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MW0MiZ4Un8fYtTrl+x7jVZHspHstStb50IKw8Wvbd5U=;
        b=n3SWT0n3IRqo/XZpzAMCvIjA2bsgz18mz3lk/BZ8mdf6tc/d5H8HBM6+bPfcA5uDd1
         NK3BzFKo/8n+YcZleEuePGgFdERx2TwUf9OkjOmq38APw91WCwgQxtsJH92KJO7uqCBs
         3bsqBoKYvM9BFB9xyGXI387chNDo0DAgzittyDl8CO+zUfwyeAfWqpyfCIfBzricbULG
         a7w0KyarV0Q8ADxt8Y+hDtoJZDrqxB0sWQD9Gp7Z/lhpi01Z42FyVtXbBc1q85BnqzXu
         T/NdDaXJ0TLefqccc/HBBFAJzxpHREQtbHzwCWAPW/Hi2+M7vTMe3GdCSvCxow4WV1nV
         0umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MW0MiZ4Un8fYtTrl+x7jVZHspHstStb50IKw8Wvbd5U=;
        b=IExg+qvpYJ3S5rsb/+MWweey7LDMdrIwdkEnc95apB/TpjZHLrk0IKguPj81pzXATE
         Qkm3cPpWVep2CcIhT2i0B7i3NT01omq23pBq9nunOHZnw/bA0aJ3SVTrNkBbtkw/w+vB
         cV7i/kn72OrKQcVcSQvFIOqs4uU7MkhkZqZbLvz1S3NppP+WSX3w2dND/lgR7vXi/Q/z
         jgNfyB8sMYOnF/goxkTsjcjbQtE8lak8QtdWHazGPB5Ij7sTEXBrs4tJGFttQbJld91O
         fg0k3mswErS5un6x/8jI7DD15b3ialS9cSNfbJx3MeDqIck/iteGqQ3VliHJPMmVKwLa
         6EMg==
X-Gm-Message-State: AOAM531N3KX2c2Ofs6pdouilRGK9L0RgQaJF+LgLaAaSJkZadgcyEuYE
        cd2wIhW/VmGFDxE41PW2vZZnIYeLti8qklcAA+117AkS
X-Google-Smtp-Source: ABdhPJwdOd5Pg+MJNemvTNNuhslAQA/KR66D738X15SQC3w6UkiaGGcHyDy3kerE7prulrKtu4m5Bgrsg7nnRf1dWZs=
X-Received: by 2002:a63:924b:: with SMTP id s11mr18746092pgn.74.1595848162878;
 Mon, 27 Jul 2020 04:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200727100336.32153-1-vadivel.muruganx.ramuthevar@linux.intel.com>
In-Reply-To: <20200727100336.32153-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 14:09:08 +0300
Message-ID: <CAHp75VeO86j-onVJX-M7YmOZeQuX=Jx58jnT3dLkwCsBom1aTQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] phy: Add USB PHY support on Intel LGM SoC
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Felipe Balbi <balbi@kernel.org>, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 1:08 PM Ramuthevar,Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
> Requires minimal external components, a single resistor, for best operation.
> Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable
> ---

> v7:
>   - No Change

I guess it's not the correct changelog entry.
You moved file to another subsystem, didn't you?

> v6:
>   - No Change
> v5:
>   - As per Felipe and Greg's suggestion usb phy driver reviewed patches
>     changed the folder from drivers/usb/phy to drivers/phy
>   - Reviewed-By tag added in commit message
> v4:
>   - Andy's review comments addressed
>   - drop the excess error debug prints
>   - error check optimized
>   - merge the split line to one line
> v3:
>   - Andy's review comments update
>   - hardcode return value changed to actual return value from the callee
>   - add error check is fixed according to the above
>   - correct the assignment in redundant
>   - combine the split line into one line
> v2:
>   - Address Phillip's review comments
>   - replace devm_reset_control_get() by devm_reset_control_get_exclusive()
>   - re-design the assert and deassert fucntion calls as per review comments
>   - address kbuild bot warnings
>   - add the comments
> v1:
>   - initial version
>
> ---
> dt-bindings: usb: Add USB PHY support for Intel LGM SoC
> v7:
>   - Fixed the bot issue: usb-phy@e7e00000: '#phy-cells' is a required property
> v6:
>   - Fixed the bot issue.
>   - replace node-name by usb-phy@ in example
> v5:
>   - Reviewed-By tag added
> v4:
>   - No Change
> v3:
>   - No Change
> v2:
>   - No Change
> v1:
>   - initial version
>
>
> Ramuthevar Vadivel Murugan (2):
>   dt-bindings: phy: Add USB PHY support for Intel LGM SoC
>   phy: Add USB3 PHY support for Intel LGM SoC
>
>  .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml |  58 +++++
>  drivers/phy/Kconfig                                |  11 +
>  drivers/phy/Makefile                               |   1 +
>  drivers/phy/phy-lgm-usb.c                          | 278 +++++++++++++++++++++
>  4 files changed, 348 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
>  create mode 100644 drivers/phy/phy-lgm-usb.c
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
