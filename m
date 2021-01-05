Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDA32EB4AF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbhAEVIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730156AbhAEVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:08:04 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945B9C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:07:23 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a12so1732419lfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTH/D0pcYHgEAjveQTnm1uxYGg2A1423go8OVRIN0MU=;
        b=fM9gCX7TtuxJ8DC4uobaxAuXJEGFuX41smIcIyruUPcKdlxMCBhXaMmzpG6vYnUexv
         2MzasiLLHzAgL8tNea0xlGNpzYdC7OwJg3OJYDEa8HBYFocV/PubW0EKP7bF1VKxxU3p
         TjzqlJN7wlYujvG84GY5TcUwWVlyxX92piDiMzdWTbV0eB15bL5CXmda0ffZjQhGBg/D
         MTJjAVNcZDM+UXtoBWyXD4abWSipNNuXBd5cBuhJUFgr4Opd7x5xHfP9DXuIDgFFEjfr
         3lGd4a51DV5+n05+Feqw4mUWrtq7oMnNnop8JmwlM1+6VTN41cPFMSE3LS9CNzLcv3W+
         CLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTH/D0pcYHgEAjveQTnm1uxYGg2A1423go8OVRIN0MU=;
        b=aWRfNhECMS72nfoK+tQAmBDC5fPQhFrBqF6rZ+fa/MtCrlrB7X9UWHs3k1L29Jr8yw
         znFzLj+EyewkvMylQ3bw8iYwBSrxazs7DG28sOaEC9SKGFoMGW11L3z/Iq1g15ZEm8MK
         eaEPVQrKO99KUBRDntTern5Vv7IYbrRaM04CKcxtN+hs9y1Ljx91yQNCZelJdbcapkQM
         z0WOo361eOoEHNt7MKJ6Saap1S/jUhnKfQg1+/2sPdsQ+ljMzxk4Ez9E+d/tCf/0JGLc
         ael3PfOU5aOxTeNs21i20x/kLLNbnAloWL1TglNTHtvvuG/4Ne7MmND+yHzmS5J8tBz4
         /nzw==
X-Gm-Message-State: AOAM533fTf06aosAp8A6Lf5ZJ0+O1m+J/f6yp6LLzBgPd1eFtoZttiQ3
        iprGTdNGURCssO1yzZXJxfZ5elDbtzdSLXJryfc=
X-Google-Smtp-Source: ABdhPJwoDlljj6UnXYXS8jwT9nLNh018rIQ0TvEI+X4OC+OrB+OAaGkMhYBqnuB2Zj+PTdu/D/I72a3LGcrUGfrdrb8=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr457934lfd.425.1609880842100;
 Tue, 05 Jan 2021 13:07:22 -0800 (PST)
MIME-Version: 1.0
References: <1609807642-31552-1-git-send-email-huangzhaoyang@gmail.com> <1535117686.42500348.1609851274846.JavaMail.zimbra@redhat.com>
In-Reply-To: <1535117686.42500348.1609851274846.JavaMail.zimbra@redhat.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 5 Jan 2021 22:07:10 +0100
Message-ID: <CAHpGcMKfjSddqj7FuUhR00GY+B4Qkzc=bHMVCk4UYQsWeMkxMw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: amend SLAB_RECLAIM_ACCOUNT on gfs2 related slab cache
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bob,

Am Di., 5. Jan. 2021 um 14:28 Uhr schrieb Bob Peterson <rpeterso@redhat.com>:
> ----- Original Message -----
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > As gfs2_quotad_cachep and gfs2_glock_cachep have registered
> > the shrinker, amending SLAB_RECLAIM_ACCOUNT when creating
> > them, which make the slab acount to be presiced.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: add gfs2_glock_cachep for same operation
> > ---
> Hi,
>
> Thanks. Your patch is now pushed to the linux-gfs2/for-next branch.
> I cleaned up the description a bit. For example, I changed "fs:" to
> "gfs2:" to conform to other gfs2 patches.

so the patch description now reads:

"As gfs2_quotad_cachep and gfs2_glock_cachep have registered
shrinkers, amending SLAB_RECLAIM_ACCOUNT when creating them,
which improves slab accounting."

I'm not sure what that description is based on; the definition of
SLAB_RECLAIM_ACCOUNT in include/linux/slab.h looks as follows, which
indicates that the purpose isn't really accounting but object
grouping:

/* The following flags affect the page allocator grouping pages by mobility */
/* Objects are reclaimable */
#define SLAB_RECLAIM_ACCOUNT    ((slab_flags_t __force)0x00020000U)
#define SLAB_TEMPORARY          SLAB_RECLAIM_ACCOUNT    /* Objects are
short-lived */

Furthermore, would it make sense to use SLAB_RECLAIM_ACCOUNT or
SLAB_TEMPORARY for gfs2_bufdata and gfs2_trans as well?

Thanks,
Andreas
