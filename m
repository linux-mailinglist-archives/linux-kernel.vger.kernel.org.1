Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA3D3025CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbhAYN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:56:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57742 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbhAYNxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:53:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10PDpDvX027768;
        Mon, 25 Jan 2021 07:51:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611582673;
        bh=XRYWFW8ZiApsdNK89cBgLtvlRTxeukU/9OXwREp/Ju8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=sDrk31bN02O61jafZX02L4Kb82vqHQ8/EzB4lfMdrBSA/jDlb/sdDmkeo8SP9V4Ue
         BupPfvjs+/jGic37+picXHTQup/qSNSjZjI7BFwjfGiU6NBJLajT/kf9JOxjOrW6JY
         E/oyCtlxZ340AJDFHe8yjbOYNHW3MvhP6UlsMv8M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10PDpDZL067459
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jan 2021 07:51:13 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 Jan 2021 07:51:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 Jan 2021 07:51:12 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10PDpCOb030504;
        Mon, 25 Jan 2021 07:51:12 -0600
Date:   Mon, 25 Jan 2021 07:51:12 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mmc: J7200: Add support for higher speed modes in
 MMCSD subsystems
Message-ID: <20210125135112.gvddr4uv7vx7kfrq@triangle>
References: <20210122162403.20700-1-a-govindraju@ti.com>
 <20210122180629.3j3aoueiwiib4gso@cavalier>
 <5341eeb2-e637-424f-3328-60dbddee1376@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5341eeb2-e637-424f-3328-60dbddee1376@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:12-20210125, Aswath Govindraju wrote:
> Hi Nishanth,
> 
> On 22/01/21 11:36 pm, Nishanth Menon wrote:
> > On 21:54-20210122, Aswath Govindraju wrote:
> >> The following series of patches
> >> - adds support for HS200 and HS400 speed modes in MMCSD0 subsystem
> >> - adds support for UHS-I speed modes in MMCSD1 subsystem 
> >>
> >> Aswath Govindraju (2):
> >>   arm64: dts: ti: k3-j7200-main: Add support for HS200 and HS400 modes
> >>     in MMCSD0 subsystem
> >>   arm64: dts: ti: k3-j7200-main: Add support for UHS-I modes in MMCSD1
> >>     subsystem
> > 
> > 
> > Just a curious couple of questions:
> > Does squashing both the patches create a problem for understanding or a
> > later bisect? I kind of thought these mostly go hand in hand between the
> > instances, am I mistaken?
> > 
> 
> Yes, they can be squashed. I post a respin doing this.

Thanks.

> 
> > Are there any otap delay params update needed or the defaults are good
> > to go?
> > 
> 
> The otap values are already up-to-date with the data sheet and don't
> need updation.

Thanks for the clarification.

> 
> > Will also help to provide some verification log along with this.
> > 
> 
> May I know what sort of logs would be best to provide. Would enumeration
> logs during boot suffice ?
> 
> Like this,
> https://pastebin.ubuntu.com/p/v9NRV7GwMw/ ?

That just says we detected the cards, no?
I thought we had tests around this? Something including /sys/kernel/debug/mmc*/ios

Something that demonstrates that this actually runs at the claimed
speeds? That would be nice on linux-next, if possible as well..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
