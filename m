Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0B62C5B11
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391700AbgKZRtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391626AbgKZRtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:49:39 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257F52053B;
        Thu, 26 Nov 2020 17:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606412979;
        bh=BD8kUdWFybD9t7G40pqo6k9zDUDc9M1OCvnslZNmT4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oGrVxfJ+LzZIs8hVexHcq3DO90RyIP3/zN4o9egA8ewsVmKocSWibGMAQiPB+c2YU
         b2vUm3XfWmGHmev1MKAGbIgC2MSHDF8wYlLR1ubi9qyg8NAGPGCc9LN8hnKlqMfRc2
         wYQOmT95L0gjoRPFXx5d5z8hm5xFieSByrUFFKm4=
Date:   Thu, 26 Nov 2020 09:49:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Daeho Jeong <daehojeong@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
Message-ID: <X7/qr/kVxl3AO/PR@sol.localdomain>
References: <20201123031751.36811-1-daeho43@gmail.com>
 <20201123031751.36811-2-daeho43@gmail.com>
 <5b3cb83d-5d0f-c1ca-2cff-f28372dec48e@huawei.com>
 <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xs0dizV_xg4-8ssC8wPRq8eXPw3QhHAFf3S-w3hp9jcg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 02:04:41PM +0900, Daeho Jeong wrote:
> Eric,
> 
> do_page_cache_ra() is defined in mm/internal.h for internal use
> between in mm, so we cannot use this one right now.
> So, I think we could use page_cache_ra_unbounded(), because we already
> check i_size boundary on our own.
> What do you think?

What about page_cache_async_readahead() or page_cache_sync_readahead()?

- Eric
