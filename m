Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDDB2FAF66
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 05:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbhASESd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 23:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbhASER3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 23:17:29 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA699C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:16:49 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d13so33850661ioy.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 20:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZJDrgzZmYXfIo0lGIMXEXiySIw3gPtBzcGCID7s8Rw=;
        b=LcbM3pmru0ucPXbMjeSV2nKL0tNYuwj4P09n7fLfJPRKFXp2iIi7QXy/+oQYIs9uvG
         VHMTvgy0LY64CPN9Ugci67iTo1g4+gw9SR79kPv+XTLTCZFvDAc7wp+iKxqK2y6H6EWf
         Qvmw/MOkOu0xWdJ9HNukA/J8BdAgyhfZSMpMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZJDrgzZmYXfIo0lGIMXEXiySIw3gPtBzcGCID7s8Rw=;
        b=kpCL2rC1IkM7eYo2nZ3IknbPdj5F6rAqsHvuKwDgLMeMJNBzRia4LgB3K+1Evjtied
         oK+laWxhekMFCtQuOH0kIO8EDCReQr/yu4kJ1b6OfDo8ev5caZH4og2mJiw3YSjDHwC4
         Vs47ZTnuD4IMFKdkJLBxgUjP7EG/fhNRvU3S59B0nOmnUqdsAz1EOjqoF30yegn8uZS7
         0dhr/rEQcYPnsiLdtRcY3TcsLTLJPnP5ETIBtTODOhnYGOxfH+rH6qiKdwYUtVy1wIyE
         ekuECPOpzyF1cWwb0yfQIZDZOo6DvjUSCNuVt6HyaRINa1fOWrkQLCYgp7y3EzDSE1WG
         rPxw==
X-Gm-Message-State: AOAM530bXw6Sl7NpvaNzsBBgpelyCr13rE/7GFYiM8c6apNs2i3xBoTZ
        Sfe5TIfhMPovP8/mNsjs+5B01upW93QTYqJfsvZAjw==
X-Google-Smtp-Source: ABdhPJx1/ogNcijA0/Z5AfgmfPpBpPyqkRKX8ipSYmZcentmAty4lVh6xCNc6+Ml/YaghCmRKnI08Jm+P91hO3WNZy4=
X-Received: by 2002:a05:6e02:1a8e:: with SMTP id k14mr1905628ilv.308.1611029808923;
 Mon, 18 Jan 2021 20:16:48 -0800 (PST)
MIME-Version: 1.0
References: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 19 Jan 2021 12:16:23 +0800
Message-ID: <CAJMQK-j_5oWcLSrsVAvjkDKUJOSeZbS6aqZQML9etYJLctRX7Q@mail.gmail.com>
Subject: Re: [PATCH v4, 00/10] soc: mediatek: mmsys: Use function call for
 setting the routing registers
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 3:06 AM Yongqiang Niu <yongqiang.niu@mediatek.com> wrote:
>
> The following series are intended to prepare the mtk-mmsys driver to
> allow different DDP (Data Display Path) function call per SoC.
>
> base 5.11-rc1
>
> change since v3:
> - move register operation into mmsys path select function
>
> Yongqiang Niu (10):
>   soc: mediatek: mmsys: create mmsys folder
>   soc: mediatek: mmsys: Create struct mtk_mmsys to store context data
>   soc: mediatek: mmsys: move register operation into mmsys path select
>     function
>   soc: mediatek: mmsys: Use function call for setting the routing
>     registers
>   soc: mediatek: mmsys: add mt8183 function call for setting the routing
>     registers

patch 01 ~ 05: I've tested on a mt8183 device, so

Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

>   soc: mediatek: mmsys: add component OVL_2L2
>   soc: mediatek: mmsys: add component POSTMASK
>   soc: mediatek: mmsys: add component RDMA4
>   soc: mediatek: mmsys: Use function call for setting mmsys ovl mout
>     register
>   soc: mediatek: mmsys: add mt8192 mmsys support
>
>  drivers/soc/mediatek/Makefile             |   2 +-
>  drivers/soc/mediatek/mmsys/Makefile       |   5 +
>  drivers/soc/mediatek/mmsys/mt2701-mmsys.c | 254 ++++++++++++++++++++
>  drivers/soc/mediatek/mmsys/mt8183-mmsys.c | 110 +++++++++
>  drivers/soc/mediatek/mmsys/mt8192-mmsys.c | 149 ++++++++++++
>  drivers/soc/mediatek/mmsys/mtk-mmsys.c    | 180 ++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c          | 373 ------------------------------
>  include/linux/soc/mediatek/mtk-mmsys.h    |  25 ++
>  8 files changed, 724 insertions(+), 374 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mmsys/Makefile
>  create mode 100644 drivers/soc/mediatek/mmsys/mt2701-mmsys.c
>  create mode 100644 drivers/soc/mediatek/mmsys/mt8183-mmsys.c
>  create mode 100644 drivers/soc/mediatek/mmsys/mt8192-mmsys.c
>  create mode 100644 drivers/soc/mediatek/mmsys/mtk-mmsys.c
>  delete mode 100644 drivers/soc/mediatek/mtk-mmsys.c
