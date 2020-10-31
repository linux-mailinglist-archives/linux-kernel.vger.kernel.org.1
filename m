Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864352A184E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 15:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgJaOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 10:50:15 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:19860
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbgJaOuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 10:50:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkMNF/kvMpIiAnrSwoE5HgBLHQabM2WA7BRJ6Y/9d8mUJit9BPjjWWI58/DMe4AitwObUqu8s8sHr/1ZPYzcZb9vgFnzJ9RuLZZ8ArijKe87RZxw1g1SxjL0ath4prZDxxP3aBDDe/woyh7OZvh51cqRYjU6b8FSrPyn5cnnAeCuOfHLFhvqY9or8XyZudP82YTqvXmxM/Ohn92e05fMCn+8p5zMX1PCD18JsOjq6H66sGhqlizhr6PfgfSF6y/PhzAO18ND/45yenajxeec3gfj+aCfzBwXpdm7o8DY4ZUC89VAECE0A82JDBzQQPg6O1tIEJD9t1s+htioR6Bgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1YB7JcnsuRNDzvd2y/c8/rf2FsQoDP+PbsNjE6ms4k=;
 b=EwVHnIqmb8pVUV6tF1CbZH4t10/sNGKA5I/HQjMMBTHEsq9lFFM6tpr68JU2/YH7dwyev+UYEhr34zvW1GTZPOA7sloYgGDvdwFb2VWL09FPI16WBOgIUlGc5ymQwf+qAbXe5QxISo1JEPYdWt2LdCeyJ5kM+DrWPy1UvV6Fx7QpZ5hFs7AZ9nJsj03eiZ5MCjyAqgJmcYPsTsXzvqqk2vjsYCVYaOOEurmgQ/yhTUhLmdPs8j/NPWblzQEr8RrnZ++lYrw9i8fW8OTxyFXH9VcJNBidI4KsEZ84KOoA3KDCN3KnZGE8dLUq5lqCJoDvCcgcmFhNA84jG4YOJ28ckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1YB7JcnsuRNDzvd2y/c8/rf2FsQoDP+PbsNjE6ms4k=;
 b=gXE9oFbQMRVboTxLYJPp0D5lr3zfaRYWlOuo/K62nvMduQUW7AMky+M+fcp/vbNlFBxN9lE0lw9owzmX2ZeQYPfX0ZVAmKHxrp5gFF8uX0JJ+LGGUmMJ7XZ1gnRi5w+3v1cCOoxDEM4h37blm8gU6ZSI+o4h68EqyEOLcEs0tKc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19; Sat, 31 Oct 2020 14:50:11 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.027; Sat, 31 Oct 2020
 14:50:11 +0000
Subject: Re: [PATCH 0/1] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
To:     Anand K Mistry <amistry@google.com>, x86@kernel.org,
        linux-kernel@kernel.org
Cc:     joelaf@google.com, asteinhauser@google.com, tglx@linutronix.de,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20201029065133.3027749-1-amistry@google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <50f3e115-f169-db02-505a-71c42bab6fb6@amd.com>
Date:   Sat, 31 Oct 2020 09:50:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201029065133.3027749-1-amistry@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN6PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:805:ca::23) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR16CA0046.namprd16.prod.outlook.com (2603:10b6:805:ca::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Sat, 31 Oct 2020 14:50:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a44c1ca8-b0c7-4567-3a01-08d87dac44b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2891C1484C128939BE523D3AEC120@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wNV7rD05u1w6n/qxiZMvmRF3Ajl5AmW4VJ1HLJxrGkxzULpD7eOEkpaC1ds0H8sRR46a7aLcywxVNRZCQruz9SUO/LbI1T1wjaP6nXj1gPn3rpB/IBAsVQhWhGYgGIL6UtYT4segFZWm3E7X6/7cIwO7M+YWUHBeoitUhxPBbPr45V6k1VLq6dAxgRx/6gajN1HrsF+lDnxzqp0kq4V74FhrvJLXMQtiNiNQlpiH7JWrBeZT81Dzysj1bmVoOOgfZHiDph4RuBQCUWJPPmA0WqVSSYdP4ySdTq2QwOw4DIGaHbyiHoSdcvmzHdyBe4z8XmRbYUHUFfEyc8eOTDp/xhgme5RpGUQx4l/NkKT11SQPSOihUP80FEGUI1cDuEGf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(53546011)(6486002)(52116002)(8676002)(6506007)(31686004)(54906003)(186003)(7416002)(478600001)(31696002)(83380400001)(5660300002)(26005)(316002)(2906002)(6512007)(2616005)(8936002)(956004)(66476007)(4326008)(66946007)(66556008)(86362001)(36756003)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GgZLVcETX7XyDF9dRphWbJICR2APONeFdphoa2EQiQxWB0sz6iHhLfdOihNyQb/k/ztuzRQkgbRjFWX2mOsuA5ssSyzwqFA9L7p101JI7hfI2l/brjdHJJR+yOpdw7M0yEwg0nLxjHappvfxdqKfH5Wq6iVbJe+eletE+tdxg6wqq9lm3lKWKNp7guCL3YMtFwfQnQq7VSD/SKhYYzymvSzGwpvhD8zDVYMfDJq67FXMH6tIBfQaQLilmSYAfgTNrK6+yGSrPLBhohSXD8krCbBX9Xg3AIQWbTb/rDyIbe1ZJWfl1pnLLJ6RSZelxae65Xn4eqnporYbBaQtzeIhFRQgZyOaMiSBVExmVPOjCutOhJnEs0gGDoJUFt7k0ZRBMmJxC+cEMBsr6Sp42U3k8lQXcscUeXIMAZ8Hmk214CA06wBKkFp0B7lQ24DSaYnthM7qSn+NCpPYJZZEAfn/2P+D+UMWFQ72QTw2LsVFIkQeRtXoHdMyJkzyFfbUmRtSEAAZleIWEJ5DOS7Tz9NKE+115CXsNfjU4DAR5fH4Ew0AsvYb1ycjTRaH4SsnFDxOa8RFm5oINtGAnEGElyWRGZGqOdp+8UUWyUPrKBRYvVrYt8L6yn6DoPC/o6qGlHsKyezUKPGYFRln9KrT12qgKA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a44c1ca8-b0c7-4567-3a01-08d87dac44b5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2020 14:50:11.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0S5rUMA/atch7FDugK3EU5qsBgXwBgS7c3J3pXXFTvIPxVQ2TQrxOCpUN5a2yI9p/MqwNXLqwHradAV39SOeoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 1:51 AM, Anand K Mistry wrote:
> When attempting to do some performance testing of IBPB on and AMD
> platform, I noticed the IBPB instruction was never being issued, even
> though it was conditionally on and various seccomp protected processes
> were force enabling it. Turns out, on those AMD CPUs, STIBP is set to
> always-on and this was causing an early-out on the prctl() which turns
> off IB speculation. Here is my attempt to fix it.
> 
> I'm hoping someone that understands this better than me can explain why
> I'm wrong.

It all looks reasonable to me (some comments in the patch to follow). The 
thing that makes this tough is the command line option of being able to 
force IBPB using the "prctl,ibpb" or "seccomp,ibpb" while STIBP is prctl 
or seccomp controlled. There's an inherent quality that is assumed that if 
STIBP is forced then IBPB must be forced and it looks like 21998a351512 
("x86/speculation: Avoid force-disabling IBPB based on STIBP and enhanced 
IBRS.") used that. However, with the STIBP always on support, that doesn't 
hold true.

Thanks,
Tom

> 
> 
> Anand K Mistry (1):
>    x86/speculation: Allow IBPB to be conditionally enabled on CPUs with
>      always-on STIBP
> 
>   arch/x86/kernel/cpu/bugs.c | 41 +++++++++++++++++++++-----------------
>   1 file changed, 23 insertions(+), 18 deletions(-)
> 
