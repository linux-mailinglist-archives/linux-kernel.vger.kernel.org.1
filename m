Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B52C2ED2EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbhAGOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbhAGOlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:41:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBB6C22EBF;
        Thu,  7 Jan 2021 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610030455;
        bh=7xoap/F3JQH2zdQsxbhjQZFUy8PtJsSlYU5ujJ5re/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4wQO1s3j6VY3fYuP2lfIcRxjVy/Hq9nglrO4dstJOWHliufituRvbOMyEKC3VKOO
         FALFeX2v3Uq8zhORbR+tXXwLi2UAruT572SCKW9i7MwstPDqCKLe2WEAz3JbWMl9f0
         81xVdHhntoR2cpbtLNMlstavXdbCkzf7vZCFAOI+d+TBKsf32RQkja0DVJyTbXPWqJ
         EJh8kwMpsXZNDdoOunw+kZoKKY3KL7+ZoAyvKqiBoHdmmX78/WEQq+16f2jXaahOJZ
         NwPEKY5T5BZSkk04Z3mCVlUUWSZHJMgYtYv0T6OkwC38sUHIEm5ESf2clVEtR/JRHJ
         jtdX2Eo6X9fXA==
Date:   Thu, 7 Jan 2021 14:40:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iommu/vt-d: Remove unused dma map/unmap trace events
Message-ID: <20210107144049.GB3413@willie-the-truck>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-3-baolu.lu@linux.intel.com>
 <20210105190443.GB12182@willie-the-truck>
 <8bf33c93-3154-e832-1197-891c684d6ded@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bf33c93-3154-e832-1197-891c684d6ded@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 09:14:22AM +0800, Lu Baolu wrote:
> On 2021/1/6 3:04, Will Deacon wrote:
> > On Thu, Dec 31, 2020 at 08:53:21AM +0800, Lu Baolu wrote:
> > > With commit c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to
> > > the iommu ops"), the trace events for dma map/unmap have no users any
> > > more. Remove them so that they don't show up under
> > > /sys/kernel/debug/tracing/events/intel_iommu. The users should use the
> > > map/unmap traces defined in the iommu core from now on.
> > > 
> > > Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >   include/trace/events/intel_iommu.h | 119 -----------------------------
> > >   1 file changed, 119 deletions(-)
> > 
> > Is this needed in 5.11, or can it wait until 5.12?
> 
> It's necessary for 5.11 as far as I can see. Without this, users still
> see the events under /sys/kernel/debug/tracing/events/intel_iommu, but
> they will get nothing traced even they enable the events.

I'm just a bit wary about breaking userspace by removing them altogether,
although I see that there's plenty of precedent for removing events from
the include/trace/events directory, so it's probably fine.

However, the patch as-is results in this warning for me:

 | In file included from include/trace/define_trace.h:102,
 |                  from include/trace/events/intel_iommu.h:22,
 |                  from drivers/iommu/intel/trace.c:14:
 | include/trace/trace_events.h:27:23: warning: ‘str__intel_iommu__trace_system_name’ defined but not used [-Wunused-const-variable=]
 |    27 | #define __app__(x, y) str__##x##y
 |       |                       ^~~~~
 | include/trace/trace_events.h:28:21: note: in expansion of macro ‘__app__’
 |    28 | #define __app(x, y) __app__(x, y)
 |       |                     ^~~~~~~
 | include/trace/trace_events.h:30:29: note: in expansion of macro ‘__app’
 |    30 | #define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
 |       |                             ^~~~~
 | include/trace/trace_events.h:33:20: note: in expansion of macro ‘TRACE_SYSTEM_STRING’
 |    33 |  static const char TRACE_SYSTEM_STRING[] = \
 |       |                    ^~~~~~~~~~~~~~~~~~~
 | include/trace/trace_events.h:36:1: note: in expansion of macro ‘TRACE_MAKE_SYSTEM_STR’
 |    36 | TRACE_MAKE_SYSTEM_STR();
 |       | ^~~~~~~~~~~~~~~~~~~~~

so I'll drop this for now.

Will
