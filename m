Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF2E26C6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgIPSFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:05:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43126 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIPSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:05:10 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GFja2L128927;
        Wed, 16 Sep 2020 10:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600271137;
        bh=CiYSe7E3zVW/oh1AM7cOjfgZJ00Tsipq0Ada6KWoncI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WKFQaakhlqRUDRsbIVjlNFKMFEyFy+OvL7AvEbTq9PuzXKgQhFm/hIZKcbrTB34a5
         IkIsO8GPk/pIq6UGtDmON7BZxciBTtZ8Sypver7TCivlAWry6x3h0xB2LNWDIOU1cC
         GTxStAn/BGM/z5K1wi4L6CE2pExwUhR1QtU5v08s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GFjarI125114
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 10:45:36 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 10:45:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 10:45:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GFja9g028183;
        Wed, 16 Sep 2020 10:45:36 -0500
Date:   Wed, 16 Sep 2020 10:45:36 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Roger Quadros <rogerq@ti.com>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
Message-ID: <20200916154536.m552ft2jzfsaeokr@akan>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06:52-20200916, Peter Rosin wrote:
> Hi,
> 
> Sorry for the delay.
> 
> On 2020-09-15 13:20, Roger Quadros wrote:
> > Each SERDES lane mux can select upto 4 different IPs.
> > There are 4 lanes in each J7200 SERDES. Define all
> > the possible functions in this file.
> > 
> > Cc: Peter Rosin <peda@axentia.se>
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
> > 
> > diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
> > new file mode 100644
> > index 000000000000..b091b1185a36
> > --- /dev/null
> > +++ b/include/dt-bindings/mux/mux-j7200-wiz.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * This header provides constants for J7200 WIZ.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_J7200_WIZ
> > +#define _DT_BINDINGS_J7200_WIZ
> > +
> > +#define SERDES0_LANE0_QSGMII_LANE3	0x0
> > +#define SERDES0_LANE0_PCIE1_LANE0	0x1
> > +#define SERDES0_LANE0_IP3_UNUSED	0x2
> > +#define SERDES0_LANE0_IP4_UNUSED	0x3
> > +
> > +#define SERDES0_LANE1_QSGMII_LANE4	0x0
> > +#define SERDES0_LANE1_PCIE1_LANE1	0x1
> > +#define SERDES0_LANE1_IP3_UNUSED	0x2
> > +#define SERDES0_LANE1_IP4_UNUSED	0x3
> > +
> > +#define SERDES0_LANE2_QSGMII_LANE1	0x0
> > +#define SERDES0_LANE2_PCIE1_LANE2	0x1
> > +#define SERDES0_LANE2_IP3_UNUSED	0x2
> > +#define SERDES0_LANE2_IP4_UNUSED	0x3
> > +
> > +#define SERDES0_LANE3_QSGMII_LANE2	0x0
> > +#define SERDES0_LANE3_PCIE1_LANE3	0x1
> > +#define SERDES0_LANE3_USB		0x2
> > +#define SERDES0_LANE3_IP4_UNUSED	0x3
> > +
> > +#endif /* _DT_BINDINGS_J7200_WIZ */
> 
> Should not the defines start with J7200_WIZ? SERDES0 seems like a too
> generic prefix, at least to me.

Thanks, good point. I am not sure if WIZ should even be used.. It is
a TI internal prefix for various serdes solutions, but I agree that
SERDES0 is too generic a terminology. That said, we should cleanup
include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
j7200 changes.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
