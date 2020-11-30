Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDD72C9262
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgK3XTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgK3XTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:19:42 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F28C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:19:02 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so13025128otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sDj8+eA3XzCGTPEcZqsXANYYErSR6D60R/FMQNZhI8Q=;
        b=GCokUG2Vos/8YIH2ozrpiXqKT+XifoavuGNKAo+UTzjldhW2+cYmsm2TG9ZM1P7l2o
         QxXqNIXiOCGSbQuTf5oKrj4ZzTxJS+YZB+Litse2iIvPu5dEcSEapeBqAME4g625b06+
         ZZZ9/BFxnoxHLK7ORHVQ6Q3MYfD//L2CnZfwsBdKidoAOeCX30FjH8Ki0uKylS2WNg2Y
         08RVp8jYemiEDetAmdY6mR0j902aNAMcBLER82jDMM49TIBbq2A4gr5LVZYg0noQJ5yq
         QD561xfTka1jFcN8QoP6SjZD9Ge/l4EnYu6xSU0wvk5KS6MTZSvMILQf0bgQMnQp1OTu
         AX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sDj8+eA3XzCGTPEcZqsXANYYErSR6D60R/FMQNZhI8Q=;
        b=E+pNaKbDwJ5mT6wFAQS677coEx/lR4MxBFoGgXAmAkaJvFRDSTjG+ziEC22AYFJdfc
         Ljsst5IFHqGyTcso8tt2lRfqkAHhmQ25suBDu4cLDsvzYsSbcIEhNftxineVyrqJNPcX
         YW4fP9okNuWU70ek45yM1X/Eo+ogD5Utt4Km33THvMSH5tR0mbaC0EClouHg6vdMsry6
         N3SRMo7N/0EfnWgut9vV1e3N17Rdwwpq3pD18V9FG2B//TO7+oLxWdFea6xHECC0Ee3G
         wj7Vfl/PBGVpXw4uT70oLxxpmioYN+Pa5OHDJ5rE+p2GgX3na8D0Tk7CqP0fiNHhHyRZ
         OtOw==
X-Gm-Message-State: AOAM531oH13r/JwePCA6Tr+JYxxNVePLkitFJ5l3EDXbAh1Htd2wqc4e
        eQ1Hk4kBFW88XdJFZrkm3mqF8g2hseN3a0Ee8kA=
X-Google-Smtp-Source: ABdhPJyMRNKB10VZELvZJOkmhj/54W+6hIen4Tqd4lQGadPUj9bd/ahylxC2LJQz7vhb0rdxcrz1XRDeFqMIEvKcxN0=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr18918840otg.311.1606778340333;
 Mon, 30 Nov 2020 15:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-8-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:18:48 -0500
Message-ID: <CADnq5_P4rYdFuK-_iaWmD+ZGk8ECs9PsOrVhRXMNWGWnXvuGZA@mail.gmail.com>
Subject: Re: [PATCH 07/40] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Demote
 kernel-doc format abuse
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/fiji_smumgr.c:1107: wa=
rning: Function parameter or member 'mem_clock' not described in 'fiji_get_=
mclk_frequency_ratio'
>
> Cc: Evan Quan <evan.quan@amd.com>
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
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> index fea008cc1f254..02c094a06605d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/fiji_smumgr.c
> @@ -1090,7 +1090,7 @@ static int fiji_populate_all_graphic_levels(struct =
pp_hwmgr *hwmgr)
>  }
>
>
> -/**
> +/*
>   * MCLK Frequency Ratio
>   * SEQ_CG_RESP  Bit[31:24] - 0x0
>   * Bit[27:24] \96 DDR3 Frequency ratio
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
