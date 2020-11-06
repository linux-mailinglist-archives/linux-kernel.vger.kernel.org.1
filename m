Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E0E2A9F55
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgKFVqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:46:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54548 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbgKFVqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:46:48 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A6LkdaP037587;
        Fri, 6 Nov 2020 15:46:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604699199;
        bh=zsJRQ7MV3ODiDNe82AFoOfWuvXT4a+QaiBnCNXKpQDQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gvQB0XqZdWzg01+ldQDIXFRqsTofUwzNf0jv4ei1S00Bvsd8JxEiItRP2pWGzAEA5
         9YIRyzzbOnN1vl8FSYHlzkL7/+2YRfNmfXZ98MBwDBwBRxysUQtH1wetF6LNY5zhOu
         1YujNuFbM5cAIcILA06XYgaQK3aeRB89q1A9RONQ=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A6Lkdir096847
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Nov 2020 15:46:39 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 6 Nov
 2020 15:46:38 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 6 Nov 2020 15:46:38 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A6LkcNn041136;
        Fri, 6 Nov 2020 15:46:38 -0600
Date:   Fri, 6 Nov 2020 15:46:38 -0600
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
Message-ID: <20201106214638.amgltswy6dygnyee@tubular>
References: <20201104224356.18040-1-nm@ti.com>
 <20201104224356.18040-3-nm@ti.com>
 <d9324b76-5587-b583-97da-5cb52f294c31@ti.com>
 <20201105140806.326ubfppb4guexpi@cultural>
 <37b4b284-0da5-c602-82a2-2b672f89891f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <37b4b284-0da5-c602-82a2-2b672f89891f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:32-20201106, Peter Ujfalusi wrote:
[...]
> > 
> >>
> >>> default power management functionality etc
> >>
> >> Right, so how does that helps with devices present in the SoC, but no
> >> node at all? First thing which comes to mind is AASRC, we don't have
> >> Linux driver for it (and no DT binding document), but that does not mean
> >> that it is not present. How PM would take that into account?
> > 
> > I think we are mixing topics here -> I was stating the motivation why
> > devicetree chose such as default.
> 
> I don't question the fact that 'okay' is the default status if it is not
> explicitly present. There is no better default than that.

^^ -> Alright, that is all we are trying to do here: defaults in the
SoC.dtsi and specific cleanups (firmware reserved / board unused
disables) be done in a common board.dtsi (for now, there is no such
specific need, I guess).

[..]

> 
> >> The reason why we kept McASP nodes (and dss) disabled in the soc dtsi
> >> file is that they are not operation in the form they present in there.
> >> They _need_ additional properties to be operational and those properties
> >> can only be added in the board dts file.
> > 
> > I dont think we are changing anything in the output dtb files,
> 
> Correct, the resulted dtb is identical. If the developer for upcoming
> boards did check the schematics vs TRM vs dtsi and spot the things that
> is not configured.

Yes.

> 
> > we are
> > just leaving the defaults as dt defaults and set the disable state in
> > board dts OR common board dtsi.
> 
> Yes, we leave the non working/configured node 'okay' in dtsi and expect
> that the board file author will know which node must be disabled because
> it is incomplete.

Yes - I understand(and empathise) the implicit omission error risk we
are incurring here. I will add that to the commit message as well.

> >> This is not remotely a subjective view, this is the opposite of
> >> subjectivity.
> > 
> > the usage of McASP was'nt meant as (c).. it is (b). is there a better way
> > to describe this in a generic manner?
> 
> I had my saying on that ever since I have been taking care of audio on
> TI SoCs ;)
> 
> I used similar analogy in a private thread around this, but imho it fits
> the case neatly:
> car == McASP
> 
> you don't put an 'okay' (as is ready, operational) stamp on the car in
> the middle of the production line when the engine is not even installed.

Completely agree with you. we are just insisting that this be done in
either common board.dtsi OR board.dtsi where applicable.

> 

[..]

> > Alright - what do we suggest we do?
> 
> Not sure, I'm 'whatever' after [1] makes it to mainline or next.
[....]
> [1]
> https://lore.kernel.org/alsa-devel/20201106072551.689-1-peter.ujfalusi@ti.com/


I don't see the relationship between the series.. I think this series
brings no change in dtb, hence with OR without your driver cleanup
series, there is no practical regressions.
> 
> > Tony, Rob - I need some guidance here.
> 
> I'm fine whatever way we take, but I think it is up to you to make the
> call as the maintainer of the TI dts files... ;)

Yep - I have'nt seen a reason yet that must cause us to change from the
Device tree default approach in our debates.


As Tony already pointed out.. if we start seeing a lot more boards for
an SoC..
Instead of (reverse issue- where we have a lot of places where people are
doing "okay" problem):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=12afc0cf81210969756daecd7eb48b307f08faed

We should look at ways to consolidate in a common-board.dtsi

> 
> >>
> >>>  &serdes0 {
> > 	[...]
> >>>  
> >>>  	watchdog0: watchdog@2200000 {
> >>>
> >>
> >> There is no such a tag, but:
> >> whatever-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > OK - I have no idea how B4 or patchworks pick that one as :D
> 
> If we take this road, than I'm okay with it, but I'm going to take
> silent protest (not sending acked-by or revired-by).
> That should not stop you doing what you believe is best for the future!

OK - thanks for your review and the discussions, always appreciate
getting our views out there.

if there are no other comments, I will try and post a v2 over the
weekend.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
