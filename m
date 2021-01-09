Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2289E2F0344
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbhAITx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbhAITx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:53:58 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C387C061786;
        Sat,  9 Jan 2021 11:53:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s26so31264277lfc.8;
        Sat, 09 Jan 2021 11:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cl+kCq9RgNjHFtJ0jMkOqkZFX0EZ3i6SD4sOc9QasOE=;
        b=A2vHOYTcitTVq1idzX6qJHQ0ZeGNGVZ01Fhfv7n4B8YNp8436zDaEefui8g3Bh8DcA
         bG2+5Jk+vWvS6MopTUqfgIjt0kij4kE/8SGjPXdPXlI6AIK9VJfm+aPd0cGs0AFdICxd
         eygbNr4OL2Hkp+v+YsVgpBsrny30pd7j0UZ5hPAt1etVHYoSeVSjKbqWOIe7VzW5fT46
         q0l85ZTiE1x8S7PnX2ujkqykHCt+g7zN6YFz1xBFjf9TiIF/xC2gLzR+xys+X0ni6MRk
         H2arIS7UJehZLSPhyatw1QkZml1kex9+2DQql9RGpuP3iKJNN3OdKtmsgyP98BdFCnNC
         +VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cl+kCq9RgNjHFtJ0jMkOqkZFX0EZ3i6SD4sOc9QasOE=;
        b=hf70PhX7AAx3Af0Y/P8DA2nxrv2+MdYjBBKeK2L3jrUXSw27rdx/nunPmdOps1s0DT
         f6ra+3pSk38SVByMk4sUPjKfookwzEDgdFvkDGqMW1r+A8xqUIdpLdsCf0LfNx47miHB
         EvZ/b+hCyYGc3he/JkapgG4stJWZbML9bn5l5OmmFFnWnSxvb63xyHU2sA6nmUEJJzF+
         +FdypAaAkYNazh5aXnSvx0++9krOd0T9pKjrIoUDVMzq15cmninfPnhufsN8znvI/qfZ
         6gSWYCtCYq2NaU53QXvaC2kdhM5qSxeCYQKf+ZmT02MjBogyl9vchTM2HXEqN2zrCK0e
         NwQA==
X-Gm-Message-State: AOAM531bEgULvSk1n/M2b/HsQn2PTg2wm6J4AwpoXFIN0Tka1cPziCwZ
        W85uzdv+/6ZEinKYr5uzL6R1oOG0AVgwzugElFVhZxvNZFY=
X-Google-Smtp-Source: ABdhPJzU1r2eTx3+DSxC1CZupRwItg9PZXkK2YTXlGkB10rcIe0vN6ZbKdYWFs0pXmzFjK5gqvhzT0eUA5VBrbbEbe4=
X-Received: by 2002:a19:e20a:: with SMTP id z10mr4568621lfg.295.1610221996906;
 Sat, 09 Jan 2021 11:53:16 -0800 (PST)
MIME-Version: 1.0
References: <1610144511-19018-1-git-send-email-oliver.graute@gmail.com> <1610144511-19018-3-git-send-email-oliver.graute@gmail.com>
In-Reply-To: <1610144511-19018-3-git-send-email-oliver.graute@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 9 Jan 2021 16:53:05 -0300
Message-ID: <CAOMZO5AGro=rGTPV0CAWPh_=Q9KqCYWO199FWn57xBc=eUWdog@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>, parthitce@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 7:23 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> +       panel1: panel-lcd {
> +               compatible = "sgd,gktw70sdad1sd";
> +
> +               backlight = <&backlight_lcd>;
> +               power-supply = <&reg_touch_3v3>;
> +               label = "gktw70sdad1sd";
> +
> +               display-timing {

If you pass the compatible, then you don't need to add the
display-timing in the device tree.
