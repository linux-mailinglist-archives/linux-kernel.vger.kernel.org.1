Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA91295124
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503187AbgJUQxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502955AbgJUQxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:53:34 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6022173E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603299213;
        bh=tysafz95EGrDRAd4koiebqQvSihPyKOlLcDwNX9+/pI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nd2u+8mcPJFj67p+FKZqC9bf8zyoXyKNuleNaz2o3D31Mb+PFWuxazOaqZBcAmSKG
         /lUrkLr5YixxzONPBEsAAduba0ND2P5zQy2SVOVui0KddeRU/uuJUzhgbapF6BUjkE
         rGxxTL3kEyG1x8l0t+f7XznXMBvd3PvqxopdMV0g=
Received: by mail-ej1-f46.google.com with SMTP id z5so4231308ejw.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:53:33 -0700 (PDT)
X-Gm-Message-State: AOAM530zO/JVhv0kv9gLAeSJYUMT9cQr5cNRCPT9J8KvNafiTIgr07ls
        /nbXaannxQxx/Th7oeTFHIPC/GKqcN/3ueW0jA==
X-Google-Smtp-Source: ABdhPJxYbs5q0DLX41jjFeTCIyysgme2FgAo9xaY3pF7NcxvbRkwTiWrHViLgF5ogY6yUTJoIVQ1f8qIeUuK06BO6Ek=
X-Received: by 2002:a17:906:7fd7:: with SMTP id r23mr4284124ejs.310.1603299211543;
 Wed, 21 Oct 2020 09:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201020152639.21950-1-matthias.bgg@kernel.org>
In-Reply-To: <20201020152639.21950-1-matthias.bgg@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 22 Oct 2020 00:53:20 +0800
X-Gmail-Original-Message-ID: <CAAOTY__MegNwaUGphYNpnKrC_y8SX-_rDNXGxsaBJ6FDBKsQ_w@mail.gmail.com>
Message-ID: <CAAOTY__MegNwaUGphYNpnKrC_y8SX-_rDNXGxsaBJ6FDBKsQ_w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: change mediatek wiki page
To:     matthias.bgg@kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        kuohong.wang@mediatek.com, yh.chen@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miles.Chen@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, Yingjoe.Chen@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

<matthias.bgg@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8820=E6=97=A5 =E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:27=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Matthias Brugger <matthias.bgg@gmail.com>
>
> The old wiki page unfortunately got lost by server crash.
> The new wiki can be found on the kernel.org infrastructure
>

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 14b8ec0bb58b..7d0088782a9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2067,7 +2067,7 @@ M:        Matthias Brugger <matthias.bgg@gmail.com>
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>  L:     linux-mediatek@lists.infradead.org (moderated for non-subscribers=
)
>  S:     Maintained
> -W:     https://mtk.bcnfs.org/
> +W:     https://mtk.wiki.kernel.org/
>  C:     irc://chat.freenode.net/linux-mediatek
>  F:     arch/arm/boot/dts/mt6*
>  F:     arch/arm/boot/dts/mt7*
> --
> 2.28.0
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
