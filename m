Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031272CA5B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403878AbgLAObt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:31:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403838AbgLAObs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:31:48 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5188C2087C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606833067;
        bh=iKyVt3ei4IjF6uUcpgpDuCr1OPzvs8ktfZvmbaiq0V4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oMsqBM0RKejCzfstwlt6YyEpaxDWsKgOG+o0IPk82w9kBAgkGtQL6ftCiJ8ERMZ2u
         cgwTOds2N8B26XkSvBv5MlYgDUiE9ylwA2mJ0qy/1mmvH+QikgJwL40rAjTzcrQnRt
         8tIXOjHigZTfKj6SbWHaYT2ryjk+BGEnLXZ0qT3E=
Received: by mail-ej1-f48.google.com with SMTP id d17so4495243ejy.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:31:07 -0800 (PST)
X-Gm-Message-State: AOAM532hT5/77+YFCwtLALAYFeId+DEUwwXYE1Bb2JPoGSZKiAFjcbqj
        7yiB0rUZ4kfbWh4qJt99xAVsThfuIthGuOq4jg==
X-Google-Smtp-Source: ABdhPJzlHxdV4VGqzoWpb7rYlMAdgwMJ1nH13c0Yed4GR1AZ/tKtVHvegqEicS3dnzhWhT9kSKQM68aoJzZdQwO0v8w=
X-Received: by 2002:a17:906:af0a:: with SMTP id lx10mr3263894ejb.75.1606833065729;
 Tue, 01 Dec 2020 06:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20201116231407.94-1-chunkuang.hu@kernel.org> <20201116231407.94-3-chunkuang.hu@kernel.org>
 <20201130103411.GN8403@vkoul-mobl>
In-Reply-To: <20201130103411.GN8403@vkoul-mobl>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 1 Dec 2020 22:30:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-Dkn_cwb39+G3SHJZdKdiBk9fsUWJN8sfM2fhLbVT8tg@mail.gmail.com>
Message-ID: <CAAOTY_-Dkn_cwb39+G3SHJZdKdiBk9fsUWJN8sfM2fhLbVT8tg@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/3] phy: mediatek: Move mtk_mipi_dsi_phy driver
 into drivers/phy/mediatek folder
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod:

Vinod Koul <vkoul@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=8830=E6=97=A5=
 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:34=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 17-11-20, 07:14, Chun-Kuang Hu wrote:
> > mtk_mipi_dsi_phy is currently placed inside mediatek drm driver, but it=
's
> > more suitable to place a phy driver into phy driver folder, so move
> > mtk_mipi_dsi_phy driver into phy driver folder.
>
> Acked-By: Vinod Koul <vkoul@kernel.org>
>
> I am thinking this would go thru drm-tree, if not let me know I would
> apply this

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> --
> ~Vinod
