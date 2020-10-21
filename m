Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C02294B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441858AbgJULEB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Oct 2020 07:04:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2997 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439261AbgJULEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:04:00 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 4D152331F30F320DC73;
        Wed, 21 Oct 2020 12:03:59 +0100 (IST)
Received: from localhost (10.52.124.50) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 21 Oct
 2020 12:03:58 +0100
Date:   Wed, 21 Oct 2020 12:02:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     Valentin Schneider <valentin.schneider@arm.com>,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        <patches@amperecomputing.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: NUMA: Kconfig: Increase max number of nodes
Message-ID: <20201021110201.00002092@Huawei.com>
In-Reply-To: <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
References: <20201020173409.1266576-1-vanshikonda@os.amperecomputing.com>
        <jhj7drkrcpr.mognet@arm.com>
        <9e14c0d3-9204-fb32-31db-5b3f98639cba@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.124.50]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 09:43:21 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> On 10/20/2020 11:39 PM, Valentin Schneider wrote:
> > 
> > Hi,
> > 
> > Nit on the subject: this only increases the default, the max is still 2¹⁰.  
> 
> Agreed.
> 
> > 
> > On 20/10/20 18:34, Vanshidhar Konda wrote:  
> >> The current arm64 max NUMA nodes default to 4. Today's arm64 systems can
> >> reach or exceed 16. Increase the number to 64 (matching x86_64).
> >>
> >> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> >> ---
> >>  arch/arm64/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 893130ce1626..3e69d3c981be 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -980,7 +980,7 @@ config NUMA
> >>  config NODES_SHIFT
> >>       int "Maximum NUMA Nodes (as a power of 2)"
> >>       range 1 10
> >> -	default "2"
> >> +	default "6"  
> > 
> > This leads to more statically allocated memory for things like node to CPU
> > maps (see uses of MAX_NUMNODES), but that shouldn't be too much of an
> > issue.  
> 
> The smaller systems should not be required to waste those memory in
> a default case, unless there is a real and available larger system
> with those increased nodes.
> 
> > 
> > AIUI this also directly correlates to how many more page->flags bits are
> > required: are we sure the max 10 works on any aarch64 platform? I'm  
> 
> We will have to test that. Besides 256 (2 ^ 8) is the first threshold
> to be crossed here.
> 
> > genuinely asking here, given that I'm mostly a stranger to the mm
> > world. The default should be something we're somewhat confident works
> > everywhere.  
> 
> Agreed. Do we really need to match X86 right now ? Do we really have
> systems that has 64 nodes ? We should not increase the default node
> value and then try to solve some new problems, when there might not
> be any system which could even use that. I would suggest increase
> NODES_SHIFT value upto as required by a real and available system.

I'm not going to give precise numbers on near future systems but it is public
that we ship 8 NUMA node ARM64 systems today.  Things will get more
interesting as CXL and CCIX enter the market on ARM systems,
given chances are every CXL device will look like another NUMA
node (CXL spec says they should be presented as such) and you
may be able to rack up lots of them.

So I'd argue minimum that makes sense today is 16 nodes, but looking forward
even a little and 64 is not a great stretch.
I'd make the jump to 64 so we can forget about this again for a year or two.
People will want to run today's distros on these new machines and we'd
rather not have to go around all the distros asking them to carry a patch
increasing this count (I assume they are already carrying such a patch
due to those 8 node systems)

Jonathan

> 
> >   
> >>       depends on NEED_MULTIPLE_NODES
> >>       help
> >>         Specify the maximum number of NUMA Nodes available on the target  
> >  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


