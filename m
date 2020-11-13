Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC82B13BC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgKMBQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:16:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:60338 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgKMBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:16:17 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD1E71w149332;
        Fri, 13 Nov 2020 01:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=8Rutt9Niok2qcRrHnnxztz8MDwQl7k5raBzLAndPrwk=;
 b=BYVvsXhxRJOlwvt7xqstWFOH51KQuGzgN9BTX7SaGuEWGOaAe0CUIbTxD3sqqOiG/gRi
 EcgQm74htkUkZ67RPknBa0vbKbaj/ir0y+8Za6X243EHCXc8d0jszw+nh3jCH7/+L9gu
 mUilftSnFVprJrXSNL2wP3LNwxZQnf2Uz1jbGn+cPCbe9BTAUQtZ15h8FpQs+LS3ASxJ
 KfN+26d2HZjGACBgPM63v9sXhjo786zvz957noJEVTevi4Nxk+DfTVWMsMOXsTFgg8h+
 tB1zKSecN1tOKy7Gdvla5dc3yhwYGYqUhlJnVyy9swgCdzVt5ZykUvRYaBgN2xghLPlq sQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34nh3b8m2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Nov 2020 01:16:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AD15Kwb089759;
        Fri, 13 Nov 2020 01:14:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34p55s6eba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Nov 2020 01:14:06 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AD1E4nF030173;
        Fri, 13 Nov 2020 01:14:04 GMT
Received: from [10.74.105.253] (/10.74.105.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 17:14:04 -0800
Subject: Re: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
To:     Nishanth Menon <nm@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Jyri Sarha <jsarha@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201026170624.24241-1-nm@ti.com>
 <d741c4d0-9e76-99de-7081-10f3a7a5cb1a@ti.com>
 <20201026190808.im4nb32jn4rd3xhu@crayon>
 <20201112215600.npr4g24gt4tvc5tm@kahuna>
 <4b23cb5b-b1c9-34b9-2bdf-4f9c2df9ad0d@oracle.com>
 <20201112222242.hala5ocnrc43s6cs@scribing>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <f5ff9c2e-b341-8ae5-693f-bd71d4801995@oracle.com>
Date:   Thu, 12 Nov 2020 17:13:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201112222242.hala5ocnrc43s6cs@scribing>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 2:22 PM, Nishanth Menon wrote:
> On 13:59-20201112, santosh.shilimkar@oracle.com wrote:
>> On 11/12/20 1:56 PM, Nishanth Menon wrote:
>>> On 14:08-20201026, Nishanth Menon wrote:
>>>> On 23:30-20201026, Lokesh Vutla wrote:
>>>> [..]
>>>>> ➜  linux git:(master) git grep -in ARCH_K3_AM6_SOC
>>>>> arch/arm64/configs/defconfig:961:CONFIG_ARCH_K3_AM6_SOC=y
>>>>> drivers/soc/ti/Kconfig:7:config ARCH_K3_AM6_SOC
>>>>> ➜  linux git:(master) git grep -in ARCH_K3_J721E_SOC
>>>>> arch/arm64/configs/defconfig:962:CONFIG_ARCH_K3_J721E_SOC=y
>>>>> drivers/gpu/drm/bridge/cadence/Kconfig:16:  depends on ARCH_K3_J721E_SOC ||
>>>>> COMPILE_TEST
>>>>> drivers/soc/ti/Kconfig:12:config ARCH_K3_J721E_SOC
>>>>>
>>>>>
>>>>> I see drm bridge Kconfig is cleaned[0]. Please clean the defconfig as well.
>>>>>
>>>>> [0]
>>>>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/__;!!GqivPVa7Brio!KWOx2aLl7hlHQrN--kiz1N5WaPWgeZzFZ12ptg8NzJE2BSnxxrWmsoqn5vjMvpfO1bSGYQ$
>>>>>
>>>>
>>>> Yes, the defconfig patches have to be queued up in a different queue,
>>>> Lets see where the two patches fall and will post the defconfig
>>>> updates as well.
>>>
>>>
>>> Santosh,
>>>
>>> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201026165441.22894-1-nm@ti.com/__;!!GqivPVa7Brio!KWOx2aLl7hlHQrN--kiz1N5WaPWgeZzFZ12ptg8NzJE2BSnxxrWmsoqn5vjMvpfO1bSGYQ$
>>> looks available in next now.
>>>
>>> Can we queue this patch[1] up for 5.11 window?
>>>
>>> Depending on your preference, I can carry the defconfig patch[2] (to
>>> prevent merge dependencies, might be good to get an immutable tag) OR
>>> you can pick the defconfig patch up that cleans after removing the
>>> symbol.
>>>
>>
>> I can apply SOC kconfig patch [1] to my soc branch. That branch with
>> some additional patches am going to send up, so it should
>> work. Let me know.
> 
> OK, sounds fine to me, If you can give me a tag, I can add queue up
> defconfig on top to prevent bisect issues.
> 
I won't be adding tag till all the commits are lineup but branch will
be immutable.

Regards.
Santosh
