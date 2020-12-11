Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D272D81AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406703AbgLKWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406588AbgLKWLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:11:33 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6584BC0613D3;
        Fri, 11 Dec 2020 14:10:53 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so8934397ybc.0;
        Fri, 11 Dec 2020 14:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=beFuTZHlQUG6A7iamEsvcuT3puooRZJTH0eQbfttlv8=;
        b=gTkFhpixTGqIIbr14JaJaN80C1csY1r0GynZtNTZYQ2asNWy8bhCkMRwVkCrq6xW2W
         ijMFd4+XZzPQSfTmhTlFLT3LClU1QLbBNLa59TOFO7fIIaHvkAlsgSNdREsMuY+Be9AD
         0MFb7VLvWV0gVXntlGO/6qpkyZLvL91KHN9LGQ+U1vwWpG1VReRF1xd+cXOJ+DY8i5Eu
         lW4Ks+85n1galUlsulOa1rccCmfNTSYU3FEz0795UVxj5N+dIa9WQXAx0gH/pIyjcdE4
         dHVjcWbqn9uB5vQpNlG72m/yJ0OC5xgrADCnalIzsCUKvwtLAlzBBHvy650PDdvAofVo
         YynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=beFuTZHlQUG6A7iamEsvcuT3puooRZJTH0eQbfttlv8=;
        b=NxspSXC11/VrFZOkvmJytjIq8rgu1ZiWR2OIgLBFlFihljpbR/8Kaqk+QKhv6gf9ht
         DVBILt6sipSJ2D2AMzHYR0zME3aZHM4uOOzQkOJN8VfYdkN2VRl7fqJU5kLbx+GbnCp4
         Kn6bRV2tpqd/WjymazXRLHky0ldXRuCHc6rvzhBdyGwvwmpLeKascOE7DCWKJX3/5Fsz
         u8i6paB1sNyLwIlS1Ep7dHew/COx97lzlFDXcXpX0ISLj05waXO/7xYAbEU/L4askuf8
         sTI4fNWjMRGD8yDszghQUzBh1h0iREc4+Wl5F/go1N2LpXWXR82cOEnKs3VKSB6BTort
         EnvQ==
X-Gm-Message-State: AOAM5310S+wuaIX6oFnU/Tl4d78zMOZGP46Jz8kBDZDdaeX37wDYm3wi
        NqbTF8F66ShTDIGOOOQIYjSXkB6qk1XLngsIStE=
X-Google-Smtp-Source: ABdhPJw6ojIU8cQ+KTB/allJKlNPB5V1vrHfxGbq7D/wNiOHL3Ja9KAgnPdkIxIoqCeMg7jprZYOvXN3XXKtC1rj/DY=
X-Received: by 2002:a25:4b42:: with SMTP id y63mr20375156yba.10.1607724652760;
 Fri, 11 Dec 2020 14:10:52 -0800 (PST)
MIME-Version: 1.0
References: <20201211215942.5726-1-zajec5@gmail.com> <20201211215942.5726-3-zajec5@gmail.com>
 <3bc097fa-3bef-396f-a4fd-fa8acbc1b71d@gmail.com>
In-Reply-To: <3bc097fa-3bef-396f-a4fd-fa8acbc1b71d@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Fri, 11 Dec 2020 23:10:41 +0100
Message-ID: <CACna6rynfMxC3wsctSPqRscjBVgTMHZpMwJ3Hn77PqGnmSo4hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: bcm: add PM driver for Broadcom's PMB
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 at 23:08, Florian Fainelli <f.fainelli@gmail.com> wrote=
:
> On 12/11/20 1:59 PM, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > PMB can be found on BCM4908 and many other chipsets (e.g. BCM63138).
> > It's needed to power on and off SoC blocks like PCIe, SATA, USB.
> >
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> I will do a more thorough review tonight, however do you mind moving the
> driver under drives/soc/bcm/bcm63xx? The first SoC that had PMB was
> 63138 and that one is DSL.
>
> And we would probably need a MAINTAINERS file update for this driver?

Sounds good!

--=20
Rafa=C5=82
