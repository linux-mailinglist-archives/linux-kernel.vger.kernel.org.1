Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757382A9DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgKFTRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgKFTRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:17:00 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B225C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 11:17:00 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id h5so1283745vsp.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 11:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjxcjMM64AoPrrGB5WU2iaP3zlHzPJnCO2/knh+pBZk=;
        b=ChDMhKoR0fYHz6+pG+digC/UdlOyMfTyTXxZYVDmx1L3K5ftT8gUyphVat8s/W/5rS
         wA3PHUwayVERFcspmZbwzWdlnfg0Fd+rr4fDUkeEFIzDweo4TafrzXhjqk1DhyuzjX9L
         QCmbfPMjuFoEKAXO1AmcXscV3L7sp69Pd9xf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjxcjMM64AoPrrGB5WU2iaP3zlHzPJnCO2/knh+pBZk=;
        b=VO5de4LHHMePaUU8G/UmPBsxYvOlZ5gUbgUw72axnfH4OxGl6ML5VtBjdCj0FJKE4s
         i9E2eMJ6G3paT90q49tfo40vRRuV46TopzT8W7DMdebN+2CoKsfeQoXbiIo8hA8WGcOa
         0epYLbLEgBPCenJucRpM2KO11vn5wj+UA98DhY3d0Dg2InXJPGyYW7fSF2Upd7tkOVxN
         mQwTyzYUylZXLXOxalXc1zciKPpeoEJeNInLXcRuVzSAFwkM5bGh9Kjh5nwWAerjmrbz
         GLBfVRDfjtrBt/Ew9u527+qhNs+5t/rCT3T+xOnWbXlf3ilgvazBD7SHUI1iRLC0/Om0
         U4Tw==
X-Gm-Message-State: AOAM5318lqs3y2U4/Lf9qPfZE97HRLRohaqUgBxiv545h/96MaT1fwng
        7zES1WZdcnExsa9yt4PobvCgdfpPhzEWFw==
X-Google-Smtp-Source: ABdhPJwbCuIC2EUEgBsmOQd37gCrIZzEUuA7q/EtoJw76eEOBYmGbZd9auorIjGh5v3IkynaEnDXYQ==
X-Received: by 2002:a67:3384:: with SMTP id z126mr2277736vsz.38.1604690219397;
        Fri, 06 Nov 2020 11:16:59 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id g123sm272495vsg.5.2020.11.06.11.16.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 11:16:58 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id w67so438762vke.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 11:16:58 -0800 (PST)
X-Received: by 2002:a1f:78c7:: with SMTP id t190mr2166294vkc.17.1604690218042;
 Fri, 06 Nov 2020 11:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20201106182333.3080124-1-swboyd@chromium.org>
In-Reply-To: <20201106182333.3080124-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 6 Nov 2020 11:16:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UFk9Lb_E4-qHdmzdC2VHOmn6emzg3YgbZWGPAdBpSnJQ@mail.gmail.com>
Message-ID: <CAD=FV=UFk9Lb_E4-qHdmzdC2VHOmn6emzg3YgbZWGPAdBpSnJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: simple: Add flags to boe_nv133fhm_n61
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 6, 2020 at 10:23 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Reading the EDID of this panel shows that these flags should be set. Set
> them so that we match what is in the EDID.
>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Fixes: b0c664cc80e8 ("panel: simple: Add BOE NV133FHM-N61")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 1 +
>  1 file changed, 1 insertion(+)

Yeah, generally I haven't found that the flags matter, but it's good
to match what the EDID is giving to keep things consistent.  :-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
