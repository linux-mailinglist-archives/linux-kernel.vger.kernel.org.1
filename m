Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1A72B23D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKMSdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:33:15 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56112 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKMSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:33:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADIX8tG053755;
        Fri, 13 Nov 2020 12:33:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605292388;
        bh=5nvwjV2Nf/9e8nFPiS2sUeR9DHOiIqZW2z1lYO43ALo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CUoA20STcwKE+tqB2kJKUD9Ia0Ie/M4wPpmSBgbrBV6xhYuHwq42XYlZbSTt/RnyT
         csD49+o1SAVzlYkJwCIQ+yAayNoII6wPnXO2H7lKLmptBEmgPwyiRfSIMin03nyjoa
         SovZStqmstfL5DBguoJWXJaFiaH/9BGlpcVr6G2A=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADIX70L023399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 12:33:07 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 12:33:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 12:33:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADIX7oZ057457;
        Fri, 13 Nov 2020 12:33:07 -0600
Date:   Fri, 13 Nov 2020 12:33:07 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable GPIO and I2C configs for
 TI's J721e platform
Message-ID: <20201113183307.koecfbgvskofqeb6@flagship>
References: <20201113154905.40095-1-nsekhar@ti.com>
 <20201113170441.2hvvqcnscpd7hos7@enigmatic>
 <f0f2056e-a386-40d6-5824-f7657860d41f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0f2056e-a386-40d6-5824-f7657860d41f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22:45-20201113, Sekhar Nori wrote:
> On 13/11/20 10:34 PM, Nishanth Menon wrote:
> > On 21:19-20201113, Sekhar Nori wrote:
> >> From: Faiz Abbas <faiz_abbas@ti.com>
> >>
> >> Add configs to help enable regulators that supply power to the SD card
> >> on TI's J721e platform. These regulators are controlled by either
> >> SoC gpios or gpios over i2c expander.
> >>
> >> vmlinux size before and after patch follow:
> >>
> > Sekhar,
> > 
> >> Before:
> >>    text	   data	    bss	    dec	    hex	filename
> >> 19755448	10376346	 535572	30667366	1d3f266	vmlinux
> >>
> >> After:
> >>    text	   data	    bss	    dec	    hex	filename
> >> 19769232	10381390	 536212	30686834	1d43e72	vmlinux
> >>
> >> difference is 19,468 (dec)
> >>
> >> Acked-by: Tero Kristo <t-kristo@ti.com>
> >> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> >> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> >> ---
> >> changes in v3:
> >> - add size delta as requested by Nishanth Menon
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/nmenon/linux.git/commit/?h=ti-k3-config-next&id=6b133f475a97a0839f02e3c0b937886b9adc2933
> > 
> > https://lore.kernel.org/linux-arm-kernel/20201103190821.30937-1-faiz_abbas@ti.com/
> > 
> > 
> > Is this a duplicate patch?
> 
> Looks like, please discard. For some reason, Faiz's v3 did not show-up
> in my inbox and v2 applied cleanly to linux-next/master. So I assume it
> was not refreshed.


OK. Thanks for confirming - keeping Faiz's version in the tree. :)
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
