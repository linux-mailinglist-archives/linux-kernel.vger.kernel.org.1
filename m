Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C059E2A01E2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgJ3Jx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:53:57 -0400
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:5729
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgJ3Jx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:53:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF2exw4vWtXj9ifhi0h+vFCUlAUrWGNda0eM0FhiQGrdCNQ6HTov+kUqdEZ36dSwcWzlSSiH0LErktr7mba4uR25PsOFoJ8uZ1ApGyexjKYNWytN/zy5pQbCs2CRQ/D3NzPTiWtfTuvQcHXWSraBehb2vP8VJKXptz04sHuzg3SMGKb8wrRoZzkG/S0D8Q+VqCT3iADsZZd09hNLIOh8v77diFFAmeCdnoYopuwrsc0PyXRLicM1KQ10NkXpK+iRBNBzVOBIhCZabGWQPyXW2Y9tl8uv3loXicBjdCHIK5tcr1bai6A9Prau9k7xfvEawiubIrFKqkFjEurkf50YrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUIoRt7PlKyDexwIRpfH7PtKv763AzOMMpQEerziKMg=;
 b=QmWkPGovTvfi9ecaSCFir97m0iQwJtusLWPcJeRUk6v+pYQMgphZuenPli0/3cm+0sS6zoOzsFKvV6oXKxVZpYgczsOxuMv2WQaSVfn8OPw5Q2R1pzxvknWndR8v8Kt/pJASeM8XXJSd3IruHi/nMoZFajF7jLMAEoM4zz/zwOo7p0wCuCnTmpVjF9lKmqFt6Dt6GAUZmpary6qJPvhFEqOL6xQ8eyFSOSYhprpXkc6jM5KrPPlOwjxenAbhQvxXm+xw2z3OfoYBaDG5oZ+EntdPN++R0r0NAMViKjtE/Gmtcz/0pfJ1n6DdASpF47AnbHEQwSuo6u7I8TGWXcqSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUIoRt7PlKyDexwIRpfH7PtKv763AzOMMpQEerziKMg=;
 b=jxg4PlmyRA4Du17ny1cTSS9e1d0zB09HGgUUBOJ/YdODZoVu+E4pnn8nUi6ysaPCXM7ZImF4JXdzGaGPF1a+TEUZqe8ONDZvkGlTBv2q0b3pZ8p/p777GsztqjJBKf4MnD9QQvMlXxKfer+oN/GX0D3PFpVPhOwBEeARw0rKfzc=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB3319.namprd12.prod.outlook.com (2603:10b6:a03:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 09:53:54 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::21a4:4ed1:c6bb:5437%5]) with mapi id 15.20.3499.027; Fri, 30 Oct 2020
 09:53:54 +0000
Subject: Re: [Outreachy kernel] [PATCH] drm/amdgpu: use
 DEFINE_DEBUGFS_ATTRIBUTE with debugfs_create_file_unsafe()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Deepak R Varma <mh12gx2825@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
References: <20201030032245.GA274478@my--box>
 <20201030071120.GA1493629@kroah.com> <20201030075716.GA6976@my--box>
 <5a7d8e8d-8db5-ff56-6448-3f1cefc11ef8@amd.com>
 <20201030082518.GB1619669@kroah.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <02ec2329-29ac-28aa-eb2d-8f6151782295@amd.com>
Date:   Fri, 30 Oct 2020 10:53:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201030082518.GB1619669@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR08CA0035.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::48) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR08CA0035.eurprd08.prod.outlook.com (2603:10a6:208:d2::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 30 Oct 2020 09:53:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f8f9567-c262-4f01-8e2e-08d87cb9b5ec
X-MS-TrafficTypeDiagnostic: BYAPR12MB3319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3319EC3E02DA88DFF319521583150@BYAPR12MB3319.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79tugfGpBsN7pLaWhYbGs4QxXeKaocdmgO6GhHd+mJW8/Bvn+HXCcTHEwGhWsqZ/Zg8n2EE0pawcIvNXWV4beeOcKDYQBHh3fOTctgBhYW4j3QnW02hcwxMuOxA20ccDMqOAPooySBzXPV9j4LwOVpqLPuZYsGhZ0DyHyB2rjpWD7QyosxV7JiLTb81YLKl1CHQxgg+0+Gua/ANWgVT5dJIGtK0ell8yZw6K02hYC+4a59gEU4MH4Mwml8CglNzpzlPb69ea3YnqUSnIewhVT8eC2KZ59coBDLgqQB9l83fht2TleQ4VhQBmf7a8S1azwbMEX145fBeva9OO/j5WZxtkZsmr8PX+33GUtw/0HWbQGE+OvdPwluq2VnaQtWhSIYjYZStpjNqZXf9+ympJn+64f7K/p9PwSNcssG04CmQE8nDGxjFkyCFO0TyKmz08E9aCdRkP+CVWOwSrih4M5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3764.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(2906002)(66556008)(86362001)(966005)(8936002)(66476007)(66946007)(83380400001)(316002)(5660300002)(36756003)(2616005)(8676002)(7416002)(31696002)(6666004)(6916009)(478600001)(66574015)(186003)(54906003)(6486002)(45080400002)(31686004)(16526019)(52116002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cBO6MpOOssRvOuJnYCCaPabRYK8hSInEU/5svO6P3QdYajjRNaG8FHIFnSN6/iLJeDq+Buf0HmsATMc28wKBpwSTGuyclr7e9DD5sh7mKKUn7Nqj9+5BKHcmj0PDdx9lXc0jNoMta/yb/xbEwhIHyWhKdM/H/qkoLmdz2pHVC4x+t95a4psSbgOBQIiNfJs1LTCckPaNZWZLf7CLMDb387A+hgLemEh3YCJGcyTj1t05PWIa3rtEEZeySd/BLEuznIJAG1fkRqEayOMqGOP3LUDpFza41TlGc345ALTHNwevBgtawc7ucL6U7DuRn2D12WHmiF3bxQSr/9Dd0RFCq4GeFkmpRE3e7HELLoXm7AQ2OFxWYFAvjheT+vuRvW4fsSf1p4BdNcFGJvdvkqR+BThA/p7pJu0o2cB4BRRTxz7MmFZblbokcH8cpmicYRsfgC8CGN28zEZjS7GyEOGZcsZ/9HjqJ4sOBXR5gNtpp35TDFRmX7vNGhP8PkfbszQIlF3t8bwi0Zd4pJ1Of50drL5lzBuG0iFNJbNyMl4RCs3weMwLzig4ShKCGFLvvxzFwWzXPONrQNaDmfd0dx234sZwr/nfhHs08IrINPgAnYjvedlryeOXrjGUa+nrnha6DQExzlYD+0P+1gmh/Bq+zs0JdBvlvU/OcCYwu8bFvrQZfX/ICYLAObl2ynrD9HjfjP2F6r4Z13pvGsZCqFHExg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8f9567-c262-4f01-8e2e-08d87cb9b5ec
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2020 09:53:53.8376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86om12hunHsQLDuw1tDx6yWwCCxskpP6IlM9AmWv08AYsRRxORyfJxo910Vd8Yij
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.10.20 um 09:25 schrieb Greg KH:
> On Fri, Oct 30, 2020 at 09:00:04AM +0100, Christian König wrote:
>> Am 30.10.20 um 08:57 schrieb Deepak R Varma:
>>> On Fri, Oct 30, 2020 at 08:11:20AM +0100, Greg KH wrote:
>>>> On Fri, Oct 30, 2020 at 08:52:45AM +0530, Deepak R Varma wrote:
>>>>> Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
>>>>> function in place of the debugfs_create_file() function will make the
>>>>> file operation struct "reset" aware of the file's lifetime. Additional
>>>>> details here: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.archive.carbon60.com%2Flinux%2Fkernel%2F2369498&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7Ce3fb2f2236f44f8779bc08d87cad3a2d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637396430734542672%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=CuDnWSIacKfdcv6%2B00Q9mZ%2BAcXse5mlFpuSsBybZ%2Fww%3D&amp;reserved=0
>>>>>
>>>>> Issue reported by Coccinelle script:
>>>>> scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
>>>>>
>>>>> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
>>>>> ---
>>>>> Please Note: This is a Outreachy project task patch.
>>>>>
>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++----------
>>>>>    1 file changed, 10 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> index 2d125b8b15ee..f076b1ba7319 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>>>> @@ -1551,29 +1551,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
>>>>>    	return 0;
>>>>>    }
>>>>> -DEFINE_SIMPLE_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>> -			amdgpu_debugfs_ib_preempt, "%llu\n");
>>>>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>>>>> +			 amdgpu_debugfs_ib_preempt, "%llu\n");
>>>> Are you sure this is ok?  Do these devices need this additional
>>>> "protection"?  Do they have the problem that these macros were written
>>>> for?
>>>>
>>>> Same for the other patches you just submitted here, I think you need to
>>>> somehow "prove" that these changes are necessary, checkpatch isn't able
>>>> to determine this all the time.
>>> Hi Greg,
>>> Based on my understanding, the current function debugfs_create_file()
>>> adds an overhead of lifetime managing proxy for such fop structs. This
>>> should be applicable to these set of drivers as well. Hence I think this
>>> change will be useful.
>> Well since this is only created once per device instance I don't really care
>> about this little overhead.
>>
>> But what exactly is debugfs doing or not doing here?
> It is trying to save drivers from having debugfs files open that point
> to memory that can go away at any time.  For graphics devices, I doubt
> that is the case.

Well we have somebody working on hot plug removal for dGPUs, but that is 
really not an issue here.

Even if our device are removed most of the debugfs files shouldn't be 
affected by that.

Thanks,
Christian.

>
> thanks,
>
> greg k-h

