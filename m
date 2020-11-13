Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC22B23E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKMSk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:40:26 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57510 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgKMSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:40:25 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADIeLH6056023;
        Fri, 13 Nov 2020 12:40:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605292821;
        bh=65UFRQeYElHDRkzVjdvoo314CxPOa/467VA1i7mcb40=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eH+KktJSQAHJb6XkWc7ipRKxZWz3vTE17QmNDQsRomN5HGKBHm6nR4suBK7nogbz4
         Kl7dImz5SvgVSfP3r1T9sK7RnB4bGgzWg7GWQzOY3paWFtF+ViFd/LIXycAoJ9yHw0
         7JuyeOC23/UHcNA2SfKwlirnghRvcSdvEWlmua78=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADIeL3R008484
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 12:40:21 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 12:40:20 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 12:40:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADIeKM3066194;
        Fri, 13 Nov 2020 12:40:20 -0600
Date:   Fri, 13 Nov 2020 12:40:20 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
CC:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in
 main domain
Message-ID: <20201113184020.drntugqsnj7dzsnh@ultimatum>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
 <20201102191120.20380-2-faiz_abbas@ti.com>
 <20201112163953.soia5cje4ry42ujf@kahuna>
 <6ce6de4b-6e4d-1d2d-aa7a-570d1796d668@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6ce6de4b-6e4d-1d2d-aa7a-570d1796d668@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23:59-20201113, Sekhar Nori wrote:
[..]
> > dtbs_check: we added:
> > arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@600000: Missing #address-cells in interrupt provider
> > arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@610000: Missing #address-cells in interrupt provider
> > arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@620000: Missing #address-cells in interrupt provider
> > arch/arm64/boot/dts/ti/k3-j7200-main.dtsi: /bus@100000/gpio@630000: Missing #address-cells in interrupt provider
> 
> Hmm, running dtbs_check, I did not really see this. These are all the
> warnings I see for TI platforms: https://pastebin.ubuntu.com/p/m2my62mjQq/

Here is the full list of checks I ran through with kernel_patch_verify
(docker)
	https://pastebin.ubuntu.com/p/tcnWw89CMD/

See lines 128 onwards for this series. kernel_patch_verify does'nt
complain on existing warnings, but just prints when there are additional
ones added in. Also make sure we have the right dtc as well
dtc 1.6.0 and dt_schema 2020.8.1 was used.

> 
> The tree I am testing is linux-next of 12th Nov + these three patches
> applied.
> 
> Also, #address-cells for interrupt provider being compulsory does not
> make full sense to me. Nothing in
> Documentation/devicetree/bindings/interrupt-controller/interrupts.txt or
> Documentation/devicetree/bindings/gpio/gpio-davinci.txt suggests that as
> well.
> 
> Existing GPIO nodes for AM654 or J721E does not have #address-cells as well.
> 
> Adding Grygorii as well, in case he knows more about this.


Yes - we need to have this conversation in the community :) I had
tagged this internally already during the 5.10 merge cycle that we
need to clean up the #address-cells warning and in some cases, maybe
the bindings are probably not accurate to attempt an enforcement.
I'd really like a conclusion on the topic as I recollect Lokesh and
Grygorii had a debate internally, but reached no conclusion, lets get
the wisdom of the community to help us here.

[1] https://github.com/nmenon/kernel_patch_verify/blob/master/kpv
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
