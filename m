Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38171269C51
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIODGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:06:38 -0400
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:4448
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgIODGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONBPMIqLDM/l8vNFs8j7UceGttsdyWJDOetsjrWCvMofpL3YVmLrY7mKwVpZhYHvtOPH17ODQxkqHvZlhLmE3EemDFKpFg/MNlkzYnOfOXLLmAjfmr2TxraRdtAb6pxpKdT83D50PQJV2L0pEsQjwlL3uwaqWMe4O3/3ydrAQVkZRA1Gcc7AlGpFhtVsBlEQ7eXMuggTKvTip+oUALUj/C0fZzKDK6epqpgD8tXfLCPIzWbATI/T+oDK/5znIPVySyqD3AAqoQhvwUbGRlb82aRlgn5Ysd0XEX0K6l5od33eigtLwMsoGMxZRM4LxxFO3IVwj8cKIGZEmvt6dl+/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G3rdL3U6zak2Z6x7qQqGujOMvA0z80Zco1TKHOI654=;
 b=GEm2mNbwk4Y1SV7/xSgj9SCGnQaqJXFgRmmX6uewGA+XEm4uohpvluX9ARRtR7VrpuP9GbKIWOdfKS2Thd7nMUS+hh5Z8lfZnYlua9OENDMRqWw0QVILViKJs2MoHZy2V1XpgUuqb8l1g03X1yl+5Nyzn6PEOXJJRaGjs7Ig6H0Vl1xg6rVpPj2FYruewNTeJ/kSqloVAm88bD6v7OZgUyplrluoKDV5LndTEaUQPw8y9HjmMpj0VnU7k+w+24ssvb3Um51JfVQ+p0nO0oUjVmoPqZhDjJWwzxydaAtEEktqg1JLCZXFV5OguOAFkN3oTPxw/OAe4QVBD9Jq04HTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G3rdL3U6zak2Z6x7qQqGujOMvA0z80Zco1TKHOI654=;
 b=hkD667oSMaRJNWnn5QRcvQnA/127Kr9rAIH834WKWT0+kE6D9xk+hyHLXrluIhAUrZuzSkunqILlNxOA737Fku6NJeUjj9sTfyXtMkrEWUB1oRz5qpKKMBfQFRobMbPKC/Qd5vg9sT6u96MmYHVz28cvy+RioDIgp1wRA4VzXbg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 03:06:32 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 03:06:32 +0000
Subject: Re: [PATCH v2] perf vendor events amd: remove trailing commas
To:     Namhyung Kim <namhyung@kernel.org>,
        Henry Burns <henrywolfeburns@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200912041101.2123-1-henrywolfeburns@gmail.com>
 <20200915004125.971-1-henrywolfeburns@gmail.com>
 <CAM9d7cjnYm8cBFJBVSkbnyfNw2-SApsAkm7xLdNkmnSOhJZOZw@mail.gmail.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <11f884ef-9a5d-e09b-b9e8-218953ab4699@amd.com>
Date:   Mon, 14 Sep 2020 22:06:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAM9d7cjnYm8cBFJBVSkbnyfNw2-SApsAkm7xLdNkmnSOhJZOZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0072.namprd11.prod.outlook.com
 (2603:10b6:806:d2::17) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.17.193] (165.204.77.11) by SA0PR11CA0072.namprd11.prod.outlook.com (2603:10b6:806:d2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 15 Sep 2020 03:06:30 +0000
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40a4f4b9-7731-4215-04e0-08d8592458ce
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-Microsoft-Antispam-PRVS: <BN8PR12MB29790D8611A935A1A972380687200@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ilsfJKn1vSh+HJp9pJzuPwe8JDVY1tWOKlq6IA9aAAKFdXl0J8Rg8evacyryomRmkW23xuxPI2pnZplfG5P4iZNGO/PP6uyGSiQNMCFazhXKNjhNUG3sLfSE8IiJRthCErBouNhu8oH4bIlvgjSk5NSqZCdQURVEFKsJ/iaZUyilAVBob4MQy5K6aZbz768ng78r1dpMkE2myEJhvo8poUNO9O5qEqc77lYbmMXdAG4dAkfrrUxElbAfdYqMyDo3kXodYS4ooTHv6Mz6cLCylFDc9ZkkMRnYO5ymXvd46PhYVz8Ms6fWe1NaX66wkNddKdRW6XVHl2i5TagQdVPluucumN+zczl5/FMzYUyrFsQ4ZNZc1SNbJrb5jjdE4PT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(16576012)(2616005)(6486002)(44832011)(956004)(36756003)(53546011)(31686004)(5660300002)(54906003)(4326008)(52116002)(110136005)(4744005)(478600001)(8676002)(16526019)(316002)(186003)(66556008)(66476007)(2906002)(66946007)(8936002)(26005)(7416002)(31696002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0AlrCZBMfvkfx6rfGDG5/YxntsL6miKRPCabQGRw9YajO0K2xq5jE/r2Uk8D5SZIRNez/uHwZsbOg/JMWfsA86n5FcWy/EZ/ao8GLRY7xaa9tsqY580T0UPyFbnQFjVQ8jbOm7WPrFl2qETjK92Mr8hX4Xwe6aUVfj5ki4ipIKPxN+F0iyT5TrROIb+NHFK6gbsS6hdfQonbyCgs+eE44VS9rtOnRcPbTDMn+/7ErD+buKzWmQVN4mWus5bliR+iZlC3AAVnf4u+yiL7HzrLRNofecZxGnblmuYZmv49cEsBT5vb0bBSXYjKPPL3O8aD6Pah4lzjxKAstBKzA3gnzAnWvC5laYJlS988jS9sp/d8I938aPt2MTt3duMSEPNJjKhn9oqonHlJAT2I5IAh2tt3M1JgpZgMzxACGRhaI7yaTyMnoIMwewipgn1A+Odhtbx7dnSqyafOjX1u4WJpE0h1jqmWjKGfw4TqY9c+KOj2h3tMZY/NsqBAphslUn3xN7AL6Eq+pQuwByoSfVy3qwYxq2+LlBv+0tImeMrAMIaQv7UlHep+behsmU3txJJZ70/cDgCNUdK3wJHq2eNceEDMg6DuNQEE5y083dErUtqXGmzNpiJP+ctD3f3V6vm5eQJMqYkIlgtEYqeDUc8Pdg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a4f4b9-7731-4215-04e0-08d8592458ce
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2020 03:06:31.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIp6/9apEMmvAjiBjiIntrnArnM9x1dhWK5HcSgEriW51OU+CMdrslAetDYpyHFsxUTbbQr9kfDfIihC6mYnQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 9:49 PM, Namhyung Kim wrote:
> On Tue, Sep 15, 2020 at 9:41 AM Henry Burns <henrywolfeburns@gmail.com> wrote:
>>
>> amdzen2/core.json and amdzen/core.json have the occasional trailing
>> comma. Since that goes against the JSON standard, lets remove it.
>>
>> Signed-off-by: Henry Burns <henrywolfeburns@gmail.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
