Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AB327E623
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgI3KDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgI3KDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:03:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27EC061755;
        Wed, 30 Sep 2020 03:03:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 197so793830lfo.11;
        Wed, 30 Sep 2020 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6qspn01NWn8HRLwIZnHAxe0/BySrc7LTnFF+a+HiA10=;
        b=n56H9rODV05DjWdDRaDEeOMCcqS/xeqc/Oy4IzVrD0cY2BUznVLlKKM1Lm3NRywEJh
         IBu9VXwqtpAR9I/PJETWqBG5CVEWR4eNuwP1dhYH4w5ew2iDXC6CBTjXC2wEu1jCXLXF
         yzpqP+Qcj3p0JESHrDYdR+6GxRc0JbAPtUlS+HXRw63YSlpBi84tM2Zy7+wq0AvWwXbX
         dXPXNHPBgNRO0W6oy29KZ4+fHBC+cX9krS3NHYlmBLs1QiVV5Fql5zTu9uhsmf54GSNB
         Ep8fg7xJIq5VaGoZSUqJsC2Xyh4cUVvMmOL3uug4s8wxs9wrCM5FJEKfwWIysDEX7plB
         VfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6qspn01NWn8HRLwIZnHAxe0/BySrc7LTnFF+a+HiA10=;
        b=WuHC5sH5m7TBeJSfvr66z5rNx8xUsxr1WZjVdtSbogRvw9EDnl/hXymzaQ84QZnaFG
         ysZjqIIYjHhjPdOA3xFkXJIYL2po6kMXZLrbni3YxKhErU2gBeoF6uyVh+ynuCoNSA2Y
         liqEVQkLDR4DrWYmmOeElM40VThHQqeGpAz4Enwg7qin5xv9+iwrRpLX9gYtTWJXbqqY
         cZZVlLXIMwINX/RUqCjx9407c1zc0UMdHCCpds2PnFRlLUk4zHVkXQBVFDyEY878FotE
         Gwu436TRGCi8u3c2AHEOV7TtX8uDxgZGsK3VykJ4f0wUnwwDbUC2moTpQwonOAt5/bKG
         ajXg==
X-Gm-Message-State: AOAM531mTH66xR+YaV+0DEw5rSlw31VpQIXfGqRPCImKaWtiAUO5nI0a
        J/cr6IQZ0zsoSE2zhXCTAm4E+QFyg4huX11Uv/Q=
X-Google-Smtp-Source: ABdhPJwkpM/1GjBv0FpeirzkqG0YElUX8P+nWSjaVIVCOIbtDJQXUUG2xAlxm8QlAuUkM3ZV9Qxz6UBOOPxlP5Camew=
X-Received: by 2002:a19:4a83:: with SMTP id x125mr653912lfa.38.1601460188546;
 Wed, 30 Sep 2020 03:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <1601277584-5526-1-git-send-email-u0084500@gmail.com>
 <1601277584-5526-2-git-send-email-u0084500@gmail.com> <20200929150624.GA583524@bogus>
 <CADiBU3_7wj7W2evOAG1GM991OigPYy4FXraeOLCVreaMO86HXw@mail.gmail.com> <20200930094224.GA4974@sirena.org.uk>
In-Reply-To: <20200930094224.GA4974@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 30 Sep 2020 18:02:56 +0800
Message-ID: <CADiBU3_My=dpV1ef82PSs5wme8q1-fgPxoTLiQbJRcYd6KZw_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: rtmv20: Add DT-binding document for
 Richtek RTMV20
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, cy_huang <cy_huang@richtek.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Sep 30, 2020 at 10:23:49AM +0800, ChiYuan Huang wrote:
>
> >    Due to that already merged into your regulator for-next git, may I
> > send the patch to fix Rob's comment?
>
> Of course, yes please.

OK, Thx.
>
> > And I also found one line need to be added into rtmv20 probe phase.
> > Please check below.
> >         /*
> >          * keep in shutdown mode to minimize the current consumption
> >          * and also mark regcache as dirty
> >          */
> > +      regcache_cache_only(priv->regmap, true);
> >         regcache_mark_dirty(priv->regmap);
> >         gpiod_set_value(priv->enable_gpio, 0);
> >
> > Can I directly merge into one that includes Rob's comment and the
> > above line to be added?
>
> Please make it a separate patch.
I'll send the separate patch by next.
