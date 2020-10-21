Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BA294771
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 06:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440209AbgJUEgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 00:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440202AbgJUEgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 00:36:23 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 706FC20795;
        Wed, 21 Oct 2020 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603254982;
        bh=US29mnjG65+3xtVs/p9mRVy5ww8iDF1b1Klps/Bj9SM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qm0rDQEMO6FxAufRXSJzGlC11JAZp8mUhBKuSp8/KCUbIVIz2e3ZK/zpuc9tPHQJR
         xyVfn1ffwy98bI3Y3wxsYh0nkkT9hg8MGFpOvuXp8EUj10fAEZ6+6sgukkKLVVjRK6
         brPMbI6yrVgvbZp0gRAXZ0jaD+ei+bUGI3exsISc=
Date:   Tue, 20 Oct 2020 21:36:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add compr_inode and compr_blocks sysfs
 nodes
Message-ID: <20201021043620.GA3939@sol.localdomain>
References: <20201016051455.1913795-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016051455.1913795-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 02:14:55PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added compr_inode to show compressed inode count and compr_blocks to
> show compressed block count in sysfs.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 10 ++++++++++
>  fs/f2fs/sysfs.c                         | 17 +++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 834d0becae6d..a01c26484c69 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -350,3 +350,13 @@ Date:		April 2020
>  Contact:	"Daeho Jeong" <daehojeong@google.com>
>  Description:	Give a way to change iostat_period time. 3secs by default.
>  		The new iostat trace gives stats gap given the period.
> +
> +What:		/sys/fs/f2fs/<disk>/compr_inode
> +Date:		October 2020
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show compressed inode count
> +
> +What:		/sys/fs/f2fs/<disk>/compr_blocks
> +Date:		October 2020
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show compressed block count

Is it the count in memory, or on disk?

- Eric
