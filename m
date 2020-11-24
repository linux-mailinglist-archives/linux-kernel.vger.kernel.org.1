Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD9C2C1AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 02:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgKXBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 20:21:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43758 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgKXBVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 20:21:17 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AO1L15D118423;
        Mon, 23 Nov 2020 19:21:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606180861;
        bh=wLuBWcTJuHH4uo4MpJn9xKHS6b81FGYIjtG5uZa0r9Q=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pDbjKt/Kf4tmMtcT2rGFeHxxIT9m4QQnxVxj9Azx0wj2BAP6ULpJ74VMV0M7u+KJh
         GnzbvLKnlWEzdmZR/NSdLaPmJzRWRXjHKvM41YeEpExMuCkH4MWkcJRtwgd+EtLl68
         9v4BipQ7MX48W9C+6by/B3XegrGexApvSfxe2GeQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AO1L1Fc029858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Nov 2020 19:21:01 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 23
 Nov 2020 19:21:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 23 Nov 2020 19:21:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AO1L0b4072324;
        Mon, 23 Nov 2020 19:21:00 -0600
Date:   Mon, 23 Nov 2020 19:21:00 -0600
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
Message-ID: <20201124012100.fq7w7bjxvewuhbt2@shirt>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
 <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
 <20201119132829.sr435jf6s4275q4i@boxlike>
 <313a9cd5-7411-4ae1-cde4-42a2c18d11e6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <313a9cd5-7411-4ae1-cde4-42a2c18d11e6@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:45-20201123, Sekhar Nori wrote:
> >> The main reason I commented - is hope to get some clarification from DT maintainers.
> >> 90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
> >> (most often is present in PCI and GIC nodes).
> >> and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.
> >>
> >> And there is no "never" here - #address-cells always can be added if really required.
> > 
> > 
> > OK - as a GPIO node, but as an interrupt-controller node, I was
> > looking at [1] and wondering if that was the precedence.
> > 
> > Yes, will be good to get direction from the DT maintainers on this
> > topic.
> 
> Shall I respin this series with 2/4 dropped while we wait for decision
> on this?
> 
> #address-cells warnings on interrupt controller can perhaps be handled
> all at once (there are many of those in existing DT anyway).
> 
> GPIO is basic support and holds up many other modules (like MMC/SD).


There are'nt too many new patches in my queue that depends on GPIO, I'd
rather not introduce new warnings unless we are completely at a
stalemate. I'd rather use this opportunity to understand where what we
need to be doing.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
