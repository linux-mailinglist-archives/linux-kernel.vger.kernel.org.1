Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F041D294AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438452AbgJUJ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 05:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729186AbgJUJ70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:59:26 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F0222249;
        Wed, 21 Oct 2020 09:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603274366;
        bh=MAH0XRQtjfZwS2Dn85ZjU5QPcr2ZcO3BIM+nhQ2YwdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvH6h2TVgrqn6OsXXzJ6TotS8CU4lDHK35VHuo3aEmgpbN9py8rSAb8gJVCswIEdx
         XvjlZQAQ11eaRQA2Y79pocpfFSQ1m+vLeOJUqfealt4XBY3b+jZJFzGSg0g0x3Zz+e
         udcPetTCoHVj1oUp6OUMhcKBL478LFcfGmIdhLxg=
Date:   Wed, 21 Oct 2020 12:54:28 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/2] mm/memory_hotplug: allow marking of memory sections
 as hotpluggable
Message-ID: <20201021095428.GB392079@kernel.org>
References: <cover.1602899443.git.sudaraja@codeaurora.org>
 <2cba881c51e42cfe5ba213e09273642136e8ef93.1602899443.git.sudaraja@codeaurora.org>
 <20201017082600.GB16395@kernel.org>
 <51333360-bcf6-0d21-923c-ce8aca4c8719@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51333360-bcf6-0d21-923c-ce8aca4c8719@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 11:36:39AM +0200, David Hildenbrand wrote:
> On 17.10.20 10:26, Mike Rapoport wrote:
> > On Fri, Oct 16, 2020 at 07:02:23PM -0700, Sudarshan Rajagopalan wrote:
> >> Certain architectures such as arm64 doesn't allow boot memory to be
> >> offlined and removed. Distinguish certain memory sections as
> >> "hotpluggable" which can be marked by module drivers stating to memory
> >> hotplug layer that these sections can be offlined and then removed.
> > 
> > I don't quite follow why marking sections as hotpluggable or not should
> > be done by a device driver. Can you describe in more details your
> > use-case and why there is a need to add a flag to the memory map?
> > 
> 
> This seems to be related to
> 
> https://lkml.kernel.org/r/de8388df2fbc5a6a33aab95831ba7db4@codeaurora.org

Thanks for the pointer.

> After reading how the driver is trying to abuse memory hot(un)plug
> infrastructure, my tentative
> 
> Nacked-by: David Hildenbrand <david@redhat.com>

I also don't think we would want to let drivers play with the memory
map.

> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
