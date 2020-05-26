Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C181C4BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 03:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEEB6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 21:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgEEB6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 21:58:55 -0400
Received: from [192.168.0.107] (unknown [58.213.210.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D3B6206C0;
        Tue,  5 May 2020 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588643935;
        bh=cQnMVodPsVGu6kr4A3A0f+mhcJdPPyK20x6xr8YdlKA=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=dG8o5twjxu0FpycuHeWowUTohcKzI5WM+H72CCEoKadH1XQZfel6wVQxdhy6X2R8Y
         ekyXRTXOflT3PsZD8JZFhkPQ2ngLg2/36/IRzhi0oS1QS5qfDOF0Z7wjb6ILZfXBRF
         TMbyxz0Xq51NDuPqVisI7RSOD+oRf4tBz2Fv7dDs=
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant check in
 f2fs_force_buffered_io
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200504143538.159967-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <b18c4be5-b56d-6b6e-3f99-d2fe05d330eb@kernel.org>
Date:   Tue, 5 May 2020 09:58:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200504143538.159967-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-5-4 22:35, Jaegeuk Kim wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> We already checked whether the file is compressed or not in
> f2fs_post_read_required(). So removed f2fs_compressed_file()
> in f2fs_force_buffered_io().

Agreed, since I have sent similar patch before:

https://lkml.org/lkml/2020/3/24/1819

Just want to know what's the change of backport concern now.

Thanks,

>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 6b7b963641696..01a00fc808361 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4064,8 +4064,6 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  		return true;
>  	if (f2fs_is_multi_device(sbi))
>  		return true;
> -	if (f2fs_compressed_file(inode))
> -		return true;
>  	/*
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>  	 * all IOs can be serialized by log-structured write.
>
