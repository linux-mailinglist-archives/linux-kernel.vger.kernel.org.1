Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5824AD0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 04:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgHTChz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 22:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgHTChz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 22:37:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F1C061757;
        Wed, 19 Aug 2020 19:37:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j15so195311lfg.7;
        Wed, 19 Aug 2020 19:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sUjnzZV5m+ARna7xY+BiV+mxbOU+kCqv+Puf4T5BzIg=;
        b=LFBm+FCUm/dIhquQdxHMfkroC3TqWMlFvuHkerELBRGXTmh9V16Nn59iA06VULsA7S
         rweSmH1yZXIog7LuPKY31lavRyNbkmrRBz9bQYxg5iKO4T1bIBZCMc5EFr1fsFCPozk1
         8hjz1pt/ZMJyUrvaAqYyuHpKQsnCfZOpkke74/XQPszUPl4ehL4yh4aWg+8bANsrR81e
         9KVmOAW7mlGf3WKoWOVZiYlyeGXJGkcOZiEF6VUy62Axf5qDG9HkgcNgdJSawDzilwDg
         VcS65Ja9rJiQnyN3bEhaNlcI8kflmhMpeFFdu2P5PJnZHWM6N1YIS36/Hc2GSoPZiNC8
         +KHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sUjnzZV5m+ARna7xY+BiV+mxbOU+kCqv+Puf4T5BzIg=;
        b=Cn/CZEqHtZ/SGPtEQTbzNqTHI/EJTaZtF0rk00BqyXL4NKfSZ9Q9eLGTQcuQ2GXxkf
         7KVjnFe9VI3CHBzUe7Sz02DcleDDRrolEflLpEoleEP4imloKJuzIIZSgWNKgEMXxwf5
         jKgTRfjGiSxTbck++W3R9PhSAXLEINk0vQ6WaP0N3Pfjryrf4jxnT4u60K4CiaIcz/2p
         +ybFH+kjw3yXwFNyGjmzBuK5nKAd2JRb0n8rU8zXoJSzaRiYQ9TJI7/dx+3XdTPXkwuk
         mOtRJGu19zB6u/X9Uq4M7ZGE5sOQ1ptUjiVw0UMkl2uS8udbFen8BAT+gtv4bdzzCZrF
         Hdvg==
X-Gm-Message-State: AOAM531uRzhGoGVDI2K/D27yhEqMSkcTpxaxmjT4EyxplKO7/CjFcQUZ
        d4jdkulfO9fEBXNq+oDlqsiFwHvnpjuskvhzvCm/yMkp
X-Google-Smtp-Source: ABdhPJz4XLTTVO1b6bZO2DcQVd/uXc3LpmxSDEzBE1Ry0fNqxbae0vYrQR1gY3z7RIo8+BZwLkTlX4Naq8ymMMWrmWQ=
X-Received: by 2002:ac2:4ecc:: with SMTP id p12mr491396lfr.212.1597891071643;
 Wed, 19 Aug 2020 19:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200817022746.3115005-1-cphealy@gmail.com> <CAOMZO5D=g-_+gmZ+=tDvEOZNqW9zBFTkKOWamzSoFWgm_fvkAQ@mail.gmail.com>
In-Reply-To: <CAOMZO5D=g-_+gmZ+=tDvEOZNqW9zBFTkKOWamzSoFWgm_fvkAQ@mail.gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Wed, 19 Aug 2020 19:37:40 -0700
Message-ID: <CAFXsbZqGX-FFnf+_-HoFLzo4uZPOiaj-q4iAfokvgeuzj0n5fA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vfxxx: Add syscon compatible with ocotp
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 3:08 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Chris,
>
> On Sun, Aug 16, 2020 at 11:28 PM Chris Healy <cphealy@gmail.com> wrote:
> >
> > From: Chris Healy <cphealy@gmail.com>
> >
> > Add syscon compatibility with Vybrid ocotp node. This is required to
> > access the UID.
> >
> > Signed-off-by: Chris Healy <cphealy@gmail.com>
>
> Would a Fixes tag be appropriate here so that it can be backported to
> older stable kernels?

Good point, I will add that in v2.
