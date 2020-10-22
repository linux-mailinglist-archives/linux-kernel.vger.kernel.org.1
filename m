Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81170295CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896663AbgJVKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:46:18 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:20166 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896648AbgJVKqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:46:16 -0400
IronPort-SDR: XapIwb8i3uk1cwC3ztGZfnSS/HXwbJiTmqqEEpIb/k8HxyQdtPUohVcX4dizKdIT11lB0jcyrf
 WQzC0Pqkmju8FMXj1NSvcEVyq3X8EAWaGtzmdsE7zjONvy0sbnWUqKc+COJ2V0FSTy5j7QlDrJ
 Ld7pQoL0SR7BosJz7AUDeq5PXZjEOWAuQTeNgDd2yKEdLqqNeGUG22Sl/s45uIMHYizNfS+0b3
 XVrtpq8GlMC3KsxWlYUbqerDZecXGm379YIqCZBdOjr5lrNbNZhsYzxM6mFOFdaUEKzJJ04Aa0
 LcY=
X-IronPort-AV: E=Sophos;i="5.77,404,1596492000"; 
   d="scan'208";a="14395397"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 22 Oct 2020 12:46:13 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 22 Oct 2020 12:46:13 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 22 Oct 2020 12:46:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1603363573; x=1634899573;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uCTyHtDHAC79z1cV/GhdEVjbHSLsQaC5sA5W/YNo7I=;
  b=VKCrPjxMwupNk5LFSO43+EeGYG/Kw/ZTYmJogzVfklLgeiFa1+RayuoS
   QI3sDoOdehfSDSACG//Kj99qv2t3CUaZAKD5sIins7IXt1/xSrYBkAU3a
   Xuq/+LA2z6PjmDPT7mjFF1tgk8vmHeIqloLxqrX/bZDQ62nLmLdWe2hxq
   pcVJ2ZJqLE83UUyG4WwUUgKRt7KlXRaHN/SUHcDjXtbZypvyRi7iqr+l4
   DwXeVB6o03YtD0F6dO4HCwDgMBXi6sP+wHsVCqg1OP0yM3svCIkaRXOo/
   yClLGT30v6mQ+IbxkJl3/Te8Fo64dlI/lAU4nnZQ+VrSjvvwSi4Yz9VfU
   w==;
IronPort-SDR: qzd9pZJm7C6jOTigG1dVilYkX+p9SQnSApPSEl1SHrsKG3/6lEU7SkDOIYfDDdiopzhST+1NW0
 VN/Nx5jHM7aYXIHei0iXSohmlMkBWPeL3AFrYHnW2y8wBLosoox3A5zomiO84VVyXPKubDqiJS
 4t0jtHYxZivaCdOPNZMYAelWiqi2VGb+JCAWgnvFuGaC01zhRj/Cd0IA9dlhEyBHr1DUzN7FpN
 YwD9Aa0M8MUSP630gaXgtH9jZ2d+etZruFg0kJTRVw6EYCAGk/yk0XS19XuBbx4wYJ4Oc4azy8
 Zlw=
X-IronPort-AV: E=Sophos;i="5.77,404,1596492000"; 
   d="scan'208";a="14395396"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Oct 2020 12:46:13 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id AB40C280070;
        Thu, 22 Oct 2020 12:46:13 +0200 (CEST)
Message-ID: <c2bb85080bde0721f88c769cafa58120e901a893.camel@ew.tq-group.com>
Subject: Re: [PATCH 01/13] dt-bindings: arm: fsl: update TQ-Systems SoMs and
 boards based on i.MX7
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 22 Oct 2020 12:46:11 +0200
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-18 at 13:29 +0200, Matthias Schiffer wrote:
> Introduce compatible strings for the TQMa7x SoMs.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>


Hello Shawn,

what is the status of this patch series? I've found the series marked
as "archived" in patchwork [1], but I can't find it in any public Git
repo. Am I looking at the wrong patchwork project?

Kind regards,
Matthias

[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=351407&state=%2A&archive=both


> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 71acf14da715..d7233cef4d38 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -298,7 +298,12 @@ properties:
>                - toradex,colibri-imx7s           # Colibri iMX7 Solo Module
>                - toradex,colibri-imx7s-aster     # Colibri iMX7 Solo Module on Aster Carrier Board
>                - toradex,colibri-imx7s-eval-v3   # Colibri iMX7 Solo Module on Colibri Evaluation Board V3
> -              - tq,imx7s-mba7             # i.MX7S TQ MBa7 with TQMa7S SoM
> +          - const: fsl,imx7s
> +
> +      - description: TQ-Systems TQMa7S SoM on MBa7x board
> +        items:
> +          - const: tq,imx7s-mba7
> +          - const: tq,imx7s-tqma7
>            - const: fsl,imx7s
>  
>        - description: i.MX7D based Boards
> @@ -320,11 +325,16 @@ properties:
>                                                          #  Colibri Evaluation Board V3
>                - toradex,colibri-imx7d-eval-v3           # Colibri iMX7 Dual Module on
>                                                          #  Colibri Evaluation Board V3
> -              - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
>                - zii,imx7d-rmu2            # ZII RMU2 Board
>                - zii,imx7d-rpu2            # ZII RPU2 Board
>            - const: fsl,imx7d
>  
> +      - description: TQ-Systems TQMa7D SoM on MBa7x board
> +        items:
> +          - const: tq,imx7d-mba7
> +          - const: tq,imx7d-tqma7
> +          - const: fsl,imx7d
> +
>        - description:
>            Compulab SBC-iMX7 is a single board computer based on the
>            Freescale i.MX7 system-on-chip. SBC-iMX7 is implemented with

