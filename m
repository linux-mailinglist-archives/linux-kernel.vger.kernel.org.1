Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0672F66FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbhANRJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbhANRJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:09:15 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:35 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id i6so5841325otr.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJ76hElPviEmL0kai1yU1qfanE+KP56ktX49es7QOLA=;
        b=VLRraNpf8Uod0P+jXq5oUWVhmv0tHCnpj0PBAkhb6VVRbTd2M0G6yfOhWlavZ0DaBy
         Q7UCBBLeB/dNUjXghVaJ6FQTgmtOJJ0YOwo5NG5pSau2j5NtBgrsbMLJGIP8aM5dqIed
         KKopZzR9oU90sGzZ64oGsA8W9NGW82xUs0qzXl41Fak4fpMJKG1nS8bnjrdig/lY648c
         CO2FCHr16UTj8tSXZSYNFO1OCo431r789AdSBcqR5W5d+FZ1pvYZbDQT/x6a5lAfB+aD
         uogwcRMteU08B0zE5XEGT6lUPBTnoF72sJW8I35Z5XxEDlSbTlvKtm+PmhMDCFRmhjJO
         rB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJ76hElPviEmL0kai1yU1qfanE+KP56ktX49es7QOLA=;
        b=fC4XPmVQyjKmy393UeSr5Ni+IQUp4UyMLMIWrdGAYBiZsLaMJwmX/GvQEKoxsY0fYw
         VcHvufveMYOTX0mAmBBnlehTLdBnO5IrdmOgJMzEf3JgdoLAXySkZZq4W6OFG0IUIoFY
         et43dTKjrf+Njgr1YyZKVAMl79jhiC0tUAiaOmgNdVwEMKJvP0fhw8f7IOq4Dd9aRc+p
         s5Xh4p4+930XLz/o5xWoUPLBV6IBj43MkBhMhF+oCUZtERngWkRcM8fxSCz9+jFWdBMD
         kWXp4zQZVPVPClHXQaD3C2Nu4MfwUimvqeqxNiFg6QkKfeqVaby0v3UAfHEqe0+fVyN9
         +uvQ==
X-Gm-Message-State: AOAM532QpJS6/Nb+ws5rWjt0rzizSVEaekIc40sDJWLYhr36rAmgR4Gn
        JLlrkM9j9VUnsegcrvPyTgp1eKBAujmgd3nRwoY=
X-Google-Smtp-Source: ABdhPJxEO/hs3H3eMB9abvpHfAIzUeDjeNa8BAjSdlHYHxcsp6EAq+lPgPgEsgv3I5tRm4PXiz2ZMDNoCq+6fbPxl/g=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr5449231ote.132.1610644114763;
 Thu, 14 Jan 2021 09:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-8-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:08:23 -0500
Message-ID: <CADnq5_OO8xcFHzmnN2-=k9sC8Fb3UnLy4EGeHu6Dh_kmJxkXgw@mail.gmail.com>
Subject: Re: [PATCH 07/30] drm/amd/display/dc/core/dc_link: Remove unused
 variable 'status'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function =E2=
=80=98query_hdcp_capability=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:599:28: warning:=
 variable =E2=80=98status=E2=80=99 set but not used [-Wunused-but-set-varia=
ble]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index f4a2088ab1792..8ccda8b9ac2eb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -596,8 +596,6 @@ static void query_hdcp_capability(enum signal_type si=
gnal, struct dc_link *link)
>         dc_process_hdcp_msg(signal, link, &msg22);
>
>         if (signal =3D=3D SIGNAL_TYPE_DISPLAY_PORT || signal =3D=3D SIGNA=
L_TYPE_DISPLAY_PORT_MST) {
> -               enum hdcp_message_status status =3D HDCP_MESSAGE_UNSUPPOR=
TED;
> -
>                 msg14.data =3D &link->hdcp_caps.bcaps.raw;
>                 msg14.length =3D sizeof(link->hdcp_caps.bcaps.raw);
>                 msg14.msg_id =3D HDCP_MESSAGE_ID_READ_BCAPS;
> @@ -605,7 +603,7 @@ static void query_hdcp_capability(enum signal_type si=
gnal, struct dc_link *link)
>                 msg14.link =3D HDCP_LINK_PRIMARY;
>                 msg14.max_retries =3D 5;
>
> -               status =3D dc_process_hdcp_msg(signal, link, &msg14);
> +               dc_process_hdcp_msg(signal, link, &msg14);
>         }
>
>  }
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
