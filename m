Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBAC2ABEAE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgKIO2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:28:12 -0500
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:39648
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730035AbgKIO2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:28:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fykPwEILDpzJRO/fTzv4Ux29lor9nOP2QPLBHK35EoxzGhh/WOxatWIabzE/PERX4kE39PwHHjKMkgSeHTEpUDI9oCJ3OeOWmB+m+MBV9zb6kP6aH6xMXUcrh+DDQyVeB3EviB8Hrp+n9XWY5pUmsQ1y3U62t6BQ3kZwfnW5C809p9esxjMjronmOzOQ0YxxYv7BrRP1Re0stCygUEngKCAHdlEpeBH/JcKtEuhmP6ri9o35547ZhTBLcLWaml9CGW1bRr/3iFmbsH1nBlDPrLpdMlzkLvukQc/R8iFDCrr9pnmoopzahEL0LnjIg2/ryP9OVFtjo00GTPo3BqTxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7Rgs8LzUh02XEulkIRAyO+q63t3pY3mKjKUx4LveBg=;
 b=gRXmPQwWUBYKNtUalD6WjoWLT0x+Y2mfyStp9nvP89uMM/JpCAisaipv/9OFccOvGRT2M6NNDS+g7YWp0icT/7s26+/Dp6k1TWIRnlbi1LxgWr+OQge1Me61R8Xy4ifZHZMMrONmAcjtgmANDmECpcY6hOuoOMEwmqEvKmt/ZMVCk3GDuKexw8dLcDjpI+PMUy7GQ8U7JGvlowGslP6inwMGU07kbuS2wyyCojIzCR+nADKO1JaJHy2RwHDkY/EyV4tlIKNjBL41Db7E+RpHNo+faSiVKBjU9DMlbFFl27+X68qyoZM6nsIjeQwRjki2AShXFbgv7p8dqDTJT3bZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7Rgs8LzUh02XEulkIRAyO+q63t3pY3mKjKUx4LveBg=;
 b=FXQb0lfBu2Tz/kpTWnndTbTP+MBpePhlamyK9potBm12o+Xk66fw+v7kvRridIxVdkWr6BFszCRO7yVzIPmCyrdJp9F2qMLV7p97cBOmSZNPvZgycytg/EHDWjwsDEX+cn0AWW8zKIim8LGS4MNdPRMU8LEkqVDnr4oBr1LT3TE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Mon, 9 Nov 2020 14:28:08 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 14:28:08 +0000
Subject: Re: Definition of PMD_FLAGS_DEC_WP in
 arch/x86/mm/mem_encrypt_identity.c
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <20201108163715.GA206902@rani.riverdale.lan>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <3960752c-af6c-e7ef-1acc-c7df8f60cf48@amd.com>
Date:   Mon, 9 Nov 2020 08:28:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201108163715.GA206902@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM3PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:0:52::19) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM3PR08CA0009.namprd08.prod.outlook.com (2603:10b6:0:52::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 14:28:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aecfa3ce-ac9b-44ed-37dd-08d884bbad9a
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680581F0C4E685AAD55D8D1ECEA0@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B740ydIBx+FRZJwdPneGSzi1H0fXQJ2PH/J6YK7Uq+ex81EYrGUN3oXamtMZYbr+QoVCmf04c0GaNrBo7K5gnIFZYFAxRRMbLYXc5ZiiYyJo7b7USmn1/p7Yf5328WFN4638N5LZr4LZpWtuod/SJzfFnrJh2eM/NIRigKnAdG4XMp/5t2rQP+xejdQbxmKqvfCmdnMuNVr85X7WnvNZsfy+kVAb13Zo2MJT9tnuTu+B/m0dPcE6ulB8+VPVJbMfZ+wi0bSrIVZRUB+Z+HtLWvVo3ktxIIAXq09ql2w8tXLgTFWEOeRdHPF2xhEsDjx+ZEu/ABov3BbQ1VB4Ri8jyxBgBEguHWgERk6guXqqE5ysjRwkUpLxlkgPqpegkyoP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(956004)(52116002)(31686004)(8676002)(36756003)(8936002)(86362001)(2906002)(4326008)(110136005)(316002)(66556008)(26005)(66476007)(16576012)(66946007)(478600001)(31696002)(53546011)(186003)(2616005)(16526019)(5660300002)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pLkxiCmo+POYSuDVUmD6Yp3jkXREt30Grcit+sZ4boQFtl71yOPrquIIg0sRBMbChxy1ufWzpYAWRa3ckHKDXVcf2mtUpyXBM9H4jbN9E7CTpodkOmmv9Wp2GIfhaWzd0LL79OBlb92S4Mw7QDIrEesBLo0LCstMjlpQHTGGNEtIWMiwzd1GsC8ucUfDaSTryCRRuqy38VrZWIfAGO4fD7x3dWq0wqdaI2bmB9lEZpp4NPsaR3Rlzz5C3wBhbRhezZVme2WUFVvRZKKKrt+gU/+04zsoQGDLm9C8nHEpGQAGt56v0U2nnUaqIuCtU1T1yicXrqX2mX8ghVzfRyaY2Ha1ZH9NKiQE0XOYgGcb9Ce6enQG+H1iKTgI93sEq5rtDzqwFPe5ryzDA9+lp/+KiH8PXXj4xxn6bojHGui6PzbWbS6sahW+UW8iVyzLB7E8ZJ0lGhrRhmSsfXNO99mOhYr7IG2h7sCA/RqsYVog+RVNgxp+AFWKL3mNZ8IgANt8eYQfILASG27uVbbk8wehyvuQMtp36apZ1rtJImhw6+L/9TpBMNijk07otA/oXOi/23aUpR3DUV3SpXxmdVaBtJEdKOidpJ5/5R1y6rjC4IYUXnF9v+ICBvEedfRerMxp3Q3gfm3/HURrQr97dRxixw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aecfa3ce-ac9b-44ed-37dd-08d884bbad9a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 14:28:08.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYM5gRXQEKUJD3+XYd2Dp8A7S3+TYIYIELgFEMi/C86rNeJbwTKE2iHdVHA+DLXzxdNeqFUNHuDFltwgFnmMxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/20 10:37 AM, Arvind Sankar wrote:
> Hi, I have a question about this definition in
> arch/x86/mm/mem_encrypt_identity.c:
> 
> 	#define PMD_FLAGS_LARGE         (__PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL)
> 
> 	#define PMD_FLAGS_DEC           PMD_FLAGS_LARGE
> 	#define PMD_FLAGS_DEC_WP        ((PMD_FLAGS_DEC & ~_PAGE_CACHE_MASK) | \
> 					 (_PAGE_PAT | _PAGE_PWT))
> 
> _PAGE_CACHE_MASK and _PAGE_PAT are for 4k pages, not 2M pages. The
> definition of PMD_FLAGS_DEC_WP clears the PSE bit by masking out
> _PAGE_CACHE_MASK, and sets it again by setting _PAGE_PAT, resulting in
> PMD_FLAGS_DEC_WP actually being write-through, not write-protected,
> using PAT index 1.
> 
> Shouldn't the definition be
> 
> 	#define PMD_FLAGS_DEC_WP	(PMD_FLAGS_DEC | _PAGE_PAT_LARGE | _PAGE_PWT)
> 
> for write-protected using PAT index 5?

Yes it should. There should probably be a _PAGE_CACHE_MASK_LARGE
definition so that the end result is:

#define PMD_FLAGS_DEC_WP	((PMD_FLAGS_DEC & ~_PAGE_CACHE_MASK_LARGE) | \
				(_PAGE_PAT_LARGE | _PAGE_PWT)

> 
> I guess the difference doesn't actually matter for encrypt-in-place? But
> mem_encrypt_boot.S takes pains to initialize PA5 to be write-protected,
> and it looks like it won't actually be used.

Given how early in the boot everything occurs and the cache flushing that
is performed related to the operations, it works. But this should be
fixed.

Are you planning on sending a patch?

Thanks,
Tom

> 
> Thanks.
> 
