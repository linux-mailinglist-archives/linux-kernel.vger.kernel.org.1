Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B57A29E316
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgJ2CpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:45:06 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:53249
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbgJ1Vd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVOsedQgYxBVieCC7U3LA5kiAj8tHS1tl8KNo+cEBlJ+7UAvqyqH2xbqbL50kn5uGm52vVH63Wja6u0XbJ5eZ8oFdQQkwrbwgbJnm1BOunf7qzMfqJifSfqPArQnDyXWJGr8apLH0Inr+JkOWcN9fIf4SmAgvZOcQSXOfJZs0VVqlpNylfLqTSEnYZSLjpgxgYCXlw42S3YN/dRySA7nzgcfPdcRxoxTlsCV2UFwtazJfmnBHqJL94YjJA9cxYvMPw3X/+htKyy9adFFx1Zy2EUd06N1epbuPGUIFcjIEbEazwhDnMX+T6mFrfbLJ5bSiJwX/wP+cEbDr79h9vliaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdQzdrz3mrI/PCr8nhAhn3y2t1XIg6vTzLhwDRhvR18=;
 b=bFV/PBmqOonrDvx01jB71DXuEmL9QxnuDj9dd2C9ksxBPAGBfrBHhbVhsOmyblYAreo8E83ARIj91D43YoBoJH3PjDnamuobaiovdFK7fRU4k+3LPr8gATL/fr4qCI2wAVwDrmCdPJyHkPmb98WDHjgBOKncG4Yza8UUwxPwEzTV0IaLZE7A9AkO+RY7LOanAOZlvTsono/Q1zSUAu/LV83DWMzsX49UtpXZyWe4OF3IyH8iYyCI4lagXn3tIckKKr4H/q75XYUnHwxVRDQ5Jcnin4G/MaT2ONhs+Q+HX6+XpzNVOlRiAF3evC9bN5yXRvnLjk+enHrBxcUk3TN/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdQzdrz3mrI/PCr8nhAhn3y2t1XIg6vTzLhwDRhvR18=;
 b=JNFE/5jNHdE89+tdFLTEhixVNvaHAP4sv5pqEjF98vguE6PaqNScoWYUlhrjGueLyzI53qAu/dwaQzVuggaW4YC9nVPUzfqZApKwYmuG0XPW9ooeiqSDyvLnbNNnqQ+6EZer2rRi6cxP6RbujMfNTC3W3m5krQal9bypFx1bRT4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Wed, 28 Oct
 2020 15:59:47 +0000
Received: from SN1PR12MB2542.namprd12.prod.outlook.com
 ([fe80::10c4:c28f:2a60:c805]) by SN1PR12MB2542.namprd12.prod.outlook.com
 ([fe80::10c4:c28f:2a60:c805%7]) with mapi id 15.20.3455.029; Wed, 28 Oct 2020
 15:59:47 +0000
Subject: Re: [PATCH 2/3] ARM: dts: aspeed: amd-ethanolx: Enable KCS channel 3
To:     Joel Stanley <joel@jms.id.au>,
        Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201027123722.2935-1-aladyshev22@gmail.com>
 <20201027123722.2935-2-aladyshev22@gmail.com>
 <CACPK8XeaWbrWBKonxqW0Gu2AnB3mXBNXsEDmsEP_hzT1e8gX1w@mail.gmail.com>
From:   Supreeth Venkatesh <supreeth.venkatesh@amd.com>
Message-ID: <5e829382-3a6b-7905-52ea-3ae274dd60b1@amd.com>
Date:   Wed, 28 Oct 2020 10:59:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CACPK8XeaWbrWBKonxqW0Gu2AnB3mXBNXsEDmsEP_hzT1e8gX1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM6PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:5:190::14) To SN1PR12MB2542.namprd12.prod.outlook.com
 (2603:10b6:802:26::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.21.55] (165.204.77.1) by DM6PR11CA0001.namprd11.prod.outlook.com (2603:10b6:5:190::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 15:59:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fb98b36-5ceb-4ecd-be71-08d87b5a7e7f
X-MS-TrafficTypeDiagnostic: SA0PR12MB4429:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44295FAA65AA0A6AF3BD07CB96170@SA0PR12MB4429.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDMqAifmgzVV2ZYlqD2gNsqf6g2I1EbrawA5EJqOeAkrqmeTooVGYQmHmMQ+UfKA/M8Hlk3nkCrzkVqu8mA6gNmV+9dbSvbnLPJ7KlKsLpGsjfj0MCb+lKhJGE6XXm3g6rFFDhJOM09g9GpXd62qMz9l/6NVxVJZs+v11SgankegM5Fw0ELnQWLiMZbwCRrV7jmZl///CKKvBGwR5dzZRBE30HbRdlSEx3sguthKEMpwOUcd7nG9LLZ1pRHpA1ERmSVN4B11s8F8fS3VCWsSRzM7iX6YuOX5446igTNcsNVFqJ6tjFIcVjbnOxBc/IBN1/TPrnEG5Dx3/kjLMNZBdTk0jcZsszO4QMy+6FoxkGgG6Yl5X5QjlAWoZfDkoY30
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2542.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(478600001)(8936002)(53546011)(66556008)(66476007)(2616005)(956004)(5660300002)(4326008)(26005)(8676002)(44832011)(6486002)(16576012)(31696002)(31686004)(110136005)(16526019)(54906003)(316002)(52116002)(86362001)(2906002)(66946007)(36756003)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8KcXjjZUZDBTO0mUWKmgyKvjwW4jzHU1rVuxr4yyvWa6h69ML0cR7HCvgDiOfSK2LaHNaFPGvQZo8sPr7QbxNL5diMrMvEYNKkmxCG9EeHPs0XbQzHblSgJDeJAJ2Z21dvfdu1XS5JI2tEyzeBDARrD1lwGxYbOAIwTMRh8bunSMwCA1wgxrFn5SbBZz0joDx+K5J1Fef1BLixlK/6X0es6t+YVHg14rKzGS0feyOpuFKIsi60BiMRnD/9MGwEYV9fm5TOa+G91A5q/82Yq2aGY1O7SbiN6SaWLmQOX3qAYWp2Sw0ZWf6uFHQ7wxKKjD+4KhrRLKdDqsrDd9TmEtfdkdwqussoYW9hPXBSc4y8Pw7Mq+cDciSmX0+tOFXjx1oFDJ0bKvy2FAcdXjzBz/WE1271qxUcZAXvEeTRjUZOhKdSHrZlzMsB+bHZsp1sNb/yXrPejtYhrd8LRHWXqAAT8Xkbp5JFdNey/fuXDWd2v42Ln9yjDxyChCmXxibVWqL4U6cqx6uVHXWEaTn6aAYoZRwJCujF3q+eBevC9/NpN8GbBt1XyVpQY2oEM2lL4WvotDmMFKSL24ZkUkolXi7JCMBpOicAoc4Qv9m0NxmXh9c9bqTlvIBKHauNnxi/pobURx/HmeYW5/vjd35GaVNg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb98b36-5ceb-4ecd-be71-08d87b5a7e7f
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2542.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 15:59:47.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rled2H1a4AStKRBhyYvs8Lp1V5jXrsx8GIiolVyfA/ena3paOY7lnmn6+1DcZC+Me4XGKkzWdbWAMct3bDn7/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Konstantin for this patch.
Thanks Joel for reviewing this.

On 10/28/20 12:28 AM, Joel Stanley wrote:
> [CAUTION: External Email]
> 
> On Tue, 27 Oct 2020 at 12:41, Konstantin Aladyshev
> <aladyshev22@gmail.com> wrote:
>>
>> The KCS interface on the LPC channel 3 in the controller
>> is used for the in-band BMC<->BIOS IPMI communication.
>> 0xCA2 is a default host CPU LPC IO address for this
>> interface.
>>
>> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
> 
> I don't have any docs on the platform so I'll wait for a review from
> Supreeth before applying this one.
Done.
> 
> It's a correct use of the bindings:
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Supreeth Venkatesh <supreeth.venkatesh@amd.com>

> 
>> ---
>>  arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
>> index 89ddc3847222..2a86bda8afd8 100644
>> --- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
>> +++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
>> @@ -147,6 +147,11 @@
>>         aspeed,lpc-io-reg = <0x62>;
>>  };
>>
>> +&kcs3 {
>> +       status = "okay";
>> +       aspeed,lpc-io-reg = <0xCA2>;
>> +};
>> +
>>  &kcs4 {
>>         status = "okay";
>>         aspeed,lpc-io-reg = <0x97DE>;
>> --
>> 2.17.1
>>
