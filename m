Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56A128DC66
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgJNJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgJNJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:09:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BB4C04585C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FtIzrrx52I9s/L0F5b/SYKDswu25oWi3u6T3OOCMfcU=; b=iXEr7LGhwI6fgLxPbSd9YPwWRV
        PgFPp8GK3eB3O312DvRFxYHL4u9cB6TzPL1Ct062Wm4uMndoUggGHPMAs/sOLWtu5MoMGHtFeGmwR
        s2FAatAW43ZDn3X26lMuL1cT4OTxIOUAO20RpKveFX9rcr/RaVR+k10EIiyosU2TRqFfw0zLB9bER
        6/F/r7v8T546N4cTE4Q5ukihs/JWRlzLTv90XmuRvcIiPyAyra6F01TM2tNG60JSZzR+JwmVizMWz
        /RSmeHnkOVVhJPiJwaBHmiCo6seJXxzOlCUmzmGZa6z/ONAaKdpVAwcn1HiltSsdjIRQ0BFkWx9lX
        9UDGW5iw==;
Received: from [2601:1c0:6280:3f0::507c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSZM6-0008SQ-R5; Wed, 14 Oct 2020 05:29:43 +0000
Subject: Re: [PATCH] jfs: delete duplicated words in header files
To:     linux-kernel@vger.kernel.org
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net
References: <20200720001353.26200-1-rdunlap@infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0329314c-c139-68a9-38c2-0163ebd304b8@infradead.org>
Date:   Tue, 13 Oct 2020 22:29:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200720001353.26200-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.

On 7/19/20 5:13 PM, Randy Dunlap wrote:
> Drop the repeated words "allocation" and "if" in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dave Kleikamp <shaggy@kernel.org>
> Cc: jfs-discussion@lists.sourceforge.net
> ---
>  fs/jfs/jfs_extent.h |    2 +-
>  fs/jfs/jfs_logmgr.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200717.orig/fs/jfs/jfs_extent.h
> +++ linux-next-20200717/fs/jfs/jfs_extent.h
> @@ -5,7 +5,7 @@
>  #ifndef	_H_JFS_EXTENT
>  #define _H_JFS_EXTENT
>  
> -/*  get block allocation allocation hint as location of disk inode */
> +/*  get block allocation hint as location of disk inode */
>  #define	INOHINT(ip)	\
>  	(addressPXD(&(JFS_IP(ip)->ixpxd)) + lengthPXD(&(JFS_IP(ip)->ixpxd)) - 1)
>  
> --- linux-next-20200717.orig/fs/jfs/jfs_logmgr.h
> +++ linux-next-20200717/fs/jfs/jfs_logmgr.h
> @@ -132,7 +132,7 @@ struct logpage {
>   * (this comment should be rewritten !)
>   * jfs uses only "after" log records (only a single writer is allowed
>   * in a page, pages are written to temporary paging space if
> - * if they must be written to disk before commit, and i/o is
> + * they must be written to disk before commit, and i/o is
>   * scheduled for modified pages to their home location after
>   * the log records containing the after values and the commit
>   * record is written to the log on disk, undo discards the copy
> 


-- 
~Randy

