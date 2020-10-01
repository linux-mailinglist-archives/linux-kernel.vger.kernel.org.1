Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04C227FFD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbgJANQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:16:02 -0400
Received: from mail-eopbgr150120.outbound.protection.outlook.com ([40.107.15.120]:35961
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731936AbgJANQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:16:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI7UZXmqectuF03s4rAyplyQm6FIJaFOCGul0NLyjONxShDOiw5yhkj07Pn/8lUUdzMuaXmdB+TrwrCqCIyKwFfwGHbugAT8umNHODQBmg/U2fYOxOD7gk0AP0WmullkCiWCcVWZll0AaB9DnvJaLj9+t6Pw6bYsHctQPBbDdplvxEFwibr/TZW1OlBJT5QmeVOzPhOriQoszF8W+eW2KDp/cEH3p7fEalBA9EM31gk1mN67oiFW84+hd77OclKer/r7xj8Q0WWYI+Bf0RUSA89fS2g+FEK3VkFX2c2G3eH87TgwmmUfVcy6QCJF8JG57FAEmTagcvORe6HW6YqIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oymseTN0LhjDNPxaggQlSXKYEasW7PRq7YHMVpWNVRg=;
 b=EGvQzy3aB9GAVA/RK0JRkSmyFgXMF949BfFugdtG9od0+gMzBk26+r8Z0GyaW79VcpT429gqmnFe0GKPOIfXC0s205bC5pIrNI7mxFq2jN+AdQ7HWdMFLLcK+t/ifx4crIX8XgK3cbUCBiwZCR4L1RAm33/NWlv8gGkZ+OC1w4YgRjZG2XvX/uMte/lp21bvZLTQgeiblrthwLTz79cpcWWSllNCjd9Za0XxsOV9XKgfNSSgBjj0Du2cPeMItQarWPLWYSo2elB0BdD2KpJKVTPuPcIITTqvmUh48UtuD6KWyplL/pnrPQNLgme/MkgI69JUHpoVdIir/Lqqe468SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oymseTN0LhjDNPxaggQlSXKYEasW7PRq7YHMVpWNVRg=;
 b=b5FLVFvYYCymkZdjQ9brF20CBXUTuxs9OPjMLL/ZaftLbKviYzi9IsQ1x/+Qfvr1ichFEAbL7WqVPRiPPr3and7IVKs3m+n75WJ8PEhiDiVqUON50O9x7b9mw94l/pRPypbyWEs2mwv9aBPzJMQehU5ye4lHi1xnojF9VmKSCLY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 13:15:58 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 13:15:58 +0000
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8M Mini
 SoMs and boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?Q?S=c3=a9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20201001120717.13027-1-frieder.schrempf@kontron.de>
 <20201001120717.13027-2-frieder.schrempf@kontron.de>
 <20201001125932.GB6082@kozik-lap>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <40e65d92-2fac-d71f-c0db-7552ee78bf16@kontron.de>
Date:   Thu, 1 Oct 2020 15:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201001125932.GB6082@kozik-lap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM7PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::40) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (89.247.42.197) by AM7PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:20b:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36 via Frontend Transport; Thu, 1 Oct 2020 13:15:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05013a0a-21bb-444b-7cfe-08d8660c22e8
X-MS-TrafficTypeDiagnostic: AM8PR10MB3988:
X-Microsoft-Antispam-PRVS: <AM8PR10MB398814583E9A9199502F713CE9300@AM8PR10MB3988.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ITNmQ6BxqnweFQu6xCrORTHaFu0Vfgfrm68nYsBMa4u9mgNS4i1vdlUuJ67AxVrzJTM5Hl4mnzjJxsoMR9S7Ux2mJrPqHvE8hjw6d1CNPbiXa7YpGhbC2Eo3ZY07dopkrJ69fsj7L+5o0jvvGJy8WvZB0wHs//kP0b8GG860fFJyofmIAkDwuV2x8sTiGGVqA/WdGM/JQkvdBZX2cqO1wdSE4Uhxzq5+RBg1s4MlEHVZs8cKgTaRp+wfHBMOBdw0lJ5LjSlYgfuhde/m7pKcjtAfoISV20Fp6y0WiQZTsT4GOm5G/6v4R+mQRfiJ+1StBxpHnWchssh6S7yOkeLMa3zUzSKMxcgKtQfj0lse0BWplNwpGiN+ekhHyS7vpUYl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(136003)(366004)(376002)(346002)(39850400004)(396003)(44832011)(83380400001)(52116002)(6486002)(66476007)(2616005)(8936002)(31696002)(956004)(2906002)(6916009)(7416002)(86362001)(4326008)(16526019)(26005)(31686004)(8676002)(53546011)(16576012)(66946007)(316002)(54906003)(36756003)(186003)(5660300002)(478600001)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cvuBSFP0BITwrjusyc0o8KyNW6l04Y5BGvAAntHk8h6T40UDdPuOx8XrAG3Ua7A4vOKV2+FaJPtRlInR2/wbd7tjpxk3POCmSYE+RM9rm5O9rnHn6HMVADYhsPmTAcn/+SBA94UaXe5Wi7HfT+Qy+kXgjUOXj54V5TWCZy/jtnAHBLkvYI0jKvxA/1EZ1nRQ4HiCZ3pBRIMEy0FgUlyo7zZzDeA8/SDw2l7ffQpsPCqaUzaqiDa/ThUPOmypF5vtTjD9apKYkMPv2wT0cABa9XK8kQgqRRhJG9li4ZQEd34lUZfH8R2tnwOyZjMutgq1OfjNdYpl5SbrInFt+SpECnUYInvZ/xHc3cjmS8BWgs7Ruaij+EJp/aUdzqgVdZoq1TaXLf05oOag+7sEW8AakJvCiImPuJeh235Qpa/UH9DZkypPXDMV+RiMl2d5fRlAc2KpKsJeMBrk9PClySsVP2WVxW0hdR2Ph/WKKjHLBs4LgjK5jfswNxiVi8twZvTzqiPEkUKdNs8zSFAbEZNCOSLGgEk0n60ArL2mwwTDPpPqdQQ7F9QZk+fq0kZ0nCNc2puYMC8O2tXTNaLVvVO4KXeTc5fRIgD/01DQBoxSUBFoK58wLsksR6mTT3CgfPybOFF0jmnEB8eKIUsO9GDJcg==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 05013a0a-21bb-444b-7cfe-08d8660c22e8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 13:15:58.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KugPJ/lTqIUCD7xhsEsOcK/Nb+ztd+2OmSXxFAjQuethB923ZxOnn1SHksgHHrzwfTnc8HTLWfeAB/yIrueYMZmQ8X5rHP6xe7s5C8A4zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB3988
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.10.20 14:59, Krzysztof Kozlowski wrote:
> On Thu, Oct 01, 2020 at 02:06:59PM +0200, Schrempf Frieder wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Add entries for the SoMs and boards based on i.MX8MM from Kontron
>> Electronics GmbH.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> Changes for v3:
>> * None
>>
>> Changes for v2:
>> * Merge the SoMs and baseboards N8010 and N8011 into a single
>>    configuration (N801X).
>> * Add Rob's R-b tag
>> ---
>>   Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 6da9d734cdb7..4217c61e3048 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -345,6 +345,13 @@ properties:
>>           items:
>>             - enum:
>>                 - fsl,imx8mm-evk            # i.MX8MM EVK Board
>> +              - kontron,imx8mm-n801x-som  # Kontron N801X SOM
>> +          - const: fsl,imx8mm
>> +
>> +      - description: Kontron N801X S Board
>> +        items:
>> +          - const: kontron,imx8mm-n801x-s
>> +          - const: kontron,imx8mm-n801x-som
>>             - const: fsl,imx8mm
> 
> You will need to rebase it on next or Shawn's tree, as new board came
> here. Please add it then in alphabetical order, so:
>    - description: i.MX8MM based Boards
>    - description: Kontron N801X S Board
>    - description: Variscite VAR-SOM-MX8MM based boards

Ok, thanks for letting me know!
