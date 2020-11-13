Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D52B25FC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgKMU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:56:00 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59104 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMU4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:56:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ADKtsSE103497;
        Fri, 13 Nov 2020 14:55:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605300954;
        bh=kGw9m7CHBC2tezcxzoqeRHbsp27X46LPmzeqoXrCqPk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jqKaZkxWimstzwdrpxp+NmfkZdbeh+owRhnz/dxifNRB7gXRdUmkQYq0XuvJTdbJR
         ky6YjcJwOFpgH9EvkN7w8DB9dpA1/1stP+o3UaPhI9bbKVGB4GMihNemi24nB5Zt2Q
         MTpa2Qk7HUHepyUv6YHrjEDDYrCu77Zget21F+gs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ADKtsAX084224
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 14:55:54 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 13
 Nov 2020 14:55:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 13 Nov 2020 14:55:54 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ADKtrDf051402;
        Fri, 13 Nov 2020 14:55:53 -0600
Date:   Fri, 13 Nov 2020 14:55:52 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Sekhar Nori <nsekhar@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <t-kristo@ti.com>,
        <robh+dt@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j7200-main: Add gpio nodes in
 main domain
Message-ID: <20201113205552.p63u2gxgw4pfxil5@stunning>
References: <20201102191120.20380-1-faiz_abbas@ti.com>
 <20201102191120.20380-2-faiz_abbas@ti.com>
 <20201112163953.soia5cje4ry42ujf@kahuna>
 <6ce6de4b-6e4d-1d2d-aa7a-570d1796d668@ti.com>
 <20201113184020.drntugqsnj7dzsnh@ultimatum>
 <c6267288-581e-3b34-cec5-d5879f3d1283@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6267288-581e-3b34-cec5-d5879f3d1283@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 00:39-20201114, Sekhar Nori wrote:
> 
> I was using the latest schema from master. But I changed to 2020.08.1
> also, and still don't see the warning.
> 
> $ dt-doc-validate --version
> 2020.12.dev1+gab5a73fcef26
> 
> I dont have a system-wide dtc installed. One in kernel tree is updated.
> 
> $ scripts/dtc/dtc --version
> Version: DTC 1.6.0-gcbca977e
> 
> Looking at your logs, it looks like you have more patches than just this
> applied. I wonder if thats making a difference. Can you check with just
> these patches applied to linux-next or share your tree which includes
> other patches?
> 
> In your logs, you have such error for other interrupt controller nodes
> as well. For example:
> 
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi:
> /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells
> in interrupt provider
> 
> Which I don't see in my logs. My guess is some other patch(es) in your
> patch stack either uncovers this warning or causes it.

Oh boy! I sent you and myself on wild goose chase! Really sorry about
messing up in the report of bug.

It is not dtbs_check, it is building dtbs with W=2 that generates this
warning. dtc 1.6.0 is sufficient to reproduce this behavior.

Using v5.10-rc1 as baseline (happens the same with next-20201113 as
		well.

v5.10-rc1: https://pastebin.ubuntu.com/p/Pn9HDqRjQ4/ (recording:
    https://asciinema.org/a/55YVpql9Bq8rh8fePTxI2xObO)

v5.10-rc1 + 1st patch in the series(since we are testing):
	https://pastebin.ubuntu.com/p/QWQRMSv565/ (recording:
https://asciinema.org/a/ZSKZkOY13l4lmZ2xWH34jMlM1)

Diff: https://pastebin.ubuntu.com/p/239sYYT2QY/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
