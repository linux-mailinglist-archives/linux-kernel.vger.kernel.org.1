Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE428C45F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 23:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgJLV6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 17:58:16 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:54020 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731083AbgJLV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:58:16 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CLujUV018511;
        Mon, 12 Oct 2020 21:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=or47yen/sP4iE5Zm/YX0VxIxCo5j8QJCFn6rUlEeFkc=;
 b=W7IgEAvyEtg+AIaOKZaV/3gddA3//bItTqNpSgjr4HzDFpFpttIoCfEwokuZ4jFZUzqn
 GjUFWLILNa8WtOjRvVHtJPlAdoBbOvE+PME0jJXVQzaW0kfl+H7gPhfipKS58ZItHkVh
 mT+n41BQX6d/+5UfiM2iR8isw5O0ck86m92TfqzH4uiiDjmEKwWFW2ZpWmyQXpolAsRh
 z6NgvpfZaEcDUYAKck/bmHp6cadnTIh3ZActunZ873ew7Ba3AU3xr/mfF6GK5JECKMyH
 FeTYoD7OafkkbQBCVNlmc9BX8knDls6LlHIgKI6vqW5ObULH9Jb9E2Mp1t13E9EpxSOW Aw== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 344e3brhbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 21:58:11 +0000
Received: from G9W8455.americas.hpqcorp.net (exchangepmrr1.us.hpecorp.net [16.216.161.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id E862758;
        Mon, 12 Oct 2020 21:58:10 +0000 (UTC)
Received: from G2W6310.americas.hpqcorp.net (2002:10c5:4034::10c5:4034) by
 G9W8455.americas.hpqcorp.net (2002:10d8:a15e::10d8:a15e) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 12 Oct 2020 21:58:10 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (15.241.52.12) by
 G2W6310.americas.hpqcorp.net (16.197.64.52) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 12 Oct 2020 21:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbG0INi6TBbJBEZ1nhUleO3TDVMknmBq+WehqVOdhNBsKfPuCNA+WjZMaAY75tw9Q1FBebOHPuqL//e6UdL43+dW0EyzORHAYstCc1Cp1gxpE9CUflsXLJ/nSicsOcO3+FVCCmhi7nAn+lWqahTQsQX1AyudCl4IiLrMzKTkZLZGAo7UGMw9GVHyZlN4q2GjBOaemKHJFUTEIEE7SYJ49TnFxhGAWMF5T4oAPgFxJLmg+F7qrHa6agOrsQglBBzRkl/X8SiERCBwUkU0mcy+fXF20+40mHEUlqvzlkldjPK0EdfS4SMZA0SdTpoA0XedTzZq9cIWqZFCvICI6Jw3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvDF9jGynCuJsAvnnRdL1ptc5j7rxF/7DIXT13HaQSA=;
 b=jZCVNQtwQZANVuLwJUMEdZQbod+haSUZXORt13n0Hwz+NGWlSjCd8owPjXFlW0b1ICD2LicqArlsyeYg1ANVkZvBpT8+cvzePbHCi5vo1YEXOsphTYNidesBlSTnP7aTI4fVKRhBzBbeqH5ePVsxjnvTcdUOqJIeWz21tyqUMCGNTjGOKNpyY9dgFIiXuzJHzB6G4+CB/Ixy5qa2E6seWNtUorerjnTNWU2gS7edyxr6ZLo3L1mVqt1D8JmstX/TpHD+gWhVH4YLx0LvAY0PniGl1qeFnn8nb8bah8UfNn0CIpjgdX6+RZmnHyNWBAjl2hKnEan9xN6sucPOGzWk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Authentication-Results: hpe.com; dkim=none (message not signed)
 header.d=none;hpe.com; dmarc=none action=none header.from=hpe.com;
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7715::8) by TU4PR8401MB1070.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7713::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 21:58:09 +0000
Received: from TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de2:a57f:7b22:5ef0]) by TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de2:a57f:7b22:5ef0%4]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 21:58:09 +0000
Subject: Re: [GIT PULL] x86/platform updates for v5.10
From:   Mike Travis <mike.travis@hpe.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <20201012101012.GD25311@zn.tnic>
 <CAHk-=wiwBYoAKQ6H=n0ppZfMe6nVDwDw6cruv7jxZZw4XEmUsg@mail.gmail.com>
 <c8cfb3d2-d3c4-6d8d-1dfd-aeb349e26303@hpe.com>
 <20201012212709.GM25311@zn.tnic>
 <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
Message-ID: <d865e9cd-38c9-2210-116b-935336a3738f@hpe.com>
Date:   Mon, 12 Oct 2020 14:58:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <f778b25e-68e7-98ec-9032-b35696948405@hpe.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [73.222.225.80]
X-ClientProxiedBy: SA0PR11CA0066.namprd11.prod.outlook.com
 (2603:10b6:806:d2::11) To TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7715::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.157] (73.222.225.80) by SA0PR11CA0066.namprd11.prod.outlook.com (2603:10b6:806:d2::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Mon, 12 Oct 2020 21:58:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91e11450-d678-4e64-9ccd-08d86ef9e801
X-MS-TrafficTypeDiagnostic: TU4PR8401MB1070:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <TU4PR8401MB10704BD4C22E5EEAE53C147AE7070@TU4PR8401MB1070.NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57EC0QORrbxpZF8mOLWVykqXDsPRuVgJ21TNJ4KWA2Cf0guGHhI8rYGXyeGKbrddSOSkS+Ji1IkiBgrktu+LDR3xiVd2WOKoMAK492mCFpZHrHxsRBEpRJY9iIA4E8Lx1SGUbNDxghsVUTLJfgF1Tg3k53tgkoPt58/6PIa3zz/i3rUVunlvkXFCi6aGAuyQeQ9VylZpgyBpabR/qvPHdshwa2iHZmRbA+9ABuxArNTsF/JVIBD+jutPqFeiaG0u6UGdh+0sT6i95eTBPHXGZIpZRdisbFuUSVulWv7mgSX8G4yh9i/5MjKRwRkIC9W9Mw6IUWBgbA46vgLdSgstBHDZLGHQm32t+H6iFu6PjzVJdjEtoJCygJl6LOy3KNUH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(376002)(39860400002)(4326008)(8676002)(31686004)(6486002)(8936002)(2906002)(66556008)(66476007)(66946007)(4001150100001)(83380400001)(6916009)(54906003)(5660300002)(16576012)(53546011)(316002)(478600001)(52116002)(16526019)(186003)(44832011)(31696002)(26005)(956004)(36756003)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: aDdxSgMUY2RE28QbOVfEw/RqDBOVkVGeKM6QgABzQzXRjra21Xbiz9E3Skw6vwlvgdmpU3GSgMPc657aZ/pgO3p+erO4dOn7boLvhQMoJPwPh0IAzi1qfvOZC1gydSnQzZeCiM/z6UfAjvcdOeTW5t0mpRezB2GRz7maMGeQTTde0Nch/4WT3SfkSnIsE3xDILjL2wC30d5i6Kt2+UkotdhjHlH66ZKRR5Y4ykV9cv6Lgej3rIAt1bJ2Qwbfx6ZFMZzABqG07TyJxVMJ+RF8/on6eat3siLUPycL1tNIOf7fuL0O9xVDx2yek6ItjApvU5V5rU/pIPCXhnGoiR2vr/kVCMhJ3wSKpmRsPF0te8TsLj+bUaMXgNrhAptNWtI6T1as8IwYKi4WDhiEN7b30ZTOm4TcMi+ty6s5NniThKdIUmB4UwjFPESStF1R2LWOA42JMW3SiUkJL/z6I+fgxz03vPY0pfVlh5ycjW7azzAmzFkSGvsroevwx6PyY3mxaZJUSm/wWQmEv/lzycmTrB+GJMPHrgnn875KbYDxEo00dd2wB17IOQjdSpTFkZArOL0MeGyoj+cnLG6ZDd5F6UJ0wfkFIeANqsHJeQhAkSAXZlO4XcqjUjD/Ae/v4ERYDUGdiEQUsp058iyqUFc1Bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e11450-d678-4e64-9ccd-08d86ef9e801
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1117.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 21:58:09.2966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7k2n2Ih9RLzuqhBiSMh6lGZc5jaVoIeNjWCbpV0+yILrbzI5UBrz8VH5j+aadyRBk5yESuL+o829haQS2Autxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB1070
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_18:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 phishscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120162
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2020 2:42 PM, Mike Travis wrote:
> 
> 
> On 10/12/2020 2:27 PM, Borislav Petkov wrote:
>> On Mon, Oct 12, 2020 at 02:15:55PM -0700, Mike Travis wrote:
>>>> Of course, it also looks like that 'uvh_nmi_mmrx_mask' thing is a
>>>> write-only variable so it doesn't matter, but can we _please_ get this
>>>> code fixed ASAP?
>>>
>>> Yes, I'll look at it right now.  Thanks.
>>
>> As this variable is write-only you could simply zap it now with a patch
>> ontop to fix the build and then introduce it properly later, when you
>> really need it?
>>
> 
> It should have been an unsigned long instead of an int as Linus 
> suggested.  I'm not sure it's a write only variable as I think the mask 
> is used to check if the interrupt occurred (I'll have to look closer). 
> I'm trying now to send the fixed patch.  It only has this change:
> 
> dog 74> diff -u patches/uv5_update_nmi{.v1,}
> --- patches/uv5_update_nmi.v1   2020-10-12 16:30:06.083941459 -0500
> +++ patches/uv5_update_nmi      2020-10-12 16:30:46.663903731 -0500
> @@ -55,7 +55,7 @@
>   +static unsigned long uvh_nmi_mmrx;            /* 
> UVH_EVENT_OCCURRED0/1 */
>   +static unsigned long uvh_nmi_mmrx_clear;      /* 
> UVH_EVENT_OCCURRED0/1_ALIAS */
>   +static int uvh_nmi_mmrx_shift;                        /* 
> UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
> -+static int uvh_nmi_mmrx_mask;                 /* 
> UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
> ++static unsigned long uvh_nmi_mmrx_mask;               /* 
> UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
>   +static char *uvh_nmi_mmrx_type;                       /* "EXTIO_INT0" */
>   +
>   +/* Non-zero indicates newer SMM NMI handler present */
> 
> (or quoted)
> 
>> dog 74> diff -u patches/uv5_update_nmi{.v1,}
>> --- patches/uv5_update_nmi.v1   2020-10-12 16:30:06.083941459 -0500
>> +++ patches/uv5_update_nmi      2020-10-12 16:30:46.663903731 -0500
>> @@ -55,7 +55,7 @@
>>  +static unsigned long uvh_nmi_mmrx;            /* 
>> UVH_EVENT_OCCURRED0/1 */
>>  +static unsigned long uvh_nmi_mmrx_clear;      /* 
>> UVH_EVENT_OCCURRED0/1_ALIAS */
>>  +static int uvh_nmi_mmrx_shift;                        /* 
>> UVH_EVENT_OCCURRED0/1_EXTIO_INT0_SHFT */
>> -+static int uvh_nmi_mmrx_mask;                 /* 
>> UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
>> ++static unsigned long uvh_nmi_mmrx_mask;               /* 
>> UVH_EVENT_OCCURRED0/1_EXTIO_INT0_MASK */
>>  +static char *uvh_nmi_mmrx_type;                       /* 
>> "EXTIO_INT0" */
>>  +
>>  +/* Non-zero indicates newer SMM NMI handler present */

I was in the process of tracing it through and perhaps it does need a 
bit more analysis to be correct.  What does it mean to send a patch to 
fix the compile error, just remove it?
