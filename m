Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AC426DB59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIQMRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:17:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41910 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgIQMP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:15:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HCEqlZ040922;
        Thu, 17 Sep 2020 07:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600344892;
        bh=cGd0Zeuy4+fUXyw2xolJhUi55PGX5GYAQgVtJo/AyC4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=E6UgGNdeQX6dbpJ4gAkJ65gVnBRDaQ9Skax2apqdMdlFOvb9W8bL+Z0iofqK932j4
         adlW/Pt/M8ZfCEU/ZUrW+PB/KDMCrGICol8hrwIlEpbeS3nqjkiOxMysyNcn3L9P8t
         p8m6LibnfbctlgKpdbhq1uONMaoL/5PHMV5Bxz5w=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HCEqq6085548
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 07:14:52 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 07:14:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 07:14:52 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HCEpmP058482;
        Thu, 17 Sep 2020 07:14:51 -0500
Date:   Thu, 17 Sep 2020 07:14:51 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Peter Rosin <peda@axentia.se>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
Message-ID: <20200917121451.mp4pdld5w6qkv6d3@akan>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
 <08c84d02-abe1-8399-50fb-9268c7130f8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08c84d02-abe1-8399-50fb-9268c7130f8a@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:00-20200917, Roger Quadros wrote:
> Hi Peter & Nishanth,
> 
> On 16/09/2020 18:45, Nishanth Menon wrote:
> > On 06:52-20200916, Peter Rosin wrote:
> > > Hi,
> > > 
> > > Sorry for the delay.
> > > 
> > > On 2020-09-15 13:20, Roger Quadros wrote:
> > > > Each SERDES lane mux can select upto 4 different IPs.
> > > > There are 4 lanes in each J7200 SERDES. Define all
> > > > the possible functions in this file.
> > > > 
> > > > Cc: Peter Rosin <peda@axentia.se>
> > > > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > > > ---
> > > >   include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
> > > >   1 file changed, 29 insertions(+)
> > > >   create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
> > > > 
> > > > diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
> > > > new file mode 100644
> > > > index 000000000000..b091b1185a36
> > > > --- /dev/null
> > > > +++ b/include/dt-bindings/mux/mux-j7200-wiz.h
> > > > @@ -0,0 +1,29 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * This header provides constants for J7200 WIZ.
> > > > + */
> > > > +
> > > > +#ifndef _DT_BINDINGS_J7200_WIZ
> > > > +#define _DT_BINDINGS_J7200_WIZ
> > > > +
> > > > +#define SERDES0_LANE0_QSGMII_LANE3	0x0
> > > > +#define SERDES0_LANE0_PCIE1_LANE0	0x1
> > > > +#define SERDES0_LANE0_IP3_UNUSED	0x2
> > > > +#define SERDES0_LANE0_IP4_UNUSED	0x3
> > > > +
> > > > +#define SERDES0_LANE1_QSGMII_LANE4	0x0
> > > > +#define SERDES0_LANE1_PCIE1_LANE1	0x1
> > > > +#define SERDES0_LANE1_IP3_UNUSED	0x2
> > > > +#define SERDES0_LANE1_IP4_UNUSED	0x3
> > > > +
> > > > +#define SERDES0_LANE2_QSGMII_LANE1	0x0
> > > > +#define SERDES0_LANE2_PCIE1_LANE2	0x1
> > > > +#define SERDES0_LANE2_IP3_UNUSED	0x2
> > > > +#define SERDES0_LANE2_IP4_UNUSED	0x3
> > > > +
> > > > +#define SERDES0_LANE3_QSGMII_LANE2	0x0
> > > > +#define SERDES0_LANE3_PCIE1_LANE3	0x1
> > > > +#define SERDES0_LANE3_USB		0x2
> > > > +#define SERDES0_LANE3_IP4_UNUSED	0x3
> > > > +
> > > > +#endif /* _DT_BINDINGS_J7200_WIZ */
> > > 
> > > Should not the defines start with J7200_WIZ? SERDES0 seems like a too
> > > generic prefix, at least to me.
> > 
> > Thanks, good point. I am not sure if WIZ should even be used.. It is
> > a TI internal prefix for various serdes solutions, but I agree that
> > SERDES0 is too generic a terminology. That said, we should cleanup
> > include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
> > j7200 changes.
> > 
> 
> I'm planning to put all TI SERDES definitions in one header file "ti-serdes-mux.h"
> and add SOC specific prefixes to the macros.
> 
> This will mean some churn in the existing DT files. (only 2 so far)

Please check bindings and examples if any reference as well. Those
changes will need to be considered as well.

> 
> Are you guys OK if I do the change in one patch to avoid a broken build in between.
> You guys can then decide whose tree it goes through.
> 
> The new SoC addition will be separate of course.

If Peter acks and is OK with the changes, then based on Peter's opinion,
I'd rather take the changes via SoC tree for 5.10+ for maintaining
bisectability.

I prefer we name it ti-serdes-mux or something that Peter is OK with as
well. reasons:

i) "wiz" is yet another TLA deal even if documented in public TI TRM in some
   remote chapter, other non-TI folks are going to go scratching their
   heads..
ii) There is no way this can scale with one header per SoC!

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
