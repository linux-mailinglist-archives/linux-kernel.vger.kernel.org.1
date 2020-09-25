Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0DF278C25
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgIYPIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:08:40 -0400
Received: from mail-eopbgr70081.outbound.protection.outlook.com ([40.107.7.81]:59620
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbgIYPIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tgfwi3IO+otkmtjD/YOELl0TM8aWIJygjBXzrlTKOw=;
 b=DGtQreRigXYt+xENWWs2aem5f6+i67GbTgMXlebR/+FD9AyiKtQ1ddGlCniumJjq1z7rXX2CsJSyWMWW/MiJR71F0D5mqZZorn0+cb3UIlqzhwL/4jFWk5+H954NLKtXouAHPim7eFi6YdyFpLFTustCgflL/wlPmQFJAF48v1w=
Received: from DB6PR0501CA0025.eurprd05.prod.outlook.com (2603:10a6:4:67::11)
 by VE1PR08MB5775.eurprd08.prod.outlook.com (2603:10a6:800:1a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Fri, 25 Sep
 2020 15:08:31 +0000
Received: from DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:67:cafe::b1) by DB6PR0501CA0025.outlook.office365.com
 (2603:10a6:4:67::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Fri, 25 Sep 2020 15:08:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT026.mail.protection.outlook.com (10.152.20.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Fri, 25 Sep 2020 15:08:31 +0000
Received: ("Tessian outbound a0bffebca527:v64"); Fri, 25 Sep 2020 15:08:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dba057682a655f09
X-CR-MTA-TID: 64aa7808
Received: from 40bc35e0b770.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 857EF440-647C-48C0-9DC3-3206FD49210C.1;
        Fri, 25 Sep 2020 15:08:25 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 40bc35e0b770.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Sep 2020 15:08:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsCmTvjL6Q8j9LB1u0rr7LUF7+23loCpSM/hVl/FMNRRoaUD9iwbFyqaca7RvbEce/N9jPtbtKYU2tFX6jxseV67kPO4uDBIM5401nqiN4kxo0islsJjsWvut3TpqVVfhxM2kd2ynYZzPwiCrNwSyU3ORZjJeVgzdWKL/JZEk6sCwwewzwXLF9QXCfXxEUWALgbsxegQCLrIoOjrVRWTU9kL0LcF7ywp6tzLHfBcAC0+tOoaKA7uE3np5kkoja+GZIVBvEFcPG1S3d1JzIk7iLOAGGysADjOp0vZmMnpJhWnjTtTSp3e25kot5Ltx1R81FUiHrIHUGPIYJtuc15Z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tgfwi3IO+otkmtjD/YOELl0TM8aWIJygjBXzrlTKOw=;
 b=KD6WFAQgOFZC2hCYqWFjg6bjzvcYWqZ00lSYyOlGVCta2Ah8WISLHRnRGdOfdnIQPPorIqX0rYaiZAO44JcTB6xv0epf0dqnx7wimbdjhPPIk36IX5FlhUSfsKaF6XC4b+mnrmgDfiBqCvNTRfoCQjzV49rdDhDvt5YCTAVbLvsXvYOhL1v4P7fV3KH3BvxePHoTWp1xiD07R9fQ6o/KmNscdVIIYyeugVpqfTTkUHIOq5U21zgp7yjZExuCLTO2dzYwAD84/hbO7OSrQ3u0DBMaIUNqMsPr+HCo+376BjbYGcozXZslLC1TeHHuU97Tr3nI2pX+iSiw5lAqCIDg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tgfwi3IO+otkmtjD/YOELl0TM8aWIJygjBXzrlTKOw=;
 b=DGtQreRigXYt+xENWWs2aem5f6+i67GbTgMXlebR/+FD9AyiKtQ1ddGlCniumJjq1z7rXX2CsJSyWMWW/MiJR71F0D5mqZZorn0+cb3UIlqzhwL/4jFWk5+H954NLKtXouAHPim7eFi6YdyFpLFTustCgflL/wlPmQFJAF48v1w=
Received: from DB7PR08MB3689.eurprd08.prod.outlook.com (2603:10a6:10:79::16)
 by DB6PR08MB2870.eurprd08.prod.outlook.com (2603:10a6:6:20::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 25 Sep
 2020 15:08:23 +0000
Received: from DB7PR08MB3689.eurprd08.prod.outlook.com
 ([fe80::cccc:2933:d4d3:1a9e]) by DB7PR08MB3689.eurprd08.prod.outlook.com
 ([fe80::cccc:2933:d4d3:1a9e%6]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 15:08:23 +0000
From:   Bertrand Marquis <Bertrand.Marquis@arm.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/arm: do not setup the runstate info page if kpti is
 enabled
Thread-Topic: [PATCH] xen/arm: do not setup the runstate info page if kpti is
 enabled
Thread-Index: AQHWks1x5K2MwRRKqk+mgjFvkj623Kl5ddAA
Date:   Fri, 25 Sep 2020 15:08:23 +0000
Message-ID: <F3D30F3F-7AEF-43A0-8A2D-A55AA570C3C8@arm.com>
References: <20200924234955.15455-1-sstabellini@kernel.org>
In-Reply-To: <20200924234955.15455-1-sstabellini@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [82.24.250.194]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba264659-2cb4-4491-addb-08d86164dd98
x-ms-traffictypediagnostic: DB6PR08MB2870:|VE1PR08MB5775:
X-Microsoft-Antispam-PRVS: <VE1PR08MB57756BDF2BC23644A7583D9A9D360@VE1PR08MB5775.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PAPIz2alU1xk5An8oSdhGeFHGRKkdF1IkgTTwuCa0AZ63yc6cyj9pa3r/lVVtJFeeq6WgeXaUIFMawlRDQ4KIKf8Rh95BUV15d1z6z5TkmhoCLkjDCTSj+5r8LTe9trPMahpHeMP1epBIvVmM7Eagh6qd5TqACoPJMUk4MbAfTZyy9tDXL+G7OFNBbbCyTH4HizlzwkGEoMM3VMsEuwL6eLY/1eQnlIUkRCqcb2Rq72dRFcPkCk2Oinlv7tPP/IgzDq8rJZvJC8eOk3f3ym6sPkjUXIYi7NAP6P5AEs9jo/O3svvTNGkbiFKnCT16TdtmaVZ38SL0dXwcUglOqLyMF0CK4BdrjDCjO27R3qPouuugga6U8ySUEYT3apR86me
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR08MB3689.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(33656002)(6486002)(186003)(86362001)(478600001)(316002)(83380400001)(53546011)(8676002)(6506007)(4326008)(8936002)(71200400001)(76116006)(2906002)(5660300002)(91956017)(6916009)(66556008)(66476007)(66446008)(64756008)(36756003)(6512007)(66946007)(26005)(2616005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8axEd7pwo3eip7N4U709EzxhAUYQEmF6NEPvDzZ7qG++usoGpWsfA5a7X66ymNE76KXrj5NncVN0zMu/SkBrPM2bfddw/1vNbywsNp+bKB73ysdb8kRqt+2XdgoE+SnlSRDMl9vpcYgsWr7Vd3QSV3/CbSXDaikydAS2cSTJv7t9/dem9PsVq+3GHF/Il2vGY3bYqXEyhaLETI2DqPUkIlYqtB/Af1gwbr4POUcr1mWhHDlNBlDyHj6YreUwhJi3iXcpsA0xP2qLcGdTnnagZJ9NO7t2Vt/Pc/aBltX7YlVjMoxV0MfHL+jih4NohwNfwHJ5PmSxI39qVZajT1LEXjmcUc/4d0wZnp0eRPdpmm5rAWylV6+nGqnoxUmenIXRtldvAYd+abOiaLMhTXbPXaVK9xbnOWcF3kTTvJNIwiS41m6FAliRZRS9r9qszJfH2QrTT+fSzBcZn9Hbmb/DYDPYmbJ5OMp2F7iKcpJm6oW32okS2CjUYj5p1uHfxQlIdkmC6zatKdbm88+2d7zjUQQXRxjazrGjTgfvaDb/A2mpr9vVk2/qCrrfNK2kVho6fYOZtRWkP8xMyPkPapNyVFIAwRqgB/WZ1DJY4spKOBhctJFmjIltFZjpHfV6aYF2GXaMcKw2kWOyPM+0HcJtvA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A92F4CC08453C4AA4607BEA08290822@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2870
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2425a4bf-009d-45e8-b9d3-08d86164d901
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QX+GHiRYOBxBGkqTTOR+4oQt8pBzlZlqCVyMpwXhtNQ6e08EANidBzHIb+Qd8lWcjd858pGPHD6lq2Y5elF4g0bh8xAA3/HO6a/1NqcF7aVQnnKdUPAceJYFfZ+ZaBDAAikhZtbVfVaA7a/NsC0p2Q0nI1HVlLbp3QLVSzNClVFSPyPWbi6KmBkSrD53piN1BtOLf4LVWxBzFemxpYfQRCQQEMWX8PJrVjQfH5RR/mAD2UFfb1AinWsKQLfKGOVu/KgN5BUxN/f0P99goemFz5rFYETwYvDcygxRxTYP54TpyZ9w48CFpq2UQJWVIhFp2FIFUPzeH1DElMOhaZgrHF5gXq+U2q+Gv41II97KW+CdBcMDQxkBseqRyCL7GpLvPGVywgwEOd/q6am9Ihp76qw25vRPu8/uOGAahguc/jRUAFgkugvkO28Ui7XT3OM2
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966005)(70586007)(70206006)(83380400001)(107886003)(86362001)(33656002)(5660300002)(356005)(81166007)(82740400003)(82310400003)(47076004)(2906002)(186003)(53546011)(54906003)(336012)(478600001)(36756003)(316002)(4326008)(8936002)(6486002)(26005)(6506007)(6512007)(8676002)(2616005)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 15:08:31.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba264659-2cb4-4491-addb-08d86164dd98
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5775
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On 25 Sep 2020, at 00:49, Stefano Stabellini <sstabellini@kernel.org> wro=
te:
>
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
>
> The VCPUOP_register_runstate_memory_area hypercall takes a virtual
> address of a buffer as a parameter. The semantics of the hypercall are
> such that the virtual address should always be valid.
>
> When KPTI is enabled and we are running userspace code, the virtual
> address is not valid, thus, Linux is violating the semantics of
> VCPUOP_register_runstate_memory_area.
>
> Do not call VCPUOP_register_runstate_memory_area when KPTI is enabled.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
Reviewed-by: Bertrand Marquis <bertrand.marquis@arm.com>

I tested this on an Arm64 FVP and Errors generated by Xen are not present a=
nymore.
Thanks a lot for the patch Stefano.

Cheers,
Bertrand

> CC: Bertrand Marquis <Bertrand.Marquis@arm.com>
> CC: boris.ostrovsky@oracle.com
> CC: jgross@suse.com
> ---
> arch/arm/include/asm/xen/page.h   | 5 +++++
> arch/arm/xen/enlighten.c          | 6 ++++--
> arch/arm64/include/asm/xen/page.h | 6 ++++++
> 3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/p=
age.h
> index 31bbc803cecb..dc7f6e91aafa 100644
> --- a/arch/arm/include/asm/xen/page.h
> +++ b/arch/arm/include/asm/xen/page.h
> @@ -1 +1,6 @@
> #include <xen/arm/page.h>
> +
> +static inline bool xen_kernel_unmapped_at_usr(void)
> +{
> +return false;
> +}
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index e93145d72c26..ea76562af1e9 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -158,7 +158,8 @@ static int xen_starting_cpu(unsigned int cpu)
> BUG_ON(err);
> per_cpu(xen_vcpu, cpu) =3D vcpup;
>
> -xen_setup_runstate_info(cpu);
> +if (!xen_kernel_unmapped_at_usr())
> +xen_setup_runstate_info(cpu);
>
> after_register_vcpu_info:
> enable_percpu_irq(xen_events_irq, 0);
> @@ -387,7 +388,8 @@ static int __init xen_guest_init(void)
> return -EINVAL;
> }
>
> -xen_time_setup_guest();
> +if (!xen_kernel_unmapped_at_usr())
> +xen_time_setup_guest();
>
> if (xen_initial_domain())
> pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
> diff --git a/arch/arm64/include/asm/xen/page.h b/arch/arm64/include/asm/x=
en/page.h
> index 31bbc803cecb..dffdc773221b 100644
> --- a/arch/arm64/include/asm/xen/page.h
> +++ b/arch/arm64/include/asm/xen/page.h
> @@ -1 +1,7 @@
> #include <xen/arm/page.h>
> +#include <asm/mmu.h>
> +
> +static inline bool xen_kernel_unmapped_at_usr(void)
> +{
> +return arm64_kernel_unmapped_at_el0();
> +}
> --
> 2.17.1
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
