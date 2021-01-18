Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE72FA2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392853AbhAROV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392872AbhAROUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:20:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC01C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:19:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id v15so12974832wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epHRA9q6PA0dMwVwLxmR5Uud/oMQ/1cmt+FdJAdfyY8=;
        b=cEpRxgA4wj2WsiX1MyF139PbxiR5Ps9fVBEDAle8155t/Fv3YeGE6Bx35D6vFx9DkI
         nXz8zb4F0G1MSXGz+rFCAdyzZK+ATt6aK63B5HEe2yo0cUk/p3h2r6ldrrMqE8d1VO4d
         HxTaJLINWK+bBNekBx3rPh5vrzwEqG2gjhn6z2xtPXo1Z5iBcOa8KdCSkrh116nxxMhK
         dZwn/d7Be8LAWDcpP6EY1o5mlSE2tRS16Of/oAsSoFHJ7TOrN8RxmTPUhcDLGPt+7fUr
         Y8+Blb0DxpVQvdwFzZ8/JtHXOB3bWl+7pphII271xcT5mYFa8Cw9LmljbIh1QuG69252
         ivMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epHRA9q6PA0dMwVwLxmR5Uud/oMQ/1cmt+FdJAdfyY8=;
        b=mJNZxPnLrgEqRjkYzFZrozI/qrh3QVObu9KhEXF6oCP2Krvpiun1EMs21ruicbcqVt
         c0yiDyI6jhyUGWMPED/OqLjlDUObc+wRghaaBgaiFZzHCE+bjYDXkycl3Xuiuw8JlAKc
         tdX6xR9jIBg6AqeXeWwZjh0WE/R0XcKMCpgYenZIwEM9htGK1O2+BLovySfM/OjLHqW6
         ijJu7O7gUMftTipieTiHwcCNw4JzzogK7NOkmdomC9lZvukmcYIDkoynF6eLJ8Or3ie6
         Oazc0GNnYB4V7gzrL/IxWegYVcKMIkecaUb2h5g4Gt3oLFOJR2BUp4TwsaEiAEVAt80X
         1/0g==
X-Gm-Message-State: AOAM5300xMHM7Svx/MlGJmxtCJ6yGvq/Jz+N3G+z2Ret3rlbQb3g0ZE2
        R9BbHYiLYUnLDvtT7rNcL2ycxho4gXRnm+LPGEBezg==
X-Google-Smtp-Source: ABdhPJyifB/eUvs4ZdOglNkvZDgmK25ztadUiJKuvCuNYzfIkI2RAabxhiYJnkh+f7yeIWvtkg8gIJEjUj4PMxwOja4=
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr25720043wrx.176.1610979576608;
 Mon, 18 Jan 2021 06:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20210118065549.197489-1-zhang.lyra@gmail.com>
In-Reply-To: <20210118065549.197489-1-zhang.lyra@gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 18 Jan 2021 14:19:25 +0000
Message-ID: <CAJ9a7Vjd86q4N3V6EJo=ssM0iNBTFV57SB=YSD4CWyTkUQU5Ow@mail.gmail.com>
Subject: Re: [PATCH V2] coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bin Ji <bin.ji@unisoc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 at 06:56, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> Add AMBA UCI id to support Cortex-A55(Ananke) and Cortex-A75(Promethus).
>
> Signed-off-by: Bin Ji <bin.ji@unisoc.com>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> Changes since v1:
> * Addressed Mike's comments - changed to use CS_AMBA_UCI_ID().
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index b20b6ff17cf6..8c4b0c46c8f3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1713,6 +1713,8 @@ static const struct amba_id etm4_ids[] = {
>         CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
>         CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
>         CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> +       CS_AMBA_UCI_ID(0x000bbd05, uci_id_etm4),/* Cortex-A55 */
> +       CS_AMBA_UCI_ID(0x000bbd0a, uci_id_etm4),/* Cortex-A75 */
>         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
>         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
>         CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
> --
> 2.25.1
>

Reviewed by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
