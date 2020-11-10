Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D8B2AE419
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732349AbgKJXbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:31:09 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:35936
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730254AbgKJXbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:31:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRXUJT7m5kqplgo02qlLqYeZRGWoFUtIa+qKPgnKGkcoHj2zVAgLz7FnAUeS+RJMbbgqxGGwScUjSr+xmTcVvmLJ/04cwkoYTggxkl+OgWhutjaQqrHgzlfJBwEA3lx4EuScRFqCUURIo0qeGjFLOs/WQt8LA4EtTPW8TuPPndjgz//K9Iovqd2xDfABL8l4Oi2QpmY3vh9YCQ+vH5x2xkRr8ijl6FOmf70JyCW0pnasRTVmb4HaHYY0Qjx5OKTyTjo6JdQJcXC5byQiv8KHUrggMnKVts9WZe36GmSxoZLInvKy5UCPS0jO16fTqVuOWuVR5D45azmboYezJUPTSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbMujP2joii1mev7fLXxZ+98IR3XMFrT+yUzxpGEJjw=;
 b=TuWGtml92U/Y+OR1+u1TXRt8Ply008izOGjDkaQnm34+3QP10hnELAgRqvTF/ZpOKMJWwQtQNq9ukEfRJG7Bv5S5Kgp+CIRg2LnCiEiprp4XlYdE9nMlvg7wyTnzpnDaS7vn6/QwP9IAWv+zJkl1kPyYtv1qj3TWXK25cGUzy6SqHpkiQyoxY3jL206MnOpiIy9AkNvW02oNlD8kB++HMTPdrUJIsJnCbL5/dtsF0oqQYfWaU5jVXxQ2SO9tuuE7uzVB1ttK56815vrBrRTUdxqfbkJxfkGC2/7RGeBGxvcM1qEN6KIZscxlxYACcZJ/VKVoGSmnpPDHoIe0CZ3QQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbMujP2joii1mev7fLXxZ+98IR3XMFrT+yUzxpGEJjw=;
 b=KSPBGsjLkmhyuKbSxauA7MLNspUU7UtMCv6uAM92sgqdWQ/1iS7mWHGvz5YL4mnk+J28aJxVAOAv4v+yBWPNRjcX2zUJG3DI2r5txug0YfrKiazvHP2nwrwjNzLfZ2ZqrBofUzk47erll53PMHzoOIwPvuEMUJaQ6UvN4jpY6TA=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Tue, 10 Nov 2020 23:31:07 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.034; Tue, 10 Nov 2020
 23:31:07 +0000
Subject: Re: [PATCH] x86/mm/sme: Fix definition of PMD_FLAGS_DEC_WP
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <3960752c-af6c-e7ef-1acc-c7df8f60cf48@amd.com>
 <20201109173543.551282-1-nivedita@alum.mit.edu>
 <fd85ff4f-150f-958a-231a-a95848cd9af4@amd.com>
 <20201109214218.GA582504@rani.riverdale.lan>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <13073a85-24c1-6efa-578b-54218d21f49d@amd.com>
Date:   Tue, 10 Nov 2020 17:31:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201109214218.GA582504@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR2201CA0016.namprd22.prod.outlook.com
 (2603:10b6:4:14::26) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM5PR2201CA0016.namprd22.prod.outlook.com (2603:10b6:4:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 23:31:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1170e5c2-3c4e-42b0-6aaa-08d885d0b2ba
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:
X-Microsoft-Antispam-PRVS: <DM6PR12MB494251C555518BB7412D2682ECE90@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePSFnWv6S8blZ2jJcDrQydu428ZBZrWXIw823UUsB9uQqB6VINpf7PP9sS04MQUWDFgrpX3TOi19iT0SPfNt2qZf660+Z+GoBDH2HMKPJtTfZ4vQ2oDRI/9f2HKEiyWrKdN66Gaq7zziKkij9xBBAkNN5FV3sHc3+Y3PnK5fgn8N4ILli7kIScHh0JLnxAuy4ioJ/G61SNxWiT4qtEnzctS0hWMAcXFu43DwYBqqRKZTs3E+i8Js5EfbfLTgBPXMcxrTjAZQQtpOjzZCuoVMrXUAAfWk8+RXUpxvA1+42TcCkNhmd+9y3+lTOYrYcAk1tr4C6U6dDXmxBamN4Fd02XUMNbmq/Zff9dXgD+cCO2/aipp4SNIc/d0HNCbkg838
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39850400004)(346002)(366004)(376002)(956004)(4326008)(31686004)(5660300002)(316002)(36756003)(6486002)(16526019)(478600001)(186003)(2616005)(2906002)(83380400001)(6916009)(66556008)(66946007)(66476007)(53546011)(26005)(52116002)(86362001)(8936002)(8676002)(54906003)(16576012)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LdHU04T6MvqiFwDme9josrlZhl6j5NVLKLf4B9+LTV3u4ztiiAHSNhqrhU2U254oP82UK/TIt2N6jO8Uz+xGZlmdjUfe8Iy8JPpnpkir8HIE9q9UWSYu8bEOn9nvFN45zHjV5SPYd7N4kbIlAPCEWUwfhHy84kAR7QxAoxu7IPQpzWHYMmiO9Yor/0/l+vOOlbjOAu+v2k+sOJRqnWnIg/rtPf26RpfkMLuZt3m3BClwFz7G838XYtrcD0uOLKj7b/RzNL/DBo1Lf68xfjcmBWEjoZb4bGzlJgo3kmHzIylDQDFfwe4zxbaqh/4cRKNjpnbI3yAxMuMlz29erRDut0qw2HasY2DTovg6jYgEdZw8Wtb22ANXvezxqQDObwSTkWTyIFnkleG2chzlUyzr9d5p5NSqYnovrNcSKJmUTydHYfTw8BiKMzq6jWqI/g6CHPKnqFlPsNDWxmpY8V7gih0bvDDAjKG5irWH3D11gFYc6cNYufVGn8A7woXA98Swbg9B2PgPP+MJ5HDgeVkv6Pvo3juwlJJtMD48k0URfAjApPOoLJw/6aXV4Ut8nWervUFOu0YkJ7dPyHf5pQ3fs47aJ7ucqKknUK+Aw6XHqLG4+QHnxyDDNPNUCIqHQa/M6Er0kViU2hXbo0rfEb6kaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1170e5c2-3c4e-42b0-6aaa-08d885d0b2ba
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 23:31:07.2387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HQnkfbm6spDeV+fBANjsqN+cb2DVt4x6gs0ryJe0zqZnD0BGaoUA1/x1q0UF4UGWiOHnymaci4ElddjCdbwwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 3:42 PM, Arvind Sankar wrote:
> On Mon, Nov 09, 2020 at 02:41:48PM -0600, Tom Lendacky wrote:
>> On 11/9/20 11:35 AM, Arvind Sankar wrote:
>>> The PAT bit is in different locations for 4k and 2M/1G page table
>>> entries.
>>>
>>> Add a definition for _PAGE_LARGE_CACHE_MASK to represent the three
>>> caching bits (PWT, PCD, PAT), similar to _PAGE_CACHE_MASK for 4k pages,
>>> and use it in the definition of PMD_FLAGS_DEC_WP to get the correct PAT
>>> index for write-protected pages.
>>>
>>> Remove a duplication definition of _PAGE_PAT_LARGE.
>>>
>>> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>>
>> Fixes: tag?
> 
> It's been broken since it was added in
> 
>   6ebcb060713f ("x86/mm: Add support to encrypt the kernel in-place")
> 
> but the code has been restructured since then. I think it should be
> backportable to 4.19.x if you want, except for that "duplication
> definition"[sic] I removed, which was only added in v5.6. Do I need to
> split that out into a separate patch?

For backporting it would probably be best if the patches were split. For
the PMD flags, I think you can target the original release and the stable
maintainers are pretty good about finding the right file. If not, they'll
ping you.

Thanks,
Tom

> 
>>
>> Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
>>
>>> ---
>>>  arch/x86/include/asm/pgtable_types.h | 3 +--
>>>  arch/x86/mm/mem_encrypt_identity.c   | 4 ++--
>>>  2 files changed, 3 insertions(+), 4 deletions(-)
>>>
