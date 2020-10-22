Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7632962A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901649AbgJVQZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:25:33 -0400
Received: from mail-bn7nam10on2115.outbound.protection.outlook.com ([40.107.92.115]:53320
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2896970AbgJVQZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntIQUQXwb1zGXEpuwRJTTx1//nCCAYfETZAL05rqKMYzt8jueQqiykmwpn20smtEcIyuhEK2KLDlyUZ5fh8KtiLF5M+5D6VCwhcjZFpJ9KOL52TZDD6TASUGlkqpC+1+VV46RiHV34/oOWitNQLU3miftmqFSJGU9XJpX0eVCzU/zL6PX83B3oCHtikGV6mV2swJL2nHQ9S96hqAu6sheEHwZPb0shTdfePCO5wQ79z2/gC/JTZ/rVvQ+/lOBgIHPifBjjTqCWdeGbRRb2g0h777vpTaa9FnNDW6kothAHhOIE3a9SKW+l7VB7jauGgieelIHgXL/wYnnqJShmYyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1fqnPLi1b7bKZslhxT3WhpgQjMRm5x3YjlBWCfNRnE=;
 b=TjxoTtCOBRpEke3nSLkkPK+5tkIITaQmlc5LwrRW2HNwcjg1xv+8TA9Qu0JJed9E4z5c0zwlQ/Y1vMnhx82yBABXgebGN0yr2iMFqMzy9kM7Xa2PahDYcDvAJvhcWNr4ASM6nZEwmq6EE9luYsFmRhqJggKWM8HLtf/73xmEXYI5as9A/FYiDqEfOBck+PXD9sbDju2xMyqpOj2zW5bS5+ftOOLgJuoatXKvUGdmHsi92U2t3467LIG40hlsbsVq9r+vybyEV9A2Ay5mcHOVe2HhVclnluF3Qr3DM6aDeiWVlzhUQUtWo45aU0umf/4jfhqHg3kiNoi/JqI20odayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1fqnPLi1b7bKZslhxT3WhpgQjMRm5x3YjlBWCfNRnE=;
 b=Y7VJjgjinLKt8XQlkEU6i23SKD8qq4nX14S6pJV29Oh9IurlCCOvN0YheTqSP8NfJqqjqEp71HkUwfp/xhezyrIYHmcSjMNW9JC6kaAe6z+gXx6ZiC+GhI/cIU6IASJijWAR2Ep9vHY5Z0K7pc2Etef3UkOV3HlAX5++c78WdUo=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BN6PR01MB2468.prod.exchangelabs.com (2603:10b6:404:53::8) by
 BN8PR01MB5377.prod.exchangelabs.com (2603:10b6:408:be::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23; Thu, 22 Oct 2020 16:25:28 +0000
Received: from BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3]) by BN6PR01MB2468.prod.exchangelabs.com
 ([fe80::4946:4492:370a:a3f3%9]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 16:25:27 +0000
Date:   Thu, 22 Oct 2020 09:25:24 -0700
From:   Vanshi Konda <vanshikonda@os.amperecomputing.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Message-ID: <20201022162501.53ck5jl3zx6iywuv@con01sys-r111.scc-lab.amperecomputing.com>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
 <jhj7drkrcpr.mognet@arm.com>
 <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
 <20201021110201.00002092@Huawei.com>
 <da1b140c-fdd9-5970-fe83-02f33c3d8251@arm.com>
 <20201022010718.5jkrcyvoae56vdd5@con01sys-r111.scc-lab.amperecomputing.com>
 <3d539f31-5fa9-b6c5-b25a-3e6bd3ae660e@arm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3d539f31-5fa9-b6c5-b25a-3e6bd3ae660e@arm.com>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY1PR07CA0041.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::51) To BN6PR01MB2468.prod.exchangelabs.com
 (2603:10b6:404:53::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amperecomputing.com (4.28.12.214) by CY1PR07CA0041.namprd07.prod.outlook.com (2a01:111:e400:c60a::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 16:25:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ec4e619-6f2d-4e06-8dad-08d876a715ca
X-MS-TrafficTypeDiagnostic: BN8PR01MB5377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR01MB53774F8B9F0333C7BA8F951B9D1D0@BN8PR01MB5377.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WcQ63uU/N6VeEMDLW1NeRrAcg8lN9KHnaDYau77234IZLzKIeOV32qAMQOOjywTPm4HtDBuPg8jP4dcI4/Ansso0LpVO9nuCoSbVWqeRKVJrI+v9VSC+zN6kPUbWgwCDWKrk2f9r06ch+P7eAsaPTawqIzWaS4I0AY9eXlYdLGce5RKGK3RjqHpNxhbIesCDpnVJG/twumXhFQRkZpSIm7jYYNK2gD1M61h2dm4qS9OLXNLgUDUFmVtXdNn147drZ7fB459fhwavsWlIEHcCcqB45tSgC19SuUxuQYN55XoB1wHe+v2tFwKbz2vjSey8RGYwW1awvp7wJ1xTCN35llyiGSb42eJb3tM8rgN7ad+3fgWqmR3hygz1qKc0InWuYHJNlczyumpALagTy/wPTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR01MB2468.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(136003)(396003)(376002)(346002)(86362001)(54906003)(52116002)(83380400001)(66946007)(9686003)(186003)(8676002)(16526019)(26005)(6916009)(66556008)(66476007)(4001150100001)(478600001)(8936002)(2906002)(5660300002)(316002)(6486002)(1076003)(956004)(8886007)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: yEDW5mhDRvJ5p8b0P9SNeUW+Hs+iXUknLAvhi8ArVa2lZOgosL3Nh32P3kuEPdlvBObwhYIHvxO1HHH3g6zoJKiBgHdVHtLo7XzNh25cvfnGOLu9c3eZ9bNF7HoLoaeGQswgaiBvDGek+nxtJmuZ7srr6umh1+vPeFrx5P2JOYHbiv+cPGIjlDGoupbPO0PAKALVNuIm2KqC/Sp/BCnMh7g+DlHlFZuTuuTvDLh/U4iF+REY4s+cwXvdhzyIvZGyZA5EolnVRiH2+pGh7+DiXBT07b801J/hBcxU+3JuqOMLuT/zEdmEel2L39Eeel5TCOv85eLOuWmjIUsLFQu4p1uI7ci9favhubZrRxf4yLJKgx7QJBi+RNsP4EvHy6CVb/VtdCuDqopvjICq/3p3gwy5Q8KUkfuP5rTpRb4ykD+yQlqbzGLDYuKFyK4KqcPQMdLxvv7nZlvisCjISTZsKMG2gYJ3sbY+Rr+Z/4+g6NMsyNASgE3mzagND/Ppp+I74dPJUr67TvKV7Pgrg/BJqSLihalGSz/4kWISFUbWWA/iUTvgkvsV0rArOT/ft7Ium7PZVg466uIfhrWqAxJwkL1xtmeXPTDVLeTXINvrZU0CtTe3NKYHan9beKTafwjco3EsE8TWVZfRDRQH/7uIUw==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec4e619-6f2d-4e06-8dad-08d876a715ca
X-MS-Exchange-CrossTenant-AuthSource: BN6PR01MB2468.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 16:25:27.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zGi+33HUVb9agsMj9PP+ZDeh9QkwxRCOie5pejUbQ95JbCe8SMLLOkxgN2WenyDCWB+Lwgq8IrDQ4mYge0TK8NCa+xgpyBDUmYZ9HoCdSuqRGAxPPz5OGwrMx4SI3EE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR01MB5377
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

If someone is running a generic arm64 distro, at least some of them are
already paying the extra cost. NODES_SHIFT for Ubuntu and SuSE kernels
is already 6. CentOS/Redhat and Oracle Linux set it to 3. I've only seen
Debian set it to 2.

Vanshi

>OpenWrt or Armbian. Increasing a generic kernel's memory footprint 
>(and perhaps more importantly, cache footprint) more than necessary is 
>going to have *some* impact.
>
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
