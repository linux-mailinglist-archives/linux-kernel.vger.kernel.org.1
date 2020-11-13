Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883082B261F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgKMVAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:00:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:00:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADKxx0a104829;
        Fri, 13 Nov 2020 14:59:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605301199;
        bh=aQaBsZBNPDJstvPRnQs7u4/Mqz7Qu8uKZtWhen6EI/k=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SzB3mYKMuFbf2IFHoO8EtWrLvNAqWFNP8m/vtP/JruT8Y+EuNHaltxn/Kap2ZaX7k
         eNahvb111dS5UKFmxrjLCeVmkLWBqrsTT4hTBEASrXgFgPNeAE1BdXIAT8Vz7u+fTr
         Q57526xBzPwOuUqbRDRvYTw2j8cqz2TYMIXOJxZI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADKxxGD108599
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 14:59:59 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 14:59:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 14:59:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADKxxki065721;
        Fri, 13 Nov 2020 14:59:59 -0600
Date:   Fri, 13 Nov 2020 14:59:59 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Keerthy <j-keerthy@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V3 0/5] arm64: dts: ti: Cleanup mix of "okay" and
 "disabled"
Message-ID: <20201113205959.42q6p4enm7lem2if@facebook>
References: <20201112183538.6805-1-nm@ti.com>
 <160527282700.18648.6417116883997393632.b4-ty@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <160527282700.18648.6417116883997393632.b4-ty@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07:07-20201113, Nishanth Menon wrote:
> On Thu, 12 Nov 2020 12:35:33 -0600, Nishanth Menon wrote:
> > Changes since v2[3]:
> > - Rebase on top of ti-k3-dts-next (no functional changes)
> > - picked up reviewed-by and acks from folks.
> > 
> > Since we have all the required acks and reviews, I will apply this
> > series tomorrow morning since this can cause churn for other folks.
> > 
> > [...]
> 
> Hi,
> 
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> 
> [1/5] arm64: dts: ti: k3-am65*: Cleanup disabled nodes at SoC dtsi level
>       commit: 957c8a49d2ed0d9ed710c8643d43912b64a3708a
> [2/5] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at SoC dtsi level
>       commit: f388cb320905e0908429ce5ce8b14b5fadb6a1ea
> [3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay" for crypto
>       commit: 2fcb0ff200d0c9b0c5cab541cc8f8444d937e9ca
> [4/5] arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to "okay" for USB
>       commit: 399e08d521a34ca8180c8eaeaf181176ace85b47
> [5/5] arm64: dts: ti: am65/j721e/j7200: Mark firmware used uart as "reserved"
>       commit: cf2e8c96b52984319c27f1e0b68fbef712df9bb9
> 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent up the chain during
> the next merge window (or sooner if it is a relevant bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 


I will drop this series from my tree - Fixes: tags on the patches should
be dropped as it is not strictly to the stable tree rules and can
potentially cause conflicts when backported.

I will repost the next version dropping the same and pick the new series
up instead.

Apologies on the churn (and thanks Peter, Sekhar for the offline
feedback - better safe than sorry).

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
