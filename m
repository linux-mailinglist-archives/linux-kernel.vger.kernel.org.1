Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C4D2A80BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731015AbgKEOVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730943AbgKEOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:21:06 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A33C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:21:05 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id 74so2534678lfo.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZzDmTp+Cx9xiy3l7a/3HUobFreQEXAoNRDoJMIB+dY=;
        b=j5qfXvtuye+LDrJ8cn8oiGjVXaW+/DLAc8UcbLbT033ClUvxzJhTbrKNxZrlpwDazv
         tL+6SFUt7wMJuASPm8C9z0mdNv6Ot/HwdXiAEaB+qTEKVRzlyreGDYSeSTf4aBm7S0tD
         x99vnBeHxRjP+8B4BG23raPlcFDAqsOpOu8e7bpzCQUxM+J7vkOnfCGK++SYfwV7w+hh
         xd9HpqLIwsSobTSF3ROpHfKDMk4Txqw5bt0n9OQ2j0qVt4I3Rzfe3KFiTTJecYogoZEp
         mtPf8NYjKWFn+vUb2CYLLTisgxQ0R+hIqVpNhpYkAC8FvCvOL9Szbg5aIy/uIeJpcdHc
         YmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZzDmTp+Cx9xiy3l7a/3HUobFreQEXAoNRDoJMIB+dY=;
        b=UuAA3m15gYYhkzZJ2P4QgS+Prj4YiV/4qgf3xqKWq4EP+GQahRjaisAdpnMuI+XymL
         wgFUnX4rEHHdCUcWDnEwv019Cv5cmK+4+cVWWAsg+3AjKoq3BW7tq1+b3mDeyfiKuGiK
         idcjOmOwn396PH+0VMoTUxmYZnbJM2LuZZWXBQ1B8ptc4x+rZKAzpRNIIZb8/ivsV7Q1
         Url+jTTbLksbe76fcMS141PyL+gR/lHvXikofKQRmufrPLIvudti/tc9xzAnvKX3AYGt
         IGgS2I7hkNEGcvz+UErWv+AEnQuer6+Cyi9IctGBp3fthrvYIKq60yOFYUvbGVmBuLIm
         6wug==
X-Gm-Message-State: AOAM530MumR348a2i6NDdJjGxc/E9DOGHCjAdmCpZYIUQHuUzPkOuUlw
        WN+6QjiMtGGzI2T3r8coBdMYac+thMNFrBKXxCKnuw==
X-Google-Smtp-Source: ABdhPJy3Z/j4XZjBZhJmurIWWAFx+TSCzZvuAiLP+FXiiCtQ/cfh5n1flpcgct7dmvjpZZn5bTyzaP+YU62sblNF27Q=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr1172912lfc.260.1604586064299;
 Thu, 05 Nov 2020 06:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20201029134027.232951-1-lars.povlsen@microchip.com>
In-Reply-To: <20201029134027.232951-1-lars.povlsen@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Nov 2020 15:20:53 +0100
Message-ID: <CACRpkday541uM4csZ4pn7mYw61YSnueVVvHJmwEVB0YhRT-HVQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] Adding support for Microchip/Microsemi serial GPIO controller
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:40 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> The series add support for the serial GPIO controller used by
> Microchip Sparx5, as well as (MSCC) ocelot/jaguar2 SoCs.

v7 is starting to look really appetizing. The kernel bot is complaining
a bit so please fix that and follow up on Andy's comments as well.

Yours,
Linus Walleij
