Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1426DBF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgIQMq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:46:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42774 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgIQMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:43:15 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:43:09 EDT
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HCaTQ6032716;
        Thu, 17 Sep 2020 07:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600346189;
        bh=vYoWYgW6dB3En0e3iIC586CdvGCOhfHOK4t+npUDGJM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=bMnfncX2TGo97mlzV5RCdKdsS0EXF4SE6ZZBh8o8TLKoPlVKdoFE0DYvg4vWG8RZh
         Hpn/VJq4mBNNMeVp8HEK+CzhYGeMEdXBlOQbTsqBLzKWoiWFk+YDjZcFVeiNWQ/Qzu
         Gpo6jV33Q6PeANzA7HtUhrTENZWZymF7ToInMbis=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HCaT6V015109
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 07:36:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 07:36:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 07:36:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HCaTQu011989;
        Thu, 17 Sep 2020 07:36:29 -0500
Date:   Thu, 17 Sep 2020 07:36:29 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Peter Rosin <peda@axentia.se>, Roger Quadros <rogerq@ti.com>,
        <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
Message-ID: <20200917123629.ve77q7koqjlhgdhc@akan>
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
 <8a27f8f3-20c4-f72c-b683-81153107d867@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8a27f8f3-20c4-f72c-b683-81153107d867@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:47-20200917, Kishon Vijay Abraham I wrote:

[..]
> > Thanks, good point. I am not sure if WIZ should even be used.. It is
> > a TI internal prefix for various serdes solutions, but I agree that
> > SERDES0 is too generic a terminology. That said, we should cleanup
> > include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
> > j7200 changes.
> 
> WIZ is defined in public TRM (https://www.ti.com/lit/pdf/spruiu1).
> "

Maybe give the TRM team a feedback to use a little more human readable
naming? if I just ctrl+f "wiz" in the 10,000 page trm the first match
is: "CA bits can be swizzled between any bit positions via the
DDRSS_PHY_1053[23-0] PHY_ADR_ADDR_SEL_0 field" (it is not even in the
table of contents?)

However, if I search for serdes, and then go down to page 7773, "WIZ:
The WIZ acts as a wrapper for the SerDes, and can both send control
signals to and report status signals from the SerDes, and muxes SerDes
to peripherals"

just call it ti-k3-serdes-mux (since there are other TI serdes muxes..)?

You dont want to be on the brunt of something like [1] caused by, your's
truely..


Also this is never going to scale with the number of devices we are
spinning out.. one header per SoC? makes no sense to me.

[1]
https://groups.google.com/forum/#!msg/linux.kernel/fcntv48yoOc/35bAdI1eaiUJ
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
