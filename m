Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3DC2F6FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbhAOA4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:56:07 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:43852 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbhAOA4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1610672164;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=deVZETbQQfdSmb+3oqLspDqKUJ4uglSMHjdurE3JZq0=;
  b=IjYXiEcTh6B4BLSajFGFb7c712ibaBRt2Fz2ng5zXxI1UEWOu+hiQGLF
   V3Ruu6Py4BgpIYwCy/3uYzJdNHf2aLPrczqVvvXwuqQ+KjLkYa5uAYber
   LC0yjRXug+bdzXUZhlEJaFFQPbV5ZWxMg621Kzzx+S/UMtPKdnZjG8HsO
   g=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: GepB1vnjs0EcaM+5+s+0p2wf3elRLDZjW6J2L8fisjpQt//9vzw1YIULI9u3aam6eDpscb1nXC
 XMQ712d0A2A21Nz2kyo9fqna1kAVmrT3yVMyvqSTkSSWIUo8n0pHLi0AAi3ZpKAR9AkV2rpcHr
 9977PAeXUGzyE1Y3/lUOFf054NXU2PfgZgQ4Gci/m+CNY07RsubSRNsWdvR+eEXJJLjObSMNZs
 viAMRsv+Mq02sCIP/mayPl/gDaP4BNqUzjD/YN/WUc3QA0x1b4/Q3JNQImeLXEz5bCMI65l9MI
 760=
X-SBRS: 5.2
X-MesageID: 35129558
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.79,347,1602561600"; 
   d="scan'208";a="35129558"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enRooZmUjlaDwKximeGMqSMBDCHnzr7eSyDwhf5MLrodHO65TlfMl+1WwaTC0bQ5UQMGlbQ/E9o7L1Th5mJrvfk11wyFxciJwsKqt1SiedC/mdKXLK9OMdE+QBfntvYYp+hxEFCFK9sjEfFT2iefUeqNlIOObdhBascQKO3DWA0r/P+INcNs59iPioYuav1s5HSz8JTV8Mswm73L/RFJMBmNlgTC1S1dOu3uKMe62HI+RY5T1TdkdPIYGJ4K68AaxHHfvu9H1rKY1CSdlEjH7iEE5mo+B1hIR9jhUAqkwDE9MDQPv9rrzMg2JqyPJdgrOiYZaf7BEDKYTK3MdMDqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Qmk1pN6JoO1y6xZCby3DvHrsguufTX8wJJmauZnKM=;
 b=K/k71GRhzeHntRQ9Rpv9JYEwj8VY6ux6fMoMrZCNJHf7IB4C3D2v8Y1CSiBxnbOjp16OkNRy4Kz+KTi94VQJtk7WlCxYlRprJd9BRzPfX1ae2Fffm3AP9WULcttaowvB05z8mOlsBHeZiFJ2HLE0TmH1nzpbSvDpZ7LpZJUQEBQzGSdDCB/cASCZVwXF5VXMFBpU7uK1kVvbFmHl67G8kI2THO3A7sFrF2+2bp3f+RgkAPZcTdF64o59lLchrxJYIuNbi7V46Gfykq5E0Wav5si6N+02HPeTU9g4JXFElI5ZSb3fVrmZPWRubm+5cSqEq3Ea7ZlNg271Nurklo8taQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4Qmk1pN6JoO1y6xZCby3DvHrsguufTX8wJJmauZnKM=;
 b=s0L6yyzbyBGImuXvxn45b0eAIo/ajJbzTuio0xXi0sbQAwxeja8GO4zsp/vhKmLg5JRt3Z8qwbBK0ABhUw2XvoTGeCv4HL9KuJVYuQEQpQeUl/Ym+m6NGUNHofU0//MPdKvV8bB/7IfHfG97okrLGaF8xlnQTBq2AghVWM+OlPw=
Subject: Re: [PATCH 17/21] x86/acpi: Convert indirect jump to retpoline
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <a1e4f5620deb81fc644b436eca5f51ec3a694459.1610652862.git.jpoimboe@redhat.com>
 <5017a6c5-55fa-0767-b1ed-2bd9e2a5efc1@citrix.com>
 <20210114234737.xpltgdu3vpa6spgb@treble>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <70343174-b9cd-d80b-7be0-5d3e3e609ca2@citrix.com>
Date:   Fri, 15 Jan 2021 00:54:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210114234737.xpltgdu3vpa6spgb@treble>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::14) To BYAPR03MB4728.namprd03.prod.outlook.com
 (2603:10b6:a03:13a::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a96ec3bb-15ff-40b9-7184-08d8b8f02973
X-MS-TrafficTypeDiagnostic: BYAPR03MB4341:
X-Microsoft-Antispam-PRVS: <BYAPR03MB43417AAAE191433D2DDF98C1BAA70@BYAPR03MB4341.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/6yOAj8YTIx+2zEuAzq0v/+MlNS+AvCNmyMc35Ry7iS/6pUKe8NEY7Oo99kowczxxDKrID+tIgGR97y5w4kKtq7yHV3RBSK0HWz6SwvUpNJGK4W/y/7d2A5egixBsuELKDUyBWlf/jxmAaUWYNalMcOrA0suhuuQKtopM0fIgyyAM7Fds+Y/ZiSxSz013OIOrpD6JneId3js34rE0XCPhNcVk3+A0zNnNCWKOyeVr/TQyrk9j/IiL3kRSdJA2A1BE2FAfdSn5QPT7M3/CzEn42EqCdwTK7vlAjRgSA3iYrBd6KjtrXkPnCwXEHBs+Jy5DmCWYa/8JcvoB28gv50dvmFJpt8KeHnNJhu8IFIMZFCg3RCeyW4sPB4HZH5BnYkuCVhnjJFhw5alY8qDK/0t5GYEnd8LDgutq2XmoP5qYTOKgg2Z+IZ/GMxJkk91BnvC/S6NlRBmxh0cBm+F2HCmMy9uNpRfp9U03kWPLqaMFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB4728.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(7416002)(478600001)(2616005)(31686004)(316002)(16576012)(6666004)(16526019)(956004)(54906003)(186003)(66946007)(36756003)(53546011)(31696002)(4326008)(6916009)(86362001)(2906002)(66476007)(5660300002)(66556008)(6486002)(8936002)(26005)(83380400001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RlQ1V1luN3NrMnBobGVlZG9Kbm1VQ1N2WkdOSzF4ZUptU2x2aXhobEhuS2Na?=
 =?utf-8?B?OU5QcVNTYnpidUkzdkhyclY3MERmSEoxNG1UVkZpUjVVK2FrRjd3bEZ3MEFU?=
 =?utf-8?B?aCtJcDZZbENMZ3lURzZSeVpxVnFqU0tRSTU1NzhKY1NFMHJJa1Y1OW8yL2JE?=
 =?utf-8?B?WkoxT1cxUEdsZWIvVEZUWnV5SlpvTUhiaG84SG9DZXVQNklXVlVPcHlVUm5o?=
 =?utf-8?B?QktsWmZvcVlhT0orbnhiT0hNVVIzQXRHT21MUmZwVERZRzBHZ21nYkRUakQr?=
 =?utf-8?B?SE9TMFoyeEE3L1d4MEZvSmMydllHaDMxWnpBN2xKT283aFhEcEpFZnNiTWRS?=
 =?utf-8?B?Nlk3TnhCcjlveVREWnRMWjI2NGNMNFkyckhZVzNoanF3dlRmUjlXM0xiVDg0?=
 =?utf-8?B?QzBOdGtZcUtwbFlXa1JXOXB3cS8rQTdjYWIzeDhyNklQdm5XOFk2Qk5NMmV2?=
 =?utf-8?B?Mk5XdlA4a3M5dGl4Mkt0TktZaXVNbXlFcVlvRlh0dDluL09PdFVzbno5c2JV?=
 =?utf-8?B?OTFkRVdiLy9FTlVyQVNSM1VrdFp4Z3paQnV3QzhCMkhVd2dxazRjc0xTUzIz?=
 =?utf-8?B?ZE1WK1haa3oyZ1lxVkZYWGVtOWRkQUJLcHo4SGF1WGpnRmltVU1nb2hPRTEz?=
 =?utf-8?B?S3dSUkVFdlRsb3RjdFV1QWhidE9QVlEvTlA1Y1BpUmhCckpsYTBHODJ1MW9K?=
 =?utf-8?B?aXZwRXlkcEpqZ3dSYzFBcG9MVk5ZT1o1Mkl6KzlmZ2lsWS9IRWtrcnBHT3h6?=
 =?utf-8?B?L0hRZUx4UU8yMmpYMTNmQkdsN21DbW1vd2RCMG9UaGVmTW5YcmR3SkNLMnp4?=
 =?utf-8?B?WW5IVzJjcDh0ei9nOXQ1WnZiQ2F5NHJMT0M5Y2hwejJFays0L3ByZExpRTFT?=
 =?utf-8?B?YUNOYkswOTVaeHg4UW52Qlk3Ymw3VXM3NUh0Ujltc0JCUE1mYjU5V2dUcVky?=
 =?utf-8?B?TUYvVjd6U2J6M1NINVB1eDl5MHhnKzdnTWhiQnA3NnpCL3pBQ1BUMFdxN3ox?=
 =?utf-8?B?VjdOVHI5bnZuSkw4NVFzNzcydDZEYkpsVko2UlE4cTJaVFBGTkw0ZVM4YmlQ?=
 =?utf-8?B?bUsvYm5SSzhidnhGbFNzeHp6Y1RSRlJsdStZb3ZXL1NJZWlxUTg0VGxOb0gz?=
 =?utf-8?B?bTBQeXVKdDdiZzRHRWYrVnZGS3lSSEluaTUxVTVXL1c4NkUrakNFQXJmMitV?=
 =?utf-8?B?WGtnR3RPUnJNRm1tbnFtS2JGSk1lRThTdzdmQU1wbUdhc1JVMUpBWkcrK09J?=
 =?utf-8?B?R0NQSkYra01iZmRXemdOZlpLWjZnQ2tMZWZqeEtzZlppRmZIeDRicjdxNWtU?=
 =?utf-8?Q?MQ/0AWkn7C3fb18o3FUpzR9ohZt/0UWld5?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4728.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 00:54:49.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-Network-Message-Id: a96ec3bb-15ff-40b9-7184-08d8b8f02973
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2W5lGpzmd5TzrumTRUEjxSf+ghW7TH2RKWecfMkBS4JCzbsfiMewIBktClOYMxgf65vNlLVseRZnBvC47YgvQ9xX6mWmgkUUDYk1p4GwYcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4341
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2021 23:47, Josh Poimboeuf wrote:
> On Thu, Jan 14, 2021 at 10:59:39PM +0000, Andrew Cooper wrote:
>> On 14/01/2021 19:40, Josh Poimboeuf wrote:
>>> It's kernel policy to not have (unannotated) indirect jumps because of
>>> Spectre v2.  This one's probably harmless, but better safe than sorry.
>>> Convert it to a retpoline.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Len Brown <len.brown@intel.com>
>>> Cc: Pavel Machek <pavel@ucw.cz>
>>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>>> ---
>>>  arch/x86/kernel/acpi/wakeup_64.S | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
>>> index 5d3a0b8fd379..0b371580e620 100644
>>> --- a/arch/x86/kernel/acpi/wakeup_64.S
>>> +++ b/arch/x86/kernel/acpi/wakeup_64.S
>>> @@ -7,6 +7,7 @@
>>>  #include <asm/msr.h>
>>>  #include <asm/asm-offsets.h>
>>>  #include <asm/frame.h>
>>> +#include <asm/nospec-branch.h>
>>>  
>>>  # Copyright 2003 Pavel Machek <pavel@suse.cz
>>>  
>>> @@ -39,7 +40,7 @@ SYM_FUNC_START(wakeup_long64)
>>>  	movq	saved_rbp, %rbp
>>>  
>>>  	movq	saved_rip, %rax
>>> -	jmp	*%rax
>>> +	JMP_NOSPEC rax
>>>  SYM_FUNC_END(wakeup_long64)
>> I suspect this won't work as you intend.
>>
>> wakeup_long64() still executes on the low mappings, not the high
>> mappings, so the `jmp __x86_indirect_thunk_rax` under this JMP_NOSPEC
>> will wander off into the weeds.
>>
>> This is why none of the startup "jmps from weird contexts onto the high
>> mappings" have been retpolined-up.
> D'oh.  Of course it wouldn't be that easy.  I suppose the other two
> retpoline patches (15 and 21) are bogus as well.

If by 21 you mean 19, then most likely, yes.  They're all low=>high
jumps in weird contexts.

~Andrew
