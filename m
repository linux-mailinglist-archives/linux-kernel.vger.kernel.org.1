Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B8277E46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 04:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIYC7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 22:59:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgIYC7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:59:16 -0400
Received: from X1 (unknown [104.245.68.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DC620838;
        Fri, 25 Sep 2020 02:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601002755;
        bh=HlyAAdYR9wyHbMonermc2egT8gBMGqZa8uXyB8IhXjU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F5JoiH8AKJ04sDI6xltJ+S5/vIuoZ5y0YVdFce44I1ipKaIvaAksqmplesJ3DHsNm
         orqNUbtTJo2z9rY2GduEN63JeYOl4xlHV09v4dEtYTK1TyEKk02AI8jKbNd9c7/E+V
         m6QdEhN2hXLtO9lQ9kYvbD2v1IVCtSvvSTKvU8go=
Date:   Thu, 24 Sep 2020 19:59:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-Id: <20200924195914.d240877a10e22b457bd9b45d@linux-foundation.org>
In-Reply-To: <20200923134251.GN795820@optiplex-lnx>
References: <20200922184838.978540-1-aquini@redhat.com>
        <20200922124750.67a20d9764ec098b17705407@linux-foundation.org>
        <20200923134251.GN795820@optiplex-lnx>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 09:42:51 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> On Tue, Sep 22, 2020 at 12:47:50PM -0700, Andrew Morton wrote:
> > On Tue, 22 Sep 2020 14:48:38 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > > The swap area descriptor only gets struct swap_cluster_info *cluster_info
> > > allocated if the swapfile is backed by non-rotational storage.
> > > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
> > > will naturally return NULL.
> > > 
> > > CONFIG_THP_SWAP exposes cluster_info infrastructure to a broader number of
> > > use cases, and split_swap_cluster(), which is the counterpart of split_huge_page()
> > > for the THPs in the swapcache, misses checking the return of lock_cluster before
> > > operating on the cluster_info pointer.
> > > 
> > > This patch addresses that issue by adding a proper check for the pointer
> > > not being NULL in the wrappers cluster_{is,clear}_huge(), in order to avoid
> > > crashes similar to the one below:
> > > 
> > > ...
> > >
> > > Fixes: 59807685a7e77 ("mm, THP, swap: support splitting THP for THP swap out")
> > > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > 
> > Did you consider cc:stable?
> >
> 
> UGH! I missed adding it to my cc list. Shall I just forward it, now, or
> do you prefer a fresh repost?

I added the cc:stable to my copy.
