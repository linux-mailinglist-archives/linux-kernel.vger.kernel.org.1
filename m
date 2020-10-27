Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B0329C6C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1827298AbgJ0SWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:22:50 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:57984
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753815AbgJ0OCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:02:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgsdx8A9Ui2vXJX515zH5haZpg3qJvCEmgLIizGr0shF3jcn5Men/VvU6RXPduFLJV1AGbZdUCeLh70m3zYBHnBSQu8MOZ6Rg5QUh+JhGlJb/WssUHK30lk8SNeMsiMHDr1G4S9+gQEvyrdLFAKKR+gyJdJfVEeIV20w07R8DJu2It3zzWRYmYafs5FaA9W0D+JQXfAwBNrnpHRqQXSwp0yTM6Pwd07Czy39GsWukU7G4sAp1rHsOrXxAhIOvJuIGrgUGmqs/jnHeuKucSXPPRH2FC4sIIMSJ7V1tgmwOlguvZL/NdfN8C35WHpdjNQWG5G+/GxVEfZbpcr6KxCFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlZr6IwoXMRTSfZJEbCLBtjWgnhfqQAWXze48yKftPE=;
 b=kArECRfLCCtQuJVuAoF3xkbrsR9G3czhZ6+4S7UvHww7JW6zNleHKGif5Nw9y/FtVqPCi82UAYAxJ+PgpM5MbZvCP7NkvOPoK82KddmPojvCI5iX/xyZe2R1p8qQdiG1XZclzMV6Ht1F9reJ5cV9hJMrXuk9fdN7Lmc+crdKGQ2bAiMPLeQizmBxGYc1/pdFqMvuI9cHXdee4bjWoDi8uiDi56s9u6NV3GisLyMinfOosx2k/QjVAKyjEgS85DQSkjHIYeDbFu58NeNukZUjiTvD+++fzqFBr37Zdz2WolMVBzAqojeKRoRHPDd5W4b4DcaKJTiVoqgCya2FsMdPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlZr6IwoXMRTSfZJEbCLBtjWgnhfqQAWXze48yKftPE=;
 b=Nsa+xSNxD1KnJ8fKM9XTcNGrNjAeNrdo1x2RIEVD+M2JdNMCmMHxGNXu9S28oww/5l+r8Q6Zy3vS9xHWPPgncs1IjJKoCbSP42UwcO4WWMfmiG6C93JwkD/9zlGFXva8OQEjVKTYRo49/DTMCPdU7QN4xttBQzO+dAVFoxttUX4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2535.namprd12.prod.outlook.com (2603:10b6:4:b5::26) by
 DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Tue, 27 Oct 2020 14:02:22 +0000
Received: from DM5PR12MB2535.namprd12.prod.outlook.com
 ([fe80::2cba:4988:f662:ad60]) by DM5PR12MB2535.namprd12.prod.outlook.com
 ([fe80::2cba:4988:f662:ad60%7]) with mapi id 15.20.3455.029; Tue, 27 Oct 2020
 14:02:22 +0000
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: amd-ethanolx: Enable devices for
 the iKVM functionality
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20201027123722.2935-1-aladyshev22@gmail.com>
 <20201027123722.2935-3-aladyshev22@gmail.com>
From:   Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Message-ID: <365d5623-6cdb-dafd-b42f-3ebe193ec18e@amd.com>
Date:   Tue, 27 Oct 2020 09:02:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201027123722.2935-3-aladyshev22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:805:106::37) To DM5PR12MB2535.namprd12.prod.outlook.com
 (2603:10b6:4:b5::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.21.55] (165.204.77.1) by SN6PR2101CA0027.namprd21.prod.outlook.com (2603:10b6:805:106::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.17 via Frontend Transport; Tue, 27 Oct 2020 14:02:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e1c0020-7bfe-4cb0-78fa-08d87a80ecd2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4249:
X-Microsoft-Antispam-PRVS: <DM6PR12MB424934CF124D07E038ED864A96160@DM6PR12MB4249.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDmy7oZ17qHQobLNa6mKyxLPb9gMCBiAOn36DHR8VV+vxxWnIOPs65byQWqJKaClXrEmAXZcP0YHZ4e65Bo9XzmATrBYDA8ncScNUjeOcwlrCLrrre2721OJFw/rSeZqyiWBC0jtV0sPZN9vCOVOXn1O/dH5NESIwr9zZt9Fj3ooO54lzAgk6qdqGUxUk8QHR7Y7HSA8kRkc3auQe5vd8nfJXrGynHTB9qVSWPZjpfRFtM+d5NHLV9t51/+CM9z8E9NkuwaKd7BtfXmRzVPLlDPbjo3Ib4FsNXIeUo2Hi6AOcZ6t9oIL+DuSF4L5AbsR/My0Y0MpS0ZjZxGx9867UxdPccjRHC7GXBwhT7/+XXKkglXjXvXQeoZMdg8tWOOU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(2616005)(2906002)(956004)(8676002)(6916009)(6486002)(8936002)(36756003)(5660300002)(66476007)(66946007)(66556008)(86362001)(186003)(26005)(478600001)(44832011)(54906003)(53546011)(16526019)(31696002)(316002)(4326008)(16576012)(52116002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7MchHuJfpsfpN+XOg2aEUeLuT/1saNwxO1yEBtFZ9kkHHA6qBdZ5tYpv4K+SCl6yVt9UkztNvzZQGxjjrCWlI7w+1i846BYqS2xnnAQGxC5jFqnu/U8Ph4u2I7syLlb8OVAGtC028kphluHzV9pBpYJKhlPBrqNs+/NtAQj9xDCi9cJ+BL9s1OxPUe3IZG8YVpNm/rhfa6IA6jG+X3yMOg2mp37UDVsoHkIG3eKF+nZlwbycPOmrT//LuslCO7B+Aeu4w1o38p8hA8yR4vD1d0xv5dOUPkePeaRk3r0GK+EdenZRJgGVvDeKizdy+8MLFR0BmdLIqnZ5Ah4Cr4kK+nBVtwiGub/V/Mb5yN6N0xfnk8PqM8pwr5oXkeaShUXDMG2YTy/finYwT2nQ8umsjkCgvLhlp0bB/i/lnBZ32/R8mcvTbYmAT6oAmUxV5rcAPRItVLQgewL2jyxyksZyg/vhY/+nIn4r7pdZi0YR0Mu2Hg1eRschZ1PXa9vnWTyoGmlRIG4bqpcUO6B8ZKaFOUJv5p3VPWhGIcsRv+w68RnriCQ3kp8EWo245uOdcgx8GXvak207YZNXCCtfl4rSdFQ7C2HZTXn4FiuE5IKLT/BKHZhiXGOw6d4sE3qIU3/bDD2WVeqMCMgV17zTHxq/NQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1c0020-7bfe-4cb0-78fa-08d87a80ecd2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 14:02:22.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8F2FQmht5sX5K2O27URzv2Sd+1I+MwCXTZT3ewC7q1v28V0CIoZCI+vR1BKZpJUpcsgA/rmmvyZNbyIQNU2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/20 7:37 AM, Konstantin Aladyshev wrote:
> [CAUTION: External Email]
> 
> Enable the USB 2.0 Virtual Hub Controller and
> the Video Engine with it's reserved memory region for the implementation
> of the iKVM functionality in the BMC.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
Reviewed-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>

> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index 2a86bda8afd8..b93ed44eba0c 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -13,6 +13,21 @@
>         memory@80000000 {
>                 reg = <0x80000000 0x20000000>;
>         };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               video_engine_memory: jpegbuffer {
> +                       size = <0x02000000>;    /* 32M */
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +       };
> +
> +
>         aliases {
>                 serial0 = &uart1;
>                 serial4 = &uart5;
> @@ -220,5 +235,12 @@
>         };
>  };
> 
> +&video {
> +       status = "okay";
> +       memory-region = <&video_engine_memory>;
> +};
> 
> +&vhub {
> +       status = "okay";
> +};
> 
> --
> 2.17.1
> 
