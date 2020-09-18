Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0C26F625
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIRGoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:44:30 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:48857
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbgIRGo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:44:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyVFmkkAQtFqj5scMq5TSoJZC2A1kVDZCmGJcW2bS0nqgNRYcigmG2CdSyHQ7yjyDYqX5mqTRWVk1dkimbLdO+zy7IeLznVL62qjxZjVkpI8BzCWE64y0hD/2P9viDv4H5k3VQ1KtnyGAyuc86g1tpq1RDr2uhKWRlKnHm9vhoMORuDAlItWUU1GKXsipBnmL2HWcrno7DLDqXOe5LZcTLepKiJ0NZp++MXp3dOpSFENO9elSezvQnsjQNhYKUxMy0sUPJzLCvblwQ6fgnNZaPKpXyMYnK9zInBnZTGxjb7QWf1+D8uubF1diXQiadQGQLFvsDddcc5OV9ONNekS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIyJMdxjv7WeLGnppWcaCiVgM6J/joZLHcLPSGzdTms=;
 b=n2rhi5XIG7zliJ2auwcybCF8UWx6CsK+ZHecdirlyunzuRDkuD70rHlUej2YzvmemuZC8fye6uCk+TJsJZBX/2/3TUErd8XwHUDiofPZxHp9z2thoi4o8dKD4nqxVsCxEYPDIy3/LoH5Om51SGJqmMtTDhzgXGljDG8z2mkySzkxneglvAzyMmLHU3/JGp4iZLF+MS6m/OiAIdPk1H0PTe47ztvlSfDeee/fxE9ciuU3kjWaPdPmG2MC3YIS0qPFxSQfCHPCs/5mg26gDYj/e8VsynoYfI1jVcDr0IjxQCuBKTqI1aDW3aEUcSvcctllVPyVQ8K6PdZs3JVrgsQBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIyJMdxjv7WeLGnppWcaCiVgM6J/joZLHcLPSGzdTms=;
 b=GLuVfYK6SuUmPQ+I1xtflnOc7T36KN3Onp0TS/QPhZt0S3q/wYv+76uGpHOAmStNvPd2U9I8DMvGA5OjP0l71AVGLhfGv8GB9Lhv873x2HnECTdKSbEUWXeFSKlaT8VcSTK8IDXtc84kv+d9oYIfCLa37N0rzWXKvIkFyfJSYOg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3815.namprd11.prod.outlook.com (2603:10b6:a03:fa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Fri, 18 Sep
 2020 06:44:23 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0%5]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 06:44:22 +0000
Subject: Re: [PATCH v2] sched, mm: Optimize current_gfp_context()
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>,
        linux-kernel@vger.kernel.org
References: <20200618212936.9776-1-longman@redhat.com>
 <20200811152921.1d43e34ad7aff928c6c1267f@linux-foundation.org>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <a5b29e4d-cc9e-a422-e7b4-e68e0dee37c7@windriver.com>
Date:   Fri, 18 Sep 2020 14:44:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200811152921.1d43e34ad7aff928c6c1267f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.8 via Frontend Transport; Fri, 18 Sep 2020 06:44:20 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76833633-60f1-40f1-c58b-08d85b9e46da
X-MS-TrafficTypeDiagnostic: BYAPR11MB3815:
X-Microsoft-Antispam-PRVS: <BYAPR11MB381560E565B81C6A142E978DE43F0@BYAPR11MB3815.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8CBQUzTUqms10zvSrvLy2wo7PNiHzTwaQFXVk2Wb/cQQ3agOzG57dgxCXkzw0L0hJP/P7kmLZjAg1rXIanE35UY9ODBx/4EPKIvnOOo/2ktS7l61FNJab+JuSnwP3s8fu7VcVUvLWycbahr8Ws75r8jX/hRsgvYRCLyoV/6MZCY1ABC+Jay6KUncz+iKMwF1tSrWYQFWhmzzWi+kaXnnFdXPTwI3j5wm8G4pD77ub3X3Rm9Ir1fWd/WgxNleFWs6HgKlgop7hNfixKD/7htsNuW89TewJgB7zSP1FSe7IBrwwnX0nZBgb2yX3ZihLInKD+uK18+DipN8llzeEX7sQi+6vCt/V5UDPzzeJ2jXK7FOlo+mFdECsi8Dsc0056ZcYHe4NbvTRNs73pKsMxong==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(366004)(136003)(346002)(83380400001)(8676002)(6916009)(31686004)(6486002)(66476007)(66556008)(6666004)(6706004)(956004)(2616005)(54906003)(36756003)(52116002)(16526019)(5660300002)(8936002)(186003)(66946007)(2906002)(316002)(86362001)(26005)(16576012)(4326008)(478600001)(31696002)(53546011)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CBAKaz5OcZ6uYxyXjvct+Qzo1Tk8KwYDZEHDhjS5e6eftKQd6VV8O6FF8sRbEChKUteX/JnhmUGuNiy+VxynLFWgYKY1Bq8JzZByEgiGEnOP5rGnVUqUTAIFwk8G3StNK0kmrJKhhX8nmn4P1CXgHdZ3FT5z0lMgcN6kGIlYAqA2PCxPNufJVr3mjaMZLB/+m3l8xn6oJvRpCMF89VuUYRqaVICV/9Jd854M1EthbOzv+C25weg4YBY6wP9KH3jWxLV+SVak9RZewPWvtDMgu4WpiPO9VsLsR/Pbq5unozymTlQIa8i3MjrS702DAKLdX/MrTvBORr5HyxzqB1YT9M8UuvNT6db1en1K8O3k9R7Mi+j0CNOylRwJd/8vMo4ZW5reIQ+fEE4esS1bWCr5tdkrt+amlX99jDY30uU/mbtA0eHE2INaTujbPlYMddMPeBLGS3wNma1hhRJhlApEWLwQwVhMsrEyz+JH2sq7SlEY5kGSOCgKcvGv9L4S7gK2ocsaiLvXsUTc8s4YjtNV9JzdHy22PLsxXBhpuMk5VQ7hb5JE4bS+ru6ajRQcoP2ERCozW1yK5TQk/BkGyR1n1Ip46LP9M6F+GSR9lAEa7ARziHHDO1Qa3NGT5kUNn6YLiICcT6UbuoHdcljobNAZ9A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76833633-60f1-40f1-c58b-08d85b9e46da
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 06:44:22.6706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDUw5unkCYi3xgk9HvpfMg0R96YthX7BF7Y9rxZRFtq25oRaNQmsTmCNJ/bfcAl5XHqx1JyrqBJINTu8V+C/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3815
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On 8/12/20 6:29 AM, Andrew Morton wrote:
> On Thu, 18 Jun 2020 17:29:36 -0400 Waiman Long <longman@redhat.com> wrote:
> 
>> The current_gfp_context() converts a number of PF_MEMALLOC_* per-process
>> flags into the corresponding GFP_* flags for memory allocation. In
>> that function, current->flags is accessed 3 times. That may lead to
>> duplicated access of the same memory location.
>>
I have a puzzle about this comment, what's the meaning about "That may
lead to duplicated access of the same memory location". After using
variable 'pflags', will it not duplicated access the same memory
location?
Looking forward to your reply :)

Thanks,
Yanfei

>> This is not usually a problem with minimal debug config options on as the
>> compiler can optimize away the duplicated memory accesses.  With most
>> of the debug config options on, however, that may not be the case.
>> For example, the x86-64 object size of the __need_fs_reclaim() in a
>> debug kernel that calls current_gfp_context() was 309 bytes. With this
>> patch applied, the object size is reduced to 202 bytes. This is a saving
>> of 107 bytes and will probably be slightly faster too.
>>
>> ...
>>
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -181,18 +181,20 @@ static inline bool in_vfork(struct task_struct *tsk)
>>    */
>>   static inline gfp_t current_gfp_context(gfp_t flags)
>>   {
>> -	if (unlikely(current->flags &
>> +	unsigned int pflags = READ_ONCE(current->flags);
> 
> Why use READ_ONCE() here?
> 
>> +	if (unlikely(pflags &
>>   		     (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_NOCMA))) {
>>   		/*
>>   		 * NOIO implies both NOIO and NOFS and it is a weaker context
>>   		 * so always make sure it makes precedence
>>   		 */
>> -		if (current->flags & PF_MEMALLOC_NOIO)
>> +		if (pflags & PF_MEMALLOC_NOIO)
>>   			flags &= ~(__GFP_IO | __GFP_FS);
>> -		else if (current->flags & PF_MEMALLOC_NOFS)
>> +		else if (pflags & PF_MEMALLOC_NOFS)
>>   			flags &= ~__GFP_FS;
>>   #ifdef CONFIG_CMA
>> -		if (current->flags & PF_MEMALLOC_NOCMA)
>> +		if (pflags & PF_MEMALLOC_NOCMA)
>>   			flags &= ~__GFP_MOVABLE;
>>   #endif
>>   	}
> 
