Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B101B292C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbgJSRGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730552AbgJSRGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:06:18 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E0222365;
        Mon, 19 Oct 2020 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603127177;
        bh=0O1fhJYNZelW5IlOs5LX842TXGsnkAfhUi+vSpLlLEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v7lhCyYxO2IAejY4XtXtiwc4whRS6uQV1lYeCuroS/EEctzWODXNTnUTtNguaI+mz
         JbWhhXSNrFIo3ymIIop1a8UYKkIN80pu/AbUgoDfn0TrQEwAgJiZiMmZOVFv5uZV1e
         3ecpgzkwkTa637cz4jGMWy+t9u9rBLM8U1xfHTkk=
Received: by mail-ed1-f50.google.com with SMTP id p13so57291edi.7;
        Mon, 19 Oct 2020 10:06:17 -0700 (PDT)
X-Gm-Message-State: AOAM530duXQSfgZu3sgzjV/kYk0uzjAZz9cJZW2cZ2Dwol67qg6VIXCa
        jgUkcvFYz2O7Sk7dUdcdxG3D9hvEIeb4fHJnoaM=
X-Google-Smtp-Source: ABdhPJyxGPC/GKoJUw/Nkd9Pik+1J1JxIOUpJXCguSpUW1ESiyaEuX3B+znG3C6aqVitqC96v1zxV6VeCvuS9nQxPp8=
X-Received: by 2002:aa7:cf17:: with SMTP id a23mr796273edy.298.1603127175197;
 Mon, 19 Oct 2020 10:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201008212706.870115-1-aford173@gmail.com> <20201008212706.870115-2-aford173@gmail.com>
 <20201012170016.GA5369@kozik-lap> <CAOMZO5DVxyR+h_jqDiJyx=UxYaWtYNG2iXso2CZ3EF3BRenuag@mail.gmail.com>
In-Reply-To: <CAOMZO5DVxyR+h_jqDiJyx=UxYaWtYNG2iXso2CZ3EF3BRenuag@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 19 Oct 2020 19:06:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcyeKEQ=UevTsj0mVrGoHYYZvQ9UqeWKVbCkSnydTzwrw@mail.gmail.com>
Message-ID: <CAJKOXPcyeKEQ=UevTsj0mVrGoHYYZvQ9UqeWKVbCkSnydTzwrw@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm: Add node for SPDIF
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Adam Ford <aford173@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 at 18:56, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Mon, Oct 12, 2020 at 2:00 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> > > +                     spdif1: spdif@30090000 {
> > > +                             compatible = "fsl,imx8mm-spdif", "fsl,imx35-spdif";
> >
> > This does not pass the dtschema validation, so only "fsl,imx35-spdif".
>
> Shouldn't the dt schema validation be changed then to accept this format?

Depends. If a given compatible is in the schema, then the answer is:
rather not. The DTS conform to schema, not the otherwise. When
dtschema is sent this is the ABI to which the kernel should conform.
User-space or other SW (e.g. U-Boot) could depend on it. Of course
there are exceptions...

If the compatible is not in the schema, then of course it could be
added if there is a need. In this case, device is simply compatible
with "fsl,imx35-spdif" so there is no real need to change the schema.
Just use the existing compatible. Look at one funny example in iMX:
drivers/pwm/pwm-imx27.c. Someone created multiple compatibles but does
not use them at all, because the hardware looks exactly the same.
Therefore driver implements only one compatible because entire HW is
compatible with fsl,imx27-pwm. In such clear case, why adding many
compatibles? It's just a churn.

Best regards,
Krzysztof
