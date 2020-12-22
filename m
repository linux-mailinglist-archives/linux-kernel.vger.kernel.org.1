Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE20F2E0AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgLVNey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbgLVNex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:34:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BCAC0613D3;
        Tue, 22 Dec 2020 05:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jf4HzBhS2w9FYHMHxloV55F4NAfUOC3EnTS7QLW52Eg=; b=jSTwzg2fyrC7vZ7B6KgOxFlXV+
        +gS6Stjk9V0l3fCUxRgSkZ+EFrSmIUTb9R4B21Zix3M8oCOgh1RUX/6mOTdsvSK/qR3bbeeA19r6l
        gXdwCk+RkhmPXGukXAaz8cEyKSZ5SmuLhJWVhSmoegxZ1J4qLQAboEB3TUWpcsYZn3pyYuYvv9FkE
        5Ozb0Yc4AomCd+QnZVlr/iF/5fXrGjIMtecBxyTHQWGg1Zc1ZFIs4SDNaaYOnYenbDa68rIJLgMCB
        nJhycEEpV/OfkutNQKYzi9C8PBySI5ysnQq55FZWjYEL+ynoBnrLl+ubP0mGpSOk3CxVo8dTeYkKL
        ydGVMBLQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krhnn-0001XI-Lw; Tue, 22 Dec 2020 13:34:11 +0000
Date:   Tue, 22 Dec 2020 13:34:11 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] freevxfs: fix spelling mistake in Kconfig "endianess" ->
 "endianness"
Message-ID: <20201222133411.GB5099@infradead.org>
References: <20201216111605.10787-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216111605.10787-1-colin.king@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

can you pick this up through -mm?  I have no active git tree for freevxfs
anymore.

On Wed, Dec 16, 2020 at 11:16:05AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig help text. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/freevxfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/freevxfs/Kconfig b/fs/freevxfs/Kconfig
> index c05c71d57291..0e2fc08f7de4 100644
> --- a/fs/freevxfs/Kconfig
> +++ b/fs/freevxfs/Kconfig
> @@ -8,7 +8,7 @@ config VXFS_FS
>  	  of SCO UnixWare (and possibly others) and optionally available
>  	  for Sunsoft Solaris, HP-UX and many other operating systems. However
>  	  these particular OS implementations of vxfs may differ in on-disk
> -	  data endianess and/or superblock offset. The vxfs module has been
> +	  data endianness and/or superblock offset. The vxfs module has been
>  	  tested with SCO UnixWare and HP-UX B.10.20 (pa-risc 1.1 arch.)
>  	  Currently only readonly access is supported and VxFX versions
>  	  2, 3 and 4. Tests were performed with HP-UX VxFS version 3.
> -- 
> 2.29.2
> 
---end quoted text---
