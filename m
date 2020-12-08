Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2B2D2195
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgLHDuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:50:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbgLHDuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:50:13 -0500
Date:   Mon, 7 Dec 2020 19:49:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607399373;
        bh=K+AuuBZl4hBPvkhnz+5DsdlBPwu1F5l2MO6LkZGaZhg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=m43jbMlV5Adfj+4GDftjqlqK9gsflMPNoZNr0MNhv8r7E2laJOnOhRlrbHijhOOYa
         JgTL1IJS4RlKO85/Dm6SoqZq8DakS5MNbROKyuu3D+VcoQM97Q3QB/nXM7onSTSelY
         TZKG9cYrbJIKaqsJ0hU4hp1/bC9LabTo0EnTv+4DFm/JAVYS1CMJerRQW2cb4q1uka
         cNwakO6vJoc4vFMyQYRqWZslvNfHROcig2VARRAQhn9vuie077K7YdbdP4/0W2ZGpr
         6DM9Pt+4KSrM0xVhyO+qePsDeF78nMBdex5a+qkWEv9yvWolb7hZ8gfqot9aB9Jspy
         EKgQA9IUPI3+Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: add F2FS_IOC_DECOMPRESS_FILE and
 F2FS_IOC_COMPRESS_FILE
Message-ID: <X873u1lHmTwktniU@gmail.com>
References: <20201203065615.402494-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203065615.402494-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:56:15PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added two ioctl to decompress/compress explicitly the compression
> enabled file in "compress_mode=user" mount option.
> 
> Using these two ioctls, the users can make a control of compression
> and decompression of their files.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---

I still don't understand the purpose of these new ioctls.  What's wrong with
just FS_IOC_SETFLAGS(FS_COMPRESS_FL) to compress a file, or FS_IOC_SETFLAGS(0)
to decompress a file?  That appears to already be supported...

- Eric
