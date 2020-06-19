Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BDA2001B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 07:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgFSFk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 01:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgFSFk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:40:57 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BEAC207DD;
        Fri, 19 Jun 2020 05:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592545257;
        bh=lPlQmiOW2RPnnTkoAb93HzGuPOoTC/zgIPoJh3IXerA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ni3wWdzj023rV/S8nF8sFDe079mgXtXseFwRXiipT8DfN+cYAcP7xjju7ClmFrxmp
         tUIcovvbURATTQRohoa4YiREfz9AScd7Mwuc/hOZVIjj8irnwSLbGcgdOhzLRcjYZD
         qNosvqD0YkjHYoWt06u8bHxTVx0aVAF1Zy1R/Iwo=
Date:   Thu, 18 Jun 2020 22:40:56 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to document reserved special compression
 extension
Message-ID: <20200619054056.GB227771@google.com>
References: <20200619032028.128668-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619032028.128668-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19, Chao Yu wrote:
> There is one reserved special compression extension: '*', which
> could be set via 'compress_extension="*"' mount option to enable
> compression for all files.

Thank you for the patch. :)

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  Documentation/filesystems/f2fs.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 099d45ac8d8f..535021c46260 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -258,6 +258,8 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
>                         on compression extension list and enable compression on
>                         these file by default rather than to enable it via ioctl.
>                         For other files, we can still enable compression via ioctl.
> +                       Note that, there is one reserved special extension '*', it
> +                       can be set to enable compression for all files.
>  ====================== ============================================================
>  
>  Debugfs Entries
> -- 
> 2.26.2
