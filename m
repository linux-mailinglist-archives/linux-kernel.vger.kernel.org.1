Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620EF29CD41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 02:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgJ1BiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 21:38:21 -0400
Received: from mail-dm6nam11on2105.outbound.protection.outlook.com ([40.107.223.105]:41411
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1832985AbgJ0XO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 19:14:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YV6XbU09temU+jFg00LxREtnuJKbxaytN9xia97LAZxUj2P/VMkLS9616Uao+xv8IhZq3nb6KUYqnMV92J6xYYO9bKpnqnVNb2mDU593kQB3knUPdDkdJohiJIsMPpI9xi/4kZZuz1bg8u0LKM0Evnv1e7gbjow8osYzra2gWqXN0QQF9SXU5p6WJVmEyo5TdudHVDLzqLISCt0ahP6xE3zG4suGUyPrQVviPv5PN1NfnobiCJz19IoQ3eiE9CHNHDzKX9+63WP3WuDOqDoe1kknm/2onYD6TG6P2eDxEeV0GynVvMiVoYB0tUsGY2u8ZQPIjqB5M+RFUKXdzMyscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0B9QuemrK7VKucppd5eOnvwmKlGL5n5k2sGjSonyu8=;
 b=Vmo/QF6abXtZpylQZ6E6wfGPdJepuwJCwrNR+cm9/ZbeLEXwjOQjyQHDqiZBQ+yyzVXhu8GDhvqsWp1ZEpW5HamyG3PsngCblBRYLTPqzjpofEy7flpjFwOeN2Hw6FekkeF1LkJlNNkPymEbJ+P3sQ0cxS4jqsOOSpm2pDBHPNYtMS8+YAG2X80N4wZajNGx43gyqCgicWAas1J8UnS+/YcZUl2Iew4uI879EsrdSiuTvg1erq8huFgXOCwjyQxHWy4NSpTvL01YxbMGewy2jOIoLZKjtpG+pRjYwHqo6OkCugC0AJKAZlAMQ5VhQ21v9hMHFj7tS4FJ28/jUfj+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0B9QuemrK7VKucppd5eOnvwmKlGL5n5k2sGjSonyu8=;
 b=cRRZfYlTpjjhRlbkFNWmxJQPP1p12AvWPJJuBAH5XKHHZ4YqG+owf57wyX42EYkDr01FZ0eaqmuaW1nPQgsQln3qHlPdr6tanqOhFHntJgnTtAbO19ROC6RgSuQIMhoJQ0qVnOqbutlWWQ5RpsA6qLH5JDSTTqF9sLfLjHmSVU0=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN3PR01MB2050.prod.exchangelabs.com (2a01:111:e400:7bb7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.28; Tue, 27 Oct 2020 23:14:22 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 23:14:22 +0000
Date:   Tue, 27 Oct 2020 16:13:34 -0700
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
X-ClientProxiedBy: CY4PR01CA0008.prod.exchangelabs.com (2603:10b6:903:1f::18)
 To BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY4PR01CA0008.prod.exchangelabs.com (2603:10b6:903:1f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23 via Frontend Transport; Tue, 27 Oct 2020 23:14:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 776d66f1-0c75-43db-4664-08d87ace09af
X-MS-TrafficTypeDiagnostic: BN3PR01MB2050:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN3PR01MB205085785E581E39D34D4EDE9D160@BN3PR01MB2050.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tPrz96EZGv+zg5h/obxqy7OGI3OhnerSme32X//bQMqPfJ07PGvg+d+W5yxVVFmsk4IZzgNt2B05kr8wk7xB53IrAtccLzjzJViraA143W4t/aA95uCgQg8J/I6aHwy8j4Jf32Cv0fAjTGu7gsAOh9Gmsm9zHo95LFHmV4oH7lPeo/gvbDig9FS0+r+UD6QZaRSJjRe2WfD/3lL9YTsqQDLhaGSnD/PJTmZA11WDho2s1oN2j4AWsZcF+1Zmlbgs6UoOWyN7kFqUbN+MNjETow5oYyQ/zf5Bn6jVDNAhDt0onK+jjRb5ONUUFrar/r1g6TgdjNWSx2ACJlCh5V6cy75j90o/8lr1H5xnKceAKHUA+dsOz0bJubavqsc6OicVd2vDmPCVfgMRci7JazWgow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(39850400004)(396003)(1076003)(66556008)(6666004)(66946007)(66476007)(5660300002)(83380400001)(4001150100001)(26005)(956004)(6916009)(4326008)(6496006)(2906002)(9686003)(16526019)(8936002)(6486002)(8676002)(316002)(478600001)(54906003)(186003)(86362001)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FNSHD2jSev0Qc8pcDf3k7hIv6r5tnDGYWx8fgJ881NFDLivERmrqP5e/Xx7ZRv5k2t66/cabt9hb37CzX/Akrg19dR4zs0qkNeU10tFgmo/QYLsyH3DindnibaBQf7srtpnSYHeWUVHKu1hrJHPP5jaHpQMl1MI+96+SwchVlBSsy3XV0JWrIh5ANywKEvqiUbUEx9klUHzRVhv8pIiN7sTs4NU2m3fybxHhQMk793lHGbuer4zuYLdVq002UDlOryPZqI0TGWV5M10RbFnoXyGdoX+vgmSQKHSSsX+StjvyY98hpAqXwmTKzFrGmsfvH/QPdZoug5eLBtGvvfftyWMyRpRSuH6PegGEj+LP5UUpzgLQP/rv7cRi/kq8HbXbiyBWrJez+N9eUDLDSNVOT8CxPLV5TWJUHbEqf5SbWNtbTBFGoxnOEUEZmML2MkMnYOkhaKWFhVj6r0RBaZavqYq+zKHXgF+JDg7pS1Vt0cjFasSgMvjvUOtcUhiJxFWcxZWQHZdQ8SWhn3xZM8HqiUFua4vzEn8iTNG9hU0YHPKYWamkq2JnYfL1/+jsV1OIvV1z9Ppdtk6pjtwdNBLChIAzKyY5K/F8rv1Cd5peL5Xpxv9P3uscGNgfkdK4QU/RUbcCRk649JNVFmAAaCQkfg==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776d66f1-0c75-43db-4664-08d87ace09af
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 23:14:22.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njCCDqULwRW7oPMM6UIwwIjFOZjJMFvMsci/gdIi2vtnEl0neIF02W+9cB/4szl3gykuO4Zec+OO3qoP8CIUx1VoqZ+mk6eW/koacMIIAWZcmPXnesriEBk8ggMDqTkb
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
