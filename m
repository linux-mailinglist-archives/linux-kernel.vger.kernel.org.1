Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B0729C5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756885AbgJ0OOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:14:53 -0400
Received: from mail-eopbgr680042.outbound.protection.outlook.com ([40.107.68.42]:35173
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755466AbgJ0OKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:10:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SAWhAVE77d26XguLdbjXm0FAhqpPF7n+8iR6PbTHyIC935L33oWMz2AzrtzidGYCcDbn1RsUjjXQ1uDnsxcJU/tUatlUq170kUBxSuJ8UJNC0ony2dQKrUTYCpLxzZhvGMtB6Dx8v5XnV4W9q85qE2rPdQgLCxRSrbpp7Ld2tHHIl7Z8AFzsREOAVWHlD088foQNcLedW8O6Uvyo/mIUpXApYblB46hucGv8wVZX8N7pt3a5NaGyV7IgVlpGEL1kyQsax1dFp4kAn+dMwH3FAbjsFgE1tQnEHRXXKxa3tR6Oj/e47T3h+cpgLPVitqkttoYQqYjEST0PwTio9CUxkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNKtsFqY/kGZDF3fi6aPIZms81VhWbfvQLjUluwc5mA=;
 b=dw3Na2ak7nB7wP5GJBmFBImsJMjcKbrsCwFUOL8rhSaMR/wIu+UW/HP6DRviu8ehFt6hwN1vXSnJ2v6PAFgnfUwqJIXnD2f6njCXULwGnb+fdhrSuOBiSK5MSIZDTnGTNlmXr4Aapg7JZJ2Y9p93alnvSXwNU7jP6WI4YrGZmn3MBzhKKUXlzamQLl4qba7itg0uWa6Ysubw730JHv6d+WJxcgrYHlWolTpfYms0BZ//mlZ7gdf2nClAXukmUNdtc7YR2c6QYUl1wTXIxLkwZciILu4DYgI3a22Slr9a1HggulPAsmdGuVHlnXLR0zVZIMDXkSzT4S3z0xXGe+q0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNKtsFqY/kGZDF3fi6aPIZms81VhWbfvQLjUluwc5mA=;
 b=eyLXCRlrV6WlpMx79Pt9jzGPRE6akZ7ncu2yEKtwAPgNsdc0ZcTOv1Wgyuae56WP8aMazirsmaLGYbMPqUm0OsfZrpta2OeDXFMTlHChWS54xAHaT3WrV1JZ9y5lD+rz3oGIazcKHvBwDegYt/dmctKRnkyK/wj+7imZsdYygL4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2535.namprd12.prod.outlook.com (2603:10b6:4:b5::26) by
 DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 27 Oct 2020 14:09:59 +0000
Received: from DM5PR12MB2535.namprd12.prod.outlook.com
 ([fe80::2cba:4988:f662:ad60]) by DM5PR12MB2535.namprd12.prod.outlook.com
 ([fe80::2cba:4988:f662:ad60%7]) with mapi id 15.20.3455.029; Tue, 27 Oct 2020
 14:09:59 +0000
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: amd-ethanolx: Update KCS nodes to
 use v2 binding
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20201027123722.2935-1-aladyshev22@gmail.com>
From:   Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Message-ID: <f35152af-34ad-178b-61db-0e57c8d19f3f@amd.com>
Date:   Tue, 27 Oct 2020 09:09:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201027123722.2935-1-aladyshev22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:3:5d::24) To DM5PR12MB2535.namprd12.prod.outlook.com
 (2603:10b6:4:b5::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.21.55] (165.204.77.1) by DM5PR06CA0038.namprd06.prod.outlook.com (2603:10b6:3:5d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 14:09:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c934792-d1c3-4db9-8e2c-08d87a81fd16
X-MS-TrafficTypeDiagnostic: DM6PR12MB4249:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42491072629321ED82DCEABF96160@DM6PR12MB4249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqFQy9iucgFTLpqljPwM/7zgjP2M/8KRzLsRa2A/DFD5RZw7f5kbGbkXK3DyLgXpCQIDSDZHpA601uxJCpvHLuyxhMlHjyQkhQxfUX4HR9ZXE7UzWH90vPXVCruve7c1mqNlXYH/cGlqWZLiUWVMlGxKZdWPUquCxKbJEKgtSRarn8K46SiWx/5WBSjoGXiKBehunrH7ZrKxSbhLElUPFpYffmczyptXYIaEfDvBSxxfpRhXGVYKU0U9dHmYKcsvifsbJJTuKt6A5pR6yz14doy/Op8KG6v+VSzpHLW31xL4AsV7SZJq2Fyj3ys3OmEltW3IR8eQuCvrRejWCycCl+CkBMD786GQVFFvz8UAAipq8prRr4NjzKLrmFnwwYmWjTF0dB1lguN88/XpO2oqAR//eBYifbdOAuR/nJ8eZS9hOmeLMg6AKN0cTfuzBo8MSsKELDQrbDEybdWaiW7XcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(54906003)(44832011)(86362001)(26005)(478600001)(966005)(186003)(52116002)(16576012)(31686004)(16526019)(53546011)(31696002)(4326008)(316002)(8936002)(6486002)(2616005)(2906002)(956004)(6916009)(8676002)(5660300002)(66476007)(66946007)(66556008)(36756003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bBtap+7qZCktWg16YBINVAPB3p1+j4mm9NfYKBsEe+OmXeJiMz9eXew2PkcAtldzHMsA4s0vSyJGrn5NVocl//+GFCaZOETxB3ezh5vRG0vs3UUgSgA+3URN1N0wBmUDSUylGpqprg2lqQ7pa9mrbpOmg8T5jemIhT9gC88Twp4gdbEhcScSx4Jk4kwR3vC7y2yG2uZXslnF04O39XNxhMhlxuoLfGFCedoOlT1lQVD69Urv61IkrixfTr2Aw4Mxf5XqIrTx0qn5TOGuHOVov45FQMGm21UJmeCvHblmjh93bo05cntU9r727UHjrkuznLgeWVm50WStXkm4hqO4FqTi3CAli71mfOTH/PrezkkCUWCDYaTiB2ow3qhAHq4cC0MXgjAd0iejOd+d23KiQFnsIXH1TsSjHkEsgKwzzcVYKcUwxV0JSkDVUPVluyFvFVphLN3jpPuG+p3kU/aIsx7sDRwFV6njgVcUED8i7KAWR/4E0sv/cPvXs0O88Mf+Bf7FsKaHXbXX/EzIg2M2YvQ5tNQJGHhjswM4k/0Gr7KSV+hwKF1VifgaQ2EtbaXRn6jDyTLhVMYUVliPW9wL5/vuxQMnHxD10Ba8uf8smAQpW6XliPx9Jpfb7VBT3eeJlpJnqb/kq5krL/PM2/40nA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c934792-d1c3-4db9-8e2c-08d87a81fd16
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:09:58.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uui0SDVLAPlrAOlJjj06RGmuWL0hJsvUOVXmJXoqzV6UPTwz71PniHAkgvPE/dXFug8yu494ALrx709lxc69Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These changes are already merged in https://github.com/openbmc/linux/blob/dev-5.8/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts by Joel.
Please abandon these changes.

Thanks,
Supreeth

On 10/27/20 7:37 AM, Konstantin Aladyshev wrote:
> [CAUTION: External Email]
> 
> KCS nodes compatible property in the 'aspeed-g5.dtsi' file was
> changed to use v2 binding in the commit fa4c8ec6feaa
> ("ARM: dts: aspeed: Change KCS nodes to v2 binding").
> For the proper initialization of /dev/ipmi-kcs* devices
> KCS node variables also need to be changed to use v2 binding.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 60ba86f3e5bc..89ddc3847222 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -139,17 +139,17 @@
> 
>  &kcs1 {
>         status = "okay";
> -       kcs_addr = <0x60>;
> +       aspeed,lpc-io-reg = <0x60>;
>  };
> 
>  &kcs2 {
>         status = "okay";
> -       kcs_addr = <0x62>;
> +       aspeed,lpc-io-reg = <0x62>;
>  };
> 
>  &kcs4 {
>         status = "okay";
> -       kcs_addr = <0x97DE>;
> +       aspeed,lpc-io-reg = <0x97DE>;
>  };
> 
>  &lpc_snoop {
> --
> 2.17.1
> 
