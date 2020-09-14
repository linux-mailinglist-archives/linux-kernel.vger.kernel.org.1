Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5573E268C21
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgINNWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:22:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgINNOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:14:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08EDEaIO010071;
        Mon, 14 Sep 2020 08:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600089276;
        bh=ODiKENSdzK4s3WG2D1yPBUfjra2xw8BwLPSrreBdVXg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CbfjXf529a0uVnIv4Wtkk9nZb0qrRMJketYNpnyGVMu9b3UoEF9GoUH1wRtA+pBIh
         OrevxtYidRzIMxQ2uApCax+ZioWyGN1zmn5VajLzuhyi8550nGRAK4aShoEJ2KRPPj
         IfQ9Ni62IiSiLz5cqkHUrL03wOfggftOu0elOpOE=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08EDEa4Q116335
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 08:14:36 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 08:14:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 08:14:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EDEafs060421;
        Mon, 14 Sep 2020 08:14:36 -0500
Date:   Mon, 14 Sep 2020 08:14:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/2] arm64: dts: ti: k3-j721e-main: Add PCIe
 device tree nodes
Message-ID: <20200914131436.fxtvximxcrtnqddm@akan>
References: <20200901140628.8800-1-kishon@ti.com>
 <20200901140628.8800-2-kishon@ti.com>
 <20200901145204.ayybrzqjcfhiqnfq@akan>
 <5f23246a-a9d7-495d-a4ec-d392ad95a450@ti.com>
 <4b17cace-09d5-af8c-6e7f-9358cfdceb4d@ti.com>
 <e914e527-00fc-2614-fa74-f2137dbcfaf9@ti.com>
 <20200914115207.wq4pmgrszhtgctdu@akan>
 <9fe50c76-8d78-c1fe-e8f5-b43eecd32db8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fe50c76-8d78-c1fe-e8f5-b43eecd32db8@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:43-20200914, Kishon Vijay Abraham I wrote:
> Hi Nishanth,
> 
> On 14/09/20 5:22 pm, Nishanth Menon wrote:
> > On 16:53-20200914, Kishon Vijay Abraham I wrote:
> >> Hi Rob,
> >>
> >> On 02/09/20 1:07 pm, Kishon Vijay Abraham I wrote:
> >>> Hi Rob,
> >>>
> >>> On 02/09/20 10:24 am, Kishon Vijay Abraham I wrote:
> >>>> Hi Nishanth,
> >>>>
> >>>> On 01/09/20 8:22 pm, Nishanth Menon wrote:
> >>>>> On 19:36-20200901, Kishon Vijay Abraham I wrote:
> >>>>>> Add PCIe device tree node (both RC and EP) for the four
> >>>>>> PCIe instances here.
> >>>>>>
> >>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>>>>> ---
> >>>>>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 218
> >>>>>> ++++++++++++++++++++++
> >>>>>>   arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   5 +-
> >>>>>>   2 files changed, 222 insertions(+), 1 deletion(-)
> >>>>>
> >>>>>
> >>>>> Did you look at the diff of the dtbs_check before and after this
> >>>>> series? I see: https://pastebin.ubuntu.com/p/9fyfrTjx9M/
> >>>>
> >>>> I didn't see any errors when I checked for individual bindings
> >>>> a0393678@a0393678-ssd:~/repos/linux$ mkconfig64 dtbs_check
> >>>> DT_SCHEMA_FILES="Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml"
> >>>>
> >>>>    SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
> >>>>    DTC     arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> >>>>    DTC     arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml
> >>>>    CHECK   arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> >>>>    CHECK   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml
> >>>> a0393678@a0393678-ssd:~/repos/linux$ mkconfig64 dtbs_check
> >>>> DT_SCHEMA_FILES="Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml"
> >>>>
> >>>>    SCHEMA  Documentation/devicetree/bindings/processed-schema.yamlsimple-bus
> >>>>    DTC     arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> >>>>    DTC     arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml
> >>>>    CHECK   arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml
> >>>>    CHECK   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml
> >>>
> >>> Can you give hint on why I get ranges is too long error
> >>> https://pastebin.ubuntu.com/p/cPm2tg3dcV/ which I give mkconfig64
> >>> dtbs_check but don't see an error when I include "DT_SCHEMA_FILES"?
> >>
> >> I debugged this and looks like PCIe "ranges" property conflicts with
> >> simple-bus.
> >>
> >> A diff like below helps to solve the issue
> >> diff --git a/schemas/simple-bus.yaml b/schemas/simple-bus.yaml
> >> index 248ac9d..ed818ef 100644
> >> --- a/schemas/simple-bus.yaml
> >> +++ b/schemas/simple-bus.yaml
> >> @@ -39,7 +39,7 @@ patternProperties:
> >>          oneOf:
> >>            - items:
> >>                minItems: 3
> >> -              maxItems: 6
> >> +              maxItems: 7
> >>              minItems: 0
> >>              maxItems: 1024
> >>            - $ref: "types.yaml#/definitions/flag"
> >>
> >> If this looks right to you, I can post a patch for it. Without fixing
> >> this we would see false errors for PCIe DT nodes.
> > 
> > https://github.com/devicetree-org/dt-schema/commit/3baf308b01786788e3ccb9824fce6d7136b21214
> > 
> > Part of v2020.08.1? Am i missing something?
> 
> I think I was using a different repo
> https://github.com/robherring/dt-schema.git.
> 
> Do you see the following issues you reported earlier with v2020.08.1?
> 
> +/home/nmenon/Src/opensource/linux/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml:
> bus@100000: pcie@2900000:ranges: [[16777216, 0, 268439552, 0, 268439552,
> 0, 65536], [33554432, 0, 268505088, 0, 268505088, 0, 134148096]] is not
> valid under any of the given schemas (Possible causes of the failure):
> +
> /home/nmenon/Src/opensource/linux/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml:
> bus@100000: pcie@2900000:ranges: True was expected
> +
> /home/nmenon/Src/opensource/linux/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml:
> bus@100000: pcie@2900000:ranges:0: [16777216, 0, 268439552, 0,
> 268439552, 0, 65536] is too long
> +
> /home/nmenon/Src/opensource/linux/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dt.yaml:
> bus@100000: pcie@2900000:ranges:1: [33554432, 0, 268505088, 0,
> 268505088, 0, 134148096] is too long


Arrgh.. you are right.. Looks like one of my PCs still had 2020.8
instead of 2020.8.1. We just need to figure out what is going on with
syscon.yaml as against ti,j721e-system-controller.yaml..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
