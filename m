Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72D32758EF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIWNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600868579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rcX1qrdKwUJLaB/VAH3GKYW4wyrkh2TnZ9mJwzftRZQ=;
        b=cLiwIDQ0n0dAaoEUSrviTZwe7TI16RP9bZZ40uNnWlS7/MdvS+rwV/NJi4y7S9yUykmwjB
        K+/MoyBzep7/fa/75FjLxhi4jEPO9+brOYeUb7UnvzKyjXwgcXdJ4+nnzaUmEq7HvqzA83
        dX5za1x+fMWBh0GDIy7A/QNfDm7nybw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-OSEAoOHIO4OLe5nfUYTYlA-1; Wed, 23 Sep 2020 09:42:56 -0400
X-MC-Unique: OSEAoOHIO4OLe5nfUYTYlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F2E0640A8;
        Wed, 23 Sep 2020 13:42:55 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67A3160BEC;
        Wed, 23 Sep 2020 13:42:54 +0000 (UTC)
Date:   Wed, 23 Sep 2020 09:42:51 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-ID: <20200923134251.GN795820@optiplex-lnx>
References: <20200922184838.978540-1-aquini@redhat.com>
 <20200922124750.67a20d9764ec098b17705407@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922124750.67a20d9764ec098b17705407@linux-foundation.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:47:50PM -0700, Andrew Morton wrote:
> On Tue, 22 Sep 2020 14:48:38 -0400 Rafael Aquini <aquini@redhat.com> wrote:
> 
> > The swap area descriptor only gets struct swap_cluster_info *cluster_info
> > allocated if the swapfile is backed by non-rotational storage.
> > When the swap area is laid on top of ordinary disk spindles, lock_cluster()
> > will naturally return NULL.
> > 
> > CONFIG_THP_SWAP exposes cluster_info infrastructure to a broader number of
> > use cases, and split_swap_cluster(), which is the counterpart of split_huge_page()
> > for the THPs in the swapcache, misses checking the return of lock_cluster before
> > operating on the cluster_info pointer.
> > 
> > This patch addresses that issue by adding a proper check for the pointer
> > not being NULL in the wrappers cluster_{is,clear}_huge(), in order to avoid
> > crashes similar to the one below:
> > 
> > ...
> >
> > Fixes: 59807685a7e77 ("mm, THP, swap: support splitting THP for THP swap out")
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> 
> Did you consider cc:stable?
>

UGH! I missed adding it to my cc list. Shall I just forward it, now, or
do you prefer a fresh repost?

 

