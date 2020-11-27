Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F0E2C6C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 21:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbgK0Ui6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 15:38:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731803AbgK0Uaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:30:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606509038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tglFuF875GWwN24HhSrupHcDE+HNcJd+ysCQTBH59Oo=;
        b=V+rIQYmWyhyCUzTO3NQiHcTA4XrDsBsJ91IGIxU+IBmCnShhcJEHWZhg/1xkuDCeByqb2m
        oOPFFXflcwDTrTmxXpzdmjmvovZX3or0NkhdV9klRXh4wAr/D2PIEw126FnVZef1l2opou
        fgICeMBQAb7sthfxAIkpOg7gYyWosmY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-KakB_rpTOVWGbbXCvC6Cag-1; Fri, 27 Nov 2020 15:30:36 -0500
X-MC-Unique: KakB_rpTOVWGbbXCvC6Cag-1
Received: by mail-wr1-f72.google.com with SMTP id b5so3920033wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 12:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tglFuF875GWwN24HhSrupHcDE+HNcJd+ysCQTBH59Oo=;
        b=euQ0Q+XIkuPgaJkQqfrB9ypFvgdIrpDqiTeC3/GPnU39XzVNlrzGvvpvOojFb3i0Vv
         89XC7xK7LZg6LT3QGCuPDkKh/fz9H81ymLEmKdb7c2Da3tg/Xu32arZQQJv3zwVchkSR
         OCxZHrafdAhgS0QhPv5SBU205XR2LvFflIA6bf2RJUfzgCb+zqrk5yo5S12ByUdfA13I
         EjXAK+seWDVIWavrY9l+9OZ/kfEk0hGK7vwanWae+BW8JuY+m/DY3b7RZqX9+uD7veSW
         4xRTsttXxi+JixnjOoxRcs6XrORGWdhAyCS5w7Q7rLUMxCd0+PAX0ZOtmJNdM48b4xxR
         KzyQ==
X-Gm-Message-State: AOAM532ZwK5hDndaFrgq0vwOZatqZwV7N03stQxNQQjqbBJW/vYdC/HJ
        zpqqaRA5fbXEq26p8rwmwO4Oq3GdJNOCHb2KIyuEivP1NwkT16a6NAeriIeTK8c+B/TAlmf3uyl
        SCgqh3Agfj2bJjz17V9FnOmzxVywIRVSBwA69YNzR
X-Received: by 2002:a1c:810c:: with SMTP id c12mr10983381wmd.96.1606509035026;
        Fri, 27 Nov 2020 12:30:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzGlJj2B75JR2lX+fXCp5ap99UGZGXWUoXauI1HGlhqeCKz3FoiXIIgqe5JDWD+P9hEEiFMiBooAHIw60sUGWs=
X-Received: by 2002:a1c:810c:: with SMTP id c12mr10983365wmd.96.1606509034803;
 Fri, 27 Nov 2020 12:30:34 -0800 (PST)
MIME-Version: 1.0
References: <20201127191209.2850758-1-trix@redhat.com>
In-Reply-To: <20201127191209.2850758-1-trix@redhat.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 27 Nov 2020 21:30:23 +0100
Message-ID: <CAHc6FU51+xn3P1SeU-=n3dV2J2XcwEMJp0f7iTee-X3u0TJK4A@mail.gmail.com>
Subject: Re: [PATCH] gfs2: remove trailing semicolon in macro definition
To:     trix@redhat.com
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 8:12 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> The macro use will already have a semicolon.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  fs/gfs2/util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
> index d7562981b3a0..493020393ceb 100644
> --- a/fs/gfs2/util.h
> +++ b/fs/gfs2/util.h
> @@ -162,7 +162,7 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
>  gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, true);
>
>  #define gfs2_io_error_bh(sdp, bh) \
> -gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, false);
> +gfs2_io_error_bh_i((sdp), (bh), __func__, __FILE__, __LINE__, false)
>
>
>  extern struct kmem_cache *gfs2_glock_cachep;
> --
> 2.18.4

Yeah okay, there are two more instances of exactly the same pattern
further below in the same header file. I'm adding fixes for those as
well.

Thanks,
Andreas

