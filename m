Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD12AAB4D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgKHOFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 09:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbgKHOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:05:23 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4AC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 06:05:23 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id p7so7186318ioo.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KUFtdshuJjHLJInS0RfMmTlPvtFm7H16bmcaUQkCkec=;
        b=T7TuwEeebt6M0GKPdkadzqDb4Um09bBRP5mLio9eay+qTEM8GgfH7XmVg3yJL68KeC
         SZvhikqIL+jKkNlfMl9qrvlLkiARf+yF7znfgr0IdzwY+pCoBs0Ks1n3wNHIle1gHwib
         tDlsIvf+KkckT7/x0XYHdTIQvSmlrJBee0mSCDFvC0LjvEsRsQUbm8uiU0C9/bmfwKxO
         6EXbclRxuBJCTJGpqG6NYW7wRYWwT6YDATqi9OwBW5BHqlLfDzBK7mR8mu0XU6OCtrgG
         eDR7zPlQjrpWzhLKQeOOzKz6OT07IwOu6AM+0Nl7qMybE9RW3GSR8xmAjH1SXYkElos0
         ctXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KUFtdshuJjHLJInS0RfMmTlPvtFm7H16bmcaUQkCkec=;
        b=qTGycRD/+lnCGsBG1vePbwMhOo5IUcoEIgHgTVp/FnPndH5oHyXhWzET+y41hNRR1U
         UrxKcM93xN1vPukX4GTRe9nFuFf4mqqt5AY0+y4+dwQohcLihq1C2RyjfX542z0UtXyj
         UKsPZGiAlVuoLcc0PIsGGM92eOlvbv5N8jG6xGmm/ABbcR9rlmYsfB0d4YTrmydaNQaA
         Q9WrRJw1bUlOH337H73hZdpzooTFI3UShRjEks6nXwebT8ENaesL/Fb/H33924MIiEZ/
         tW5JSVf5WcKnQOWlRZZ21N3ABdV5YjWJlAVcvu2md7AyJKuXi/YVJKMNjcEvK9ICxZdu
         W4DQ==
X-Gm-Message-State: AOAM531II1vuFDkxyDsdIbsh003np4xe8/aIif1+3Oa61fbfZCuMuaXK
        hO0dzquFMXfHhFcVHuN+CcMOmu7DO1yh4fSIGvE=
X-Google-Smtp-Source: ABdhPJx4Yt46fQSCRI7b56rvvngAMwdLf+/9Z/8fCsB8R1mzsbzssUCjFkmMGvYq/PiurVLrFWhOp/GFlx8PGmhgY1E=
X-Received: by 2002:a02:9981:: with SMTP id a1mr7976758jal.54.1604844322446;
 Sun, 08 Nov 2020 06:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20201016132047.3068029-1-hch@lst.de> <20201016132047.3068029-3-hch@lst.de>
In-Reply-To: <20201016132047.3068029-3-hch@lst.de>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <gmpy.liaowx@gmail.com>
Date:   Sun, 8 Nov 2020 22:05:11 +0800
Message-ID: <CAL3PxMpPGsyX4LWxdJ=NdHJTv=L9EDKM8AqEfkpqzFft0k7cpg@mail.gmail.com>
Subject: Re: [PATCH 2/9] pstore/blk: update the command line example
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 9:28 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the human readable device name instead of the device number, and
> add the required best_effort parameter.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/admin-guide/pstore-blk.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
> index 296d5027787ac2..d9ec8b0572d3b2 100644
> --- a/Documentation/admin-guide/pstore-blk.rst
> +++ b/Documentation/admin-guide/pstore-blk.rst
> @@ -35,7 +35,7 @@ module parameters have priority over Kconfig.
>
>  Here is an example for module parameters::
>
> -        pstore_blk.blkdev=179:7 pstore_blk.kmsg_size=64
> +        pstore_blk.blkdev=/dev/mmcblk0p7 pstore_blk.kmsg_size=64 best_effort=y
>

Reviewed-by: WeiXiong Liao <gmpy.liaowx@gmail.com>


>  The detail of each configurations may be of interest to you.
>
> --
> 2.28.0
>
