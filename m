Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091352A63DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKDMHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:07:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDMHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:07:00 -0500
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9B621734;
        Wed,  4 Nov 2020 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604491619;
        bh=duO1j2GGcQwevtBQUg8hBjbl0GtrzLAe1ZI9BqgVsxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eD89QmjZS7Bhb45LPDsNVTa4M6Lrt1nokstBxIOs5ZmPG9N4cbuMHN0DRZsPKkx2L
         OdwqGkhjrJ6WVz2H3idePpfpYx9n1cBBpsxJDMgxfvnGLZndLM6eqoSOdGTKabWkBk
         58XHdmB3TudbGRqfdtIz7zg4vR0uya8vePLxMXVA=
Date:   Wed, 4 Nov 2020 14:06:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     osalvador <osalvador@suse.de>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 3/4] powerpc/mm: remove linear mapping if
 __add_pages() fails in arch_add_memory()
Message-ID: <20201104120651.GQ4879@kernel.org>
References: <20201029162718.29910-1-david@redhat.com>
 <20201029162718.29910-4-david@redhat.com>
 <20201104095007.GB4981@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104095007.GB4981@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:50:07AM +0100, osalvador wrote:
> On Thu, Oct 29, 2020 at 05:27:17PM +0100, David Hildenbrand wrote:
> > Let's revert what we did in case seomthing goes wrong and we return an
> > error.
> 
> Dumb question, but should not we do this for other arches as well?

It seems arm64 and s390 already do that. 
x86 could have its arch_add_memory() improved though :)

> -- 
> Oscar Salvador
> SUSE L3

-- 
Sincerely yours,
Mike.
