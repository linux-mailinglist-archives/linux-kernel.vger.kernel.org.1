Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0F2A90A0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgKFHpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgKFHpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:45:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:45:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 72so542153pfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=K54S4tmdbHgMW+MVK8p9l4H5bicSeAudRQfjdTGyLmc=;
        b=Tfr4vWWXNyo+W8LEk1g+3587ILfmUu3wbnu/yPBAXpP7i5mJoiIn6WZ6n89yu2Zc3F
         +QpGeeNJwUae2BH9aDxV7GfuIj2Mq3LkJuhyUh1gceU6Zc9s5N+gVJd+HA0qOqFqthr6
         Gn8N7u8dMKrFEUOzR/Z5OA0NUXkxFKEBHXrIsMffgTp/haZlZl9NBYbpzQk+E8GR7Z5/
         c0/xfYc69dXrfWOfxSHLpbnqf+bSUWmirnk6G3zGybE7JsrYKjIZeitxKwDXNUC+eBo/
         G1M3oWVtS3VWJZ0F8GNHYTZvJSY8JYAv+QDNAVeQYSD/SYTrN2w1ev25G+zjpg9HjxSk
         nrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=K54S4tmdbHgMW+MVK8p9l4H5bicSeAudRQfjdTGyLmc=;
        b=LZDmPW3sFdcEQL+2B9YJJfQ0qndnE9lRxlgax48W9ZJPrHCfAtqw59kTXaspRiy+b+
         oaYikV1yvkmqwqjLEnx7x+qedfcK5qsTM2b0n/YWDKjinVhsf6z4c+1RPD9Rc0r8lC76
         /UqX9PNBwyEgpGV87fBysRTUBKgFoU46QCSGFBWCm0+GuXkv302eEfcZJVTpjHoheO4u
         FrfhtEusuQVqHNdMgcDIRiFxq4n1+R1BqchH1c2k4evLaLVhPbQz8dslahAhUeH1bAaL
         6bkecZFsB2znddhHpOoas1qavzYd62CJpH2cgCftOaCriJheFDcyYUp91oezwk1aLceG
         Ve4g==
X-Gm-Message-State: AOAM532sO6xXwYcstXa4xy5/iGaNUFttqFmZNiaLmjFXRC0YNPxzoWkg
        jr4ZW3xKEcBtymmrpACI/lPpoA==
X-Google-Smtp-Source: ABdhPJynR1+zk4zYU4UhoL7YmxIbYRJ1mpvelbP8x/YimozLjQ+nfno7quluYOXj+rrg2uLvyysNFQ==
X-Received: by 2002:a17:90a:ca91:: with SMTP id y17mr1022137pjt.205.1604648704549;
        Thu, 05 Nov 2020 23:45:04 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s17sm1088651pjr.56.2020.11.05.23.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:45:03 -0800 (PST)
Date:   Thu, 05 Nov 2020 23:45:03 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 23:39:34 PST (-0800)
Subject:     Re: [PATCH] riscv: uaccess: fix __put_kernel_nofault()
In-Reply-To: <20201102073052.199638-1-changbin.du@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, changbin.du@gmail.com,
        Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     changbin.du@gmail.com
Message-ID: <mhng-21386a65-a083-4346-89a7-0b8ac583b9c4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Nov 2020 23:30:52 PST (-0800), changbin.du@gmail.com wrote:
> The copy_from_kernel_nofault() is broken on riscv because the 'dst' and
> 'src' are mistakenly reversed in __put_kernel_nofault() macro.
>
> copy_to_kernel_nofault:
> ...
> 0xffffffe0003159b8 <+30>:    sd      a4,0(a1) # a1 aka 'src'
>
> Fixes: d464118cdc ("riscv: implement __get_kernel_nofault and __put_user_nofault")
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/uaccess.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index c47e6b35c551..824b2c9da75b 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -476,7 +476,7 @@ do {									\
>  do {									\
>  	long __kr_err;							\
>  									\
> -	__put_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
> +	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
>  	if (unlikely(__kr_err))						\
>  		goto err_label;						\
>  } while (0)

Thanks, this is on fixes.
