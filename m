Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91FC2F9A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbhARG7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731245AbhARG7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:59:33 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA4C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:58:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 91so15344321wrj.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnkAUdUHFhY2odR39n/9Rvo7dIFPPCLx+Oekpa8Q9VU=;
        b=k7Fxd9hMKwi0DNYO1pJMkrE9+7OfE4HCDtfAYRf69eMMivmBRMMFaMval0XrJat8Rv
         /ouOrJIQBZ7OUr9pJ1nHsowckfjscSKDljac+3dULN8VmrvLVqyBSu8Hro8R0ROOerxM
         8DXcghFiG5AFVfZQPk6O1/Bfyu2urKt1hmcjl6EKaqm7uDPg1hx7vDV5sQvurbEkQ1lB
         v2ZsPXoLb8gdigl7aBfMZEAyf3yINcZ6YnUn3pRPcdA63MjDaTbwBq/c1Nmrf3cDSZxO
         eepIMlyUQQmMUCqkCUlOerTuJ4Vmw6q0pXo2nmR9PGyohKlB0wP5FYeyIXuzR8MXp4mA
         sOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnkAUdUHFhY2odR39n/9Rvo7dIFPPCLx+Oekpa8Q9VU=;
        b=n2oP4fcYGlOTuXFUHt6uuZQp1l0ycRzo1veMGvQWLuTHI1cIkcq0TKcUOjHtdU+yRX
         LIgmCVFX3PmrJ5IVEsD/QwPp0b5ixSVfWrLcPflWUcQNyiZUN8go00b67KgzOQYLBqTJ
         kcBt7Tgnw64S1NlX/CUfJUK+s4R1npzCTY54isMuLkBSLl6NambNm8opwKKVOPlIzqGq
         aIzgI7u1JM4znliSsT1Es6loZz4nRPILDh9xuLIR7ne773PYIiEz44xKyH+KyqxRFZKo
         7fWUqo6qk/BZK820fJFTg7/iAac49rOyHtlolJRbMjfj4uyH8ecvjZvsnL8HsCQs7Nm6
         raEg==
X-Gm-Message-State: AOAM533fVnCw6faaC0H78U3TaHKYUrEUafl/ScQK9T2pQBJMz39UT0A1
        tRKyvHfvB/mZq15Y2PFvx0zkP/XkywYVpBCGBqQ=
X-Google-Smtp-Source: ABdhPJyQsq/LCrj8I5JhVBHmVZTpwWy21zT6fXLs09xdzfzR0sPBkYs16aoGqDlW13ewZ8Hc2jMZXNmnXesP6fB/aN4=
X-Received: by 2002:a5d:6888:: with SMTP id h8mr24571875wru.268.1610953131712;
 Sun, 17 Jan 2021 22:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20210115083933.50522-1-zhang.lyra@gmail.com> <CAJ9a7VgxqZw7F8P2TE_javqq-XqunOupu8iKgyMppb211gserw@mail.gmail.com>
In-Reply-To: <CAJ9a7VgxqZw7F8P2TE_javqq-XqunOupu8iKgyMppb211gserw@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Mon, 18 Jan 2021 14:58:15 +0800
Message-ID: <CAAfSe-u2vr-jbrVe3sfC470=y+=Dc=vffUSS-+gm1cfGnkW=OA@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: add AMBA id for Cortex-A55 and Cortex-A75
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bin Ji <bin.ji@unisoc.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 at 18:18, Mike Leach <mike.leach@linaro.org> wrote:
>
> Hi Chunyan,
>
> On Fri, 15 Jan 2021 at 08:39, Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > From: Bin Ji <bin.ji@unisoc.com>
> >
> > Add ETM amba id to support Cortex-A55(Ananke) and Cortex-A75(Promethus).
> >
> > Signed-off-by: Bin Ji <bin.ji@unisoc.com>
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index b20b6ff17cf6..66c6641c71ea 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -1709,9 +1709,11 @@ static int etm4_remove(struct amba_device *adev)
> >
> >  static const struct amba_id etm4_ids[] = {
> >         CS_AMBA_ID(0x000bb95d),                 /* Cortex-A53 */
> > +       CS_AMBA_ID(0x000bbd05),                 /* Cortex-A55 */
>
> Use AMBA_UCI_ID(). See UCI  comment below.
>
> >         CS_AMBA_ID(0x000bb95e),                 /* Cortex-A57 */
> >         CS_AMBA_ID(0x000bb95a),                 /* Cortex-A72 */
> >         CS_AMBA_ID(0x000bb959),                 /* Cortex-A73 */
> > +       CS_AMBA_ID(0x000bbd0a),                 /* Cortex-A75 */
>
> This AMBA ID is used for PMU, ETM, debug block and CTI for this core.
> Please use the CS_AMBA_UCI_ID macro to correctly identify this
> component.
> See CoreSight 3.0 Architecture Manual 3.0 (IHI 0029E) section B2.1.2
> for an explanation of UCI.

Thanks Mike.
I just sent out a new version addressing your comments.

Chunyan

>
> Regards
>
> Mike
>
>
>
> >         CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),/* Cortex-A35 */
> >         CS_AMBA_UCI_ID(0x000bbd0c, uci_id_etm4),/* Neoverse N1 */
> >         CS_AMBA_UCI_ID(0x000f0205, uci_id_etm4),/* Qualcomm Kryo */
> > --
> > 2.25.1
> >
> > _______________________________________________
> > CoreSight mailing list
> > CoreSight@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/coresight
>
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
