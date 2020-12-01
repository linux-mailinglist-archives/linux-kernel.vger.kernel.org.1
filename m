Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49ECE2C94DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 02:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLABvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 20:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLABvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 20:51:41 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302EEC0613D6;
        Mon, 30 Nov 2020 17:51:01 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id p5so124829iln.8;
        Mon, 30 Nov 2020 17:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=em4YU42Fs6lSBwH+JyScO6dSKH6FGFIk8tAnL75Dz34=;
        b=CIAjauV1yX8a6ogo9BAT9XwExhmpU03eb44Ku59Vkgd68h1RqaPWaFDo/EpoUSMdEq
         GbkU77UupGI1B+ZLQURhBeBflaD/kJqEWaIwaYjPimMFAZ1AHAOvQgKFUkCqwbP5U3gM
         wrUJGOlZLEZaP5m5YEjcgJRbqq7h2QMVlGU4YpZ5fd5r2l8M7stOpefVQCug87Y8CfQw
         mt1yse0bkhuRbFUYvWalMjh3XgQ16nFQ+TieS2WMJJge173aoTDERViKYfD3G2odO6vu
         OcihRPnI39rJLqwPVbfdhYp2+cMd1/RfW0r87gVcI4qMs27VfLOwqtcEA61qtSpIfpnR
         1IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=em4YU42Fs6lSBwH+JyScO6dSKH6FGFIk8tAnL75Dz34=;
        b=BOZL/Zt0AC5x1behuum+7feKfda8v+SLGBLiW+iZ/69xN3y2eD4PK8V5MazjST1M6+
         3COrqbGYNNpkviq51Qx1eOK1y3cvdSoLWKwoQQ9PRHfAfdpDebWZ/2mjGsxn5K+oGp4Z
         lOGHbDvyWqFTJx3BFgUAwXFE0Bqdtr8QxL8IebLUZPvvdb4ad7LoRJ8ef2OAa+gYiayd
         HJAXqLv4vOHaAz5yKZHdZeQfkHfCLiTqXqFzFN+Z72tpj72eBVlDQkZ1afpT9nxIzBEo
         KrNVPXRnZvxphfrpv63xrbgZATc4szpp3UqFSzVpDyXu6JtzFTF8HjZMD6DuQ0gpPyEs
         Ix9g==
X-Gm-Message-State: AOAM530kwqiOKk2wRDWr6dlfNbG32OZsxTwGHydW1lPnBrbAKZNuEGXH
        YuibN5DRmw6cRmGlaIUBuEwXAKn9ndzlwtpr+50=
X-Google-Smtp-Source: ABdhPJwjiN6p/qStPk13tgf0UmwOMI/OARKj3UxZ7e/eUnj8ai0C+Ttr48c7PQwV624NnzL1JW5S7LLFPSetxOoIobU=
X-Received: by 2002:a92:cf4b:: with SMTP id c11mr610910ilr.46.1606787460409;
 Mon, 30 Nov 2020 17:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20201107144811.1977108-1-aford173@gmail.com> <20201110033243.GA31601@dragon>
In-Reply-To: <20201110033243.GA31601@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 30 Nov 2020 19:50:48 -0600
Message-ID: <CAHCN7xLdB4q=DpRYOiPVewbpqGmx3aC4Ktm27vpUsNYtfppFcg@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: arm: fsl: Add beacon,imx8mn-beacon-kit
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 9:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Sat, Nov 07, 2020 at 08:48:08AM -0600, Adam Ford wrote:
> > Add beacon,imx8mn-beacon-kit to list of compatible options.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> You need to stop posting patches that have dependency not accepted yet,
> or explicitly mention the dependency.

Sorry about that.  I wrongly assumed the series dependency would have
been accepted by the time this was reviewed.  I'll try not to do that
again.

Based on your e-mail from [1], it appears as if you've accepted the
other series upon which this depends.  Is there any way this can be
reapplied again, or do you need me to re-submit it?

thanks,

adam

[1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/20201107115809.1866131-2-aford173@gmail.com/

>
> Series dropped.
>
> Shawn
