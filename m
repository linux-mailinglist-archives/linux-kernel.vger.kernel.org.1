Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3887E2CC46F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgLBR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:59:05 -0500
Received: from mail-eopbgr760042.outbound.protection.outlook.com ([40.107.76.42]:29506
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbgLBR7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:59:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCiYbWJZRgXt+RqgPiXDFU4sQYlif1UdXVs+FQAtqcarZuR2zZDs36zjDUtJduCMbh9V5HP/pcAJoJHy8uahx0nO57yvfbrSzRQcrIYd2NfsizWC1kTrzlGsrq0GFBr2xSOfhboeopFosubVD/YRxEDyPtJXnkV37QeJ+iY6smETppg46tJOJ4LUBeMJ5Vydu1h7oPVVzEIy58LKjoLozc5FqvkKQ5Dq8fKv40zpV7a1mPdeCMgG03zn3uGJM1jbFmdl0dI5wStOtP1+dQMgoSOSzIp0cLejeiCrEmC1vMLVglAuGwrT8u3v9MPRxpzjqNrUpLZQI6qhvfMlL4vMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlTFTUXCyAcQLHMu4JjugleWE1IpSSpHKAVWqfiEmtU=;
 b=GL592UhnGZBQpGSrsfVmwcDVySkbxluwHhU4FPJpfwDXI8mhMxVLn6tx69xcvmm4y+I5l3xSiac4aLD/ut3ZJL7dIAw/VuYbZ2+rHcGDh9V6uEhbosSZ6gGe8DuiTp/kwy+ImsjZOB7vMrCotTeUNvSm69WeqkUgA5yhroeDmsGPgj0kPhqv1KI2nl0hYkPGNQrHf7ePsTOtUpDAaU8s+RdwDkElJ4y+oqF+vlzLS0c1poPNWWLH2OOrfspeEkjtwGEmZ1btaFNDgLh2VXDcKwqhqaALfv5ziC7ahxnJ9vYwbOO6LH4SkpU0ybVC//Vs4Dmkv8kZUUP3g6T0o/jMGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlTFTUXCyAcQLHMu4JjugleWE1IpSSpHKAVWqfiEmtU=;
 b=o6USuAhVfbzKXZhuFWeIowQOWtIoFFfXSBJ1GYDfM8xMZAP8iQe1q8R8D6nuHohjryvSX5VOZuQoS2aEXZLjKkmAEx4WmQDxV3pdYLtyv6AAfqVwTGG14hIoshDm3rFhuryQ1EAAfJkGUDbKM3ihVec78KFRePxWrlVPDbU2yOM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Wed, 2 Dec 2020 17:58:17 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3632.019; Wed, 2 Dec 2020
 17:58:17 +0000
Subject: Re: [PATCH] x86/cpu/amd: Remove dead code for TSEG region remapping
To:     Borislav Petkov <bp@alien8.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Kim Phillips <kim.phillips@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>, Pu Wen <puwen@hygon.cn>,
        linux-kernel@vger.kernel.org
References: <20201127171324.1846019-1-nivedita@alum.mit.edu>
 <20201127172747.GE13163@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <b726e0d7-7dfb-d902-652f-8aab4bf43e89@amd.com>
Date:   Wed, 2 Dec 2020 11:58:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201127172747.GE13163@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SA9PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:806:21::17) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SA9PR13CA0012.namprd13.prod.outlook.com (2603:10b6:806:21::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend Transport; Wed, 2 Dec 2020 17:58:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b935996-b95f-4645-dcdc-08d896ebd8b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18362C889F9530B007358115ECF30@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ADEC9sB/EXjHqvel9GSpdgM9v0/ic5/sAcJpcOEBJcdmJYwy5dz2/xylk1V/4Um8q+Xf1kekP+YbmV42VW/AWbqdQ6ih7JJzEjY4OZhuN4Wmr91fnQAxlbQOGdffLMNCfia9vKveJKJQa6ehs8xE6TrARoGpbKLGViYWdLzxxnIQkb/kuZRYfP0Yi+YQqHWy3CwVdFk4NHYqhGR4D0slyqJAU3AhxwwzzOIQsOPQ8hx8FMhdWm++COI9mxIAfpS53Wfk/oDr2qcLY/FvQnu76KaSFkECtRgUHxxnD+OH7hn4XwQ35zhscPQGqHmIZaROI52rPiYBGiaSkOtnGSIlwjOVsaD6t6a48nGZwoqUB21GelhxXjMdpAVAmLSJ+VD4TGyXHqXCql+sGnobGEYfTf6ChaadppFtvl7GYFMa1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(26005)(8676002)(956004)(2616005)(36756003)(31696002)(110136005)(316002)(54906003)(478600001)(31686004)(5660300002)(66476007)(66946007)(66556008)(83380400001)(186003)(2906002)(6512007)(86362001)(6506007)(4326008)(53546011)(16526019)(52116002)(6486002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUJySEdsSGNRd09mMit0M29sUDVZV25LZEpGT3pGYTNEZ0g3TUpGUmd1Mk5n?=
 =?utf-8?B?aFloZWQ0RVBFM3ZxRGx4aS94YjU4TGY3VkZsYVN2cjFid2FraDdJdXdlNFQz?=
 =?utf-8?B?Q0xKaytlUzdFNVdEMEtGNVA0ejlJNlA5R0pndzRNY2ViUUhibENSUTBuYVhY?=
 =?utf-8?B?cklRYThQY0RNZlVRaWhyVnpUZGhsWTNuZ013eTdlZmVybEZnN1AveEdqa0NB?=
 =?utf-8?B?WjFkdUMvOW1jZGhJSFl4Z2lSWXZyRXZCc2xLbXU0b2h4cVRhZ0xiS3NSUTFs?=
 =?utf-8?B?eUR1ZTRHdG10NzZ1QlFYdm8vWXVvandxbWg5V1lXTC9aaVlQUUhRR2wwV3I3?=
 =?utf-8?B?b1B1U2xxOTVyRE9kTVdiTWI2VkFjK1h2Q0k3UVFNWFJPSm9PamZnU2hRbytJ?=
 =?utf-8?B?VG9vRFBibWFpTGUrbUFpekVLU3lSK2NucG9PK2llUDh5YW9ndmNyYW0xV2M2?=
 =?utf-8?B?TlVyU3MycVVFbWVkY3hheTB4d0dzSXBIT0dTRmkxSlh0WlZNdVRuZzRVd0pL?=
 =?utf-8?B?SmR2VWF1bXRFV2xCZVBucVAzQ3VXbFh4U1IwU0FzVll2Qm1VN0RnOFp1amUw?=
 =?utf-8?B?azhFOU5PZGludVVoOXZoMWZxVmVMbndseHkreVplWlowRGQzYVVaSEVVMXFa?=
 =?utf-8?B?TkRKVWdSWDh2RVF4UWNMa1VWbnppQzNzZzgzcDNLM3ZyS1JvRjk5dFU4ZFpi?=
 =?utf-8?B?WUgrS3c2UW1pNkNqc3YzcUx1Ny91Q0RDaHdWWmdNZ2JOYldvNlFzOWpkSlQx?=
 =?utf-8?B?djBuVjJMWHAyalFkUk5iYzRodHlHZFFTMXJLVkxiWU5qYmdCWS9Tek9OdUxP?=
 =?utf-8?B?VmJhbmVFTjFiSjB1UHRXVXFMNWZuUElISDgzQ2ljUXVzZm1FQjJlRzgvNXpK?=
 =?utf-8?B?Z3BEbU9DRHVmdm5HVGZURWM1NU5GTGRXaHpiZ3NXOXlFTWNPczIwR1RNemk3?=
 =?utf-8?B?SzBRbEY2cll6V2JKd3ZjTUVXckJWQXZwUm91anVTQ25FRkdkelpUZG9teDJD?=
 =?utf-8?B?bTAvSGRpbTFsaStrS2cxTVVvcGJEOG82T053Mk1jc3p1OWdCeXB2YW42MXYz?=
 =?utf-8?B?bUE3OWJKQWZXNHdlVVpwUTZNaHcxL0lqZjJQS1JlQ0VIMkxzWnNVak8yQXBH?=
 =?utf-8?B?RjFoWFZZYlA3SVU1ZkhiYU52ZFZDcWl3YnNpWGpxa2xJcmRRbSt2b3VqR3Qw?=
 =?utf-8?B?L3N5a1duVjNTSHpnanBha2hyenkrK1FWRDAvYXV2SzVudnBIOGxZbHN4TnVx?=
 =?utf-8?B?aVk0T3o3RjJKNFpCYkg3MFoveUpETmUyb3dQVHAwd2xON09uV0ppdlhSb3h6?=
 =?utf-8?Q?xPC1xhvvvwWMV3JoRLbuYyWRuiQtuKsbvL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b935996-b95f-4645-dcdc-08d896ebd8b5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 17:58:17.2112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7uRy+9xmEcDi1cUSYBMaaOnMJ8S1Ii0NeX87CysfsU2HP2b3xzOH7c9MB/ThxZgv6C+4uyrp5jOnuP8NCYsQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/20 11:27 AM, Borislav Petkov wrote:
> On Fri, Nov 27, 2020 at 12:13:24PM -0500, Arvind Sankar wrote:
>> Commit
>>    26bfa5f89486 ("x86, amd: Cleanup init_amd")
>> moved the code that remaps the TSEG region using 4k pages from
>> init_amd() to bsp_init_amd().
>>
>> However, bsp_init_amd() is executed well before the direct mapping is
>> actually created:
>>
>>    setup_arch()
>>      -> early_cpu_init()
>>        -> early_identify_cpu()
>>          -> this_cpu->c_bsp_init()
>> 	  -> bsp_init_amd()
>>      ...
>>      -> init_mem_mapping()
>>
>> So the change effectively disabled the 4k remapping, because
>> pfn_range_is_mapped() is always false at this point.
>>
>> It has been over six years since the commit, and no-one seems to have
>> noticed this, so just remove the code. The original code was also
>> incomplete, since it doesn't check how large the TSEG address range
>> actually is, so it might remap only part of it in any case.
> 
> Yah, and the patch which added this:
> 
> 6c62aa4a3c12 ("x86: make amd.c have 64bit support code")
> 
> does not say what for (I'm not surprised, frankly).
> 
> So if AMD folks on Cc don't have any need for actually fixing this
> properly, yap, we can zap it.

I believe this is geared towards performance. If the TSEG base address is 
not 2MB aligned, then hardware has to break down a 2MB TLB entry if the OS 
references the memory within the 2MB page that is before the TSEG base 
address. This can occur whenever the 2MB TLB entry is re-installed because 
of TLB flushes, etc.

I would hope that newer BIOSes are 2MB aligning the TSEG base address, but 
if not, then this can help.

So moving it back wouldn't be a bad thing. It should probably only do the 
set_memory_4k() if the TSEG base address is not 2MB aligned, which I think 
is covered by the pfn_range_is_mapped() call?

Thanks,
Tom

> 
> Thx.
> 
