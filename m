Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA5274973
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:47:51 -0400
Received: from X1 (unknown [216.241.194.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F396520888;
        Tue, 22 Sep 2020 19:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600804071;
        bh=MqlXCLEZquChpaBvVYye8Wj9L6hvnijd7TNDRmPo42U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m2iYWrQa06vGlD6u9Pxv1j23pQGigrIJ6W9hx/BIbyOUnxz/oLVWjrqbYF5VButKN
         e8+dXDDxntZ68M5Tb/r8309LZYt1Yg/ESNTRsiaBzCKik7GBadAYCDlbe8nV00H8fy
         2E01dAKomwCYXai5m7tUk3B0RizOheqGXe4Gsy90=
Date:   Tue, 22 Sep 2020 12:47:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ying.huang@intel.com
Subject: Re: [PATCH] mm: swapfile: avoid split_swap_cluster() NULL pointer
 dereference
Message-Id: <20200922124750.67a20d9764ec098b17705407@linux-foundation.org>
In-Reply-To: <20200922184838.978540-1-aquini@redhat.com>
References: <20200922184838.978540-1-aquini@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 14:48:38 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> The swap area descriptor only gets struct swap_cluster_info *cluster_info
> allocated if the swapfile is backed by non-rotational storage.
> When the swap area is laid on top of ordinary disk spindles, lock_cluster()
> will naturally return NULL.
> 
> CONFIG_THP_SWAP exposes cluster_info infrastructure to a broader number of
> use cases, and split_swap_cluster(), which is the counterpart of split_huge_page()
> for the THPs in the swapcache, misses checking the return of lock_cluster before
> operating on the cluster_info pointer.
> 
> This patch addresses that issue by adding a proper check for the pointer
> not being NULL in the wrappers cluster_{is,clear}_huge(), in order to avoid
> crashes similar to the one below:
> 
> ...
>
> Fixes: 59807685a7e77 ("mm, THP, swap: support splitting THP for THP swap out")
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Did you consider cc:stable?
