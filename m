Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF8C294BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441888AbgJULLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410576AbgJULLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:11:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D49C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 04:11:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y16so2206283ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 04:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A4W516nHeaJArblifyO5xloC9Sa78F58jblVLqZpa7U=;
        b=VjKHVKN6Rl7G5o0v7ib1B1TzhN/XdLVKQWTL6zgu6HxCB1Ce8YXj44EtSDMXAIsINq
         +OqbyfE0+GA0bO6UURBL9wMQzxiz+B3jdIexTVYBW3Y3uFuOIQC182AsCJcLVStPQgd8
         6oFR0wzkMpMSnrmR4l3zvPtotnEilLe5JSd9XtfzeQkI9TeUx46MmWPowcErefEwIMwY
         tK1xZ9beZYfiLAzjmY5gFoesfixPj5Hzye9/XOkRmoBwrLp4BFMGce2Jmn3KNPxrkqh1
         Kgj/AeU0aNMXIMSt4Mujb/1HTu3BJYCLk1NmC1T+aN3+ntgY0La2DJnlTfp8F/tkfmmD
         uURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A4W516nHeaJArblifyO5xloC9Sa78F58jblVLqZpa7U=;
        b=Lhh81s0JqB2+30x++ophMgUFRj2U8HAw7GvD6guxv/1Q2GmstK1vIbKA8Csj0odT1N
         +iXHfTQj9gHLG9i5GUEQHm8m447AnnR/QLCVEcYd006fLterKTy5QCQwMyAn7g9ZAdo2
         8AtDqVCSH4c/8k6+QVE0wfKZXA1EAFckNPtoFaqbuetRX7QvFhsmSGecNveA1IlVDP2C
         QRwx2fdx7Ggg488q1INnJNI3ctkTEJnuPrtLkqoBks9X10ryTahCfaS4+ExMyOhRsZjv
         bn/bZYxOBF3df8JVRvvLOm7r0wynkZnVqau6BXD95LmcNoKJ8dy5jtbfleu6Fb5Fwy45
         z+Aw==
X-Gm-Message-State: AOAM532xZ/9fHNXKlhHthzbmBME3iR3eQWP34bMPFePFtfgBQpQXJbn6
        SIkfPnwnePVyhz/J4nQeez1w9PosVkYWqzQCxHo=
X-Google-Smtp-Source: ABdhPJydI93IW2I74pZFsoEIqfIVovnTUTBYkeaAS6Yn0Yh0ozxXtaoQlqCu/DdtuUt/Rxx8NbfwSaopl/8yO2/gScE=
X-Received: by 2002:a2e:b4f5:: with SMTP id s21mr1255575ljm.44.1603278696233;
 Wed, 21 Oct 2020 04:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <1603262006-28217-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1603262006-28217-1-git-send-email-peng.fan@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 21 Oct 2020 08:11:26 -0300
Message-ID: <CAOMZO5DJ==aRqZAg8hmBZeBy3yeHKxTd08Vmym=meW31hqtWBg@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable CONFIG_GPIO_MXC
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Wed, Oct 21, 2020 at 3:38 AM <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> To i.MX8MP, always met "Waiting for root device /dev/mmcblk1p2...",
> it is because the gpio driver not enabled. So enable CONFIG_GPIO_MXC
> to make sure it could boot well.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Anson has already submitted this change:
https://patchwork.ozlabs.org/project/linux-gpio/patch/1600320829-1453-2-git-send-email-Anson.Huang@nxp.com/
