Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA81301A51
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbhAXHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 02:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbhAXHfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 02:35:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E537422CB9;
        Sun, 24 Jan 2021 07:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611473668;
        bh=l26cadTrzC6oT1xvBvVwDxUyuOKNwCRzA4NrTS5KmJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FxP/GSt6Nu/NaO08sLfRDvYXj8tVW5hBVmYO/tm7FebCncZoAwX4ExNTcimu1j35Z
         ns/okx4cRyvfmGdn1cYdNaAbZ5OWQgsU6xsnB2531nlb4fFNQqSawN4qZEm7k0ic4p
         XJbuKgUSwELlk1mqU/+R+3wtPN7/fVSYndf742xaE23TKnVgMkWyLTLppSY34WJLOK
         AWHImsMpxblrvI+l3JRYUR4nlZYmDWUF4vfUmZSpTEnUhlmBDUzvvfuhunjFc7qWto
         Uvhnp0vNuR7k2s8NX89kr7bv++Gz16fMI1fDltsqexgEzoeSu+KMsTWoIASbvhbPyg
         eniG0w7KGjlBA==
Date:   Sun, 24 Jan 2021 09:34:21 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, guro@fb.com,
        iamjoonsoo.kim@lge.com, Ram Pai <linuxram@us.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        mhocko@kernel.org, riel@surriel.com
Subject: Re: [PATCH v2 2/2] memblock: do not start bottom-up allocations with
 kernel_end
Message-ID: <20210124073421.GG6332@kernel.org>
References: <20201220064959.GB392325@kernel.org>
 <20210122043714.266075-1-bauerman@linux.ibm.com>
 <20210123180911.aafa8404a3a7a30779713456@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123180911.aafa8404a3a7a30779713456@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 06:09:11PM -0800, Andrew Morton wrote:
> On Fri, 22 Jan 2021 01:37:14 -0300 Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
> 
> > Mike Rapoport <rppt@kernel.org> writes:
> > 
> > > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > 
> > > Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > I've seen a couple of spurious triggers of the WARN_ONCE() removed by this
> > patch. This happens on some ppc64le bare metal (powernv) server machines with
> > CONFIG_SWIOTLB=y and crashkernel=4G, as described in a candidate patch I posted
> > to solve this issue in a different way:
> > 
> > https://lore.kernel.org/linuxppc-dev/20201218062103.76102-1-bauerman@linux.ibm.com/
> > 
> > Since this patch solves that problem, is it possible to include it in the next
> > feasible v5.11-rcX, with the following tag?
> 
> We could do this, if we're confident that this patch doesn't depend on
> [1/2] "mm: cma: allocate cma areas bottom-up"?  I think it is...

A think it does not depend on cma bottom-up allocation, it's rather the other
way around: without this CMA bottom-up allocation could fail with KASLR
enabled.

Still, this patch may need updates to the way x86 does early reservations:

https://lore.kernel.org/lkml/20210115083255.12744-1-rppt@kernel.org
 
> > Fixes: 8fabc623238e ("powerpc: Ensure that swiotlb buffer is allocated from low memory")
> 
> I added that.
> 
> 

-- 
Sincerely yours,
Mike.
