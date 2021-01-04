Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160F62E955C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbhADM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 07:57:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59606 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADM50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:57:26 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104CtjVK102918;
        Mon, 4 Jan 2021 06:55:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609764945;
        bh=JiZZQu6dpjhga2YUtT9K1Udslqr6GMyu4soFi9cIwio=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DzSiSZOOp8QBit06iy4hBadl2Qx6H08H2GD6CShGiZryvShximoPKvgBbnsc7+svK
         L89oWNvFUmbZ9Nq4MhUyk5XmCKT90qLrIE3JqQ7Jc3/Jzn7S+A6QT9y2RXgrngHaNQ
         WlYs1GoPwD3xawTOsrZlVsULogFOYIUUVGMYaU8Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104CtjGO100189
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 06:55:45 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 06:55:44 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 06:55:44 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104CtiPX093860;
        Mon, 4 Jan 2021 06:55:44 -0600
Date:   Mon, 4 Jan 2021 06:55:44 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] arm64: dts: ti: k3-j721e-main: Fix supported max
 outbound regions
Message-ID: <20210104125544.arluqus2xbqwacez@curler>
References: <20210104122232.24071-1-kishon@ti.com>
 <20210104122232.24071-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210104122232.24071-2-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:52-20210104, Kishon Vijay Abraham I wrote:
> Cadence IP in J721E supports a maximum of 32 outbound regions. However
> commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device
> tree nodes") incorrectly added this as 16 outbound regions. Now that
> "cdns,max-outbound-regions" is an optional property with default value
> as 32, remove "cdns,max-outbound-regions" from endpoint DT node.
> 
> Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")

^^ Is this a backward compatible fixup. If I were to apply this on
v5.10, wont we have a broken PCIe functionality? Drop the fixes if this
is not backward compatible fixup (unless ofcourse the driver fixup is
backported all the way back as well - I am assuming will be done in a
manner to preserve compatibility with older dtb?)

On master right now:
$ git grep "cdns,max-outbound-regions" .
Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml:                cdns,max-outbound-regions = <16>;
Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml:  cdns,max-outbound-regions:
Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml:  cdns,max-outbound-regions:
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:              cdns,max-outbound-regions = <16>;
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:              cdns,max-outbound-regions = <16>;
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:              cdns,max-outbound-regions = <16>;
arch/arm64/boot/dts/ti/k3-j721e-main.dtsi:              cdns,max-outbound-regions = <16>;
drivers/pci/controller/cadence/pcie-cadence-ep.c:       of_property_read_u32(np, "cdns,max-outbound-regions", &ep->max_regions);


> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 4 ----
>  1 file changed, 4 deletions(-)
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
