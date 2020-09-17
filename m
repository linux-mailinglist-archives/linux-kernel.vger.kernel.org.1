Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E128A26DC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgIQMyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:54:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47590 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgIQMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:51:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HCp58F051343;
        Thu, 17 Sep 2020 07:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600347065;
        bh=h1+j6WmExINKlQygCh7j0c5ayp42nqCQ1rs/Cq/b8uU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qrL5Uq9ifDK0pkNIIsIzSFOlAXxjP1ST9zzxe/KHVEj5Vf0vUsGNo5MKBG6GT7onC
         0AzHa7hOpmByLmNOJe7kRkQhtrC/ghJ4GgWcgBmn6li6PkoF27WNN8HCOrKRcnTfA3
         hWM+kLwL3JBNR4BMUxRls9n4eIxWpiDmlz2lOUGc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HCp51O012763
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 07:51:05 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 07:51:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 07:51:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HCp54b041373;
        Thu, 17 Sep 2020 07:51:05 -0500
Date:   Thu, 17 Sep 2020 07:51:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
Message-ID: <20200917125104.xznpg2fhv5iilbtl@akan>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
 <08c84d02-abe1-8399-50fb-9268c7130f8a@ti.com>
 <ad1d6964-f553-3a22-65fd-58bc5a166f80@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad1d6964-f553-3a22-65fd-58bc5a166f80@axentia.se>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:37-20200917, Peter Rosin wrote:
[...]

> >>> Should not the defines start with J7200_WIZ? SERDES0 seems like a too
> >>> generic prefix, at least to me.
> >>
> >> Thanks, good point. I am not sure if WIZ should even be used.. It is
> >> a TI internal prefix for various serdes solutions, but I agree that
> >> SERDES0 is too generic a terminology. That said, we should cleanup
> >> include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
> >> j7200 changes.
> >>
> > 
> > I'm planning to put all TI SERDES definitions in one header file "ti-serdes-mux.h"
> > and add SOC specific prefixes to the macros.
> > 
> > This will mean some churn in the existing DT files. (only 2 so far)
> > 
> > Are you guys OK if I do the change in one patch to avoid a broken build in between.
> > You guys can then decide whose tree it goes through.
> > 
> > The new SoC addition will be separate of course.
> 
> We should get these changes done before 5.9 is released.

OK.

> Not breaking the build for each intermediate step is always a priority.
> Also, renaming mux-j721e-wiz.h to ti-serdes-mux.h and renaming the macros
> could be seen as orthogonal, and it is certainly possible to do that
> as two patches without breaking the build in between. It would just need
> changes on both sides of the interface in both patches. But I wouldn't
> worry about separating this into two patches, just do a rename patch and
> be done with it. Then follow up with additions for j7200.
> 
> However, now that we are renaming things anyway, do we really need "mux"
> in the name of the file itself?
> I personally find .../dt-dbindings/mux/ti-serdes.h descriptive enough.

yep, OK with me.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
