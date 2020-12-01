Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020CF2CA468
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391352AbgLANwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbgLANwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:52:44 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E0AC0613D6;
        Tue,  1 Dec 2020 05:51:58 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b6so1150231pfp.7;
        Tue, 01 Dec 2020 05:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U8eJNOHS+aUbBXn7pcWjETPrHmmQZ5+rMmh0rfza66c=;
        b=Zs0zlqNz5yvaZTjtyetjqTA/N59AU/PLxzuAxbg7oluNJXAAosAncYfbQ4gqeWRl71
         0sopphmkSvDUwdoxU3STU6Fj0zCQnup0aNfqEJHDniloim4EqK++ST62cD65exMtHGKG
         n/rIQrfHyKYn6bxJ6ovXsnXp9iS/A/r93CPe39cL+1xC/5mK5g8eA6JazRuqdu4lT7ZG
         yjc9sGLJzA82NrkPQasvDOEbbx6Hzbrxl95PTXTJL66BqGMLjKVzuXjENbYZELYFC0Cn
         WVUjPV7nciq/zytcpXGMwpi50t/QJuxkOreYqpn1JWRMUwURwangM2vGkajqATeC9Q1c
         LMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U8eJNOHS+aUbBXn7pcWjETPrHmmQZ5+rMmh0rfza66c=;
        b=ty2ayfYKtPEYlykA1sloUppvkmZDQo4QGLJ7jIIoMU0UE24rP/LdiJO2VJU9QDn4v4
         jeb5W+wWHyHOMOMEblFiK67X0u9SEQ8zrFEMn5u4Lf/aKtuFZLHbnUFd0gw27iD73hpg
         FoxcpSJMa+BfqOsLqx/BIf6jkeJDzjyFXSc6SLZaPPha09RYSZcG90pKm+rvcNF8gvXm
         XlJO8Per/OTubzyVDJScKy9Sp7HWIbxS4aJ5XqDlQPeD0VybUVG4g0MCEIbFtg0I1u/g
         MLYHGBH3toknrvwDPCIRiaXyUdrin3gtqKm8VkoivQPEk8yW0/BaFUnn9SylRuS6TdG/
         rh6A==
X-Gm-Message-State: AOAM531PdGM91/bmZmrWyBIxjZ2Y7PJXRTiiefpHat2O+kwhQMK8l6eO
        P0WZQ1B2porQ+8sdiwjJ71P6e971PGr23Ojy5dHXfCDD6wY=
X-Google-Smtp-Source: ABdhPJzkxeLTyDyGsVXpEwI/AlYj0VzxJq37602ZsfoiCdy29DoYIk86M0FBPsiMCf2cQij+pRUC8uY63L2zmwlZWRk=
X-Received: by 2002:a63:1514:: with SMTP id v20mr2348579pgl.203.1606830717796;
 Tue, 01 Dec 2020 05:51:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606827507.git.agx@sigxcpu.org> <ee2df27df04e6ff01d15255665458be1000dcfa8.1606827507.git.agx@sigxcpu.org>
In-Reply-To: <ee2df27df04e6ff01d15255665458be1000dcfa8.1606827507.git.agx@sigxcpu.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 15:52:40 +0200
Message-ID: <CAHp75VdwnGD+39AHusGvSKcnOZs7q_AfXniTBaA+J=yMqL4_nw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb: typec: tps6598x: Export some power supply properties
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 2:59 PM Guido G=C3=BCnther <agx@sigxcpu.org> wrote:
> This allows downstream supplies and userspace to detect
> whether external power is supplied.

...

> +static int devm_tps6598_psy_register(struct tps6598x *tps)
> +{
> +       struct power_supply_config psy_cfg =3D {};
> +       const char *port_dev_name =3D dev_name(tps->dev);

> +       size_t psy_name_len =3D strlen(tps6598x_psy_name_prefix) +
> +                                    strlen(port_dev_name) + 1;

I'm so sorry by not noticing this one...

> +       char *psy_name;
> +
> +       psy_cfg.drv_data =3D tps;
> +       psy_cfg.fwnode =3D dev_fwnode(tps->dev);
> +       psy_name =3D devm_kzalloc(tps->dev, psy_name_len, GFP_KERNEL);
> +       if (!psy_name)
> +               return -ENOMEM;
> +
> +       snprintf(psy_name, psy_name_len, "%s%s", tps6598x_psy_name_prefix=
,
> +                port_dev_name);

...followed by this.

Please, use devm_kasprintf() instead.

--=20
With Best Regards,
Andy Shevchenko
