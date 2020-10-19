Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989E92925D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgJSKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:30:00 -0400
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:64096
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbgJSK36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:29:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjiQ8P5yB8mTQ9/ksd//eDmlHZ9dL7NXsF6t4Z5yYRZhhkoNRCCeJtHUFFJrXJf73bEwKecV/TTFcT3vP1qmjoygeR+0GeefDxqaGt6WHec73LecGIBXZGrfW8YlFFgRg0X0UIter6M+inuSQhk9KeSrZEvHTL3MdHZqwFuxbfANGX1xXOZfbG4KELVXAiNs6uUoZa5rCVPJOhen+/2rPRzIAlmS0D7302mNE9a4RvTYqcIsmSZHFPg1iMjV3d38eBXawwen7XnDLilBy+Bs9R6PkmdCqVssU0Cjc5MwtJQLuO4wYdiaHDLTyTC0ZLU3/4CHZiN7SpQF6vCaql4x1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y39+0+MdeRZbDExeNbPHrPk/wkgzmOYxxPBy9qiKtbc=;
 b=j0SQj26AEGi0IjeBP3a55I36vPWkXju02FWR6jFKBHcAE++ap6OMmxw+RZasjGZJgnLJagXNlbSNM4nAPWp/YmPq/AcOpOEH2+3optaIR5B5tOvXhGoppRRMrxDNXLoCt+Sy61mIszvfzM4TRXQi/8JsgOeXyGcNOxMRXGQBbcYqZjAb1iWWn0h7LjpPh51+vZaHzirkgLv7qzweGTJbTtcpqC9Xr28P+K1lpx9qMmturB8m9228Xf8YrjqD0ntdY+x6BDb3Em/Hv0BJfrzw1ma5KgQdNAKIgfyj9ikmpOztusjFh0pBgXuHSlgR5aVD4/pIothIop7q+rBioYh+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y39+0+MdeRZbDExeNbPHrPk/wkgzmOYxxPBy9qiKtbc=;
 b=LQRwW2SQ89NCAiUPBUar+F1ihtR8lK/OhKpXr527v0LQdCp7IY70d7HWwDlLQYaLO45u/QjBfELIj06nxz66Abv+OjeQtgngt5O7Ac7GByIG4LJnLxAJJ7bl2TM0IMlXVEfQZANkRHOwDK1OI/K1AGdOfGaGTOQ8yilpHuzv4Ko=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3767.namprd11.prod.outlook.com (2603:10b6:a03:fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 19 Oct
 2020 10:29:55 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 10:29:54 +0000
Subject: Re: [PATCH v2] mm/compaction: Rename 'start_pfn' to
 'iteration_start_pfn' in compact_zone()
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        david@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20201019083632.25417-1-yanfei.xu@windriver.com>
 <57730b8a-f5d7-d6c7-3961-3fa95701aba5@suse.cz>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <4aa294a0-c256-7e89-55af-6a7c790eec4d@windriver.com>
Date:   Mon, 19 Oct 2020 18:29:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <57730b8a-f5d7-d6c7-3961-3fa95701aba5@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BYAPR07CA0040.namprd07.prod.outlook.com (2603:10b6:a03:60::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Mon, 19 Oct 2020 10:29:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e658b36-365a-4bcd-f64b-08d87419eb49
X-MS-TrafficTypeDiagnostic: BYAPR11MB3767:
X-Microsoft-Antispam-PRVS: <BYAPR11MB37675C9BCC0ED6C92FF85D5EE41E0@BYAPR11MB3767.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Opn4NTIiAPR4IK3yfVoNvnYAENnXfVRuw72UJMIliSWoJpSMaRkmqOyTzrZoDCqCOX9D83uchcZrismyr6i8Zovo8k5ObRyUrOzaAeP4gzNzTSRaxileGAuyprsr465XkYBupwblz+JW5c48s6HG6KlODoG0FYN0J8j7aB7LJjC5RiudU/LO+i0Jh0gHRSf34Ohr/DqgEZGthNJ2OxQJiXtuY07HyA+co3T9jIPT19hYtUuhGhFpQq+PM3whkfvt4VSDk24EdYOJuYsEnSe/x8RUmso9CniRMZUqmuSAHpkazQ5CgNrxbI+2aWnRCD3HXteUa+DapyL49MlVTZzPJSQyFup6Ps50VKDhyTeFJ3GD4Btki7AzKzmoC1Y6+7TbMsKHOL5hFd3JpNFVfynt+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(366004)(346002)(136003)(16526019)(8676002)(5660300002)(186003)(6706004)(956004)(16576012)(2906002)(36756003)(2616005)(478600001)(316002)(66946007)(6486002)(86362001)(83380400001)(6666004)(31686004)(66556008)(26005)(52116002)(53546011)(66476007)(4326008)(8936002)(31696002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zciUVxPyOOJSG+NRFpuWhfVWj0H0gg5H2/CS/Ts//zrKnOqpP9SZKdtCJ7AnNFhQ1bCwNJQLZWSzZ386lZvVi5vQ4Eve9Ksz/LX26/jxUQ1KSuyTpGV1hGTaLWFAQ2l8hwEty0wr1I35I/uD9K0RUgIfCcOSDZ3uIbqKeNWhJ66ZiPyAa/33oOblBC5ksaqcSuxEDWKH68jMuybXQurtOH+849OwbSzk4RcWlzwLkt3zNCF+0BddJIY+BE3xZ31pUqm28I0QBvdEgapNpQPZIMZzJCV/LuWppfxSKRWz9BOqHRzOcKzreytd39pGMuI3Xf+JzimCBDDcUmjcpJilBodFiOoJCeCqgsWDJBeQmeIfI2XG3PQhL3criGniPyUvGHo0Igq0GYa9bWAOGbw/sY89vCj05yywKRDhvANa9m3cQWXBftck4qalJmY0Aak4aPHZoCop8ERR+RwdNlbFfFSAqj2sQWiXYjvWf2gRzpcj6vLL/u8rtp9nbWlEpv89xXOY577VzlLNWYuuFSScapliJaAvXJUu5g4n7pzeI+KGB0edbzq1sOXzHsNSOBnOnthw6DC7FWbV/i+OF3l+9iQ5vafvup04ZY94cOfPRU1nNMn/cm0uunTYQ/06ToUK1lQ0BWpybha8oq6Bs7IRug==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e658b36-365a-4bcd-f64b-08d87419eb49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 10:29:54.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imzlBt4dsKGPp54jED2Osynfn2UFoUeiZ4AbwXJKhVpCKdnTKydez8HXcuD4ZjFnzgEQRbXXzze6/eQ6ejFqZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3767
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/20 5:40 PM, Vlastimil Babka wrote:
> On 10/19/20 10:36 AM, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> There are two 'start_pfn' declared in compact_zone() which have
>> different meaning. Rename the second one to 'iteration_start_pfn'
>> to prevent trace_mm_compaction_end() from tracing an undesirable
>> value.
> 
> "to prevent confusion.", because trace_mm_compaction_end() has the
> correct value even before the patch - the second start_pfn is out
> of scope at that point.
> 
> Thanks
>
In the while-statement, the second start_pfn is always be reassigned the 
value of cc->migrate_pfn in every loop, also the cc->migrate_pfn might 
be changed in the loop. Does trace_mm_compaction_end() really want to 
trace the new assinged start_pfn?

Without the patch： 566e54e11（mm, compaction: remove last_migrated_pfn 
from compact_control）, there is only one start_pfn which has a fixed 
value. The trace_mm_compaction_end() trace it too.

Thus, I think the tracepoint might get an undesireble value.:)

Thanks,
Yanfei

>> BTW, remove an useless semicolon.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>> v1->v2:
>> Rename 'start_pfn' to 'iteration_start_pfn' and change commit messages.
>>
>>   mm/compaction.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 176dcded298e..ccd27c739fd6 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -2272,7 +2272,7 @@ compact_zone(struct compact_control *cc, struct 
>> capture_control *capc)
>>       while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
>>           int err;
>> -        unsigned long start_pfn = cc->migrate_pfn;
>> +        unsigned long iteration_start_pfn = cc->migrate_pfn;
>>           /*
>>            * Avoid multiple rescans which can happen if a page cannot be
>> @@ -2284,7 +2284,7 @@ compact_zone(struct compact_control *cc, struct 
>> capture_control *capc)
>>            */
>>           cc->rescan = false;
>>           if (pageblock_start_pfn(last_migrated_pfn) ==
>> -            pageblock_start_pfn(start_pfn)) {
>> +            pageblock_start_pfn(iteration_start_pfn)) {
>>               cc->rescan = true;
>>           }
>> @@ -2308,8 +2308,7 @@ compact_zone(struct compact_control *cc, struct 
>> capture_control *capc)
>>               goto check_drain;
>>           case ISOLATE_SUCCESS:
>>               update_cached = false;
>> -            last_migrated_pfn = start_pfn;
>> -            ;
>> +            last_migrated_pfn = iteration_start_pfn;
>>           }
>>           err = migrate_pages(&cc->migratepages, compaction_alloc,
>>
> 
> 
