Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5192CDE04
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgLCSum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:50:42 -0500
Received: from mail-co1nam11on2069.outbound.protection.outlook.com ([40.107.220.69]:4328
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbgLCSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:50:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP28zEilgDMf00vWRGHvF2YBug88aPPNO7ksIUoqHJ9oR4Vn38MRIKrcqqBzzXUgZrCeWW7oDyypbMCodRWnZWoHdkljmDAUx2TMx5x68lZEgEBam6tqMYhIVkJPw/UrvS++G/oVYIBu9s1Aps98v2XOBxqySZQ1ZAAt42OZxNkTYmqqf8Qt0XFXeSX0zc3rNcrWOANsgnBbpEJRgCUMT4rqLYUstB+l6Z2u+hxr0TYCx+Q7kKQDnA+AXwysEms02pXwX6GDEXGt/PrTq8QrdDNmZe15FERPwkZ+8Mje1TsfoTF1ufJxiZRAP1prY2ERjGSGTMmF6apeG3y8ZLZN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmRpDV6Rwlr6A7z4Pyag1uMrjEwppmj46Tidcvo0luA=;
 b=Rvf1Hmg1HpLaOZm+ciSmMbtSXitr4sro+WsZUUD30G1vzI26i1YyZmg4LPhuNNv1uTFws3YcVsMZULxmzLVdY9+pRteX86UPUKH8g+bPSCpqQEfkGdChV7bjA8hsLnU+kfMd4NomxM23CFnNrNYsy8TYl0LvEot2ZSBMV7f48IJRHxK4TcZAwLPg3NlpjFNQpooVnY6PZXgBnkEcyufm1kQnQvupoIpwoIBTqqBfOum+4daiRMuEPXdhlxLJmu5XalIg9keZ1dTUMEUiCcwBc7/hPBttCwBjyll53alMNr9tvN6FblEftQJbkXOvCDNxiAp+hMekcvnyFju4FzlG6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmRpDV6Rwlr6A7z4Pyag1uMrjEwppmj46Tidcvo0luA=;
 b=rDiGzjca/xV8EhtplWDuey8FTuFL7nFP5LWjXOOJwmqpG8hRJHSIh9TjdeSP136v/3cwUCOtrLy29i1TiSBEZFq4Vl3vy+rjGKitbEtflcoHrpBpKBhQ5mYZJE9UIp0Ydbc+gRzl6JcHtvKb8o3psHhIUhMsyqhHXn3ZOLdUHr8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.19; Thu, 3 Dec 2020 18:49:48 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3632.019; Thu, 3 Dec 2020
 18:49:48 +0000
Subject: Re: [PATCH v2 1/3] x86/uprobes: Fix not using prefixes.nbytes for
 loop over prefixes.bytes
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <1c1b265f-34e3-f5cc-0e7b-186dc26c94b7@amd.com>
 <20201203165420.GL3059@zn.tnic> <20201203170140.GM3059@zn.tnic>
 <d9b47fc6-6d9d-b966-30df-9ef8c83b46e3@amd.com>
 <20201203181712.GN3059@zn.tnic>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e7148653-0156-b895-714c-0d4cd580a2a8@amd.com>
Date:   Thu, 3 Dec 2020 12:49:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201203181712.GN3059@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN6PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:805:66::26) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR08CA0013.namprd08.prod.outlook.com (2603:10b6:805:66::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 18:49:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb2160e2-3e70-49c9-83fa-08d897bc3591
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0220044975A456AF18D635CDECF20@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uE4cX+K48C3uh2R7vkhXWfdzZ1KrE+6G/DhTxOc5MhE7TYzI66Tz96ZqE+Qwx/rlLfDN0zyQgjxGaDf3dUzYhAOBhxSbo40TcPT6ye8nYJ1TtZyWOS3JAsMvB1wwzRt/C6dRkEwXU47pjrg4y5iZcWZHPacp/Ib/TI3IsuNdtD6AbDALS76dCJItqpf7Qiw73A5WO0YIbbM5/lOAIrtK6zabizIKcHakcTPJ8Y5e2f1PxAJlbY/5yRZgerpWOZbREZyVIwRDskncluzu9ilVG9GfTmKHIeJYTmoiSTzjU0t0s/gd5k5YPoB/olpKkhNyscqY8+QZQ6HToaidrl5y8W1jPh3c5+izRt/KBSPjSNnBIhSQ2BiJQLH6Q7lCi5V9LyUuT7RAF55C+x01og7EWgFqKpgZbZDoCU0gILOgmAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(86362001)(2906002)(8936002)(316002)(2616005)(7416002)(956004)(4326008)(6486002)(52116002)(6506007)(53546011)(6512007)(54906003)(66946007)(66476007)(66556008)(83380400001)(31696002)(26005)(5660300002)(186003)(8676002)(6916009)(478600001)(31686004)(16526019)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QnZmWk5iWlE5R1RUb2lrdFg3eVRoeFE3bFlSR3NiQk5kRlVZdGx0SzVneXFI?=
 =?utf-8?B?VVVhaVNxTFhZaEpvK2xvZm1VMkI4WmxETkRySWlxS0dIL1daYVlLaTNsTVdl?=
 =?utf-8?B?QjNpZFpXNmpLeUtodVNndi9zYmJ5TnNlMHAwOFVnY2Z5RVlWT3ZTdVAxNkh2?=
 =?utf-8?B?aVZPRDRWSWlNeXZVK1NyVGp0dW1QQ1ZHWU1vcCtzZ3NTZStUYWdabVFwODZ3?=
 =?utf-8?B?Y3hoaTJXNW1iRzZ4OElBdGFuSnhtVVNwYTRvYmp2MHFnVnRiby8vcWh5VkMx?=
 =?utf-8?B?Vm42MmNuWGpMdUwwamFTb1c3SFlmNDZsNStRWXZ4V0h3dUpweHFsZDNHcGZK?=
 =?utf-8?B?S0h6RDVJRHQxU0VBd3kwVnIvVzcrU1p5Y2JsRDhSU0tUdm9FR3pJNG9maEtD?=
 =?utf-8?B?SlVxR3BxYXFoSWxFNVpUYlhxYVphWlI0aTZmNHd6MThMZG1SSWZLbUtsNEdn?=
 =?utf-8?B?TytUZUtvdmhJOFkrSGVJaDRXemQ4Y3Z0VXNkZGxsdllQT01XQWxnYTl1OGxt?=
 =?utf-8?B?b0tzTUpOWmdjSEtOdG5kQVo3SlphUkxZV01WcWN3RzhvNG0zb1U2MzdOa0FH?=
 =?utf-8?B?Zm5Sekh2U3BYYS9yT1dHai9LcTV6Z1I5Y1FURVI0TkxwaXZ4cXB6eDFXakUw?=
 =?utf-8?B?WUhEUFJtSCt2UWZ2UElPSTJaSktEeGRnblpQOFZ6MmY1NVd5OStsK1Z5RnpY?=
 =?utf-8?B?b1E2K2FYaDdVelZHUk91NEF4TlBhbjBjOXhSRHZxcHBnRm50OE5HTDUweHpu?=
 =?utf-8?B?VnF3Q01wd2pybk5wYytqMmc5azFkZlZRSmVsTTR3MWdIR1A4Tjl1eHRSV0Uy?=
 =?utf-8?B?QjRtRk1Nb1drNW1uQTNWaGJPYUx0VFBBMkRQN0tRcTlpTi9MQy9LZ2NKR1Y1?=
 =?utf-8?B?Z0RVeTZMK05QbTZ5ZTZmdDBaYVY0NHdGTS81Smp5VTNjOVhDNkxaWkxvSWFV?=
 =?utf-8?B?WXZVSGQrTzdtb3dza216cGtaV3Q5QVljWERzbGFOUVF3Y0F3Yi9YbjVXZjhY?=
 =?utf-8?B?aG9rQzhBeks0OFErK25VSHZPZnMzQ3hKN0pwYk1vUTYvTnNHeFFXVEd4YXVp?=
 =?utf-8?B?M2h0eThKNk5IM1lYQnUrTjJEc2FHQnBKY0w2U2FLcWo0VlZ1eU01dFI5bDRk?=
 =?utf-8?B?S0x2YUNYRGRwYk1WbzZNbCthNTg2NjA4OXhBZ3FEVGhHbFNsSkUra0lKUG11?=
 =?utf-8?B?cGRoajJDQ1MxOXVsRVc3NWNtQUc1ckdrWWVQTU9YS1JCMGxqbzdQRXVPSitB?=
 =?utf-8?B?eE9PK1phdGFsWHZiNmw4Nm5YSXpPdDhMR0sxcDNjcW9NRVRLOUZ5QkZoVjZj?=
 =?utf-8?Q?cX2GRWhDAAcJQ7hTINUFSzUctrX8IjLv2G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2160e2-3e70-49c9-83fa-08d897bc3591
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 18:49:48.3538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I47T0h463xnCxTm8nqw+DAQsOFnBHqER55wnYhiWkZvqnhcC8wDbbAcxR8f27ur3aFs6zdDH8CIG6/QUoU7ZDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/20 12:17 PM, Borislav Petkov wrote:
> On Thu, Dec 03, 2020 at 12:10:10PM -0600, Tom Lendacky wrote:
>> Since that struct is used in multiple places, I think basing it on the array
>> size is the best way to go. The main point of the check is just to be sure
>> you don't read outside of the array.
> 
> Well, what happens if someone increases the array size of:
> 
> struct insn_field {
> 	union {
> 		insn_byte_t bytes[4];
> 				^^^^
> 
> ?

I think we need to keep the parsing of the instruction separate from 
accessing the prefixes after (successfully) parsing it. This fix is merely 
making sure that we don't read outside the bounds of the array that 
currently holds the legacy prefixes.

> 
> That's why a separate array only for legacy prefixes would be better
> in the long run. The array size check is good as a short-term fix for
> stable.
> 
> I'd say.

According to Volume 3 of the AMD APM (Figure 1-2 on page 5), there could 
be as many as 5 legacy prefixes and it says that more than one prefix from 
each group is undefined behavior. The instruction parsing code doesn't 
seem to take into account the different prefix groups. So I agree with you 
that short term the array size check works, and long term, the legacy 
prefix support probably needs a closer look.

Thanks,
Tom

> 
