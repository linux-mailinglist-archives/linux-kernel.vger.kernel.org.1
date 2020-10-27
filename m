Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D013029CD62
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgJ1BiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:38:24 -0400
Received: from mail-dm6nam11on2105.outbound.protection.outlook.com ([40.107.223.105]:41411
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1832986AbgJ0XO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:14:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7UoWGuHdFFrSj1ze3daI9866TKnXz2V849Yh5rD104loyoz8Lo0Xmmd7zGD1ZPJskoFGorN0BxKmABazdEoJFKkBXHo8tea92AH0AedYmXayDFB2nuAotdur3FFP77OObjJpna9g/2GCCL5JmkGsHfvrnW8SxPLdIxytl3ioEqeymmc/d2j4NTIWEyH6q4HfE6CL7otvGSk/mTyLceuRMg4MeLo/P1A6po5kBvKoIhBMpl0ulmN47aYPHIUhHtqyMoRrSrh9yrjr/TSwn9pTUAEMHs/RS8o1D2IXoCwG+6QB3wNmg7DeJrsKeFsTSYBr+m4ntsIznDCGvSaa6VxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0B9QuemrK7VKucppd5eOnvwmKlGL5n5k2sGjSonyu8=;
 b=VkNJGCrnnQdgANJa8T6Ya0nD8OINS9yGhcfnsluTiBVGOKUZp59WfXKzHRshufg1EPxpP+F0i95I673ZJfF+tty3n3ZFQ4RuPUGLuVdPfIpPfpKQXqbiqiGKk4EwPcg3WAImluaOKYMUWs9Ydj9AJhQ/bJlOdzbSvskLybt7syfOfbA8nTCQlzg+nv7RhflI3jF5bWgAzFwnj+Jj2TSFQI0nih/pj/0kgP9KL0UljQEqJjUVWLVYAX9cqSNpEQhNW5RV+R7d1Tq0rPqIvgQ3sAFO9Rsf2pnhTG/iRlII7CKk98vz9eAvj2KmYLt0a1vAlhJ7A2u1BFfviYCGk+Sxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0B9QuemrK7VKucppd5eOnvwmKlGL5n5k2sGjSonyu8=;
 b=ipGgC/vzHWHGhiytgCoFU0ywApJwqdpQk1l1OposdGWuI+2bL+fveoLPU02OHV7xillNu0HA6q5JWQo9DuH446XGdY8WbKi4bm8mtCPDC0FmibZbVUksTqxJh5fW+o2qnp0epQYCOfYasUopPIVbmUWmevoR2g4ozt+ZFlUORzw=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN3PR01MB2050.prod.exchangelabs.com (2a01:111:e400:7bb7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Tue, 27 Oct 2020 23:14:20 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 23:14:19 +0000
Date:   Tue, 27 Oct 2020 16:14:16 -0700
From:   Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Message-ID: <20201027231334.qlgktaizonbqyrt7@con02sys-r111.scc-lab.amperecomputing.com>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com>
 <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
 <20201021110201.00002092@Huawei.com>
 <da1b140c-fdd9-5970-fe83-02f33c3d8251@arm.com>
 <20201022010718.5jkrcyvoae56vdd5@con01sys-r111.scc-lab.amperecomputing.com>
 <3d539f31-5fa9-b6c5-b25a-3e6bd3ae660e@arm.com>
Content-Type: text/plain; charset=unknown-8bit; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d539f31-5fa9-b6c5-b25a-3e6bd3ae660e@arm.com>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY1PR07CA0040.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::50) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY1PR07CA0040.namprd07.prod.outlook.com (2a01:111:e400:c60a::50) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 23:14:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b00002a-1835-43ea-e52f-08d87ace083b
X-MS-TrafficTypeDiagnostic: BN3PR01MB2050:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN3PR01MB2050C187608D29C5C8ACF10A9D160@BN3PR01MB2050.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlHXujLT7WnCEUQ6Kgzi47mYByRp5SRpKwJbHOFDNCBElAwwRSut1xTFnO6RwyFIAPxhBnsJTFQ8WEOPoLZ3mRaDyTfiBxDKXu1pzJ7R3g5mmGdAqKM9Y6gK6DZh01zrokRF4RveJEPyAh2eKvP29KfOuk6iDk+BrWPRwV/izx2AIyv7n0MLJNkuexF2+NlxDldIhpxpZgYZzBf4e8rP6EeubJhNWWK84EkioH9Vj/jD0LBLtZ+SSXk1R+u2EXBJNfKbbgfBTsjzJ634TvGEauTwjm+oVL6ZZzIw4XqnxjHX95Ckvd8OBYLv2QVikQ0mQblArlJh/n5zmrHBaSl2X8qr8NdbtEZAiRAEjCdktsOGjvXeOdYy4CrRjuKzAc96IaikiQaw+S24sKUa4bcpgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39850400004)(396003)(1076003)(66556008)(6666004)(66946007)(66476007)(5660300002)(83380400001)(4001150100001)(26005)(956004)(6916009)(4326008)(6496006)(2906002)(9686003)(16526019)(8936002)(6486002)(8676002)(316002)(478600001)(54906003)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: dXAvdtxePI6pELt/RNkINOhBR9PyeMqV21qAsdPLLM+ASrISqi+jpRu0bXctm3BXczkZAOSqKGJj9nWlm+ur95i6mQzrmo+L2xGbkzrqSpco/Q4MHbtKUH6RkoHbBh5N00/40IF7fcvXzObbzA6Q/2P+/LhE/PocXaikT64MVYCHBsQs+4XEnJeQULQQdB37QGb5U+1hZKKUAzZIfglg1L+9w88gDD0MH3iNWgogl16OWA/6RxxXx98X3q1KezTizd8HPnsJit/Eh1/MRcgrq8aYEqXudiEVk1FbrUfKXm8rnTGvL9OcxfDUb97UTijS3dKQIe/8YiDe6mCR//sLA9XNmig2ZBi5fUYD3dcLUxc5tSvwoVaQqVUf45vSp5eft5AHWbhCSo30up4nRGDILHLbT2IlBvCK9pTd+NbjdETrrD8o5FAKZjXG4TQqzmeu6cdH/qAUWA/eIQDJQtApSKs3tcxBCQ9eI/B/dAhUrL/wpvnNrkjMPYP98U/Xu+8xQAahqFwqZIaluVYVG75T5Wt6LzUzImDCaq4j1VOsjBobKwtd00Lbz8lQX8Q4+FVDYtZos0k4Fpp352SyU4bvrGoEFQvB+FP190qUeLtk3kL5sErjhEY7orsOLIoI3gUDFrNWjQ/VbxaSycus5C2j9A==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b00002a-1835-43ea-e52f-08d87ace083b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 23:14:19.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xN4GjWLdf0//dfvZSuaz+/w0hrFaVCV7y9EPoDYAqdfl3V6E1JhJrSiS7kKSoBaIOM5zZF2/ne7ezEBi2gNLWbB4VCL+l/xBYBppnsdDO1tf+c276UaFmDNq1DaNu0J5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB2050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:21:27PM +0100, Robin Murphy wrote:
>On 2020-10-22 02:07, Vanshi Konda wrote:
>>On Thu, Oct 22, 2020 at 12:44:15AM +0100, Robin Murphy wrote:
>>>On 2020-10-21 12:02, Jonathan Cameron wrote:
>>>>On Wed, 21 Oct 2020 09:43:21 +0530
>>>>Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>>
>>>>>On 10/20/2020 11:39 PM, Valentin Schneider wrote:
>>>>>>
>>>>>>Hi,
>>>>>>
>>>>>>Nit on the subject: this only increases the default, the max 
>>>>>>is still 2?????.
>>>>>
>>>>>Agreed.
>>>>>
>>>>>>
>>>>>>On 20/10/20 18:34, Vanshidhar Konda wrote:
>>>>>>>The current arm64 max NUMA nodes default to 4. Today's 
>>>>>>>arm64 systems can
>>>>>>>reach or exceed 16. Increase the number to 64 (matching x86_64).
>>>>>>>
>>>>>>>Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>>>>>>---
>>>>>>>??arch/arm64/Kconfig | 2 +-
>>>>>>>??1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>>>index 893130ce1626..3e69d3c981be 100644
>>>>>>>--- a/arch/arm64/Kconfig
>>>>>>>+++ b/arch/arm64/Kconfig
>>>>>>>@@ -980,7 +980,7 @@ config NUMA
>>>>>>>??config NODES_SHIFT
>>>>>>>?????????? int "Maximum NUMA Nodes (as a power of 2)"
>>>>>>>?????????? range 1 10
>>>>>>>-?????? default "2"
>>>>>>>+?????? default "6"
>>>>>>
>>>>>>This leads to more statically allocated memory for things 
>>>>>>like node to CPU
>>>>>>maps (see uses of MAX_NUMNODES), but that shouldn't be too much of an
>>>>>>issue.
>>>>>
>>>>>The smaller systems should not be required to waste those memory in
>>>>>a default case, unless there is a real and available larger system
>>>>>with those increased nodes.
>>>>>
>>>>>>
>>>>>>AIUI this also directly correlates to how many more 
>>>>>>page->flags bits are
>>>>>>required: are we sure the max 10 works on any aarch64 platform? I'm
>>>>>
>>>>>We will have to test that. Besides 256 (2 ^ 8) is the first threshold
>>>>>to be crossed here.
>>>>>
>>>>>>genuinely asking here, given that I'm mostly a stranger to the mm
>>>>>>world. The default should be something we're somewhat confident works
>>>>>>everywhere.
>>>>>
>>>>>Agreed. Do we really need to match X86 right now ? Do we really have
>>>>>systems that has 64 nodes ? We should not increase the default node
>>>>>value and then try to solve some new problems, when there might not
>>>>>be any system which could even use that. I would suggest increase
>>>>>NODES_SHIFT value upto as required by a real and available system.
>>>>
>>>>I'm not going to give precise numbers on near future systems but 
>>>>it is public
>>>>that we ship 8 NUMA node ARM64 systems today.?? Things will get more
>>>>interesting as CXL and CCIX enter the market on ARM systems,
>>>>given chances are every CXL device will look like another NUMA
>>>>node (CXL spec says they should be presented as such) and you
>>>>may be able to rack up lots of them.
>>>>
>>>>So I'd argue minimum that makes sense today is 16 nodes, but 
>>>>looking forward
>>>>even a little and 64 is not a great stretch.
>>>>I'd make the jump to 64 so we can forget about this again for a 
>>>>year or two.
>>>>People will want to run today's distros on these new machines and we'd
>>>>rather not have to go around all the distros asking them to 
>>>>carry a patch
>>>>increasing this count (I assume they are already carrying such a patch
>>>>due to those 8 node systems)
>>
>>To echo Jonathan's statement above we are looking at systems that will
>>need approximately 64 NUMA nodes over the next 5-6 years - the time for
>>which an LTS kernel would be maintained. Some of the reason's for
>>increasing NUMA nodes during this time period include CXL, CCIX and
>>NVDIMM (like Jonathan pointed out).
>>
>>The main argument against increasing the NODES_SHIFT seems to be a
>>concern that it negatively impacts other ARM64 systems. Could anyone
>>share what kind of systems we are talking about? For a system that has
>>NEED_MULTIPLE_NODES set, would the impact be noticeable?
>
>Systems like the ESPRESSObin - sure, sane people aren't trying to run 
>desktops or development environments in 1GB of RAM, but it's not 
>uncommon for them to use a minimal headless install of their favourite 
>generic arm64 distro rather than something more "embedded" like 
>OpenWrt or Armbian. Increasing a generic kernel's memory footprint 
>(and perhaps more importantly, cache footprint) more than necessary is 
>going to have *some* impact.
>

Ampere’s platforms support multiple NUMA configuration options to meet
different customer requirements. Multiple configurations have more than
4 (currrent default) NUMA nodes. These fail to initialize NUMA with the
following errors in dmesg:

[ 0.000000] ACPI: SRAT: Too many proximity domains.
[ 0.000000] ACPI: SRAT: SRAT not used.

[ 0.000000] SRAT: Invalid NUMA node -1 in ITS affinity
[ 0.000000] SRAT: Invalid NUMA node -1 in ITS affinity

If we look at the forecast for the next LTS kernel lifetime, the number
of NUMA nodes will increase significantly due to SOCs with significantly
higher core counts, increased number of memory channels, and new devices
such as CCIX attached memory, etc. Supporting these platforms with a
default kernel config will require a minimum NODES_SHIFT value = 6.

Vanshi

>Robin.
>
>>
>>Vanshi
>>
>>>
>>>Nit: I doubt any sane distro is going to carry a patch to adjust 
>>>the *default* value of a Kconfig option. They might tune the 
>>>actual value in their config, but, well, isn't that the whole 
>>>point of configs? ;)
>>>
>>>Robin.
>>>
>>>>
>>>>Jonathan
>>>>
>>>>>
>>>>>>>?????????? depends on NEED_MULTIPLE_NODES
>>>>>>>?????????? help
>>>>>>>?????????????? Specify the maximum number of NUMA Nodes 
>>>>>>>available on the target
>>>>>
>>>>>_______________________________________________
>>>>>linux-arm-kernel mailing list
>>>>>linux-arm-kernel@lists.infradead.org
>>>>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
>>>>
>>>>
>>>>_______________________________________________
>>>>linux-arm-kernel mailing list
>>>>linux-arm-kernel@lists.infradead.org
>>>>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>>
