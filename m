Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441832A77F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgKEHZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:25:34 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKEHZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:25:34 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A57PTgx084143;
        Thu, 5 Nov 2020 01:25:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604561129;
        bh=KslEU2O68CHJb3gLVJxeNScHoYi9XbnVfavsgk9RqVU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=F0Lvsrl9udoe3tKshM8zwbmdWz/W1U4H+1Y4mPgfdynKk0xRrhC+Q1wmR/WjRc47M
         BoChFHvicvjIBeVrHrblsmhwx1EvN8p8+4MwuMnDkXvPOUveRu01sfh/9GiS1mr5Xv
         yTG5sZTywAGlla5aNqdYRljzB0jtINekTiLyq5Is=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A57PTY9068421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 01:25:29 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 01:25:26 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 01:25:26 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A57PNVs052480;
        Thu, 5 Nov 2020 01:25:24 -0600
Subject: Re: [PATCH 2/4] arm64: dts: ti: k3-j721e*: Cleanup disabled nodes at
 SoC dtsi level
To:     Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@ti.com>,
        Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201104224356.18040-1-nm@ti.com>
 <20201104224356.18040-3-nm@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <265fdc00-7f5f-48c3-3d99-971ccd466232@ti.com>
Date:   Thu, 5 Nov 2020 09:25:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104224356.18040-3-nm@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 00:43, Nishanth Menon wrote:
> The device tree standard sets the default node behavior when status
> property as enabled. There are many reasons for doing the same, number
> of strings in device tree, default power management functionality etc
> are few of the reasons.
> 
> In general, after a few rounds of discussions [1] there are few
> options one could take when dealing with SoC dtsi and board dts
> 
> a. SoC dtsi provide nodes as a super-set default (aka enabled) state and
>    to prevent messy board files, when more boards are added per SoC, we
>    optimize and disable commonly un-used nodes in board-common.dtsi
> b. SoC dtsi disables all hardware dependent nodes by default and board
>    dts files enable nodes based on a need basis.
> c. Subjectively pick and choose which nodes we will disable by default
>    in SoC dtsi and over the years we can optimize things and change
>    default state depending on the need.
> 
> While there are pros and cons on each of these approaches, the right
> thing to do will be to stick with device tree default standards and
> work within those established rules. So, we choose to go with option
> (a).
> 
> Lets cleanup defaults of j721e SoC dtsi before this gets more harder
> to cleanup later on and new SoCs are added.
> 
> The only functional difference between the dtb generated is
> status='okay' is no longer necessary for mcasp10 and depends on the
> default state.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/
> 
> Fixes: 1c4d35265fb2 ("arm64: dts: ti: k3-j721e-main: Add McASP nodes")
> Fixes: 76921f15acc0 ("arm64: dts: ti: k3-j721e-main: Add DSS node")
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 48 ++++++++++++++++++-
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 26 ----------
>  2 files changed, 47 insertions(+), 27 deletions(-)
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
