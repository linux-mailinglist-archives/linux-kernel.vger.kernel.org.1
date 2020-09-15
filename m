Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4426B6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgIPAMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgIOO0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:26:30 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA54CC0611C0;
        Tue, 15 Sep 2020 07:25:16 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y17so3296434lfa.8;
        Tue, 15 Sep 2020 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2ena36266wspP5Tvq0z3LkWyHPiOIA4EJedY59v6W8=;
        b=WAKxs8a8KXr9nguLjtBBb9lvjVcObesbz4bgZPIN6UV8LTMWJLG2hsQOUWcUjKJJOe
         +ry+c/ulbt7UJhJOjZoNu2gCG3dw3XAlntnnCt3u6grclGsrY5bRvnhv40TBxclnXH6D
         ffpP1PCig83WCd8UFDFgEAbHGq2we4MMKShlv40XIYwkARD+GpATv3PkTzlOZumFeM6Q
         /Hjil6otG/utDTP/xseXKQ1eTNuvo5Zob1mOvG+71Wu0zozlgUw7r+sqsDi8efJK25W/
         7JyKPdDhYQLeQ8puWbNqSHukcc7NAGsKbvwxmm164hbsgSbDlBQUKhYhM0Gm5Fm1s3xr
         8BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2ena36266wspP5Tvq0z3LkWyHPiOIA4EJedY59v6W8=;
        b=GiEqSvY0OWl4C+yvKO9BNly3pMOb7cdkafr0t9hYO3NvbaDrAyq+XqUgbPs8NawB9O
         adHs67kPN2EWzfrDIF8OSObNU16Tg/qVNqgohVs8j6/xQ3t0niuWI1cOjQCXmTDqgVN/
         4cOMv1IiEGGKQ+7gafoF66c3wSemwqmsxAK/ZE+ZNCzQ+lrUmgG+RNY8FVCwNJ3V+LU7
         OaJ9qQ/b5XheiB/Jc4t5BuHWKS6Puw9A7GgjTP1IhBLl5ml/VgcwMfCKSpepb/zs6zrI
         voszd/O1PYIp3L59LaNFObk+tQ/BZkuHtceZvX2QZFB/oTk1JDxs/S2rkYsCny5jPf4X
         p4XQ==
X-Gm-Message-State: AOAM532zB8LbZRBGbXraHA/EmV0/UG6djGqdL6OLr+RwMPOqM7FNL6tU
        zgPnrHPVrwb6DEaT2LSHtSvC7/QxoUTy8fiq+II=
X-Google-Smtp-Source: ABdhPJziiDvVv5TwjyT08hovVM0PLo9ow1i+dQdNZ+baakeZcwhIiYbCH+Y2gkFMgubUzmc05g4szm56woQ7TLPYUIo=
X-Received: by 2002:a19:dcb:: with SMTP id 194mr6279863lfn.25.1600179913805;
 Tue, 15 Sep 2020 07:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200915140141.42876-1-yuehaibing@huawei.com>
In-Reply-To: <20200915140141.42876-1-yuehaibing@huawei.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 15 Sep 2020 11:25:02 -0300
Message-ID: <CAOMZO5BOBqCoLgM=yHBKFdM3oXR91mDdRnJY1gOyGmQWiMq+Dg@mail.gmail.com>
Subject: Re: [PATCH -next] clk: imx35: Make mx35_clocks_init static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi YueHaibing,

On Tue, Sep 15, 2020 at 11:02 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fix sparse warning:
>
> drivers/clk/imx/clk-imx35.c:251:12: warning:
>  symbol 'mx35_clocks_init' was not declared. Should it be static?

This is not the correct fix. mx35_clocks_init() was only used by imx35
board files.

Now that imx35 board files are gone, this function can be removed.

I will send a patch removing it.
