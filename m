Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0C22AFD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgKLBcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:32:14 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:5744
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbgKKWow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 17:44:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLVf58Tpa+NdoPhWEBjdPze0OSTcdBBb9l0jyIOlrHRriM5ZwP7j33mHgA1UUe7ZhmaAliFAV+9a7SnZ3AIjVZpp0NeMDY0wQSXoETCsXkojYXKhQ3dgJ3p6f0V/r6nMv3b22zZ5WXf/9Ro5Tc4LkDhPKMgHYQn3vy7k+La0GJQma1q9opkJsJzyubbf8j/rjcUxvyV6qYmXtnbNLUYClg9P36K6D+p1S5aWpZjLSFEo58CtDoAZ64QtX2IHUF4FTLSmnaeZgziQHBNJmIi0U2F6q7cIFF7tOEbhV6n3c+T9WcAjSTrpFCILS/foqMRpBe/HvCTc8Xu8tGeRKuJOjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hkZU/h18V2g/5R41hsXtSLUPbWx8sNQ7oozOrqCUJM=;
 b=eetAsI/cYyrVAUSEYlkICD5IFpBURJvaLu5qJ+s0iHkKL42O48J+W2DX4sL/xLfkANNf4f83T06NMykRmoeH1QInkEa/2IzHPdlPLFs4tasgbLHiOYm0H3aeV7ueTR3Lc9ty588BYEUtg/KE+4lDfW3NQhR0wMP+MoZKcpNWYeIfr090ghZGiT8yVmzouXS2gv7DbZVqelNGRhMVdzDt02didvC8qmD+rhf29J9xHz0rFdEJy+n9EbQ3fIQBrPeAE7IeWwfjL2umCKtFpsRZBBGy89ZzdDWbO429PWLOkQwjdKLw1iRvZgU6hsrNsgVRofdUS2CYeQD2YFK67RH+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hkZU/h18V2g/5R41hsXtSLUPbWx8sNQ7oozOrqCUJM=;
 b=A7evhiWT1eBSuB5rI8AMfzcdqy8R2htlAzw2j4eMOZmgbbcR7FtHNOW9mgILPAa1g8FF2D0ITd83LNb8jQFo26PaDLZaobNYMJT4Rcchk9QTb0ohCXdXrkZXSwE8netq3XONqIakiYjsX+y3oRkc5AzK44dVfTHZwUuue5vPvZU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2535.namprd12.prod.outlook.com (2603:10b6:4:b5::26) by
 DM5PR1201MB0012.namprd12.prod.outlook.com (2603:10b6:3:e7::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 22:44:47 +0000
Received: from DM5PR12MB2535.namprd12.prod.outlook.com
 ([fe80::2cba:4988:f662:ad60]) by DM5PR12MB2535.namprd12.prod.outlook.com
 ([fe80::2cba:4988:f662:ad60%7]) with mapi id 15.20.3455.040; Wed, 11 Nov 2020
 22:44:47 +0000
Subject: Re: [PATCH] ARM: dts: aspeed: amd-ethanolx: Add GPIO line names
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20201111132133.1253-1-aladyshev22@gmail.com>
From:   Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Message-ID: <1a223f4d-8654-89e9-3b39-97e4b1128700@amd.com>
Date:   Wed, 11 Nov 2020 16:44:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201111132133.1253-1-aladyshev22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:d3::27) To DM5PR12MB2535.namprd12.prod.outlook.com
 (2603:10b6:4:b5::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.21.55] (165.204.77.1) by SA0PR11CA0022.namprd11.prod.outlook.com (2603:10b6:806:d3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 22:44:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a00b46ef-21ce-4f91-5228-08d886936434
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0012:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB001238FAB1031FF086313E1796E80@DM5PR1201MB0012.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:486;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8A1F70Xjc+jRdjwmTLR1mWOGz63lpAmGnVzLpT5KTOG3Ivw5+8Lm5lWo92z0csfSqkPVZ8SplXMbgXA9B91jDykXL6KT9nPIVsJgpJRwmuNB6d6R8d+ItSDRguk2zItirQwuhgGvpo8Tg2h0ek2kyg0ggrspHkwvtNg+CApwDxVglysVqO9CxkZAh5hNWGe0fBjZ+sFYLm1GGxqI7oxNtSEpP28jAHqjRSTzogp0ovUbCtcGljN/RHXglAYUFq9Cl+mF3sEVHLHhvGP9/xPSs52a2abZc0qJfuwg2KO7Bu7W+jXC/3jnGCOpsQvNwDvH1T+TYiW3aig0Lr5HruCDIr9SEd2PDIWl3h4Ps43GcoM3Q1ksPlRji7ns+wiM5Ao
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(5660300002)(956004)(478600001)(54906003)(2616005)(16526019)(186003)(26005)(16576012)(8936002)(8676002)(66556008)(66476007)(36756003)(66946007)(53546011)(6916009)(52116002)(83380400001)(86362001)(2906002)(31696002)(31686004)(44832011)(316002)(6486002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PrRloNzQ4+jhvW4CeRyZyA29rMQOR/vWAMatR3iQdHG2Q+IBDCr8/d+qXRaN4bn+0gEhNreMo4BjDAYrsIU6V8CNgQUmA2MqHfBdkmExSQbfxvBJG0PZ4ZrPkmxyyzP+mMX+rHRleq0aqIyFLO+HkaII0xkbLnHrdxzfaNxXRnNN0Ppx/syczzvCJKLM0kGf+m0Q5IgAn6PVs69ACoapaIMMImaDDlPMb6n2vA8QkY0t64ShUgnVEW+h21T22Gqgiesm/+km8KeF+IIHGPknYEf4SQkVJrUHRWWjiw6RfKDlOlr4/+zuX+XEzPKjOzuYwu70D7/+fVZsDoqpHWxj/ALrQ0ipas9UKkoh5gsSRjIWFbytghcb3ZAMcA6i/xaZIuFxPGp3cxkcxhfPF5FCclhZZdJ6t2u8pJ/c/ME8tkluiBhEOBLttggf1p0i0MNYWGT/3wnsakvDBokBgAueVjoo/wDrRYxWTfVhkLJvj9bbt+M6W6CXTFh3y7Eq630JaNVVk3zWgtF3yM3Aah/gRo+uuCFuiCTgaakdQzFFIRsBCzdcL6NrcC2tz9aEESEhOFpcTx0mUzct7g+DBHa8CK5UANmdzyo8e2biDsR7DDhtoFyjdE4gwXwRKBmFkREE87dWEdotbZ3FFYAAT1tqBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00b46ef-21ce-4f91-5228-08d886936434
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 22:44:47.4179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIlh63p/ETqAfy+7oEDbuMeXwCWPWEny70616Hyi4qxw7cc/zZUXwP2t2zOl3kGuTM6TX5ZYnmBzW1suEnQkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/20 7:21 AM, Konstantin Aladyshev wrote:
> [CAUTION: External Email]
> 
> Add GPIO line names for AMD EthanolX customer reference board.
> It populates AST2500 GPIO lines (A0-A7 to AC0-AC7) with AMD EthanolX
> designated names.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
Reviewed-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> index b93ed44eba0c..96ff0aea64e5 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
> @@ -97,6 +97,50 @@
>                      &pinctrl_adc4_default>;
>  };
> 
> +&gpio {
> +       status = "okay";
> +       gpio-line-names =
> +       /*A0-A7*/       "","","FAULT_LED","CHASSIS_ID_LED","","","","",
> +       /*B0-B7*/       "","","","","","","","",
> +       /*C0-C7*/       "CHASSIS_ID_BTN","INTRUDER","AC_LOSS","","","","","",
> +       /*D0-D7*/       "HDT_DBREQ","LOCAL_SPI_ROM_SEL","FPGA_SPI_ROM_SEL","JTAG_MUX_S",
> +                       "JTAG_MUX_OE","HDT_SEL","ASERT_WARM_RST_BTN","FPGA_RSVD",
> +       /*E0-E7*/       "","","MON_P0_PWR_BTN","MON_P0_RST_BTN","MON_P0_NMI_BTN",
> +                       "MON_P0_PWR_GOOD","MON_PWROK","MON_RESET",
> +       /*F0-F7*/       "MON_P0_PROCHOT","MON_P1_PROCHOT","MON_P0_THERMTRIP",
> +                       "MON_P1_THERMTRIP","P0_PRESENT","P1_PRESENT","MON_ATX_PWR_OK","",
> +       /*G0-G7*/       "BRD_REV_ID_3","BRD_REV_ID_2","BRD_REV_ID_1","BRD_REV_ID_0",
> +                       "P0_APML_ALERT","P1_APML_ALERT","FPGA ALERT","",
> +       /*H0-H7*/       "BRD_ID_0","BRD_ID_1","BRD_ID_2","BRD_ID_3",
> +                       "PCIE_DISCONNECTED","USB_DISCONNECTED","SPARE_0","SPARE_1",
> +       /*I0-I7*/       "","","","","","","","",
> +       /*J0-J7*/       "","","","","","","","",
> +       /*K0-K7*/       "","","","","","","","",
> +       /*L0-L7*/       "","","","","","","","",
> +       /*M0-M7*/       "ASSERT_PWR_BTN","ASSERT_RST_BTN","ASSERT_NMI_BTN",
> +                       "ASSERT_LOCAL_LOCK","ASSERT_P0_PROCHOT","ASSERT_P1_PROCHOT",
> +                       "ASSERT_CLR_CMOS","ASSERT_BMC_READY",
> +       /*N0-N7*/       "","","","","","","","",
> +       /*O0-O7*/       "","","","","","","","",
> +       /*P0-P7*/       "P0_VDD_CORE_RUN_VRHOT","P0_VDD_SOC_RUN_VRHOT",
> +                       "P0_VDD_MEM_ABCD_SUS_VRHOT","P0_VDD_MEM_EFGH_SUS_VRHOT",
> +                       "P1_VDD_CORE_RUN_VRHOT","P1_VDD_SOC_RUN_VRHOT",
> +                       "P1_VDD_MEM_ABCD_SUS_VRHOT","P1_VDD_MEM_EFGH_SUS_VRHOT",
> +       /*Q0-Q7*/       "","","","","","","","",
> +       /*R0-R7*/       "","","","","","","","",
> +       /*S0-S7*/       "","","","","","","","",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","","",
> +       /*V0-V7*/       "","","","","","","","",
> +       /*W0-W7*/       "","","","","","","","",
> +       /*X0-X7*/       "","","","","","","","",
> +       /*Y0-Y7*/       "","","","","","","","",
> +       /*Z0-Z7*/       "","","","","","","","",
> +       /*AA0-AA7*/     "","SENSOR THERM","","","","","","",
> +       /*AB0-AB7*/     "","","","","","","","",
> +       /*AC0-AC7*/     "","","","","","","","";
> +};
> +
>  //APML for P0
>  &i2c0 {
>         status = "okay";
> --
> 2.17.1
> 
