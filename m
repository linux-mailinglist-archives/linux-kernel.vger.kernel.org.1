Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C6B2922FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgJSHdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:33:02 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:52833
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727614AbgJSHdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:33:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtkhqPg+I3GC7llaRmCnMmYjEIg1t8zAKtBciZzqQzN4k46IoaMqIhG76eUjzCudh/2crdr3cbH2jIBDMWi4yfYOyn3ZPRqxfnpD02Pgu/uMIceI7nrFnUK9+vhjW+soZF9zqgS9m5j9QHliNZve15ZawoXXg65O/UmK+XT3qELjWqqzSVBE27YRBz2fir8lw2kmftvoGAc377fGsFgL+r0eaI6L1+z8eRF3bCdcTHxWdt1CC0aoAtjGDbCewhJe6Z9jo9t/qiJFIk2/WCAzFyophdHlCzxVmqNh54C11/Lj8sUAR0QnL/OzX+R15TH/D2SdWdwSCaqvBz4rELcwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uAHdQHSc55m8z91BkbbywYacvj3BMTUJKI3gcP7PrA=;
 b=RdjxaRheqSVby11b/qexCyyWnVPcsCpcBhrrPfzO80xPHh15clrecBAnxDP27vjI5XDl/c/i/aD3QHRoxSTg3saAB4a/F9If1Y+p2LDi8PE9QiNzvaP42oOc4vG228OjANubtHqIczSS+RENEfFjacYh3S4FHwmC66gYrKoohB2tQPRmJS6YiFvrAzQIDQ7pzksxnCgtNlnBDr4lOEwujKncNVKsbr+vXYcra/BiCnF5x3I1NIVjrS+8ZSciA5FNJHPEFfgYMeB1ff7wplF8NXMNyeQLCKmwavXaMWodqjE4h192PbBHloz7fWQzrGnqOoRFfM/McfFoEJMdnQ9Oew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uAHdQHSc55m8z91BkbbywYacvj3BMTUJKI3gcP7PrA=;
 b=ijg5IajZpW7qN6fu+eIgJ6ZMpz6UHGRp6pVeO1H8C8K9f9n519ioycqVmwCVeSVPt8DJglaGXt0/OJYRU/LXCH4TnOis8RFXdGo7lPMbVW5oUd1bpqS0nREeZ+X5ymLxj1Njxmllol6k6WSjZoYg7sBkaEn5ccls/OO51f7X/k8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB5039.namprd11.prod.outlook.com (2603:10b6:a03:2da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 07:32:59 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 07:32:59 +0000
Subject: Re: [PATCH] mm/compaction: Remove some useless code in compact_zone()
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201014072349.34494-1-yanfei.xu@windriver.com>
 <dc40599d-e964-3a53-f3e7-94c03d3a162c@redhat.com>
 <ec5c9395-23f9-2b6a-0709-887751ff2d56@suse.cz>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <f8b1b87f-4910-1ea5-65e7-f10772dd170b@windriver.com>
Date:   Mon, 19 Oct 2020 15:32:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <ec5c9395-23f9-2b6a-0709-887751ff2d56@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:202:2e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 07:32:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1332a83b-07cb-4567-0672-08d8740133fe
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5039:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB503936B66044C0FD6FB2A00BE41E0@SJ0PR11MB5039.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FIsBopE2Ro8wG5vtF0crHhuwO0oFgIyPaU7NPdkEIzy/L32GqY6LYMwfnm5s2KfSmDu2hzdVy6dLOMl0fa1pqP7n3Aeewypg+SHAj+DX7dz/rNaXzM4J/DB6zo9blqW9seJzgeUOHkNlM6DoPfyudYuSfOPleDBYbIAhF2QzpBZjqy6tI4AuLUOuRECU1Oiwh+iH8v/e2xHgBFt3qo7CFjaQebwMh38bNEOjwiW/xifqezIz1i8HGbCGO1maJAz89xa9jRs9Gzr5rnW0pqKzAfKPu+PFWxGtWEJOUffgfVK668lcMAJ2HGDzkrxNILHzjYVRXq+XQTjMS1oGIJ2sf2yClH+ShEETXXSvRoI30U1WzYc9R0NULbiNxmCXX4d+eZPdONHsXgDuXMF+G5bhhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(346002)(396003)(376002)(366004)(52116002)(316002)(66556008)(16576012)(26005)(6666004)(2616005)(956004)(66476007)(5660300002)(186003)(478600001)(6706004)(110136005)(53546011)(31696002)(16526019)(66946007)(2906002)(83380400001)(6486002)(4326008)(8676002)(86362001)(36756003)(8936002)(31686004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6VNI2EJP9+fGRLkjnCzKszb6a18UqdZnYdgttlCeeKS388Gx8HMMoTqeCewtZUf5jDZ/gY4vyN1lUfYUF6w6hcnQomU2eye49AHBq6EXZavLwR/xY2JPFHFkGXDrtOggG2M07Fv7io2Bv6F+aFqAe8d1XyUrOSl9s/VCXoVAM44+WhGBSzB3ytVC1F2Kg0db3EfOtYjN9BmujhsYKP8w5aGLXJK2IPH7VdPhQIYoV64c7RrEZvp5bk+qGLh30D22j8lSCK8srXM0SdEEs7hqP9B69xcc5YVKeFXGn1TU5E8X9u/L0IRCc3tovBKXIsGkOMmhVAuxF/q0DgeFzhUk0jV5VHAhZi8eSGkyzv1NMorAYt/rR/bek8NCSiSWVN9rnkQvXQp4PEJHKXGYlpVxLoA1RwZmuF2ytC4SS6kPrhaiBoIp+nhDPE93MntE2TD1TTJFJx6pBf9zJoG+7o7C3YzlOCl0N0KmaHuCBPVduSFgF/uG4yNvY9kKfllv8nAZOrnl6O9e0ECwPSl4NH2FNip3YIjSaKwzud5iPF7GQ0IQeNaIlh5hka+w6dSk4pXoAT9qbit9a7B8rexyD1wD0C2cZBtkBOXzQJazDzCYBDCEOSW9T4y3qEo7VgIbwmhpxJlVwQYHB2vTmXSOc5Fu5Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1332a83b-07cb-4567-0672-08d8740133fe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 07:32:59.1319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjHEM2zHrf5A1B0su4gAzztg0no/dl4i/a+kasY2VzsLB+q5IzojfESO6fsKg4CRQLYeAcfhy+EL3gAmGW2+XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/20 11:05 PM, Vlastimil Babka wrote:
> On 10/14/20 2:28 PM, David Hildenbrand wrote:
>> On 14.10.20 09:23, yanfei.xu@windriver.com wrote:
>>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>>
>>> start_pfn has been declared at the begin of compact_zone(), it's
>>> no need to declare it again. And remove an useless semicolon.
>>>
>>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>>> ---
>>>  mm/compaction.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>> index 176dcded298e..5e69c1f94d96 100644
>>> --- a/mm/compaction.c
>>> +++ b/mm/compaction.c
>>> @@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, struct 
>>> capture_control *capc)
>>>
>>>      while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>>>          int err;
>>> -        unsigned long start_pfn = cc->migrate_pfn;
>>> +        start_pfn = cc->migrate_pfn;
>>
>> There is a user in
>>
>> trace_mm_compaction_end(start_pfn, cc->migrate_pfn, cc->free_pfn,
>> end_pfn, sync, ret);
>>
>> we would now trace a different value, no?
> 
> Agreed. We should rather rename the while-local one to avoid confusion. 
> Something like "iteration_start_pfn" ?
> 

Thank you, David and Vlastimil, for pointing out the impact to the 
tracepoint. I think "iteration_start_pfn" is appropriate and will send V2.

>>>
>>>          /*
>>>           * Avoid multiple rescans which can happen if a page cannot be
>>> @@ -2309,7 +2309,6 @@ compact_zone(struct compact_control *cc, struct 
>>> capture_control *capc)
>>>          case ISOLATE_SUCCESS:
>>>              update_cached = false;
>>>              last_migrated_pfn = start_pfn;
>>> -            ;
>>
>> Huh, how does something like that happen :)
> 
> Looks like "case ISOLATE_SUCCESS:" used to be an empty implementation, 
> then statements got added, but semicolon not removed.

Yup, this case used to be an empty.
