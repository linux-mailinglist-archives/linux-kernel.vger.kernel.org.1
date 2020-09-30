Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03027E2DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgI3Hqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:46:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgI3Hqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:46:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70B59ACE3;
        Wed, 30 Sep 2020 07:46:48 +0000 (UTC)
Date:   Wed, 30 Sep 2020 09:46:46 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2] mm/vmstat: Add events for HugeTLB migration
Message-ID: <20200930074639.GA26786@linux>
References: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601445649-22163-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:30:49AM +0530, Anshuman Khandual wrote:
> -			is_thp = PageTransHuge(page) && !PageHuge(page);
> -			nr_subpages = thp_nr_pages(page);
> +			is_thp = false;
> +			is_hugetlb = false;
> +			if (PageTransHuge(page)) {
> +				if (PageHuge(page))
> +					is_hugetlb = true;
> +				else
> +					is_thp = true;
> +			}

Since PageHuge only returns true for hugetlb pages, I think the following is
more simple?

	if (PageHuge(page))
		is_hugetlb = true;
	else if (PageTransHuge(page))
		is_thp = true


Besides that, it looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
