Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B632A83D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbgKEQq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgKEQq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:46:28 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF90C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 08:46:27 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id i19so3542393ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=29qYUBnstFfboFv2mg9vsqVSbBZs0I387vj3YfVm6dk=;
        b=II5shNoJCK2Cewg3NSaPtC8aobDS9l/lHDPEYf75bZtespCqW7Gm7ib5oXSfJYW2Av
         R/C/JQI0JjqMMFvXAQJw/FImOUhQvYCjUSjLGjKoMmAw3crDiUwrOSzQ/W/APddBRGD/
         /5YufjT/MHA3HjJlSOBmMbm4DYadvE5VuF9KTU9af+bgBZFbQVGpiT6hdwLlmdKZkJzq
         RareYyrJnFF0gOxLqZvoeB9+FxVnaUyZwVkugtG9MYMR2kMgURuQUhGfYcWY3jtXtTGc
         J1ugyS0ZaoGbuFHHu4ShH+0oP989l5ZBPVvZBKVR8ebhPxAYyuPFCR64c15BWF0pTtxD
         7SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=29qYUBnstFfboFv2mg9vsqVSbBZs0I387vj3YfVm6dk=;
        b=RvU7EW7d5X37tqCEK7OMd4hGUjoeNT4u+HwyHPdF2lbRNhw1+corTg5unnihQG2q3f
         YzmM3J7pejhruiUUfeVNCGzKIJRdzWIwql0/20Gwx7LLJtqlF4Lno7p8TgI9tfd74ODI
         q5T6LPnzVCLZeXvJR9h20E4TfVMpM6vvb0rW2K/mFDe6Y0ozXp5xfGGhgc6UZ1YMg/Ng
         CYoPx4Nwf5HBYHfB87oZgFBF3MGbnX1HzybADTj0uxDDttqFwtGO1X63ewSLHzFaa0JV
         ryyohtPA1dN++vsjZJtUk6f60gddnAohDgXO2OCACdFWpLwqQ945AdkyncMohLjEhs3N
         ukEQ==
X-Gm-Message-State: AOAM533WSfL8jYYZpZVpLGMBsohFOTxPYOp7blnE53eZMpO/qwPEPTlq
        TrUzztrliUatxXAxh7nPeBA=
X-Google-Smtp-Source: ABdhPJxIZpvnLQNfs8wESkAX/rb+zQv8nqxskl6xI4n2/3VX8PlpMfN61uocZRVwu33wCBZich744Q==
X-Received: by 2002:a17:906:1f86:: with SMTP id t6mr3118790ejr.356.1604594786458;
        Thu, 05 Nov 2020 08:46:26 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id pk25sm1287449ejb.16.2020.11.05.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:46:25 -0800 (PST)
Date:   Thu, 5 Nov 2020 17:46:23 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 11/19] gpu: drm: panel: panel-simple: Fix 'struct
 panel_desc's header
Message-ID: <20201105164623.GF485884@ulmo>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-12-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <20201105144517.1826692-12-lee.jones@linaro.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 05, 2020 at 02:45:09PM +0000, Lee Jones wrote:
> Struct headers should start with 'struct <name>'
>=20
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/gpu/drm/panel/panel-simple.c:42: warning: Cannot understand  * @=
modes: Pointer to array of fixed modes appropriate for this panel.  If
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 2 ++
>  1 file changed, 2 insertions(+)

I think a more common prefix for this file is:

	drm/panel: simple:

Other than than:

Acked-by: Thierry Reding <treding@nvidia.com>

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+kLF8ACgkQ3SOs138+
s6GgJQ/+NwC+0SrX1jbvcPBuQI1k3Fb1qIqdz3yOHf8EhMmez40Y+wftOBahZzBK
A9RtRz/U5oO3y9LrLK5sfmx7ChF0UKQc+16gNPBfvnIWNu3fn+awlcMBADXOD+KM
ouL5/xd/B0GYIyIlLLLqZmduAUv5U2RSytzFzaGjNwPUBY1batE1cVF6acBuQKp3
04GCu1RpRT4QdilNY2EjlDVRRKJyWjN8Vi1RfEd9flsBH5bmBMDcSBnFOXMyA4xN
0shUq8iTTgXQZpb74RyRol8uOmsIBn0JReGVFRMLf9UiyjZDUpyT6l3gahWHkJIT
lBA0r9QNDookvgXHHBm02og+5SrOtubJbB5dhDXdzS/c7MH5PBiCLp4juuiN3Rxh
toak+arn2a0IER26bSUcvdDSIK0IOz8xh5N/jcBF1TLZ7Y+OSbKW0yJlVW3/Q+en
Rxnd0e9Ghc8hFuIPLpSA30QiQTRyUEuBjj5GmD+Zmj335VP1obigowaGBAKwFEQ4
O0tWC0y1+TcH1Yw9Fk7dYE94sQnZTAX7dK07U0ezHqll3rb/jT7BNlmxbDqSEjex
HtL4KuPbBsNToDP7y1RmwREfieSfzmkuF+l/gvpoVtPDsc6UAcwev4CLLOofz3K7
hKMjRLywIdCePbx5PjbMYJPiyF/xLQ65n9JuiA3EJ34SFSpRiDk=
=THD+
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
