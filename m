Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC129267E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgJSLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:39:53 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com ([40.107.94.41]:59232
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbgJSLjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:39:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1VvCo9ZqqLeBm2PkBUxSs+qBPC2q/+6pk/+NAjaJvip4JvWh/hilbz6FlYmpGthJz4o8fh0sqX1Yj8IsBjAPYaI6UqIFLHNC4GAwRB3cYnq11xVRr3gxL0SLwmnsBqkpmZ2bbvbnO30p8bt77/s0Mbaqe3d7l2XjMQud0FxcUMjIHMpSJEpBqMh+ssE8M96IEPteBpMFSHustZZC58+m2pHGAd0BI8idYJj3zkQhwxChChaD+LIZa7xXr40IwVOClvWZ4JfCoTBIhOZS83isLEM3ZicMetcFikVakRfYrqQWRqitY2WJ4tz8WgYE00C4c+EWGsumsZC/USi+RYnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kUPtAz5kVrCUQD2nKxNMRYSAzzg+qBtwMcU1Z+kxmY=;
 b=mi0IbkGielXjQsFRl01fhuiBavomS7W5VGxUoyq0NFvfKDTl5tu3LvYTxwahgoodSfgDKbWVca6jMwblL6lCodjeXoyNUTR0NaOrGvUf23QJD3y74r1HJezaUc+ZhxKBWgsuUyjBoQ4au5rosfxQmCNdlJZ9FmhqBFzdCSw0tRTQio5GC5YmJGnKWw6qzzxCfEpLqBlIdTgKzNOiG5u2v6hPMXOCsmNjoscXpPoIGYqWftphXLJUgsvlp7DqYTvpbF1ZKfIK8I2fHkvaZ9FldzpNMHxFxmLxKm5LeBQ6Ds2FyTbsKpMcqS8WORhkFVkqcG7BsicoISYSp8BHZEuQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kUPtAz5kVrCUQD2nKxNMRYSAzzg+qBtwMcU1Z+kxmY=;
 b=oD+6DWbskU2thXvIOgdW1yuLnRC8uW9NlOPyryKJLbZ0YEkAuXVgn5nXEJ2Trsbff75n64FtkJ02lPxKfAXKvENB5FiTukXNnWkU/pgtwd81W1AuSRVh0i8xlItp9YfW4G9h8qLFHOcz72iD3XyMSkoq+uyIjUHiB3wP9P0SH08=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB2839.namprd11.prod.outlook.com (2603:10b6:a02:c8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 19 Oct
 2020 11:39:50 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 11:39:49 +0000
Subject: Re: [PATCH v2] mm/compaction: Rename 'start_pfn' to
 'iteration_start_pfn' in compact_zone()
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201019083632.25417-1-yanfei.xu@windriver.com>
 <57730b8a-f5d7-d6c7-3961-3fa95701aba5@suse.cz>
 <4aa294a0-c256-7e89-55af-6a7c790eec4d@windriver.com>
 <0480a649-9f49-90fe-fbf2-be1d2df306f0@suse.cz>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <abd2eab6-c1e1-7031-a66d-785524deb32e@windriver.com>
Date:   Mon, 19 Oct 2020 19:39:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <0480a649-9f49-90fe-fbf2-be1d2df306f0@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 11:39:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 067a3580-682d-4458-41fd-08d87423afbb
X-MS-TrafficTypeDiagnostic: BYAPR11MB2839:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2839E7C00DF32D317912C592E41E0@BYAPR11MB2839.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: soqCw9asecWnQBNyUZsG6VwnG+OiB5NrgJldKy7aAk5nbuGYtFWl8dYSNPxvJ7IScfTDJq29nh9BqswY8bL6/rciun0xUEYj+BeEjgGj/AcvbhKyD6fnNLVje/2N0+DSTORS7Yse8R5VXowBIPTZ8KKmvToC9QbmTUf4wJZmVWV1nblr4A1/oz1UGmXT7VXqPqLC0SG6Gx426QhvnSJjIKBs1mGi836hGk3yxE9UK10DGeWQeMnxSsZFncDp4Qp14nfVpa/RtHmqBv5+MOd/fE1T/wMpRnOFU3P2rBdMGcyebe1MfIDeUN3mJxkskoMDbf/gy0Zx7gXfbQ5kHoJLCVEHGXz0R6+5EqkwURM8Bnlff1gsy/W5uJnd3vmlJwfo2c/vMoGxKUBmO6hWpGIWRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(31686004)(5660300002)(52116002)(6706004)(316002)(66476007)(6486002)(186003)(16526019)(16576012)(66556008)(31696002)(4326008)(36756003)(26005)(66946007)(6666004)(478600001)(8936002)(86362001)(2906002)(2616005)(8676002)(956004)(83380400001)(53546011)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Uh30ypT3Gr0290PT9q2KUR0vQqyNCghuWFGRfHEjAaEcVErtIPARr/elVESjzi46S3HuMBDKt1ZvOCwjv7d+ymGw/6BOeNtv/4u57HA9eYk3pT5dCPjzg6utPn/qe7sTvfiBSx1/H16S3dEL4wVKV0+D2+++5z/OOIzeCnSQolhppxBg6wSDsEVZgyuYPak9K6Yk3O6OdS8p4qTGCYRDL2BB2r/0SSZgkpobfGm+eiOeNZEapPymp/WeFEWtthZGmt55HAvLcvNtl15IxHTlI3i9E+NUfjmV4L0HlNgysMicjul9WWFITdGkeGXs/b0YE5SfGYJszrsOW7P2uPcrqJfzBXjB79kVr5/r3t88aPFq15Q7Q+76pO2O/9POvX02bSkPVL91qVNcsipdX2trrD6nk0QtCfZmDx8nw833rVBFdl54ukB5IkSq9vZahl1rTSMIjVct7c8+NOEGS4gt8uqFL7u12H54zDlXnEdscDaEuZZ7qo084BkeF2/iSNlh1CyMgzlgBd98mmF21ht/ZSpvGVVpmNoMtLsx8ZbKpNN21Twy9QVeNcARV5+0v64OmmAj7W/l4+Ns8WoBZQEQ8428WiA054fbockWVkb5siwEvsStrOA+FRnNQy05dNb5xqDmkQ37Mtuu5KU8b4wiWw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067a3580-682d-4458-41fd-08d87423afbb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 11:39:49.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csJYdv3pT1ibt+HQGxW4+vpcFekIWqgK5xXA/GMFRsAF2CavTRJF7EM9jGVIGv9KuDPeWUaLmtwcXdyG9OFZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2839
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/20 6:48 PM, Vlastimil Babka wrote:
> On 10/19/20 12:29 PM, Xu, Yanfei wrote:
>>
>>
>> On 10/19/20 5:40 PM, Vlastimil Babka wrote:
>>> On 10/19/20 10:36 AM, yanfei.xu@windriver.com wrote:
>>>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>>>
>>>> There are two 'start_pfn' declared in compact_zone() which have
>>>> different meaning. Rename the second one to 'iteration_start_pfn'
>>>> to prevent trace_mm_compaction_end() from tracing an undesirable
>>>> value.
>>>
>>> "to prevent confusion.", because trace_mm_compaction_end() has the
>>> correct value even before the patch - the second start_pfn is out
>>> of scope at that point.
>>>
>>> Thanks
>>>
>> In the while-statement, the second start_pfn is always be reassigned the
>> value of cc->migrate_pfn in every loop, also the cc->migrate_pfn might
>> be changed in the loop. Does trace_mm_compaction_end() really want to
>> trace the new assinged start_pfn?
> 
> compact_zone()
> {
>      unsigned long start_pfn = cc->zone->zone_start_pfn;
> 
>      while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>          unsigned long start_pfn = cc->migrate_pfn;
>      ...
>      }
> 
>      trace_mm_compaction_end(start_pfn, cc->migrate_pfn, ...)
> }
> 
> Unless my C knowledge fails me completely, the start_pfn in the while 
> loop is a new different local variable that shadows the start_pfn from 
> compact_zone() level, but does not modify its value. After while loop 
> finishes, start_pfn has still the value assigned at
> compact_zone() beginning and that's what tracepoint sees.
> 
You are right! and I got your point. As you said, the second start_pfn 
is out of scope at that point.
Will send v3.

Many thanks,
Yanfei


> So renaming the variable in while loop is not a bug fix, but removing 
> confusion.
> 
>> Without the patch： 566e54e11（mm, compaction: remove last_migrated_pfn
>> from compact_control）, there is only one start_pfn which has a fixed
>> value. The trace_mm_compaction_end() trace it too.
>>
>> Thus, I think the tracepoint might get an undesireble value.:)
>>
>> Thanks,
>> Yanfei
>>
>>>> BTW, remove an useless semicolon.
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>>>> ---
>>>> v1->v2:
>>>> Rename 'start_pfn' to 'iteration_start_pfn' and change commit messages.
>>>>
>>>>   mm/compaction.c | 7 +++----
>>>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index 176dcded298e..ccd27c739fd6 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, 
>>>> struct capture_control *capc)
>>>>       while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>>>>           int err;
>>>> -        unsigned long start_pfn = cc->migrate_pfn;
>>>> +        unsigned long iteration_start_pfn = cc->migrate_pfn;
>>>>           /*
>>>>            * Avoid multiple rescans which can happen if a page 
>>>> cannot be
>>>> @@ -2284,7 +2284,7 @@ compact_zone(struct compact_control *cc, 
>>>> struct capture_control *capc)
>>>>            */
>>>>           cc->rescan = false;
>>>>           if (pageblock_start_pfn(last_migrated_pfn) ==
>>>> -            pageblock_start_pfn(start_pfn)) {
>>>> +            pageblock_start_pfn(iteration_start_pfn)) {
>>>>               cc->rescan = true;
>>>>           }
>>>> @@ -2308,8 +2308,7 @@ compact_zone(struct compact_control *cc, 
>>>> struct capture_control *capc)
>>>>               goto check_drain;
>>>>           case ISOLATE_SUCCESS:
>>>>               update_cached = false;
>>>> -            last_migrated_pfn = start_pfn;
>>>> -            ;
>>>> +            last_migrated_pfn = iteration_start_pfn;
>>>>           }
>>>>           err = migrate_pages(&cc->migratepages, compaction_alloc,
>>>>
>>>
>>>
>>
> 
