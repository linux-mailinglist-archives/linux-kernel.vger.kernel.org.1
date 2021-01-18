Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FF32FA165
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404457AbhARNYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:24:45 -0500
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:29792
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392196AbhARNYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:24:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EynpIcg6pl1OqgoYAEHmataSOt95r1FUvsqlPec6S2mZSmksMX3RZWROiVjPLJwLkLqpKo1cGNCM6pdgVX7E/iMDWTNYsFlm2aCsgGNPoNa9r9L41zHo9P+qlvy0vJqhBpe6z3aFzSEgv4rIALlA7ASHuWjD4ntmcL1ztpXiLF9tKWXFbk9UkSYEJ2JFbveTaPUVSha3GNhHZmbD+OCjW3gUqMvwUmI2Xm851wfaKERjiFzwq9XTSDm/fwiZHZX3YKR1z24WIA5/ewyFH6C+LH7GpJO90ljoVBidmjLMO5wQ+XQ/Rc1UGQV2cesmsomXlDjg/0MonnIR0yEBARzbAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/TT/rmioQVcHW2TITi9TVVty49oa/+9u2kRmxbq004=;
 b=Ci4rFXlPvdvJtva/QCjwX/k0dRE2nClFZWT6/YBHAFlmeN+QXjs/W+pORNyUZYrgyNAPUkeXvhRGxk/2WbnJmkY0bbPGnJ1ybTxqmJ56MUEleM00EDRHeElCk7rRCpS4wihP/pSKZ/xL223RAZUPPP8ZsLjSSTSePcb5WdGBGvyD7fIZW6INzx9rIXt7UY1TBiw6wPVcX5FpTGWx2g1p/kX3r4dCBGYS3jxQsTAJKHipbaZN3VU2bIadD6FfpQ+viKwwk/D+25TUoK6Tb2wwZ7trRDBlmpdblXDV9DW19iwetT0YRxzq3JwJ1Ixe4g8oIV/BasrIdRqRRtZA4rtM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/TT/rmioQVcHW2TITi9TVVty49oa/+9u2kRmxbq004=;
 b=221TjYAK3+z1b+C5FmJ/fxBysGtj7ybPNnaWC48GyIb8HRHv0Axfo/DHN4rplQbSaVHKR9s0LQXUqLch8QpwehrIuxYwdsq5B9Nm2uRAzMcfRSibsL7jgZt5VqO/aaQycuHdyIBcssh+HGfSqKwAE8xTfnjU8wO2P9UYxsnaHlM=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 13:23:36 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 13:23:36 +0000
Subject: Re: Change eats memory on my server
To:     Eli Cohen <elic@nvidia.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel.vetter@ffwll.ch, sam@ravnborg.org,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
 <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
 <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
 <c9078ed1-a3c6-32b9-b76f-cc511cb54c83@suse.de>
 <20210118132225.GA51141@mtl-vdi-166.wap.labs.mlnx>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b36485a3-2fc6-bf3f-fea2-6a7d040f4df1@amd.com>
Date:   Mon, 18 Jan 2021 14:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210118132225.GA51141@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.4 via Frontend Transport; Mon, 18 Jan 2021 13:23:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fab0432-a020-4574-281b-08d8bbb442b8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4047:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4047FD6ED109D26B70BE17DE83A40@MN2PR12MB4047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBE/KV2au+bkFJT+f8LfS+s3yOqpP4Qg63PfXDmH0uawwyOpquLPzEsupTt7vWw4TiursHXhlRrr2um9++boOk7Bi4jtPtx61mMUqZk7QtyQtXO59T3b16Yim42r6lECTKtYDPmCJpbHgrAUWHsRnR+N3azz9co10p6XnYTy1MRPOWkJR6NDueAGppz8eBaWKuRzkXMQ6zK9nd8IMKbSMSHgIajfCCf6dZbXSCe3s/CCfMDRZ1JDryIYQM85ygx0UCHOCvl5akRuR5eSsX/cnlZNC6go9nNZOT4nfc0Fo44vC+rzAnE147OlQaQchzPNRXvMl5+oQVI1vRgsvnqMbXMP9Xv31lbq8oaaDUSVsezgCnPXlNBla6u8Aeo2Qj99sASgrV2eOaGsvzqThVXYEJHDFxUkyLlpM9+iT677EWJkHYVeO9fVZIBjBzQIV6U1ut5WY9c/PzG46/WRfVKsmHvN7GvAClbUe0qPDmf+Ce+V5itCON9KjXoCOFzLHbjvan2KS8/sviw1dabplbtA+DkkCHusWIE9xsUf1zAOE0FqQgY0PaotlDornJ+YJ+nPWv+pUc8E42iOkEnQd28q+0wutl7wWtwHOIkKkH7Vd9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6486002)(8936002)(16526019)(4744005)(4326008)(186003)(66556008)(66946007)(6666004)(2616005)(66476007)(36756003)(8676002)(478600001)(31686004)(5660300002)(110136005)(86362001)(31696002)(316002)(2906002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Nm0wUkJmVzhRM240TVQxNkZvN2dOdFNCSWlPdTdpSnJsN21FbXk0UWpxVGpM?=
 =?utf-8?B?NlJuVS8raDZIdmNvOW1aMEhGcUtleEpqOWNUZWMvdTlUTHdtcTVaWnNWekk0?=
 =?utf-8?B?azhoZll1MmtkRjYyOEEzQnNlaC8vTmhpd0dsRDFIY2dYQm10K2U5eVhMK05T?=
 =?utf-8?B?RFBZT3NMek1kcFZpQzd6amk4NS96aUwzejcwTlpTeit4Nm16K3NDa1cxSlF1?=
 =?utf-8?B?SU1qdCs3QkdOTWE5dTlMRDFaN3pXUVkyTTV4WUE1MjNHb0U4UHBFT1hVOW1l?=
 =?utf-8?B?UTBKaUV6MzVxSWF6bDRKazI5V3Y1ZWZhM2VLTzU2ZXZXU045a09iWCtXdllF?=
 =?utf-8?B?Q0JXaXh6T3hpcUtJa0lHb1o2WUtLR2VYRU12ZnllRndyanFzVXpyc0NCd0Ry?=
 =?utf-8?B?OGhnWkFJOVdPeUI5UUV0NjZpbjhDUHVwc1RVRXBJRUE2MVVWdS9aY3g5UU0z?=
 =?utf-8?B?NmZjSlZ1RjIrTDFJZHhicmRGVXpVRUY1eGNjeVFDdXBhdnM3eUl6RHF5b1lG?=
 =?utf-8?B?NGRPTks2RnFWNWZXQXRmQ2FobHZqZjdRNkpURzY2Wi9jQ1JMckhmR3dXVDZG?=
 =?utf-8?B?dmhFV01sUy81aDNEQXhEVnpURGM1eEZ2MitsK0thRFVYRjJuTHVBazJaRVVI?=
 =?utf-8?B?SDRHeHhFdGlkMS9pVEEraGRURDNXTDQvcWcwM2ZIOGFoNTZwNThGZHNSUDFF?=
 =?utf-8?B?anBMK1lMQkc4aWk1elpxNm9DVW9ZRnpJVU5VRzNLVGptampkNzRPbC9SdUQ2?=
 =?utf-8?B?NUx4MlpZSmRIS2hIT1VidjNOWkMxS29KaDRkUFdUc3NtQTQ1dnFQREtyay9M?=
 =?utf-8?B?UHhCYTc2UmRIcDVoVVdwTkJkaTh2UzBBMVVMY010Tm43ZXZ6UC82bVcybDNP?=
 =?utf-8?B?SENTci9Zd1k3TVptTzQvN3piNFowOTJQb1JpOUpFRG5Xa0NwaEFJUEtFeXVk?=
 =?utf-8?B?bG9ULy83VjQ5WnlkRHFiZlNWMGRpM0c5WVhBRmZDN1pjZXhWL0YyMzNWMWVJ?=
 =?utf-8?B?eTE5U2lQWWNnQzRUWVdLdWxjRk5iVVZhS1dEbzBYdVBZdFdMcEhKYktmSFdF?=
 =?utf-8?B?Uk1TaWlHTmQ5VmV6bzA4V0FaL1o4a3Nwcm9iZlU3Nnk2V3k3UmpkU3pGdjRj?=
 =?utf-8?B?OVArc1NIY0VaQytKT2diMytDSnVWYW0xQ1cwUzVmd3dzekdoeUlvODB2bkRJ?=
 =?utf-8?B?dk5UNXVxNVVmTCtMTTc2aFdRTEJVazh6dkF4dHd0VVN2d2JYZmJVelpEZ001?=
 =?utf-8?B?ZlBzcjRTbkQwM0NMZjdVQmVka1lRRnNsWFpxbmtWY3BTTXhWU3pTZlRLaHhR?=
 =?utf-8?B?VjllWGpaTDVPcEE0Y1FZZkd3TlRuSkxoQ0JaQVJYTUxLQjZFSGMvMHhYcFgr?=
 =?utf-8?B?dkg1N2ptc213bkFyMUp3ZjhsQ0tlMkdKTVBHeUNtYkwwL0ZxU1ZQMWpvLzh6?=
 =?utf-8?B?UkErSDREM3dKckFWYi9qQzR1dkR6VURPUmN6TDZWc3NoMW43QThpVGo3RHJD?=
 =?utf-8?Q?qe6w9UMe92uR2Y+JZCEJ6G1m1Tg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fab0432-a020-4574-281b-08d8bbb442b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 13:23:36.3146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaK3nvAeRXM/3xvlu8HgbIeRBLrLz4+dj1pa+f4NGEb5/EFELncYs40BT4oK18GG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.01.21 um 14:22 schrieb Eli Cohen:
> On Mon, Jan 18, 2021 at 02:20:49PM +0100, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 18.01.21 um 14:16 schrieb Eli Cohen:
>>> On Mon, Jan 18, 2021 at 10:30:56AM +0100, Thomas Zimmermann wrote:
>>>> Here's the patch against the latest DRM tree. v5.11-rc3 should work as well.
>>>>
>>>> I was able to reproduce the memory leak locally and found that the patch
>>>> fixes it. Please give it a try.
>>>>
>>> As far as I am concerned, this issue is fixed by the patch you sent.
>>>
>>> Thanks for looking into it.
>> OK, great. I'll prepare the real patch soon. Can I add your Reported-by and
>> Tested-by tags?
> Yes, sure.

Feel free to add an Acked-by from my side as well.

Christian.

>
>> Best regards
>> Thomas
>>
>>> Eli
>>>
>> -- 
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 Nürnberg, Germany
>> (HRB 36809, AG Nürnberg)
>> Geschäftsführer: Felix Imendörffer
>>
>
>

