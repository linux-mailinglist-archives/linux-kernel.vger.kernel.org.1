Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998CF28AD22
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 06:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgJLEjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 00:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgJLEjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 00:39:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95909C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 21:39:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s4so16699735qkf.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 21:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpWfSYwTmxBzkXDi9ht7uL8LFxGO5JzEbAJnVgaiE+c=;
        b=nU7uQ0hR6wJjdWA+ED+sikls3Urhi/cl8eNleJbNfjGbqwKo7zCEkywRHTc7K3jBkz
         Hyf3gr+6FCDB2hatcKdnG8zwLPgj2qv/GT72VXlOzM35Lbr2YkQQYN3K0NBCOyAkn2CU
         vAGPm7dFAe5q1Nykt7UDg+llyzoNG3DVtOVFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpWfSYwTmxBzkXDi9ht7uL8LFxGO5JzEbAJnVgaiE+c=;
        b=A+iFNDCyqHqkDA90hq6R8TAdfhX5tN6ODraPYk/GOhYRvgclD6TgLVWIWV3kn24yfa
         3JkGopC6AbFkrR9L9LuUQWhTJrYhdeFbc67WiPvd2/okC437wIHYEw2T/OFJhE3yCBFb
         Ci4Doa0uuCmuATgwFwYkbB+iK/JYFWjkSgqPCT8QI95WtQQbvqNvKhdR3A3aUkPSmDcK
         uTbj8NK+9cm5sSNNID0hBQ+VKTAWuaNg+ebDSiS3h5ds+tTlF14XN5A088tHz6jw6yHy
         DmgwypCnj31AtTxc7jkQuYZRqofRqLN8aM9fEsGy88cGz2GgfEczPzBFfpbTOWd7KdcT
         spDw==
X-Gm-Message-State: AOAM533TGlTghEwCLnGLYTrJcq+KIWu0mizY2cxAjm1WJ7QFX3RNXONj
        CPRJUIzu/FAbuackNqgZRt2NHHOelBweo7IQQlI=
X-Google-Smtp-Source: ABdhPJxMnMaMZnf67NjzBaX5vchMC+7Xo+nOk0fNRJ58YDhTE2vwQffIxSTvvFe2bSZywyWdiFwrGtVmwtV88lyxzsE=
X-Received: by 2002:a37:4a4d:: with SMTP id x74mr8376653qka.55.1602477548637;
 Sun, 11 Oct 2020 21:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201011230131.4922-1-rdunlap@infradead.org>
In-Reply-To: <20201011230131.4922-1-rdunlap@infradead.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 12 Oct 2020 04:38:56 +0000
Message-ID: <CACPK8Xej8SoJxrJBL2NB2PnGwjFQ8=oWsfALv2g2r7HxxP9xZQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/aspeed: fix Kconfig warning & subsequent build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michal Simek <monstr@monstr.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Oct 2020 at 23:01, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> kernel test robot reported build errors (undefined references)
> that didn't make much sense. After reproducing them, there is also
> a Kconfig warning that is the root cause of the build errors, so
> fix that Kconfig problem.
>
> Fixes this Kconfig warning:
> WARNING: unmet direct dependencies detected for CMA
>   Depends on [n]: MMU [=n]
>   Selected by [m]:
>   - DRM_ASPEED_GFX [=m] && HAS_IOMEM [=y] && DRM [=m] && OF [=y] && (COMPILE_TEST [=y] || ARCH_ASPEED) && HAVE_DMA_CONTIGUOUS [=y]
>
> and these dependent build errors:
> (.text+0x10c8c): undefined reference to `start_isolate_page_range'
> microblaze-linux-ld: (.text+0x10f14): undefined reference to `test_pages_isolated'
> microblaze-linux-ld: (.text+0x10fd0): undefined reference to `undo_isolate_page_range'
>
> Fixes: 76356a966e33 ("drm: aspeed: Clean up Kconfig options")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: linux-mm@kvack.org
> Cc: linux-aspeed@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> ---
> First sent on 2020-09-07.
> Feel free to fix the Kconfig warning some other way...

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks Randy. Sorry for missing it the first time around. I'll merge
this into drm-misc-next.

Cheers,

Joel



>
>  drivers/gpu/drm/aspeed/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20201009.orig/drivers/gpu/drm/aspeed/Kconfig
> +++ linux-next-20201009/drivers/gpu/drm/aspeed/Kconfig
> @@ -3,6 +3,7 @@ config DRM_ASPEED_GFX
>         tristate "ASPEED BMC Display Controller"
>         depends on DRM && OF
>         depends on (COMPILE_TEST || ARCH_ASPEED)
> +       depends on MMU
>         select DRM_KMS_HELPER
>         select DRM_KMS_CMA_HELPER
>         select DMA_CMA if HAVE_DMA_CONTIGUOUS
