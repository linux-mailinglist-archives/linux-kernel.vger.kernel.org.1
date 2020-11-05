Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA802A77F2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgKEHZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:25:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60358 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgKEHZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:25:12 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A57P6cI083934;
        Thu, 5 Nov 2020 01:25:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604561106;
        bh=T5DlDzsAeznf0wsBj6LJt3ZW12Kli5EmdqiLUvgGk5g=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=eNheejXCzcCcnho3WrCgym6kgAMsiCZOrNHwLd/b2s+iB8urUNfGazEN1beSMHAf9
         flnkvhf89pUbqT5ZQd5WcEQX5dSkRVT1XaqhgzAkAPZtlLR1/9qtrAYcRj4VbcxFfz
         1ZSA2b1tAbtSJLugOrBcYduLJnqNeQgF4OrJTnio=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A57P5Ih122475
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 01:25:05 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 01:25:05 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 01:25:05 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A57P2AC051619;
        Thu, 5 Nov 2020 01:25:02 -0600
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-am65*: Cleanup disabled nodes at
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
 <20201104224356.18040-2-nm@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3cc234ac-ea7a-fe3e-e485-ee3123048fec@ti.com>
Date:   Thu, 5 Nov 2020 09:25:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104224356.18040-2-nm@ti.com>
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
> Lets cleanup defaults of am654 SoC dtsi before this gets more harder
> to cleanup later on and new SoCs are added.
> 
> The dtb generated is identical with the patch and it is just cleanup to
> ensure we have a clean usage model
> 
> [1] https://lore.kernel.org/linux-arm-kernel/20201027130701.GE5639@atomide.com/
> 
> Fixes: 9bcb631e9953 ("arm64: dts: ti: k3-am654-main: Add McASP nodes")
> Fixes: fc539b90eda2 ("arm64: dts: ti: am654: Add DSS node")
> Cc: Jyri Sarha <jsarha@ti.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi       |  8 --------
>  arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 16 ++++++++++++++++
>  2 files changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
