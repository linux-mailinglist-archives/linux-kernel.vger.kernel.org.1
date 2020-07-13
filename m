Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA021AD76
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 05:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGJDZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 23:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgGJDZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:25:33 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D14EA2065C;
        Fri, 10 Jul 2020 03:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594351533;
        bh=yu4mEjxbnjkjZzRIjB5mnWuk0m2YiSQbrdpmN1gRhqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ejAQEHyYdq51BJ0MUh+81fQkYKHt0zpT5KoWtQR8dvJE0AAqcyuSwvH3KKtG8nrnQ
         AtX+6ruou0CVTsqc8g7FTaboCuPTZIAaPg796ivBI+LmRB/iqhhTyWyDmjz/AtFMKe
         A02HtIsjKAGeaS72AvpGCReSZmpaSA5jfQkioyR0=
Date:   Thu, 9 Jul 2020 20:25:31 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
Message-ID: <20200710032531.GA2805@sol.localdomain>
References: <20200710021505.2405872-1-daeho43@gmail.com>
 <20200710030246.GA545837@google.com>
 <CACOAw_yJvQgDsLRd0-iJqXN06wDXmC3_OqKgKey7p=WeqxzMFA@mail.gmail.com>
 <20200710032035.GB545837@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710032035.GB545837@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:20:35PM -0700, Jaegeuk Kim wrote:
> On 07/10, Daeho Jeong wrote:
> > 1. The valid data will be within i_size.
> > 2. All the trim operations will be done in a unit of block, even if
> > i_size is not aligned with BLKSIZE like the below.
> > 
> >         index = F2FS_BYTES_TO_BLK(range.start);
> >         pg_end = DIV_ROUND_UP(end_addr, F2FS_BLKSIZE);     <= BLKSIZE aligned
> > 
> > Are you worried about the case that sudden power-off occurs while a
> > file is being truncated?
> > ex) 1GB file is being truncated to 4KB -> sudden power-off ->
> > i_size(4KB), i_blocks(maybe somewhere between 4KB and 1GB)
> 
> Yes. Basically, I believe we can have some data beyond i_size like fsverity.
> 

Note that fs-verity files are read-only, and therefore this ioctl can't be used
on them (since it requires a writable file descriptor).  So that case doesn't
need to be handled here.

- Eric
