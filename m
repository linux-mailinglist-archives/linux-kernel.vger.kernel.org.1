Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDA02AE483
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgKJX50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKJX5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:57:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D7CC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:57:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id b8so441042wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LE0afzOkIj/zw0NBe6e0ObJGwDPaqDvyeJKttoSBeoM=;
        b=WtSIs1xD+MaXeb4ffhufvVlCIwYGYGl3mt6GnySmJpVCXy5bBDmq+7ZXsWg3iG8Rp/
         gdEDCYi+ni0pe3NodHC0IZ0pKlWwiuA/Htn995ZPkOosIEVz9Sj/Ui8N4XZ+9nLKw1/e
         OqSmVIUrZvbNsiCqB4t2kV/o183c6ZRCPVV8TQOYYKdeSk/oamorEmFGsNLnr5YVnAjG
         qWVpvtldJORI1nYMNUu6Ih15+efFTYnqy+YX8Ly0nC5Ahb0bvnEur4AJIFtlmdLaKJBW
         /7q4rf8oVpVbr0YdzAkbr6dnCpGlMUlY6NvCWZL+bFaEk2ah9aCqamm2zRH8+FPUyZmH
         S34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LE0afzOkIj/zw0NBe6e0ObJGwDPaqDvyeJKttoSBeoM=;
        b=Z7aMpUah+WHB3VU5eF5CcGER9RYYkBsYhSf7l+wwLBh6GKpWVEph9rzaKIVd9K2J/j
         pOyx3vPqOPxE0iBZ/KomhftUIjOwfhMxqdRyqwTPYe9BT+tgqJD8T7OsuxqcozJRo9sb
         /J2RDUQlUyUte+gfQ4fwwxM2YvTzAgLxcphOgsO/aWy2Kh4QeFRQx7PKxppImkM4AEo/
         7eHJg1SZWGyYvIf5dXd8C4aYE3xWvTj3to0GNVMtAI1kf1bdNjTjpaf7WZRHX/CcVKkS
         HAroe+FJxHla2ndEGE4TsDYZy/0sviQD1CBNn9AQ0LRg5Ld3N43e5J1B+ek1HuDU97ga
         fvtg==
X-Gm-Message-State: AOAM533tPG+jhU8SRnlpimD8cxi4Kdy7DT8ysktU78LkoD4A7upWJYUO
        gN89TAKVbpA1sSYUM83lFFi88kmyVoSX+UURKm/AQG7w
X-Google-Smtp-Source: ABdhPJx3T38wEbSDtMYgkoopvqAG8NVHXxX+0Z2QyanoquRAnGIg4EhxIojZyJp498+74haST3uNYCspixYe2oDURp8=
X-Received: by 2002:adf:e551:: with SMTP id z17mr27350227wrm.374.1605052637210;
 Tue, 10 Nov 2020 15:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-19-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:57:05 -0500
Message-ID: <CADnq5_OH9n+7gVUhUXJ5gHPtAMpimDLY8QmjNyDS0S+h=Q3xRw@mail.gmail.com>
Subject: Re: [PATCH 18/30] drm/radeon/evergreen_cs: Fix misnaming issues
 surrounding 'p' param
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/evergreen_cs.c:1026: warning: Function parameter =
or member 'p' not described in 'evergreen_cs_packet_parse_vline'
>  drivers/gpu/drm/radeon/evergreen_cs.c:1026: warning: Excess function par=
ameter 'parser' description in 'evergreen_cs_packet_parse_vline'
>  drivers/gpu/drm/radeon/evergreen_cs.c:1095: warning: Function parameter =
or member 'p' not described in 'evergreen_cs_handle_reg'
>  drivers/gpu/drm/radeon/evergreen_cs.c:1095: warning: Excess function par=
ameter 'parser' description in 'evergreen_cs_handle_reg'
>  drivers/gpu/drm/radeon/evergreen_cs.c:1757: warning: Function parameter =
or member 'p' not described in 'evergreen_is_safe_reg'
>  drivers/gpu/drm/radeon/evergreen_cs.c:1757: warning: Excess function par=
ameter 'parser' description in 'evergreen_is_safe_reg'
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/evergreen_cs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/rade=
on/evergreen_cs.c
> index c410cad28f19f..53b75cf201958 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -1015,7 +1015,7 @@ static int evergreen_cs_track_check(struct radeon_c=
s_parser *p)
>
>  /**
>   * evergreen_cs_packet_parse_vline() - parse userspace VLINE packet
> - * @parser:            parser structure holding parsing context.
> + * @p:         parser structure holding parsing context.
>   *
>   * This is an Evergreen(+)-specific function for parsing VLINE packets.
>   * Real work is done by r600_cs_common_vline_parse function.
> @@ -1087,7 +1087,7 @@ static int evergreen_cs_parse_packet0(struct radeon=
_cs_parser *p,
>
>  /**
>   * evergreen_cs_handle_reg() - process registers that need special handl=
ing.
> - * @parser: parser structure holding parsing context
> + * @p: parser structure holding parsing context
>   * @reg: register we are testing
>   * @idx: index into the cs buffer
>   */
> @@ -1747,7 +1747,7 @@ static int evergreen_cs_handle_reg(struct radeon_cs=
_parser *p, u32 reg, u32 idx)
>
>  /**
>   * evergreen_is_safe_reg() - check if register is authorized or not
> - * @parser: parser structure holding parsing context
> + * @p: parser structure holding parsing context
>   * @reg: register we are testing
>   *
>   * This function will test against reg_safe_bm and return true
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
