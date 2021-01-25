Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAF30300E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 00:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbhAYXYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 18:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732710AbhAYXX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:23:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F7E021D93;
        Mon, 25 Jan 2021 23:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611616958;
        bh=XH7o6BXLIqIYaGWEZfAOHh39LYn7HZemY8tFhMvJ2dM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JMhXNc1DfCG1TUjT9FxgF1jgnk+hDAELuuTUKJP6LFumwcEcxLrbpvhIvhofBwVKN
         3DP+iRwua1qj8UOpxOelV2f27uyZrH2QakZMs0945/KwIecL/l7uZd1qhMfu1PGP1T
         D4wjUVBz16FvIrEpzQ3qtphiq4/KrUSil0g2Lwsk=
Date:   Mon, 25 Jan 2021 15:22:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Remove redundant variable's assignment
Message-Id: <20210125152237.d3cfebac78907fb50ae5cbbc@linux-foundation.org>
In-Reply-To: <08dc7237b44b9455ab095b44dc6969a1607b08db.1611544316.git.baolin.wang@linux.alibaba.com>
References: <08dc7237b44b9455ab095b44dc6969a1607b08db.1611544316.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 11:20:02 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> We've already set the variable 'i' 's initial value before using it,
> thus remove redundant previous assignment of variable 'i'.
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2472,7 +2472,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>  		if ((iocb->ki_flags & IOCB_WAITQ) && written)
>  			iocb->ki_flags |= IOCB_NOWAIT;
>  
> -		i = 0;
>  		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
>  							     pages, nr_pages);
>  		if (pg_nr < 0) {

Matthew's patch series "Refactor generic_file_buffered_read "
(https://lkml.kernel.org/r/20210122160140.223228-1-willy@infradead.org)
changes all this code - I dont think the patch is relevant after that,
so I'll skip it.

