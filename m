Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6912B2CEEF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgLDNr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgLDNr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:47:26 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C99C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 05:46:45 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id u7so3239507vsq.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UlVbXqiDdFrt8nR6CihMFsoN+ELRH/W5hnUR0aYu8U=;
        b=NJg5wcNea1ycZ8S7Em9aKmUg4zJ+scn/2jaJ3Yc23Ys2bjNhWpeD+dGbV1GQ8mdmzn
         RP4g/jfeWd7BCK4lhLyr36D91MLki+mvWLhM/3K3H+NB4wV5BUAnDTB1/Jp2JdID3usi
         LZh5T49n/Uf6b+VlgaRdP6zrxm5xZ7uAPfQBrmfqcqL6jjddaUB8PIdfbudG3ll5Cbd6
         g7LynthiqLFicU/22n9WCPkG58KgIt9ExXq7D5sluzIDuytZt71lO45tRd36XPhOAs9l
         DZ2uidd0vFxS9OkZxqREJAxrFUV3HPynuhzPlMqzrx2rVwpjTeGpkWAWH33GAiqLU5ss
         NUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UlVbXqiDdFrt8nR6CihMFsoN+ELRH/W5hnUR0aYu8U=;
        b=LWsOk0chwRO9vDX2J141ipYvlYF76V1JGAOAi9W8SJPcq8P48w7wFODUxCIRpjKbXo
         d02TeLJTHJEq2Dsd1tDYfbOkEL2onLts87kezYgt/3MBPDkF1LU+j/pF1fy9EQm/JL4c
         AWadCirggKwhpYNVuNEXrEfruPBS1NZddnk4QM8n1N9QC8Yd9bHjLbVY1PTY5ByDYe4b
         nlHUG5awqzhXOn7UGbyw2ZM5r89NFWK47fO2YUGZxhlHEvQ2wN7P5I+iksX/unC41ECd
         v2q0i8D0+PRcPS6Fh/s0eDpjtfoqj9wDFgTTuLK4lGBoWEBZYztI5kjcEIoLO15D7i7y
         Ag9Q==
X-Gm-Message-State: AOAM530LfcUhi/MNA789pDt92Vr68c5UOqIlVybaCM9/Yln0FkZVWcdm
        8QKoego+U5JumeEzaBDsPIp44Iz73+3OQpFCo3MpbDGJzPpv2w==
X-Google-Smtp-Source: ABdhPJzvOTASb8hwxalqdFjVpmh0aJPMdLi7oWPRSePcv26AwHOmoVZ+Uwu2dh8ppEpdvyuDl7IFlgv8kd1OsFThGes=
X-Received: by 2002:a67:e217:: with SMTP id g23mr3512620vsa.15.1607089604856;
 Fri, 04 Dec 2020 05:46:44 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
 <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
 <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com>
In-Reply-To: <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 4 Dec 2020 08:46:33 -0500
Message-ID: <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 5:11 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Anyways it is debatable if this is a bug at all. It is just a definition.

I respectfully disagree. Prior to the fix, your panel's active-low chip select
needed to be described in the devicetree with 'spi-cs-high'. That sounds
very much like a bug to me.

> Which is not well documented anywhere.

I agree that documentation can be improved here.
Would you like to submit a patch that improves:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/spi/spi-controller.yaml?h=v5.10-rc6#n28
?
This way, we also get Rob Herring involved, which may lead to more elegant
documentation. He is more likely to respond to a patch than to a question.

>
> What I especially wonder is why you fix that at all in drivers/spi/spi.c
> if polarity inversion is handled in gpiolib.

The reason for that is described in the commit message of
766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
