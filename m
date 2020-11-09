Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074B82AC611
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgKIUly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:41:54 -0500
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:12641
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgKIUlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwJw3SkRFbxF8pzCKsKeCmWDbWDIAI89M2j6+oiVwC0DqCPz9cDoS5j5nPD6pKvNfnmLkmfIuHXZmjyOAY1Uv/w0zQbKxHS8bcKfMfkdrEUFxGhxb+q26xOKITPE8QOpKNdXwc8pd0KSN5zUap4ykUfiRfGDGZ/YepzBBfZYSBGdmL2u967cKCj8ThXPTQqptwP/1tq2oe5xFsP3ER/7B+Q/wM7vU0CDVXTdwYmtDBLtu/zwTZ4Pf5IAKB3TboGIWS8OxkDVN/CWJl2wqno5OSJpxlbQLu+uwXixYvC2SIbiADwjrbBfLIResfXz70ZPJLERRta60kLIKjlII3+SwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stae0lBTegzKKGJEGPx72dJLQWI+GNaazvUJmRODbJ8=;
 b=GE7tlyrJbYsnYrMafT9356v6n529v/rrhNRw8kLzMz8Lz/XkkFW0FGLJ5pyovAnJSbOWne/3+rA2Xmi/fsw7y5PVwrh2Ia2pfY8/mUv4K7JbPO3QbQUlMcPWwUMNi+q0z9NuCYVRdyDGSjwtTDFELGMr7iAcc+TOxDgrdMfLTOL1HdeQCdW/3Asl2zsiZzIEpGkETJxva7AtdSQd7r/yzZUu69BcM42MmA6zT2fE1avbZKIaSbeBHQhvYH7HTuOaIcXKUz5X2WL2BNZWKVbb7etiX9a8ZmoOQJfTfnD3fvFCpBHEDzgF0dQvFGUgc0dcJvzxAkQhyGJ1VCQ//2M6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Stae0lBTegzKKGJEGPx72dJLQWI+GNaazvUJmRODbJ8=;
 b=k+DpLAVUBAC21CjR7tMVVdorXyRwm8pBwtUXOfzIfMtEk1238WZni2QQefTU9xTsMp9Idk6/auoRTKs+GY2aYLGt7TlXLJPfPWLQzsaC2tHYG1/m615ZUK9LjUa1NJeGJfajFa9eurRYtCp4bmkBNZIN+s4iOM7zUb9ET1z7SA8=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3692.namprd12.prod.outlook.com (2603:10b6:5:14a::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Mon, 9 Nov 2020 20:41:51 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 20:41:51 +0000
Subject: Re: [PATCH] x86/mm/sme: Fix definition of PMD_FLAGS_DEC_WP
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
References: <3960752c-af6c-e7ef-1acc-c7df8f60cf48@amd.com>
 <20201109173543.551282-1-nivedita@alum.mit.edu>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <fd85ff4f-150f-958a-231a-a95848cd9af4@amd.com>
Date:   Mon, 9 Nov 2020 14:41:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201109173543.551282-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN1PR12CA0083.namprd12.prod.outlook.com
 (2603:10b6:802:21::18) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN1PR12CA0083.namprd12.prod.outlook.com (2603:10b6:802:21::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 20:41:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cde08f53-c500-4ecd-3567-08d884efe2c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3692:
X-Microsoft-Antispam-PRVS: <DM6PR12MB369210AE6400D063B2110C78ECEA0@DM6PR12MB3692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFE3wSq5lliM3F+/kqyt98pQFpqcs/P4G9vBAuMPlAsBERBpZwCI+/FT50LVNEHACqfmqCCqRnsIRjEHp+pIxVFkk2g1IYj38qTobxBT1MVklLnhlO4gah/KxWZta3UvHZkCuJOE91i7affqakTMs9b3XAFL83TL5E/VAWJCHFGqEE4cGG8ONb0ZwcoDuaDM4tnNVgxJbEyBqD5ev/LEbCXU4V2u4Zn/RRk7lreW0HVd0RcG1qBfsELg9arkTXpyNCpz2zc+UMQgEYZSDDyLL1/mkIMXiF/YPsO5RrE2Em/proorG0D9S1+AoOm6wAjRPRocjBYcdEP04TdXVhnSxviC+cNQ52dRnGE28KlEVgN/wTYGRZpctXv1kV0zOWvL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(83380400001)(31686004)(478600001)(4744005)(316002)(86362001)(16576012)(110136005)(5660300002)(66476007)(66946007)(66556008)(4326008)(6486002)(2906002)(2616005)(36756003)(31696002)(52116002)(53546011)(186003)(16526019)(8676002)(956004)(8936002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +IfA3uBL0Ht5jphXME1V14Kbz/wV+t1hRMHtufEy4u8CJu0ZY1M73OUvDKOIjT6FfyvaHp/vwynYpgFJu+DfVTIoVfBPFx7/0iuDRuhmgZa5s1LQN4M92562KHaGsFtZn/MzooEoQlyxmaguCRKwQiFJDZaIS0YCKhqPO2idlwufDazDPjS6jtmaHeWteKWkoEHjz39f9hH4ZfoGVtcQnXiu+mq2aL2UNSjEbxbOJ+V40A+vnp8dQ+aacE1xteSIVJRbeWMkxiM6XGAH7lM28S/rYxRiuzPQDilY2/4AKY6JjoCss5nHKvN7tQBp13hPC4paZB552F8RsZsFTlwTJFAD0BCd7HHarSZxs4ADkOpR1CadqwIctJMBG/hjO4z24z9wCxSnmls6LCw+65N8Ud9Wul4MPa/SIp+Q7HAxpLdgEWeOjB21qJxXO/NPtjyRN9byBJ6MkmtaROBooIETwpnU3xlRZFB48Qa8aZw/rXlO17afbJC3cs0WhyJriRmG003Hu+eHyPO2nJ10yRLDlGIqX+NQWSBmgrLHN2lMVRgxzGDVdv0YmtmvpKV17JJOZwf120oBZ8u0ww76rm555ZJegmGv8OvGxXOpB/23xJYDO94t+btQmmd48bpZrWkLHJWVZtwl01JUvP7FgvEUvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde08f53-c500-4ecd-3567-08d884efe2c5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 20:41:51.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Va0/U22XkjpYTju1WIuNf14+Ed9DaSHh7kVuNGrlN5/QiKYItSecfEGqxlLhCz2ARU+rEvDS72n4rHKP/1g5bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3692
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 11:35 AM, Arvind Sankar wrote:
> The PAT bit is in different locations for 4k and 2M/1G page table
> entries.
> 
> Add a definition for _PAGE_LARGE_CACHE_MASK to represent the three
> caching bits (PWT, PCD, PAT), similar to _PAGE_CACHE_MASK for 4k pages,
> and use it in the definition of PMD_FLAGS_DEC_WP to get the correct PAT
> index for write-protected pages.
> 
> Remove a duplication definition of _PAGE_PAT_LARGE.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Fixes: tag?

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/include/asm/pgtable_types.h | 3 +--
>  arch/x86/mm/mem_encrypt_identity.c   | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
