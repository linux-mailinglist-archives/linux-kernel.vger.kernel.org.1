Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB15E29287E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgJSNpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728405AbgJSNpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603115150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfp5uLmmKAQpYXoC1rTEcSiy92a8B0maxskNVT2+r00=;
        b=WXhRQ/JWWJG49WairP3u+tS2y8/dwytamyPVcFd5/6nYERJPBNEkIjem3QexNFgkaagiCQ
        yNvw9Zv/ra3krvqneq/Ug4THescRjDh6UOr/JcmnlAQ7oLKRjB6/Qeky+QTLzdp/fccsP9
        YIZLbWDxvU9yztAFzAedPQg9jEgfQ6w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-tDszte3vNVysPoO-lclYYg-1; Mon, 19 Oct 2020 09:45:48 -0400
X-MC-Unique: tDszte3vNVysPoO-lclYYg-1
Received: by mail-wr1-f72.google.com with SMTP id j15so7444283wrd.16
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 06:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfp5uLmmKAQpYXoC1rTEcSiy92a8B0maxskNVT2+r00=;
        b=DdgWqQ0iJLc/MYmpqxwxWL9ScmK7Pmh2wY/D81Ck4rm98Op6Y2G56l/ryGZzbhF0WJ
         V4F7TCCsdx3H0M4qgqHEgtz+OAfy/TLuzfV++jq7UpFVaSKXinwze4WES0Nr20Zzf/hm
         qhQXLMX8718q3DJK6uEnS83N8Wma6J0R63y1H0JAKduTBmC0+PTSKiDA78JGxm+Df75T
         rWc009WS5s5pPefS5GIhKhq9746hsj3ReqCVmo1q9mt9bf2cnIPHZzy1cz9AQ67IpfJF
         4uuQlph5CENQUKiUqrWhnvr+HCxYy5Jb8epEJEcEGEFhSbRLDlW6xGTEXHqDXJFHOnWP
         8yPw==
X-Gm-Message-State: AOAM533NB5ZEclLRF/z+q3Jbbp+gFU5AjvFGPFvHjYQeI2YxopC+Vb7R
        6CRSuYGOjmHZb6+Sn6fMi1W6jT3nn+P3tDvk1qogkdRiob4uZkJBtGrLmHEHbJ0EhwCau3nIsZM
        pBkNAQT96xQYf5hI6GinxcdBUc4X6Ifi68QWnketv
X-Received: by 2002:adf:e412:: with SMTP id g18mr19685812wrm.211.1603115147252;
        Mon, 19 Oct 2020 06:45:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypMPk3ptYRJlhTEoD6Pnb2amjXgoQz74lxSA6h6ds5An9um9bDwD+EEKJz8brGKKXoYzKIN/JtsPrO/AAciQg=
X-Received: by 2002:adf:e412:: with SMTP id g18mr19685793wrm.211.1603115147039;
 Mon, 19 Oct 2020 06:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201019064349.48828-1-tian.xianting@h3c.com>
In-Reply-To: <20201019064349.48828-1-tian.xianting@h3c.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 19 Oct 2020 15:45:35 +0200
Message-ID: <CAHc6FU7TsdKopGCHo-PEJYr2gN7cpai+1YkfZ8=WNMSyX_Pk+g@mail.gmail.com>
Subject: Re: [PATCH] gfs2: use helper macro abs()
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 19, 2020 at 10:03 AM Xianting Tian <tian.xianting@h3c.com> wrote:
> Use helper macro abs() to simplify the "x >= y || x <= -y" cmp.
>
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  fs/gfs2/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 9f4d9e7be..05eb709de 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -304,7 +304,7 @@ void gfs2_statfs_change(struct gfs2_sbd *sdp, s64 total, s64 free,
>         if (sdp->sd_args.ar_statfs_percent) {
>                 x = 100 * l_sc->sc_free;
>                 y = m_sc->sc_free * sdp->sd_args.ar_statfs_percent;
> -               if (x >= y || x <= -y)
> +               if (abs(x) >= y)

x and y are signed values, so this really doesn't seem right.

>                         need_sync = 1;
>         }
>         spin_unlock(&sdp->sd_statfs_spin);
> --
> 2.17.1

Thanks,
Andreas

