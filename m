Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9309A29FC3F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgJ3DgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3DgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:36:17 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55824C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:36:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c9so86366wml.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpTdrDRkqx2HX8+Ao111ZZvDGbkWV2lswjjfmR4K1dg=;
        b=c5sOUUNO35F+/uRRrQWpGRjzlAaWaPvjaRgOYEytNZzbhfNaEGmMAejM6C7j5X0nR8
         LdUAIS7lMnpDHHkYwEnYs/Q+/ahDCNV0mQhDOw5UTiEbu13xLRT17AiwT2P5x86QWDbg
         kiEW4igiK5g0LV90sxAu8I4k6Cfi0o2BOn82hjqRBfLNZQ5HSYDi0JabNlP4Axy2R59v
         aCSA0hRmc0AuJYDO0Om98ySQfY8PHzZq1TGD8pFOEcMRdjIsmxZxusgUhu/HFVAOUpjl
         jjJFVjKpDOYhF+WNGBUFlY9t5hAoDLghEf6jbhrYNibOBowTthy/NIvIbZLwTT6MR5oD
         CWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpTdrDRkqx2HX8+Ao111ZZvDGbkWV2lswjjfmR4K1dg=;
        b=HQonO0Cw7mmK5byEZgpbbSCcfmyZ4UjI5J9oNhclvdZaatKTb93B9oC+Neae705XZz
         LNZkzBvw3yec4jy3WqLOnLUhlX1qyIVSnIDxeKC/ePCI2rm8LBihf37uGWFOb61NWc4z
         QiKYm00/2bg5m5l077KcY7KM2L0gzJpzv/FUQR1jY0xTrSHr/VObQZZaSz3JXx3/27Dz
         W05d4wC2cX2pgra91Bvu/RrGXnRL8WSwrXbv2w0SdguUgV8igcI5kjboh+MVqQYy7v2p
         3ObJfojuCUTFgPZPdPtnvhXryAv7WiQouYAE3bCv2h+fH0KYXNapD84rI10Rv4YcaNj0
         ZO4g==
X-Gm-Message-State: AOAM533xjoHKuIGH9PBJXpU9EVwod1wv5s1lLv99Gyqidvv+d20/n2p6
        6oYIVi4J1uwP8rqLRQdt+r8jBh0LcQwr5RyR9K8=
X-Google-Smtp-Source: ABdhPJzlszIwtuyR37tOF74yRqXeK392gG6mumSjaKF07bpgrRkjdTgLuooTCjjPn1TPiCczetwbTzYAENFdaix/rIQ=
X-Received: by 2002:a1c:e403:: with SMTP id b3mr194500wmh.79.1604028973927;
 Thu, 29 Oct 2020 20:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201027200708.1596235-1-trix@redhat.com>
In-Reply-To: <20201027200708.1596235-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Oct 2020 23:36:02 -0400
Message-ID: <CADnq5_OrW7UR9a-UFq_OhVE445L0jr9EKeyaG47s1nhO2tDi8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unneeded semicolon
To:     trix@redhat.com
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        "Cyr, Aric" <Aric.Cyr@amd.com>, "Cheng, Tony" <Tony.Cheng@amd.com>,
        Igor.Kravchenko@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>, joseph.gravenor@amd.com,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Oct 27, 2020 at 4:07 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> A semicolon is not needed after a switch statement.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 2 +-
>  drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> index 7b4b2304bbff..5feb804af4be 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> @@ -858,7 +858,7 @@ static struct clock_source *find_matching_pll(
>                 return pool->clock_sources[DCE112_CLK_SRC_PLL5];
>         default:
>                 return NULL;
> -       };
> +       }
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> index fb6a19d020f9..ee5230ccf3c4 100644
> --- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> +++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_log.c
> @@ -280,6 +280,6 @@ char *mod_hdcp_state_id_to_str(int32_t id)
>                 return "D2_A9_VALIDATE_STREAM_READY";
>         default:
>                 return "UNKNOWN_STATE_ID";
> -       };
> +       }
>  }
>
> --
> 2.18.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
