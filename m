Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7E2E95B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhADNSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:18:22 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42470 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbhADNSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:18:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 104DGhbh026547;
        Mon, 4 Jan 2021 07:16:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609766203;
        bh=iJ1802YOh7KicshdudWrLWMW3lmwZ6YkfRDeyy0c0bQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KUa9eQtStEXWo9Kvu+j++tGzbffWYAH4eweFfYZtb9SiKXBSKM4rxuAoGCfJNm8P6
         jQB+gHoclq+ho5mneuS2DB2BjwN61CPAi4S6xKpZvXj2Pz9lMuKvdY3ch8ug2gBrMJ
         8ze+LSZxzKNnLOg+nBl1YI2YVp9BX8qWNeqDAdKk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 104DGhOj015840
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Jan 2021 07:16:43 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 4 Jan
 2021 07:16:42 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 4 Jan 2021 07:16:43 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 104DGge2093061;
        Mon, 4 Jan 2021 07:16:42 -0600
Date:   Mon, 4 Jan 2021 07:16:42 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] PCI: J7200/J721E PCIe bindings
Message-ID: <20210104131642.m5rgpkhnrffq5nrx@circular>
References: <20210104122232.24071-1-kishon@ti.com>
 <20210104125910.qaf7vi3dx6vsne6t@backfield>
 <465097c1-2d38-ad45-cc32-d92c385114c5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <465097c1-2d38-ad45-cc32-d92c385114c5@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18:40-20210104, Kishon Vijay Abraham I wrote:
> Nishanth,
> 
> On 04/01/21 6:29 pm, Nishanth Menon wrote:
> > On 17:52-20210104, Kishon Vijay Abraham I wrote:
> >> Patch series adds DT nodes in order to get PCIe working in J7200.
> >> Also includes couple of fixes for J721e.
> >>
> >> v1 of the patch series can be found @ [1]
> >> v2 of the patch series can be found @ [2]
> >>
> >> Changes from v2:
> >> 1) Moved serdes_refclk node out of interconnect node and also replaced
> >>    "_" with "-"
> >>
> >> Changes from v1:
> >> 1) Include only the device tree patches here (the binding patch is sent
> >> separately)
> >> 2) Include couple of patches that fixes J721E DTS.
> >>
> >> [1] -> http://lore.kernel.org/r/20201102101154.13598-1-kishon@ti.com
> >> [2] -> http://lore.kernel.org/r/20201210130747.25436-1-kishon@ti.com
> >>
> >> Kishon Vijay Abraham I (6):
> >>   arm64: dts: ti: k3-j721e-main: Fix supported max outbound regions
> >>   arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for
> >>     pcieX_ctrl
> >>   arm64: dts: ti: k3-j7200-main: Add SERDES and WIZ device tree node
> >>   arm64: dts: ti: k3-j7200-main: Add PCIe device tree node
> >>   arm64: dts: ti: k3-j7200-common-proc-board: Enable SERDES0
> >>   arm64: dts: ti: k3-j7200-common-proc-board: Enable PCIe
> >>
> >>  .../dts/ti/k3-j7200-common-proc-board.dts     |  38 ++++++
> >>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 111 ++++++++++++++++++
> >>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  52 ++------
> >>  3 files changed, 157 insertions(+), 44 deletions(-)
> > 
> > 
> > A bit confused on the dependency here. is there something merged into
> > next-20210104 that makes this series ready for pickup? is there a way
> > I can get a immutable tag for driver fixups to pull so that my dts
> > next is not broken for PCIe (I am assuming looking at the series that
> > this is probably not a backward compatible series?)?
> 
> There are no driver changes for the basic J7200 PCIe support and the DT
> bindings are already merged [1].
> 
> There are few errata fixes applicable for J721E which has to be removed
> for J7200 but that depends on other patches to be merged [1] but that
> doesn't impact j7200 functionality.
> 
> [1] ->
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml#n19
> [2] -> http://lore.kernel.org/r/20201230120515.2348-1-nadeem@cadence.com

So, Dropping stuff like "cdns,max-outbound-regions" (change from 16 to
32) will work on older kernels? Could you do a quick sanity check on the
couple of "fixes" patches in this thread is not breaking functionality
introduced in the older stable kernels?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
