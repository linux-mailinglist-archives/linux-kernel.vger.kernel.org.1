Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73A351AF664
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 05:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSDTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 23:19:14 -0400
Received: from lists.nic.cz ([217.31.204.67]:35226 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDSDTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 23:19:14 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id C51A8140079;
        Sun, 19 Apr 2020 05:19:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1587266352; bh=jzs55wN+zxgwJgkgiXcqXtgwjnh4IgEdGh/n6vKt/Io=;
        h=Date:From:To;
        b=l1qqsOhe3XeChgdJOBat9enl4XDCKRzMFmu6CL7wgBIZWznVbq8oNMcpQNDhnyfCJ
         69iDvJUa+lwtR0GFdAxh5dHCNIFUSwitxWCpJpsKRcjHulo0IVnYQuJ8ciAFJwsEAY
         rOYa5TbvXpz1hNAJ4BzWZRsQJm486qDz7ZhMAXzU=
Date:   Sun, 19 Apr 2020 05:19:11 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] dts: espressobin: Define max-link-speed for pcie0
Message-ID: <20200419051911.1b5adef0@nic.cz>
In-Reply-To: <20200415160054.951-3-pali@kernel.org>
References: <20200415160054.951-1-pali@kernel.org>
        <20200415160054.951-3-pali@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When chaning dts files in arch/arm64/boot/dts/marvell, use subject
prefix
  arm64: dts: marvell:
for espressobin for example
  arm64: dts: marvell: espressobin:

instead of
  dts: espressobin
or
  dts: aardvark

Marek


On Wed, 15 Apr 2020 18:00:48 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Previously aardvark PCI controller set speed to gen2. Now it reads speed
> from Device Tree and as default use maximal possible speed which is gen3.
>=20
> Because Espressobin has advertised only PCI Express 2.0 capability and
> previous value was gen2, define max-link-speed to 2, so there would not be
> any configuration change.
>=20
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/a=
rch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index 42e992f9c8a5..6705618162d5 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -47,6 +47,7 @@
>  	phys =3D <&comphy1 0>;
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pcie_reset_pins &pcie_clkreq_pins>;
> +	max-link-speed =3D <2>;
>  };
> =20
>  /* J6 */

