Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C80277E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgIYDKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgIYDKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:10:35 -0400
Received: from X1 (unknown [104.245.68.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D417206C1;
        Fri, 25 Sep 2020 03:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601003434;
        bh=Ds+x7kGYL6Aj7LMGPrjmzDsE6gk5ChKlSYdVj+ut8w0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jYwOpAwVfVctDlpMmjnjRUplgtiMt4mV/5scgwfkjbJ6Bo5ZjwM6v7bL0dquOqNJl
         cMP1JYdzy0PkLqhIbfblhX1qQY3EeW4keEDOoQtxsxTtwT6gF6md8ZIWvyY794zHBX
         tDCtAsNRAAu2pViXvPTs3EYpcv9VqpkEdfxURzr4=
Date:   Thu, 24 Sep 2020 20:10:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang\, Ying" <ying.huang@intel.com>
Cc:     Rafael Aquini <aquini@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-Id: <20200924201033.64e22c2915a8f2be3aacd97f@linux-foundation.org>
In-Reply-To: <87v9g2blma.fsf@yhuang-dev.intel.com>
References: <20200922184838.978540-1-aquini@redhat.com>
        <20200922124750.67a20d9764ec098b17705407@linux-foundation.org>
        <20200923134251.GN795820@optiplex-lnx>
        <20200924195914.d240877a10e22b457bd9b45d@linux-foundation.org>
        <87v9g2blma.fsf@yhuang-dev.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 11:06:53 +0800 "Huang\, Ying" <ying.huang@intel.com> wrote:

> >> UGH! I missed adding it to my cc list. Shall I just forward it, now, or
> >> do you prefer a fresh repost?
> >
> > I added the cc:stable to my copy.
> 
> Please don't merge this patch.  This patch doesn't fix the bug, but hide
> the real bug.  I will work with Rafael on root causing and fixing.

Yup, I saw the discussion and have put the patch on hold pending
the outcome.
