Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755D324FF37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 15:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgHXNmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 09:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgHXNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:42:05 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CCBC061573;
        Mon, 24 Aug 2020 06:42:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f26so9666999ljc.8;
        Mon, 24 Aug 2020 06:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u/tcJcoNjBd65aqyixuPMYO1EjOL24DArTaKRcQSR00=;
        b=BiZxRmOE+xC12DVhSxL3FViWBFtWVsV9ckYM1zZpmO2F4R4pYhAywA5QdYcVbJG/Ek
         zy2Sd77F/NlVe767uNCBSSvCNi7PobDSlucyhApkqvpjIVxb6wEexBeARyugignsEuuz
         MyJUv+RROyabcFliRWNawnSVSQCcXxrWJDpB/I4DAN1Xou/DcS4vwJ/olsUJ/mUGLdVY
         WaJgcjnmBE4SNUm56xIzeWNT2rZRW3fLwhisypEvwzIMfBMPIX388LJwP+WTUbj+roY1
         KKoa1PkXj6KtofZAl2OgoomKTu3SBSE9rKaa1VvA7NyMwrrwSqxcxnBq/x5H5OJXV2OY
         XFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u/tcJcoNjBd65aqyixuPMYO1EjOL24DArTaKRcQSR00=;
        b=T8BtSo+P7h9EBi/l5SrcgYHxI+Zx59MzAFD8vY/sBOkzXnHEWD0KkH+qsrCq4ZnvBr
         cLMgw1MEGkvt1ApjVlyXPO/I47faWtxHLvq3OoH9FwLgrUv76WprlfOWBv1R+Dos1iWS
         xv0E2rj60f1bE2SKXKClj9GyqLytALMcqQBMZYmfmXJG+6/HdFJdEXoMmOl6EMvZ7fZ5
         POW2GJrvx766lh2oZ558RxE/ywiyKeF5gwSZlIav77O/0P2Y0P8jWFrdC4onjbk6qS+h
         qG+irloh3uM0FaynDUpCnyYPScs5oVAL4k23a9Ql3rPOL+XCl/tY+EBKImrx29Rkk4bN
         FrKA==
X-Gm-Message-State: AOAM530zujV/JfrEFuJUzockq37UFP7MlPixFXbxQrYKG0l0Lb3g636R
        ttJeouINONiLtezEDjIcEiUH94mdIBqf+lM+u8Y7TGgA
X-Google-Smtp-Source: ABdhPJy99YCtFNmjhnje+8maJuYGXldM7qWMOvONoQmUneZSH8j64uwO12iXneGBihZRrBZ82TAwjMcXSKVjMwftwfs=
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr2690924ljb.452.1598276520241;
 Mon, 24 Aug 2020 06:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <1598255439-1193-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1598255439-1193-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 24 Aug 2020 10:41:48 -0300
Message-ID: <CAOMZO5B74eiCH0bf-Dr3T8tNVm8wZzPAUaAn858HtVRQ0fUWGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add headphone detection for sound card
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On Mon, Aug 24, 2020 at 4:56 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> Add headphone detection for sound card
> and add audio sound card node for imx6sll.
>
> Shengjiu Wang (3):
>   ARM: dts: imx6sx-sdb: Add headphone detection for sound card
>   ARM: dts: imx6sl-evk: Add headphone detection for sound card
>   ARM: dts: imx6sll-evk: Add audio sound card node
>
> changes in v2
> - add pinctrl_hp, don't add headphone detect GPIO in hog group

Series looks good now:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
