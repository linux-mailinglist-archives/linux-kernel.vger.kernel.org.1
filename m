Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D1E28A305
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgJJW7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731603AbgJJTyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:09 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF36B2072D;
        Sat, 10 Oct 2020 11:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602331140;
        bh=KfphMgJoG+7J6N0lfM56ASmEua7G6nMhwmZkQcR67yw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ujxPtAegJyLlJHb2M/Dhl1WpztK8OJZ3Cki+li7y6CMEuE//CeTkx1fOIV6FgwnUL
         +eGcqdY9FT2DWvT2Xf0cRrtwcZPRAsmC4Igan0x93wJTvCOFBmAPaRTkYU95oOw7Ow
         ncNJH9J18pUjjQM6erd9lQu9pjqF4PHrUK9moiPk=
Message-ID: <072facd74fafbd10901f43cde06abd13d15341ea.camel@kernel.org>
Subject: Re: [PATCH] mm: validate inode in mapping_set_error
From:   Jeff Layton <jlayton@kernel.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 10 Oct 2020 07:58:58 -0400
In-Reply-To: <20201010000650.750063-1-minchan@kernel.org>
References: <20201010000650.750063-1-minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-09 at 17:06 -0700, Minchan Kim wrote:
> The swap address_space doesn't have host. Thus, it makes kernel crash once
> swap write meets error. Fix it.
> 
> [1] 735e4ae5ba28, vfs: track per-sb writeback errors and report them to syncfs
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/pagemap.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 17ba0fe59290..9cf540447e73 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -55,7 +55,8 @@ static inline void mapping_set_error(struct address_space *mapping, int error)
>  	__filemap_set_wb_err(mapping, error);
>  
>  	/* Record it in superblock */
> -	errseq_set(&mapping->host->i_sb->s_wb_err, error);
> +	if (mapping->host)
> +		errseq_set(&mapping->host->i_sb->s_wb_err, error);
>  
>  	/* Record it in flags for now, for legacy callers */
>  	if (error == -ENOSPC)

Good catch.

Acked-by: Jeff Layton <jlayton@kernel.org>

