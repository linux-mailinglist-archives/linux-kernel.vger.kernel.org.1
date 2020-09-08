Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7F326112A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgIHMEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 08:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730076AbgIHL4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:56:11 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB9520936;
        Tue,  8 Sep 2020 11:32:13 +0000 (UTC)
Date:   Tue, 8 Sep 2020 12:32:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, akpm@linux-foundation.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic
 MM semantics
Message-ID: <20200908113210.GC25591@gaia>
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
 <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
 <20200903165631.GC31409@gaia>
 <b29e2bda-3299-e69f-90cf-1c9bd59a219d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29e2bda-3299-e69f-90cf-1c9bd59a219d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 03:48:08PM +0530, Anshuman Khandual wrote:
> On 09/03/2020 10:26 PM, Catalin Marinas wrote:
> > On Mon, Aug 17, 2020 at 02:49:43PM +0530, Anshuman Khandual wrote:
> >> pmd_present() and pmd_trans_huge() are expected to behave in the following
> >> manner during various phases of a given PMD. It is derived from a previous
> >> detailed discussion on this topic [1] and present THP documentation [2].
> >>
> >> pmd_present(pmd):
> >>
> >> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
> >> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
> > 
> > The second bullet doesn't make much sense. If you have a pmd mapping of
> > some I/O memory, pmd_present() still returns true (as does
> > pte_present()).
> 
> Derived this from an earlier discussion (https://lkml.org/lkml/2018/10/17/231)
> but current representation here might not be accurate.
> 
> Would this be any better ?
> 
> pmd_present(pmd):
> 
> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
> - Returns false if pmd refers to a migration or swap entry

Yes, that's better

-- 
Catalin
