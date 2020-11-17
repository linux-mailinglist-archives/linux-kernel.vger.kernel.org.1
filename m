Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC502B5F66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgKQMwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:52:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50430 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgKQMwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:52:46 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHCqbYq053910;
        Tue, 17 Nov 2020 06:52:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605617557;
        bh=DGMIL9bjshIBnyCRIB0aJStK052SCWOqCEtJuYD63dA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gOf7UQvvP/nupM8xdhGmnj9rVHHvVqJ8Hd9q/4ipEdPBUk1ZL7HBbN86hLs7/hXlD
         m5dBLshi4sOA2VJNpC783fJaF/XnYhZ+YRl2WPhSH3x+TAdbHMo0qCPtH0LNPWPHe8
         i8y6MCZzcWJzhVRSzTx2loQineSwhda8h7xwpfMc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHCqbjP036824
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 06:52:37 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 06:52:36 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 06:52:37 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHCqaMw119516;
        Tue, 17 Nov 2020 06:52:37 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Nishanth Menon <nm@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 0/5] arm64: dts: ti: Cleanup mix of "okay" and "disabled"
Date:   Tue, 17 Nov 2020 06:52:35 -0600
Message-ID: <160561743968.22347.10185221222649723152.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113211826.13087-1-nm@ti.com>
References: <20201113211826.13087-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 15:18:21 -0600, Nishanth Menon wrote:
> V4 changes:
> - drops the fixes tags (as this is not strictly a stable fix)
> 
> Repost. older versions v3[3] v2[2] v1[1]
> 
> Summarising the blurb of the discussion[4] we have had, there are few
> options one could take when dealing with SoC dtsi and board dts:
> 
> [...]

I have applied this revision to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am65*: Cleanup disabled nodes at SoC dtsi level
      commit: af03de2b9b908e776c233744b84ce9dbb70dcafb
[2/5] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at SoC dtsi level
      commit: 5d1bedf252db3ec2becb9f43c55e0f33af1fd7fc
[3/5] arm64: dts: ti: am65/j721e: Fix up un-necessary status set to "okay" for crypto
      commit: bfbf9be725d8effdbb60eb2ece44c06ae87a54de
[4/5] arm64: dts: ti: k3-am654-base-board: Fix up un-necessary status set to "okay" for USB
      commit: 90e6c38848f8e86047e0e758c0725b155e2e349b
[5/5] arm64: dts: ti: am65/j721e/j7200: Mark firmware used uart as "reserved"
      commit: 4cc34aa8a208665aa0362a615deefc3db6a5d7bd


[1] git://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

