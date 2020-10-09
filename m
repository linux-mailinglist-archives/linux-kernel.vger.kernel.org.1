Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5701F288827
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgJIL7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:59:55 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46050 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbgJIL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:59:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099BxlB9117443;
        Fri, 9 Oct 2020 06:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602244787;
        bh=lbHB2t+9cdnp16Vg+EKQvgv0g50IbJWJa1ti64DJZJ4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IoXJAGuAWXX7F8kS42SkhEk+iTbULhr8Vtug2kfDBtxxLCmH/Z7PnRh3ju364m2P/
         dhtFeIzbOPmA+oo7hj29g96+iVLMpzGMkG1E+hpQ4ZhpBiUS8gdHNDPYpnYVkw1OSV
         MshsZZRKG37rswWQ5jq1qiM5d3fRw+wptASaVSis=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099BxlML084938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 06:59:47 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 06:59:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 06:59:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099BxkBH096189;
        Fri, 9 Oct 2020 06:59:47 -0500
Date:   Fri, 9 Oct 2020 06:59:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 10/11] soc: ti: k3-ringacc: Use correct device for
 allocation in RING mode
Message-ID: <20201009115946.fl4lvkg5yk7f43pz@calculus>
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
 <20201008115224.1591-11-peter.ujfalusi@ti.com>
 <20201009030204.3i3d6azsmfekl5qx@whole>
 <6d8f5331-251d-5409-4a1c-e3e42d340071@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d8f5331-251d-5409-4a1c-e3e42d340071@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:43-20201009, Peter Ujfalusi wrote:
> Nishanth,
> 
> On 09/10/2020 6.02, Nishanth Menon wrote:
> > On 14:52-20201008, Peter Ujfalusi wrote:
> >> -	ring->ring_mem_virt = dma_alloc_coherent(ringacc->dev,
> >> +	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
> >>  					ring->size * (4 << ring->elm_size),
> >>  					&ring->ring_mem_dma, GFP_KERNEL);
> > 
> > Any chance of getting a cleanup of the file for 5.11? I know this series
> > has'nt introduced this warning or set of warnings, but I am starting to
> > get concerned that we are carrying over too much of a debt now?
> > 
> > https://pastebin.ubuntu.com/p/tT2kPDsCWD/
> 
> Right, you know that git blame points the finger at you on ti_sci.c errors?
> 
> Never the less, I have run the tool locally on my linux-next-wip with
> these patches:
> https://pastebin.ubuntu.com/p/myJwjvKYw8/
> 
> and I don't see the noise you see.


Hmm.. Looks like gcc9/10 make W=2 does generate those warnings with
container_of .. I will investigate it later today.. just checking to see
if it is just me seeing this..

Yes, I introduced the container_of() usage, which is pretty standard
usage in other subsystems as well, but lots of checks have gotten
stricter and catches new issues since I introduced things in 2016..
Time to get the new issues (if valid) fixed up.

> 
> > Checkpatch does point this:
> > 
> > --- /tmp/kernel-patch-verify.25812/ptest_check-start	2020-10-08
> > 19:33:31.025898581 +0000
> > +++ /tmp/kernel-patch-verify.25812/ptest_check-end	2020-10-08
> > 19:33:31.593893830 +0000
> > @@ -0,0 +1,6 @@
> > +CHECK: Alignment should match open parenthesis
> > +#84: FILE: drivers/soc/ti/k3-ringacc.c:657:
> > ++	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
> > + 					ring->size * (4 << ring->elm_size),
> 
> Yes, that's correct. Readability VS very long lines


checkpatch limit in linux kernel is now 100 chars (I know, it is
hard to update .vimrc etc.. to the new norm..)but, anyways.. will
be good not to see such warnings esp when you are touching the same
lines.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
