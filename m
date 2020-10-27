Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFD29CC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 23:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgJ0WtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 18:49:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39340 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgJ0WtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 18:49:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RMPCix022432;
        Tue, 27 Oct 2020 22:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GlEFjdnzTpjC8ufMbY+pbgLzIgbEcE1EHCkja664ll8=;
 b=i1O9tbkk3ZXJ5oL6kHk2H8+NFZ4jXYZ1ERHKHzuoAZZiDkANjfoXFf2XnTJDN0IX5IlJ
 vKWEUt9js8B7GKgr6sMsFEGkQViN0+toe3X33fJs37/I8cdmXdJNFQXrrtSk4LWFIq67
 J0fY1W9Q69wqpYMkcEhLou8EElfcZpwYtrazokGNiatELA7noQvGEOfS7+tOE70Zycdj
 xUl45Ab/S2yi/wsPKWPBSKuLCl7OoV/Sf46d83NMHyqCvqLg7I8nuBCpkabiPuDQfI0P
 Y/ueltPQnb+cLtRm2BevSb8iHIVtCpEwLLImo57Ult2biMJVjHFEkhTN2PVQOQSf819o zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9savtep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 22:48:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RMPKns016218;
        Tue, 27 Oct 2020 22:46:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 34cx6whgu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 22:46:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09RMkafV004788;
        Tue, 27 Oct 2020 22:46:37 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 15:46:36 -0700
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
To:     Vanshi Konda <vanshikonda@os.amperecomputing.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com> <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
 <20201021110201.00002092@Huawei.com>
 <da1b140c-fdd9-5970-fe83-02f33c3d8251@arm.com>
 <20201022010718.5jkrcyvoae56vdd5@con01sys-r111.scc-lab.amperecomputing.com>
 <3d539f31-5fa9-b6c5-b25a-3e6bd3ae660e@arm.com>
 <20201022162501.53ck5jl3zx6iywuv@con01sys-r111.scc-lab.amperecomputing.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Autocrypt: addr=dave.kleikamp@oracle.com; keydata=
 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
 rnNNL3zBkwD3nWcTxFnX
Message-ID: <75c86a68-00b9-8d87-c7f8-2cc3a32c693c@oracle.com>
Date:   Tue, 27 Oct 2020 17:46:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201022162501.53ck5jl3zx6iywuv@con01sys-r111.scc-lab.amperecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 11:25 AM, Vanshi Konda wrote:
> On Thu, Oct 22, 2020 at 12:21:27PM +0100, Robin Murphy wrote:
>> On 2020-10-22 02:07, Vanshi Konda wrote:
>>> On Thu, Oct 22, 2020 at 12:44:15AM +0100, Robin Murphy wrote:
>>>> On 2020-10-21 12:02, Jonathan Cameron wrote:
>>>>> On Wed, 21 Oct 2020 09:43:21 +0530
>>>>> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>>
>>>>>> On 10/20/2020 11:39 PM, Valentin Schneider wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Nit on the subject: this only increases the default, the max is
>>>>>>> still 2?????.
>>>>>>
>>>>>> Agreed.
>>>>>>
>>>>>>>
>>>>>>> On 20/10/20 18:34, Vanshidhar Konda wrote:
>>>>>>>> The current arm64 max NUMA nodes default to 4. Today's arm64
>>>>>>>> systems can
>>>>>>>> reach or exceed 16. Increase the number to 64 (matching x86_64).
>>>>>>>>
>>>>>>>> Signed-off-by: Vanshidhar Konda
>>>>>>>> <vanshikonda@os.amperecomputing.com>
>>>>>>>> ---
>>>>>>>> ??arch/arm64/Kconfig | 2 +-
>>>>>>>> ??1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>>>> index 893130ce1626..3e69d3c981be 100644
>>>>>>>> --- a/arch/arm64/Kconfig
>>>>>>>> +++ b/arch/arm64/Kconfig
>>>>>>>> @@ -980,7 +980,7 @@ config NUMA
>>>>>>>> ??config NODES_SHIFT
>>>>>>>> ?????????? int "Maximum NUMA Nodes (as a power of 2)"
>>>>>>>> ?????????? range 1 10
>>>>>>>> -?????? default "2"
>>>>>>>> +?????? default "6"
>>>>>>>
>>>>>>> This leads to more statically allocated memory for things like
>>>>>>> node to CPU
>>>>>>> maps (see uses of MAX_NUMNODES), but that shouldn't be too much
>>>>>>> of an
>>>>>>> issue.
>>>>>>
>>>>>> The smaller systems should not be required to waste those memory in
>>>>>> a default case, unless there is a real and available larger system
>>>>>> with those increased nodes.
>>>>>>
>>>>>>>
>>>>>>> AIUI this also directly correlates to how many more page->flags
>>>>>>> bits are
>>>>>>> required: are we sure the max 10 works on any aarch64 platform? I'm
>>>>>>
>>>>>> We will have to test that. Besides 256 (2 ^ 8) is the first threshold
>>>>>> to be crossed here.
>>>>>>
>>>>>>> genuinely asking here, given that I'm mostly a stranger to the mm
>>>>>>> world. The default should be something we're somewhat confident
>>>>>>> works
>>>>>>> everywhere.
>>>>>>
>>>>>> Agreed. Do we really need to match X86 right now ? Do we really have
>>>>>> systems that has 64 nodes ? We should not increase the default node
>>>>>> value and then try to solve some new problems, when there might not
>>>>>> be any system which could even use that. I would suggest increase
>>>>>> NODES_SHIFT value upto as required by a real and available system.
>>>>>
>>>>> I'm not going to give precise numbers on near future systems but it
>>>>> is public
>>>>> that we ship 8 NUMA node ARM64 systems today.?? Things will get more
>>>>> interesting as CXL and CCIX enter the market on ARM systems,
>>>>> given chances are every CXL device will look like another NUMA
>>>>> node (CXL spec says they should be presented as such) and you
>>>>> may be able to rack up lots of them.
>>>>>
>>>>> So I'd argue minimum that makes sense today is 16 nodes, but
>>>>> looking forward
>>>>> even a little and 64 is not a great stretch.
>>>>> I'd make the jump to 64 so we can forget about this again for a
>>>>> year or two.
>>>>> People will want to run today's distros on these new machines and we'd
>>>>> rather not have to go around all the distros asking them to carry a
>>>>> patch
>>>>> increasing this count (I assume they are already carrying such a patch
>>>>> due to those 8 node systems)
>>>
>>> To echo Jonathan's statement above we are looking at systems that will
>>> need approximately 64 NUMA nodes over the next 5-6 years - the time for
>>> which an LTS kernel would be maintained. Some of the reason's for
>>> increasing NUMA nodes during this time period include CXL, CCIX and
>>> NVDIMM (like Jonathan pointed out).

This is a very good point. It won't be long until systems will be
pushing the number of NUMA nodes and increasing NODES_SHIFT only
slightly now will result in the default configuration not recognizing
all the nodes. CONFIG_NODES_SHIFT=6 seems a reasonable step up for a
generic kernel that should run well on small to very large systems for a
few years to come.
>>> The main argument against increasing the NODES_SHIFT seems to be a
>>> concern that it negatively impacts other ARM64 systems. Could anyone
>>> share what kind of systems we are talking about? For a system that has
>>> NEED_MULTIPLE_NODES set, would the impact be noticeable?
>>
>> Systems like the ESPRESSObin - sure, sane people aren't trying to run
>> desktops or development environments in 1GB of RAM, but it's not
>> uncommon for them to use a minimal headless install of their favourite
>> generic arm64 distro rather than something more "embedded" like 
> 
> If someone is running a generic arm64 distro, at least some of them are
> already paying the extra cost. NODES_SHIFT for Ubuntu and SuSE kernels
> is already 6. CentOS/Redhat and Oracle Linux set it to 3. I've only seen
> Debian set it to 2.

Right. The distros may not agree or even care what the default is, but
it doesn't make sense for the mainline default to lag too far behind
what the major distros use.

Shaggy

> 
> Vanshi
> 
>> OpenWrt or Armbian. Increasing a generic kernel's memory footprint
>> (and perhaps more importantly, cache footprint) more than necessary is
>> going to have *some* impact.
>>
>> Robin.
>>
>>>
>>> Vanshi
>>>
>>>>
>>>> Nit: I doubt any sane distro is going to carry a patch to adjust the
>>>> *default* value of a Kconfig option. They might tune the actual
>>>> value in their config, but, well, isn't that the whole point of
>>>> configs? ;)
>>>>
>>>> Robin.
>>>>
>>>>>
>>>>> Jonathan
>>>>>
>>>>>>
>>>>>>>> ?????????? depends on NEED_MULTIPLE_NODES
>>>>>>>> ?????????? help
>>>>>>>> ?????????????? Specify the maximum number of NUMA Nodes
>>>>>>>> available on the target
