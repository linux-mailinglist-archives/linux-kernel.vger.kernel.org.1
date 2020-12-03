Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D63B2CDB82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgLCQql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:46:41 -0500
Received: from mail-eopbgr770070.outbound.protection.outlook.com ([40.107.77.70]:44118
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728092AbgLCQqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:46:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGCatczoonuPC9kwnaV8CyTDotTKbqZhOLb7q+xYnZJLVM1QT695hsiYkKxgtsy15GtwPCpdVlt8CIKPgREuTmkc/rlPp2eAoxE3oko1sCU2Y9Y1ihjtpr189M0fcleuE/NJfvnuCaU1nopsAvONnApZiRid1YbfZjoxICYNv6gxqNvBqwy06dmyf+FqGlheY72tcBA738lw/Ry6H4PIOl8SqCkAFGMwSkEst4U+4ELONU4ADnZ491g+lx8XWj3UFM4CIA6aoVKw6R37UbRBgWJwJ7vSf7hMwVaVE1/qttnVqqUh+BZFMsQjBwd0EGBRZCDUQyouFg9+6IjV4QFTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTEOC9VviHHjTIHRyQzrFH65x0U4GvWqsWXAVhCmNvw=;
 b=C2dNRM+KRY03cuwivzeEFUg2xJ08LtU6hWlFcb4ZFq2P6t88fW70+caCwOMjq34cYPNBis7XezCskshs0dUGX0YUBtSHXfRNRabnVMHdJjePSupsiwphMUF03LFC3MwTpKrjmqJtDOcGzJpY2cgMdC648jZI3CkZOWdma6tHAS/jxO8AdOpvaLkAb56sgWHzwyJaVnoFAnGTiUdGuzGNYKFWsVPBVN++8xstDmHXb3NrDD3E36So97nqgYWWeZbAoLeV7yc3T+5ElSh7lZEiz5/IcgWxM7XDpP9v1SUHlsyQNLQLV0or8dfooWwo5JkK6P907GVtvehY3BV20Ihzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTEOC9VviHHjTIHRyQzrFH65x0U4GvWqsWXAVhCmNvw=;
 b=FRc1xaHQe26yJ37mQYyjMf9ImHzRbU7OaepA58nFhnKB3YEpYEzAsFkCf3daRvmfI3YU3H/+8VVTe4mEtT88mDJ0ihdKRHnj4iPhAosblpt36Qe59+j+9bCPzckTMCVtcqXJZildbmmyy7hdJY8daTxn8OcZ5dTiu8oM5yyc3qw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1356.namprd12.prod.outlook.com (2603:10b6:3:74::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Thu, 3 Dec 2020 16:45:51 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 16:45:51 +0000
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
To:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <160697102582.3146288.10127018634865687932.stgit@devnote2>
 <160697103739.3146288.7437620795200799020.stgit@devnote2>
 <20201203123757.GH3059@zn.tnic> <20201203124121.GI3059@zn.tnic>
 <20201203124820.GJ3059@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
Date:   Thu, 3 Dec 2020 10:45:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201203124820.GJ3059@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN6PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:805:f2::22) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR04CA0081.namprd04.prod.outlook.com (2603:10b6:805:f2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Thu, 3 Dec 2020 16:45:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73d4a2c5-7a84-4863-f9b2-08d897aae4a2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1356:
X-Microsoft-Antispam-PRVS: <DM5PR12MB135675C5E43848750F3C344FECF20@DM5PR12MB1356.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26Rx/dIqpb2qdcNbHAvGTd8fIqMXt3ZyBuisjuKseOUi9EMwDZLihvl7yg4qvzwM2R5T8GewXcqihEcSgOHaoSUSQrz2E70djWAv7xMdV1TJ8hcxnjN3sMCzmfE/8cwfZSDtTbt6qAVPemOYOyDAbQ5m0Qjl73hF3coN0T8hEZwljIDswtDLo+yk2vYPn5RQSxmFUds4CL/XTbxMBzUiqbNre2xPaXH9RDSwKfF7T2TSKe7wKBRSubxqWkcBBAjfZoO8FUvfs8vSjpjCgc1zt7SwAM2HkTpIt9ydrHClHDgZ49ig9SGHMaY+S4OCGL9AefvObbMZXQgzkdNaPYUVrlQ3Eo9CFsZF3I7lx42iXHiu6RJ6LjlWc+1z35GQnTA6VCZARhbpZgdWLJpx3JPcfzsh6OtGCZzcYlk1Gc5TY0VDtJNOf6UA698IkLDEArp7yTaiD0crDeqeQAc3f1aCvXQRE+9+jJ/SwaHhenEcHQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(6512007)(8676002)(66946007)(6486002)(2906002)(31686004)(2616005)(66476007)(66556008)(4326008)(31696002)(36756003)(956004)(5660300002)(53546011)(16526019)(26005)(8936002)(83380400001)(186003)(86362001)(6506007)(316002)(478600001)(7416002)(54906003)(45080400002)(52116002)(110136005)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2VsK3JzS05HL3d4MXZMYXVtN3FBOGMycWpCUUpJSGtHMXVUTTBvcmp1dHFC?=
 =?utf-8?B?eFg3M3NYcjk4RkJQQVBMZUVhRlZDTldzaXR5ZGpQd0t5cmNBclZuQkVsVXJD?=
 =?utf-8?B?TFJ1STFsTmt2Tk1IU1MwZmg0M29CZWJaMWtYR2c1WXVMcURXWU85L0Yzc3h2?=
 =?utf-8?B?N3RDUUQ5OVRWTStRWm5ndVBCZlRSYXA1TDh0QnpvZ0drbmlobHcyMDVBa09V?=
 =?utf-8?B?Zm9FNW9uVmVxM3ZTQUw1Y0dEdWdUMmFqeGp6QjZDdTYvYy9haTBUblN2bGNv?=
 =?utf-8?B?eHRKY0pEM1VRSVNaV3RuVUkvbUhieUN3MFAzV1R6WU91MUh1dThYKzdaeVNO?=
 =?utf-8?B?a25mNjh5dGduV0JHK3hyVjhyL0RaTUJXQUd3RnhFSnhvWEp4TlhJa1JaVjB6?=
 =?utf-8?B?Q3BOY3ExOHd3VU9EWThyTHlxZWVqNTBLYXp3N1BVd0UwWlFPRVJ6OFFNaWlk?=
 =?utf-8?B?aE0yeCt5MUZ4OVo2UDF4eW95ck1wZU1EZ0Q0NGMyYnVxSy91SDBSM0xDU3pv?=
 =?utf-8?B?QjQ0YStOam8wenBiOXJYeHdxaE9JbmlaNTJrNkpmSHBPV2RyeEk4UUt3ZG9B?=
 =?utf-8?B?SmpJTzlaQWhXY2t5VGluNUxtcDhSSE8zZC9nOTZwd3NpVit2bHhqejZtRTQ1?=
 =?utf-8?B?QTBGN09nK2E0S1NoUVdPVVQ0QWllZnRoNXo0M0J4RVZyUUhvajFoQm1yR1Jw?=
 =?utf-8?B?SXE3UXpsTzh3TllkU2VpOEkzKzNaT2ROaWFyUER4by8zcnFjT0loNExiRStz?=
 =?utf-8?B?SjdxOGwvWExycTVGMFZxaHJERUpYVERkMVFiWTFyUmlpVGVBVXpEQVhXemdI?=
 =?utf-8?B?SHZscG5SVmtJMVkyRDFLYXQ1aTQ3K0djNEFnOVo3ZnJ4Y1BqUzBpb3FBbEFl?=
 =?utf-8?B?cy8yWG5OWHNPajI5RVlSZ3lnMGdXQ1V4bndpUy8ySmd3bEZ1ODF1TXJEM2RJ?=
 =?utf-8?B?MGpwS3I1VzFnVndKNm1CNVU4MExteVd0bEdUK0FlQThWbGkvVzhUT0trRTF0?=
 =?utf-8?B?QjIyR3poV2lOQ3hiRkNjWW9JVWlpS1pDcHhTVXprWWRqSU9ycHNSRG9iVEFK?=
 =?utf-8?B?MTJQQVVVNnEzWVpTODY3ODd2VWZ6MGxBRDFOdFpYTVBXblNYa3JyMWpyay9s?=
 =?utf-8?B?SVhOQ2V2azlwSUIza3YzRXp2a1lPOGkwNktqWSsvaFVsUW1DWGdJOXhRQkVm?=
 =?utf-8?B?N1YrczFuUnh3cGlPcXc5WHQ0RkMzN0pZOWtERXU0WDNNTVd0eC9oY1hhN2I0?=
 =?utf-8?B?QUpSNW1rdWl0eUZuQXdVcTkxa1A2NmZYKy9WVG1HYmx1UHlxYnd0c21neFBv?=
 =?utf-8?Q?M5kk5O60rhJOwSSiaUgIxSnGrHQcK+k6xh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d4a2c5-7a84-4863-f9b2-08d897aae4a2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 16:45:51.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAS9F66AUcWl+CT0cfPcS3rFbGqmNe4RP6LsYPmH4+JYkkQJfRBxgMytZ7xxTXbA6K2GG4KqlSoG7p1xGuHtdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1356
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 6:48 AM, Borislav Petkov wrote:
> So it ended up like this:
> 
> ---
>  From 5014e4e902778d63ce392f864b3654baa4b72384 Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Thu, 3 Dec 2020 13:50:37 +0900
> Subject: [PATCH] x86/uprobes: Do not use prefixes.nbytes when looping over
>   prefixes.bytes
> 
> Since insn.prefixes.nbytes can be bigger than the size of
> insn.prefixes.bytes[] when a prefix is repeated, the proper check must
> be
> 
>    insn.prefixes.bytes[i] != 0 and i < 4
> 
> instead of using insn.prefixes.nbytes.
> 
> Introduce a for_each_insn_prefix() macro for this purpose. Debugged by
> Kees Cook <keescook@chromium.org>.
> 
>   [ bp: Massage commit message, add NUM_LEGACY_PREFIXES, sync with the
>     respective header in tools/ and drop "we". ]
> 
> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org
> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.kernel.org%2Fr%2F160697103739.3146288.7437620795200799020.stgit%40devnote2&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7Ce8ec706c564245542b4408d89789b727%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637425965056484231%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=csaC0C2cszr45mKES42CHeZjC4TnEJtKrMa0gSmHjn8%3D&amp;reserved=0
> ---
>   arch/x86/include/asm/insn.h       | 16 ++++++++++++++++
>   arch/x86/kernel/uprobes.c         | 10 ++++++----
>   tools/arch/x86/include/asm/insn.h | 18 +++++++++++++++++-
>   3 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> index 5c1ae3eff9d4..fe8e862004d3 100644
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -58,6 +58,7 @@ struct insn {
>   };
>   
>   #define MAX_INSN_SIZE	15
> +#define NUM_LEGACY_PREFIXES 4
>   
>   #define X86_MODRM_MOD(modrm) (((modrm) & 0xc0) >> 6)
>   #define X86_MODRM_REG(modrm) (((modrm) & 0x38) >> 3)
> @@ -201,6 +202,21 @@ static inline int insn_offset_immediate(struct insn *insn)
>   	return insn_offset_displacement(insn) + insn->displacement.nbytes;
>   }
>   
> +/**
> + * for_each_insn_prefix() -- Iterate prefixes in the instruction
> + * @insn: Pointer to struct insn.
> + * @idx:  Index storage.
> + * @prefix: Prefix byte.
> + *
> + * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
> + * and the index is stored in @idx (note that this @idx is just for a cursor,
> + * do not change it.)
> + * Since prefixes.nbytes can be bigger than NUM_LEGACY_PREFIXES if some prefixes
> + * are repeated, it cannot be used for looping over the prefixes.
> + */
> +#define for_each_insn_prefix(insn, idx, prefix)	\
> +	for (idx = 0; idx < NUM_LEGACY_PREFIXES && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)

Since this is based on the array size, can

	idx < NUM_LEGACY_PREFIXES

be replaced with:

	idx < ARRAY_SIZE(insn->prefixes.bytes)

?

Thanks,
Tom

> +
>   #define POP_SS_OPCODE 0x1f
>   #define MOV_SREG_OPCODE 0x8e
>   
