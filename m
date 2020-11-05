Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133C02A8065
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgKEOIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:08:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42918 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgKEOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:08:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A5E86hX106134;
        Thu, 5 Nov 2020 08:08:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604585286;
        bh=zcmJI2iGAsjEzlWmyxcXFNtdwy2DNlvmgs+08LYg1ck=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RlTRpAuHsDiFGE7IgsgeEUoH6qjxVC5ivx+J3XHFk4yi4ztalvMXV8C+DvqI5OBSs
         qsg0Gp1y+UltGIIn0PdF+IPu+br20raBDIpXOd0bEtsQ1qCUHOiZTJ30ZhykUDW7ky
         NzTUV3eC4yV7oeMDK9BmhHWbx5di6fikr2Eg01JI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A5E86vi051225
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 08:08:06 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 08:08:06 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 08:08:06 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A5E86eQ108247;
        Thu, 5 Nov 2020 08:08:06 -0600
Date:   Thu, 5 Nov 2020 08:08:06 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Roger Quadros <rogerq@ti.com>, Keerthy <j-keerthy@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at
 SoC dtsi level
Message-ID: <20201105140806.326ubfppb4guexpi@cultural>
References: <20201104224356.18040-1-nm@ti.com>
 <20201104224356.18040-3-nm@ti.com>
 <d9324b76-5587-b583-97da-5cb52f294c31@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9324b76-5587-b583-97da-5cb52f294c31@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:32-20201105, Peter Ujfalusi wrote:
> Nishanth,
> 
> On 05/11/2020 0.43, Nishanth Menon wrote:
> > The device tree standard sets the default node behavior when status
> > property as enabled.
> 
> It should be:
> When the status property is not present under a node, the "okay' value
> is assumed.

Thanks.. will update.

> 
> Note: the device tree specification does not document default value as
> such, see v0.3 (2.3.4, page 14).
> Yes, the "okay" is used in case the status property is missing (by Linux
> at least).

Maybe the spec update needs a formal release? Kumar's patch is merged:
https://github.com/devicetree-org/devicetree-specification/pull/33

on that exact same section, which you can see
https://github.com/devicetree-org/devicetree-specification/blob/master/source/chapter2-devicetree-basics.rst

Brings it to sync to:
https://elinux.org/Device_Tree_Linux#status_property

> 
> > There are many reasons for doing the same, number
> > of strings in device tree,
> 
> with expense of loc and readability.

The "readability" part is subjective a bit.. enabled and disabled both
have verbosity problem lets see how we can optimize as new boards come
in.

> 
> > default power management functionality etc
> 
> Right, so how does that helps with devices present in the SoC, but no
> node at all? First thing which comes to mind is AASRC, we don't have
> Linux driver for it (and no DT binding document), but that does not mean
> that it is not present. How PM would take that into account?

I think we are mixing topics here -> I was stating the motivation why
devicetree chose such as default. Do we have a suggestion to improve
the description in the commit?

> 
> > are few of the reasons.
> > 
> > In general, after a few rounds of discussions [1] there are few
> > options one could take when dealing with SoC dtsi and board dts
> > 
> > a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
> >    to prevent messy board files, when more boards are added per SoC, we
> >    optimize and disable commonly un-used nodes in board-common.dtsi
> > b. SoC dtsi disables all hardware dependent nodes by default and board
> >    dts files enable nodes based on a need basis.
> > c. Subjectively pick and choose which nodes we will disable by default
> >    in SoC dtsi and over the years we can optimize things and change
> >    default state depending on the need.
> 
> For the record: c was not really an option. There were no subjectivity,
> the reason was pragmatic.


(c) some examples where we did pick that option (fixes):
https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-4-nm@ti.com/
https://lore.kernel.org/linux-arm-kernel/20201104224356.18040-5-nm@ti.com/

> 
> The reason why we kept McASP nodes (and dss) disabled in the soc dtsi
> file is that they are not operation in the form they present in there.
> They _need_ additional properties to be operational and those properties
> can only be added in the board dts file.

I dont think we are changing anything in the output dtb files, we are
just leaving the defaults as dt defaults and set the disable state in
board dts OR common board dtsi.

> 
> This is not remotely a subjective view, this is the opposite of
> subjectivity.

the usage of McASP was'nt meant as (c).. it is (b). is there a better way
to describe this in a generic manner?

> 
> As for things not owned by the OS we have the "reserved" status.
Which is correct usage. I think your point with wkup_uart should be set as
reserved? I might have missed doing that - am I correct?

[...]
> >  
> > -	status = "okay";
> > +&mcasp11 {
> > +	status = "disabled";
> >  };
> 
> Looks much better in this way.
> ?
> 
> I always wondered what is _not_ used by the board...
> But it is not really about that, we need to disable these nodes as they
> are incomplete in dtsi, they are not operational...

Alright - what do we suggest we do?


Tony, Rob - I need some guidance here.

> 
> >  &serdes0 {
	[...]
> >  
> >  	watchdog0: watchdog@2200000 {
> > 
> 
> There is no such a tag, but:
> whatever-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

OK - I have no idea how B4 or patchworks pick that one as :D

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
