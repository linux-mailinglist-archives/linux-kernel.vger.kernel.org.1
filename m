Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473B02AABA0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 15:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgKHOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 09:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:34:53 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D93C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 06:34:52 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id k1so5950719ilc.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 06:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/hajfbDBhWPyuSG1FXJgfVpGK2JD2d1UCKyN7jvqEo=;
        b=Cc6D2+MLiS6otK/8DhbQ5uA8yerdIrTcKvRZlBWpTFeCTmB8anU80yCHpLn/3g7LBz
         LqN3NY005zC/+2d84B9DDeP6In5T/5VKiN6O+a1t8IVpfLo7Dn+OGr9J5RQrEnKZTHEZ
         1l32wU7bHfjLZUGEbnk0GkajfUEO0sF3vsbmupsuYp2wzLoOA2VziyDmNRGY8qO/eca2
         gZmkuViKm6sqJk+788R0qsruqaqEH2+EpLHT5vNyZYVLdlMG/Px2mzj76/FBdB5xBs1u
         pV5R67hze39Nis7YDiadNdz1sZZCDKMX/LbuQ5muMz2P3wpcJRjyUyVlEN51tGyfBEtC
         8tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/hajfbDBhWPyuSG1FXJgfVpGK2JD2d1UCKyN7jvqEo=;
        b=tjukSiv63ewuC1SrIxqZD3rRIyClk4HB5BJBE9/C4GFYixU3/jc181w3Bwo2o/yYPD
         CdKO5BtXFwAks9yuyLHt+ypaPlsapbTnmYhc7ZcdEs3TwS+pE0K7OOvkN2Eb9t4jItII
         YmHb4Q075SravnI/YpU2mDNs15WIblPW/+UtAZhT9POJxsddgUyBe7jvqSg+6j+hx7hF
         2s9atWL4r9UMN9unhbi8fbo+zHVHYplH9BkcHBgZ39fNpNGHfb1S6+5tlNja50hdSe9L
         xVffS51DsFeJz8BhS96/VF8JOT/qMWnr7Vqlt9h7SMv1YmWKBkxY4Ox3iT+XzoO0VDGO
         +dzA==
X-Gm-Message-State: AOAM531AgAbNBWOl7dlA/5eM3/2BZ273vCSWuCgYkpOmNIbbt8yWwejH
        Kk7Ia2TlgQjNCuuEuJj/NjGQyer5+H/YZl2cGaU=
X-Google-Smtp-Source: ABdhPJxNragDyPzG/mk4YRldhZPoqb9pGN1pWZ9aosLAt+Zc2b82MBp/DCm+c7AwtqPtUuXXPkYxyzdlO6L7/PiK1Xs=
X-Received: by 2002:a05:6e02:149:: with SMTP id j9mr3652283ilr.276.1604846092246;
 Sun, 08 Nov 2020 06:34:52 -0800 (PST)
MIME-Version: 1.0
References: <20201016132047.3068029-1-hch@lst.de>
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
From:   =?UTF-8?B?5buW5aiB6ZuE?= <gmpy.liaowx@gmail.com>
Date:   Sun, 8 Nov 2020 22:34:41 +0800
Message-ID: <CAL3PxMqzgza_GSBVVTuzh1u1EH=h=Zce4VF-xftY9f30ANnGSQ@mail.gmail.com>
Subject: Re: simplify pstore-blk
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

hi Christoph,

On Fri, Oct 16, 2020 at 9:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> this series cleans up and massively simplifies the pstore-blk code,
> please take a look.

Thanks for your code. I am going to redesign pstore/blk referred to
your idea.

I want to split pstore/blk into two parts, pstore/dev and pstore/blk.
pstore/dev is a common layer that handles all configurations
for users. All devices including block devices, ram devices and
mtd devices register to pstore/dev with operations and some flags.

Besides that, we can delete the codes for the block device to
register a panic_wirte() interface since there is no block device
needed. But it should be easy to implement registering if necessary.
