Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F653304150
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405826AbhAZPBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 10:01:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:57378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391681AbhAZPBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:01:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611673229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c+5YKS0svuQQeOzhA6HYPOjpNIFBWkPSoaZk/8ICdxs=;
        b=IoG1jC9tMwehf1Cs0lMjSzV4qcgYwo9JvHFp4bV/9A4XTGn0l+xA1ZWE8EJ+VUpVnJr8Bc
        XEF9/t2kuFBiFlu4V5dqGaHmvqCBlLUOwsdbdTE2gQuqxT4oUMvjMTvTTOp6sHgZcDTAyK
        09YSdJJAoVx/nyrrf9g4rRWvB68rshQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31137AB9F;
        Tue, 26 Jan 2021 15:00:29 +0000 (UTC)
Date:   Tue, 26 Jan 2021 16:00:16 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony <tony.luck@intel.com>, Tim C Chen <tim.c.chen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Du, Julie" <julie.du@intel.com>
Subject: Re: Test report for kernel direct mapping performance
Message-ID: <20210126150016.GT827@dhcp22.suse.cz>
References: <213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <213b4567-46ce-f116-9cdf-bbd0c884eb3c@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-01-21 15:23:07, Xing Zhengjun wrote:
> Hi,
> 
> There is currently a bit of a debate about the kernel direct map. Does using
> 2M/1G pages aggressively for the kernel direct map help performance? Or, is
> it an old optimization which is not as helpful on modern CPUs as it was in
> the old days? What is the penalty of a kernel feature that heavily demotes
> this mapping from larger to smaller pages? We did a set of runs with 1G and
> 2M pages enabled /disabled and saw the changes.
> 
> [Conclusions]
> 
> Assuming that this was a good representative set of workloads and that the
> data are good, for server usage, we conclude that the existing aggressive
> use of 1G mappings is a good choice since it represents the best in a
> plurality of the workloads. However, in a *majority* of cases, another
> mapping size (2M or 4k) potentially offers a performance improvement. This
> leads us to conclude that although 1G mappings are a good default choice,
> there is no compelling evidence that it must be the only choice, or that
> folks deriving benefits (like hardening) from smaller mapping sizes should
> avoid the smaller mapping sizes.

Thanks for conducting these tests! This is definitely useful and quite
honestly I would have expected a much more noticeable differences.
Please note that I am not really deep into benchmarking but one thing
that popped in my mind was whethere these (micro)benchmarks are really
representative workloads. Some of them tend to be rather narrow in
executed code paths or data structures used AFAIU. Is it possible they
simply didn't generate sufficient TLB pressure?

Have you tried to look closer on profiles of respective configurations
where the overhead comes from?
-- 
Michal Hocko
SUSE Labs
