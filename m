Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187FC1AD50D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 06:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDQEGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 00:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgDQEGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 00:06:47 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C772321D93;
        Fri, 17 Apr 2020 04:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587096407;
        bh=Ox+92WObcJunp5pe05700XTqNPVCEcZ9XiB7PoMy0Tc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QY7ZU/+JVxuT2+vH/epQoI3Nw4QIVGsEgVwexZzpUIVeCl6hpubioHP9oR74gcb42
         J1FpGvATJx+EGzI4rv2eMbjBISoyvIVfXOAaSaKV7uL+V6KcMVSBDwQMMtgCK4cJz1
         AvgNYBimV4WNZVsQfXSLzqxwE6GXL3J2t/S1JbUI=
Date:   Thu, 16 Apr 2020 21:06:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang\, Ying" <ying.huang@intel.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mm: swap: properly update readahead statistics in
 unuse_pte_range()
Message-Id: <20200416210646.774bae8c321e3a44d6ffa8c3@linux-foundation.org>
In-Reply-To: <871romvmrh.fsf@yhuang-dev.intel.com>
References: <20200416180132.GB3352@xps-13>
        <871romvmrh.fsf@yhuang-dev.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 11:01:22 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:

> Andrea Righi <andrea.righi@canonical.com> writes:
> 
> > In unuse_pte_range() we blindly swap-in pages without checking if the
> > swap entry is already present in the swap cache.
> >
> > By doing this, the hit/miss ratio used by the swap readahead heuristic
> > is not properly updated and this leads to non-optimal performance during
> > swapoff.
> 
> It's more important to describe why we need this patch in the patch
> description.  So, please add some information about your use case.  And
> please focus on the technical part instead of the business part.

Confused.  I thought the changelog was quite good.  If "business part"
means "end user effect of the patch" then that's a very important
thing.

> Thanks!  But you don't need to do this.  You can add my Reviewed-by after
> we have finished the work on patch description.

Can you be more specific about how you want this changed?
