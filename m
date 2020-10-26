Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4936B299676
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1741117AbgJZTNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404216AbgJZTEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:04:08 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBF820720;
        Mon, 26 Oct 2020 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603739048;
        bh=AHD3Q5NMnAqW/PwhjTlDcGnCMCU3a5L5yG8ci6S0zhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je72NyXI3XtA5RGI7O1keBA4S4KImpY9W/vjiVJSHGSVtL2pwKwmGfA5MP6TvN5lJ
         p/fBZvTsQYNNIVnr0cVEUuAxTTbUYSjyqcOuR4cZuEp99fi2ohvYGBSmF5bebvB/Uz
         /6GjcduJqU53mmtwYXmfSYHEcxZ/8aEbiHjM6YNQ=
Date:   Mon, 26 Oct 2020 12:04:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v3 1/2] f2fs: add F2FS_IOC_GET_COMPRESS_OPTION ioctl
Message-ID: <20201026190406.GL858@sol.localdomain>
References: <20201026041656.2785980-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026041656.2785980-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:55PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added a new F2FS_IOC_GET_COMPRESS_OPTION ioctl to get file compression
> option of a file.
> 
> struct f2fs_comp_option {
>     u8 algorithm;         => compression algorithm
>                           => 0:lzo, 1:lz4, 2:zstd, 3:lzorle
>     u8 log_cluster_size;  => log scale cluster size
>                           => 2 ~ 8
> };
> 
> struct f2fs_comp_option option;
> 
> ioctl(fd, F2FS_IOC_GET_COMPRESS_OPTION, &option);
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>

Please don't add Reviewed-by until it is explicitly given.

The actual code looks fine, but there's still no mention of documentation,
tests, or use cases.

- Eric
