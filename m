Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2B2C67D6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgK0OXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:23:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55826 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgK0OXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:23:51 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ARENesJ013300;
        Fri, 27 Nov 2020 08:23:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606487020;
        bh=PhyXEFa04z4jyA1nInkwZxWormbSXLe8grkSoGIgTQo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sH8Z3qrPlQ13ERTb7KqT1Nw1Nl9nHRhx/oNEqdZYIRibQQfijDGC53h6HHv+iskYd
         aUthLgQXN7TxwbA+/eQjfJL/VyKP+JPrP0Eb+lcRicP08KaHk10Es3sp13qVMPrIN2
         tptXfUFGSjcenfEMCTWwhidXWONyk/vy+WBexkGE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ARENe9v099705
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Nov 2020 08:23:40 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 27
 Nov 2020 08:23:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 27 Nov 2020 08:23:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ARENe0w023178;
        Fri, 27 Nov 2020 08:23:40 -0600
Date:   Fri, 27 Nov 2020 08:23:40 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>
CC:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
Message-ID: <20201127142340.ei7o4zkg5trwcspy@chevron>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
 <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
 <20201119132829.sr435jf6s4275q4i@boxlike>
 <313a9cd5-7411-4ae1-cde4-42a2c18d11e6@ti.com>
 <20201124012100.fq7w7bjxvewuhbt2@shirt>
 <8885dd79-061b-82e3-1aeb-a318f7d8256d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8885dd79-061b-82e3-1aeb-a318f7d8256d@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:46-20201124, Sekhar Nori wrote:
> On 24/11/20 6:51 AM, Nishanth Menon wrote:
> > On 09:45-20201123, Sekhar Nori wrote:
> >>>> The main reason I commented - is hope to get some clarification from DT maintainers.
> >>>> 90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
> >>>> (most often is present in PCI and GIC nodes).
> >>>> and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.
> >>>>
> >>>> And there is no "never" here - #address-cells always can be added if really required.
> >>>
> >>>
> >>> OK - as a GPIO node, but as an interrupt-controller node, I was
> >>> looking at [1] and wondering if that was the precedence.
> >>>
> >>> Yes, will be good to get direction from the DT maintainers on this
> >>> topic.
> >>
> >> Shall I respin this series with 2/4 dropped while we wait for decision
> >> on this?
> >>
> >> #address-cells warnings on interrupt controller can perhaps be handled
> >> all at once (there are many of those in existing DT anyway).
> >>
> >> GPIO is basic support and holds up many other modules (like MMC/SD).
> > 
> > 
> > There are'nt too many new patches in my queue that depends on GPIO, I'd
> > rather not introduce new warnings unless we are completely at a
> > stalemate. I'd rather use this opportunity to understand where what we
> > need to be doing.
> GPIO was originally submitted as part of 8  patch series titled "[PATCH
> 0/8] Add support for UHS modes in TI's J721e and J7200 boards"
> 
> Rest of those patches need to be resubmitted after GPIO is accepted.
> 
> Can you apply patch 1/4 at least. Its fairly non-controversial. It will
> help reduce patch backlog and fix some warnings too.

I see that Grygorii is suggesting 1,3,4 to be pulled in. can you repost
with just the required patches alone and pick up the reviewed-bys?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
