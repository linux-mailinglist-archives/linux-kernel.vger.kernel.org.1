Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6552C2AA8D9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 02:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728752AbgKHBxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 20:53:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727871AbgKHBxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 20:53:48 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D44A020888;
        Sun,  8 Nov 2020 01:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604800428;
        bh=Gig2SIDrt7cb+ATUHWOVvdgio0+3OMp/2fZUD1joO84=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cdVBU0e2I4Ed0XKksB5eDB0tzB3II0mmnjw10uFt7lv1lc3pFe46KCHonZnxvvaDc
         /i0eXcxbTCUrvG5hxSbXsdQeqVozcJagfUSIRqLXak+ZsDqXvTZP+Y47LHFx1SAW4Y
         ptL7fc3qvGxSIhIgk7IXsq9Gnf67/O9RP4vEXkKM=
Received: by mail-ej1-f50.google.com with SMTP id cw8so7292029ejb.8;
        Sat, 07 Nov 2020 17:53:47 -0800 (PST)
X-Gm-Message-State: AOAM530l29R3uWtr8NahQ5mPgAt7IROteXiF2J4bhBsxpt8cAOEUUaM2
        VjvJe5pJlp9JDLyYEQnOdRpqRjzL0IJZ/oiY6g==
X-Google-Smtp-Source: ABdhPJw+JMkdcxFi2E62CLyHrr1EHcjqGBZXOrhKRS2LNp5+RUTgSOC9eBSIEnz/5eF5WsZ+Jh1CBEJHez0gc15GkMQ=
X-Received: by 2002:a17:906:cc4f:: with SMTP id mm15mr8912480ejb.267.1604800426455;
 Sat, 07 Nov 2020 17:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20201023133130.194140-1-fparent@baylibre.com> <20201023133130.194140-2-fparent@baylibre.com>
 <20201030154944.GA3905431@bogus>
In-Reply-To: <20201030154944.GA3905431@bogus>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 8 Nov 2020 09:53:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY__vuGYRi+_8Aokko9JmPN1-nvrsWSdBW3Tij6raKe-cHg@mail.gmail.com>
Message-ID: <CAAOTY__vuGYRi+_8Aokko9JmPN1-nvrsWSdBW3Tij6raKe-cHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: display: mediatek: disp: add
 documentation for MT8167 SoC
To:     Rob Herring <robh@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Fabien:

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8830=E6=97=A5=
 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:49=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Fri, 23 Oct 2020 15:31:26 +0200, Fabien Parent wrote:
> > Add binding documentation for the MT8167 SoC

For this patch, applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > ---
> >
> > Changelog:
> >
> > V2: No change
> >
> >  .../devicetree/bindings/display/mediatek/mediatek,disp.txt    | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>
