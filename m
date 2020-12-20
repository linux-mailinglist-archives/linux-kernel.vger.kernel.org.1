Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8B12DF36A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 04:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgLTDkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 22:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgLTDkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 22:40:02 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608435561;
        bh=SDbbC9xAE1LVkneeTOYgnsdezXsc1NQUo7UQYlejktU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FUWuOVTaVfpHd4TKWmLv6mubhHNgaTPgEqdMhSCO4fds25VvdGsF7+e14IgiIbtdo
         DllBTPBfFSXKcJ+I53MqrFtY6RjL9ghNLWcrL+YskoboS8TQUucJOTbHP9ZvLgwsh0
         13kgujbRDN7NUtmFePaSdJwCD/fDIcJLHMW7/eXiYnxuVejafO54Svv79S99+fLZT7
         Vznjam6gfDHhS6AaRNFm0+ogC04SVYabHN7hOoGWa4NUEH3E+O2ztcZN8zpOsEpOy6
         XJAh8TBdZQbVV3CMOmMIDVPLjwaLdttfDnkRGpEXqF83M2Sl1gycWz9+/FzGm+FMlk
         GqkPLTIuDKDYA==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201114135044.724385-3-daniel@0x0f.com>
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-3-daniel@0x0f.com>
Subject: Re: [PATCH 2/6] dt-bindings: clk: mstar msc313 mpll binding description
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
To:     Daniel Palmer <daniel@0x0f.com>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Sat, 19 Dec 2020 19:39:20 -0800
Message-ID: <160843556037.1580929.13575770228476494246@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2020-11-14 05:50:40)
> Add a binding description for the MStar/SigmaStar MPLL clock block.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  .../bindings/clock/mstar,msc313-mpll.yaml     | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mstar,msc313-=
mpll.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/mstar,msc313-mpll.ya=
ml b/Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
> new file mode 100644
> index 000000000000..9ddc1163b31b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/mstar,msc313-mpll.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MStar/Sigmastar MSC313 MPLL
> +
> +maintainers:
> +  - Daniel Palmer <daniel@thingy.jp>
> +
> +description: |
> +  The MStar/SigmaStar MSC313 and later ARMv7 chips have an MPLL block th=
at
> +  takes the external xtal input and multiplies it to create a high
> +  frequency clock and divides that down into a number of clocks that
> +  peripherals use.
> +
> +properties:
> +  compatible:
> +    const: mstar,msc313-mpll
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-output-names:
> +    minItems: 8
> +    maxItems: 8
> +    description: |
> +      This should provide a name for the internal PLL clock and then
> +      a name for each of the divided outputs.

Is this necessary?

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +  - clock-output-names
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mpll@206000 {
> +        compatible =3D "mstar,msc313-mpll";
> +        reg =3D <0x206000 0x200>;
> +        #clock-cells =3D <1>;
> +        clocks =3D <&xtal>;
> +        clock-output-names =3D "mpll", "mpll_div_2",
> +                             "mpll_div_3", "mpll_div_4",
> +                             "mpll_div_5", "mpll_div_6",
> +                             "mpll_div_7", "mpll_div_10";

It looks like it can be derived in the driver.
