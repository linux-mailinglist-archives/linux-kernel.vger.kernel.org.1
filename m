Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EED52FD607
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404027AbhATQuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:50:03 -0500
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:17299 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbhATQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1611161315; x=1642697315;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=doH9F7GS4g+bTjj489rEPcGj8ZTLLmbjOcj3HnhIk/g=;
  b=ZwB3plyvbsjWVgth2d0fy7G2ZQ5Xq18itordEtDkQCe9z6uU1cxCc7vo
   tJzy7IvQHgminCC/yG906h8TpeX5AmwN/VQp9jYtF8gFum3Cog6Dq9AzE
   FpAA6SkGT5RgjKEqk7ls4OI0D3Xzj3ptc8d8Byfzfz9/2YGSxHq3KQeg+
   0=;
X-IronPort-AV: E=Sophos;i="5.79,361,1602547200"; 
   d="scan'208";a="912075018"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-cc689b93.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 20 Jan 2021 16:47:39 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-cc689b93.us-west-2.amazon.com (Postfix) with ESMTPS id 12C7D1216F0;
        Wed, 20 Jan 2021 16:47:39 +0000 (UTC)
Received: from EX13D20UWC001.ant.amazon.com (10.43.162.244) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 16:47:38 +0000
Received: from edge-m1-r3-201.e-iad16.amazon.com (10.43.162.94) by
 EX13D20UWC001.ant.amazon.com (10.43.162.244) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 20 Jan 2021 16:47:36 +0000
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
To:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Hector Martin" <marcan@marcan.st>, <linux-kernel@vger.kernel.org>,
        Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
From:   Alexander Graf <graf@amazon.com>
Message-ID: <ce5692a9-e716-514a-f196-b0645bb03eb8@amazon.com>
Date:   Wed, 20 Jan 2021 17:47:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120132717.395873-4-mohamed.mediouni@caramail.com>
Content-Language: en-US
X-Originating-IP: [10.43.162.94]
X-ClientProxiedBy: EX13D29UWA002.ant.amazon.com (10.43.160.63) To
 EX13D20UWC001.ant.amazon.com (10.43.162.244)
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 14:27, Mohamed Mediouni wrote:
> Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious hardwar=
e quirk.
> =

> On Apple processors, writes using the nGnRE device memory type get droppe=
d in flight,
> getting to nowhere.
> =

> Signed-off-by: Stan Skowronek <stan@corellium.com>
> Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
> ---
>   arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> =

> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 1f7ee8c8b7b8..06436916f137 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -51,6 +51,25 @@
>   #define TCR_KASAN_HW_FLAGS 0
>   #endif
> =

> +#ifdef CONFIG_ARCH_APPLE

Is there any particular reason for this #ifdef?


Alex

> +
> +/*
> + * Apple cores appear to black-hole writes done with nGnRE.
> + * We settled on a work-around that uses MAIR vs changing every single u=
ser of
> + * nGnRE across the arm64 code.
> + */
> +
> +#define MAIR_EL1_SET_APPLE						\
> +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
> +
> +#endif
> +
>   /*
>    * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal mem=
ory and
>    * changed during __cpu_setup to Normal Tagged if the system supports M=
TE.
> @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
>   	 * Memory region attributes
>   	 */
>   	mov_q	x5, MAIR_EL1_SET
> +#ifdef CONFIG_ARCH_APPLE
> +	mrs	x0, MIDR_EL1
> +	lsr	w0, w0, #24
> +	mov_q	x1, MAIR_EL1_SET_APPLE
> +	cmp	x0, #0x61			// 0x61 =3D Implementer: Apple
> +	csel	x5, x1, x5, eq
> +#endif
>   #ifdef CONFIG_ARM64_MTE
>   	mte_tcr	.req	x20
> =

> --
> 2.29.2
> =





Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



