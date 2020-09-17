Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857DF26DB90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIQMaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:30:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:43644 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgIQM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:27:37 -0400
X-Greylist: delayed 735 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:27:35 EDT
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HCR44A044284;
        Thu, 17 Sep 2020 07:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600345624;
        bh=h6OSpodV87NvHPxkIpIpIZPach27yXLw2FWSGojvvF4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Rh/QMCITmgUxEIqK/aTN6LkyK3HkutT6/qo58DtuiVyZlg2I4qZ3DOUwxnh3ulGBD
         8idi+DOxwRqf6GWUkk8SOYZsXXOx5RIcaMr2A9wqqbayfO6Ve/WANjJA8RzKBqYVMr
         oi/iwBZkcRPonwNq549pe7ATCZmWJpDVtKj/nmfA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HCR3Q6129725
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 07:27:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 07:27:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 07:27:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HCR3Em125110;
        Thu, 17 Sep 2020 07:27:03 -0500
Date:   Thu, 17 Sep 2020 07:27:03 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Rosin <peda@axentia.se>
CC:     Roger Quadros <rogerq@ti.com>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
Message-ID: <20200917122703.ojuzn6b3tvqbnssc@akan>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
 <d8b8c070-577f-f778-e595-58517ffce6e3@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d8b8c070-577f-f778-e595-58517ffce6e3@axentia.se>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:45-20200917, Peter Rosin wrote:
[...]
> 
> >> Should not the defines start with J7200_WIZ? SERDES0 seems like a too
> >> generic prefix, at least to me.
> > 
> > Thanks, good point. I am not sure if WIZ should even be used.. It is
> > a TI internal prefix for various serdes solutions, but I agree that
> > SERDES0 is too generic a terminology. That said, we should cleanup
> > include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
> > j7200 changes.
> 
> Right. As maintainer for the directory in question, I should have
> been on Cc for that series too, but it appears I wasn't. Hence, I

yes, you should have been. The following commit introduced it.

commit b766e3b0d5f6 ("arm64: dts: ti: k3-j721e-main: Add system controller
node and SERDES lane mux")

> didn't notice that file until now when I went looking for it. Why
> wasn't I on Cc?

Got through the SoC tree - an oversight on our part[1] and should'nt have,
Apologies on the bad call.

I would like to propose the following:
a) The header should be renamed to be something more human friendly.
b) The header should be renamed to be something TI specific and NOT per
TI SoC.
c) The macros need renaming to be less generic as it stands right now.


If you ack the changes, I am guessing that the changes will impact dts
a lot and would rather take the cleanups through SoC tree to maintain
bisectability? OR I can pick on an immutable tag from you with just the
header file change and pick on the dts - but I doubt that would be
bisectable. Just worried that I have picked a bunch of cleanups already
on the dts for 5.10, and would like to avoid a merge conflict.


your thoughts?

[1] https://lore.kernel.org/linux-devicetree/20200709231933.GA1083562@bogus/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
