Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB02E0DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgLVRo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgLVRo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:44:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF07FC061793;
        Tue, 22 Dec 2020 09:43:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x20so33818853lfe.12;
        Tue, 22 Dec 2020 09:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzzE6j+cx3HB7AE5Awf/yeHA62EAEZFv6jwWV43vnDw=;
        b=Zq377Eyn29CoDW4CcVmdhTAbJPgeIt26XFqQCqOVsuccfuksV/6Ph8SjhQ5tqRVFqc
         joC46t8OidNIABR2Lk+n6P5RAPSL31hDOq1Hdxs20wk0WdfpRTKPd4L0jzFUA2GkDXtz
         ThAXKMkBSj8jT2BGMTxhzetOHrAcUYxOFi1tGBUJOCUIAJ0K0+mG079zOfW0MBzTdrTR
         sbFV4AL+mpGK0VU9DjHfUTaceDKAjfZX1u0JB8EofPwtCaAut/uPhyD9jSqk86KLD9bC
         /dW6doe+8t67AscwheTvvYL7BuNpWB6yDYUzd4B3Ju8M88ylzkiEiBGe9boekA0mTozN
         znpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzzE6j+cx3HB7AE5Awf/yeHA62EAEZFv6jwWV43vnDw=;
        b=ED5dZ7gCnPw5QN7AxXzAE/AXFQJE2IaOgQREYhBwelBbkuRoHg53/pjzbV8yC4Ar7w
         MWAO3IXxC7fEak9Ltv/dmwa37zIZfaXxvxc3FrvX3bO36fj9nyrteFnTcl9zF/+IIog7
         Gl4cDwqtDtuUG0NYaXnfERV2i3Zvug1b2/MhnwZ6jtjXX39hskfXyyHnFmURq8GAnvsi
         KhDwtvDRGnd4g2kKUreMGEhQh7RS96dV3wXuINDdt9hGd2YKao1Sf7UBhMd5eOm0irqz
         KRyQ6sJtSur8fgqw0bQj0ulSf90FbBUuNJTl3gCipZqtl28e3m/W9MPvcwH7Riq3bVeF
         fjxQ==
X-Gm-Message-State: AOAM531ofyeYTddPT8nkoHc08WTeWQ0Dh0hsZqTuqWB2PiIK9gHD1sbX
        RLfO0mtfFYw0R0WjKdHHbQ2KXelWlU95nH3+XgU=
X-Google-Smtp-Source: ABdhPJxyuv0poFZOZhnYBBHfFDujtLJGFpl4FAb9IsmdFFVl+pr2rkjuETOxv3DHpLVwxHPJ1zgibs/q75sJSCZJSjY=
X-Received: by 2002:a19:e20a:: with SMTP id z10mr2462849lfg.295.1608659024192;
 Tue, 22 Dec 2020 09:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20201209220903.27058-1-lukma@denx.de>
In-Reply-To: <20201209220903.27058-1-lukma@denx.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Dec 2020 14:43:32 -0300
Message-ID: <CAOMZO5B=+fsPuoi8LmZEk5tMmAfkwPj=8_G9nb66iTgyebw6XA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx28: add pinmux for USB1 overcurrent on pwm2
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mans Rullgard <mans@mansr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 7:10 PM Lukasz Majewski <lukma@denx.de> wrote:
>
> From: Mans Rullgard <mans@mansr.com>
>
> Add pinmux setting for USB1 overcurrent on pwm2 pad.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
