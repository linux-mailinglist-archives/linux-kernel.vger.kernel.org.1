Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADD285516
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 02:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgJGACa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 20:02:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgJGACa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 20:02:30 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6967214DB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602028950;
        bh=tFASekccPs0uwtl2alfNzpZUiMaOcFfZ7JluNg7mEA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zGOcAx3ib718MRD2RusoZpw7CLWDysskCpjbMp/zPQMDTANZ9ugFs8eixKxbeHFpr
         mYlTcDyp19X+py+ph+AiO1aiw9ZXnJ4L2yQlVz/5V5D2U0lwO627vw2WYIX5d3Z6Hv
         xcpov2M8GpwsEiPrqkMlJHSk1Kz9FfPwKKaUOlOU=
Received: by mail-ej1-f49.google.com with SMTP id c22so422105ejx.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 17:02:29 -0700 (PDT)
X-Gm-Message-State: AOAM531gW0O56cVetdh02kIZ/4Gb2WOzvmcjnyaMjtslyvS9nXZT3iZb
        1xiF1Sm3gzW5WtKfsvrRC9T5IW3w2qkpFRLOAA==
X-Google-Smtp-Source: ABdhPJzI0UQRn161pSh9DvK7aC7kX0LiTZEqKOHL2UdsgF9XLDlxe42OFso0BYlFjTvNoWRyaboTRlzMmZrRdV7tVV0=
X-Received: by 2002:a17:906:3716:: with SMTP id d22mr538107ejc.267.1602028948530;
 Tue, 06 Oct 2020 17:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201006193320.405529-1-enric.balletbo@collabora.com> <20201006193320.405529-5-enric.balletbo@collabora.com>
In-Reply-To: <20201006193320.405529-5-enric.balletbo@collabora.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 7 Oct 2020 08:02:17 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8R=aOx4y6=fenA_hpm4A6-zqiiyrM_S3G3AZHLzUppoA@mail.gmail.com>
Message-ID: <CAAOTY_8R=aOx4y6=fenA_hpm4A6-zqiiyrM_S3G3AZHLzUppoA@mail.gmail.com>
Subject: Re: [PATCH 4/4] soc: mediatek: mmsys: Use an array for setting the
 routing registers
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2020=E5=B9=
=B410=E6=9C=887=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:33=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> From: CK Hu <ck.hu@mediatek.com>
>
> Actually, setting the registers for routing, use multiple 'if-else' for d=
ifferent
> routes, but this code would be more and more complicated while we
> support more and more SoCs. Change that and use a table per SoC so the
> code will be more portable and clear.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/soc/mediatek/mtk-mmsys.c | 393 +++++++++++++++++--------------
>  1 file changed, 210 insertions(+), 183 deletions(-)
>
