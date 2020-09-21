Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EADA2730FD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIURnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbgIURnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:43:20 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3932C20BED;
        Mon, 21 Sep 2020 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600710200;
        bh=cKsg3hVBq8JmOrVbzOqJFlMVUVoBqKhQpJuOU8riZ5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bZyYgvBmKfZafOxEhG2K4ORoS3NEEMdspfjYl1vEVg3HOT6ZU9h9MfGFZSDDW6Woi
         gAJqaHEVxKi6HKTncc3Vct29nwp2hQYwT44hPDj2RpazfmZ3W4XyakP/Nh/plx2jvJ
         LTo1ntQ9HIOiZEeW5jyZgK/OaeoGYlyNg2F6E9mE=
Date:   Mon, 21 Sep 2020 18:43:15 +0100
From:   Will Deacon <will@kernel.org>
To:     sudaraja@codeaurora.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        pratikp@codeaurora.org
Subject: Re: [PATCH] arm64/mm: add fallback option to allocate virtually
 contiguous memory
Message-ID: <20200921174313.GA3141@willie-the-truck>
References: <01010174769e2b68-a6f3768e-aef8-43c7-b357-a8cb1e17d3eb-000000@us-west-2.amazonses.com>
 <b8c6e11f-00f3-a89c-6ebc-eef55f92298b@arm.com>
 <145c57a3-1753-3ff8-4353-3bf7bac0b7de@arm.com>
 <0101017479c7063b-aec9b77c-4f0f-41b6-84e6-f91a5ed1f3f6-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0101017479c7063b-aec9b77c-4f0f-41b6-84e6-f91a5ed1f3f6-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 08:48:40PM +0000, sudaraja@codeaurora.org wrote:
> On 2020-09-10 03:50, Anshuman Khandual wrote:
> > The proposed patch tried to mix both approaches. Regardless, the first
> > approach
> > here seems better and is the case in vmemmap_populate_hugepages()
> > implementation
> > on x86 as well.
> 
> The 1st approach looks more cleaner compared to bailing out in first
> failure, unmapping all previously mapped sections and map entire request
> with vmemmap_populate_basepages. Thanks for the review and suggestion - will
> send over a cleaner patch soon.

Did you send an updated version of this? The threading has gone wonky in
my mail client, so I may have missed it.

Will
