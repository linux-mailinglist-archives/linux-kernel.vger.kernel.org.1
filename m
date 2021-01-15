Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6466F2F890D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbhAOXA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhAOXA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:00:26 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DF4C061794
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:59:45 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id o19so5936122vsn.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBeHYBPs8O+PuMBSXIDj9EGHakvLyVLX6sC/5Rr17Uw=;
        b=ND4BhA6Nr8vjqjBtdcIkQkMJzPTFPMG+L9xCmvlLIbeVS/TMzcLLcKSWxLVLWFh+zl
         KW3OjtmjZjtir71AO6GCHm9ejeO1o9+wshl3qk/RKumMzQQc1/Nr3yxA/JhFbk/gu0F4
         E4Qe8P6iLBuy4RzA4+JoUtE9xsTKt7+a8wsr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBeHYBPs8O+PuMBSXIDj9EGHakvLyVLX6sC/5Rr17Uw=;
        b=g/jieSSM1cw/Z7ZT0Rlm2k2PUzQj/sDuANQY9uwERsEc8dJM7eA9OUL+Rmq7fphzRn
         6EdJxv9QyeIUb2u1zhH7pTojqMWOf6NFpGlkA0acTxt8RmQXRtAgU9EydYkikIOvbfdb
         K0u60lrMuKP26m5dwffb+F8aNn5YWYegEsaHsr8vT6z7sLEdzi0qH4PTTbQsIjuunhpj
         eyCBVsEFS1e/WfvDKCMmCjYO4OlMO8+gxSf5khryP2/5MgANfurd8gDdJXQFAbDSXyUF
         sGTm8OH5eodDsH4kBTpuA0tpxCmKytQMz+Q0erIu8YPfLYE25mR7AIXNX1Akoy+VppxI
         DTqQ==
X-Gm-Message-State: AOAM533YOrqFfmlIduA2jmuqZrskEoqmENTXCXqMMhgvR3tiAxFJtrsV
        B1xiwB+8OWHP4TO/bMAIzjVC3ebREgOvxw==
X-Google-Smtp-Source: ABdhPJxR87DGdkvtAkRsM3T7GuAej70V/cev/y9dYfzUdNLQc/A4I7RBxBomFvFnTL29WynYgt/qJQ==
X-Received: by 2002:a67:dd95:: with SMTP id i21mr12826068vsk.33.1610751584488;
        Fri, 15 Jan 2021 14:59:44 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id y2sm1446689vkg.47.2021.01.15.14.59.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 14:59:44 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id t15so3435593ual.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:59:43 -0800 (PST)
X-Received: by 2002:ab0:5a70:: with SMTP id m45mr11259619uad.121.1610751583152;
 Fri, 15 Jan 2021 14:59:43 -0800 (PST)
MIME-Version: 1.0
References: <20210115224420.1635017-1-dianders@chromium.org> <20210115144345.v2.4.I6889e21811df6adaff5c5b8a8c80fda0669ab3a5@changeid>
In-Reply-To: <20210115144345.v2.4.I6889e21811df6adaff5c5b8a8c80fda0669ab3a5@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Jan 2021 14:59:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X3LgTz1x_C_y3u1cypa80qikOnvmo-v2sETkfaDd_ChQ@mail.gmail.com>
Message-ID: <CAD=FV=X3LgTz1x_C_y3u1cypa80qikOnvmo-v2sETkfaDd_ChQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 15, 2021 at 2:44 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Another simple eDP panel.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - ("dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1") new for v2.
>
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)

As per always I find my typos right after I hit send.  ${SUBJECT} has
one too many copies of the "dt-bindings:" tag.  I will assume this can
be fixed when it's applied.  Please yell if you'd rather I spam a
repost.  ;-)

-Doug
