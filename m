Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E0A1CECCF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 08:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgELGEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 02:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726347AbgELGEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:04:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334EAC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:04:51 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k18so3555049ion.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GmXNnj8j0/DuRakjHfxnYDbYR3/p1C2Z1WRm/EsJUCQ=;
        b=m7upY6SSbbF74mMD/6Ct02MUFC+lcQkE0M2ZSEfUwz8/zFr2LXYe+zyjsa7QHwNxLU
         E1xtIq6cls/6Xl5PC2oNnB9MLcngcGNCboLNlcaeqdA/QhxuPYlg6fSrcTJ1yt3PhSm8
         p4nRLQKIhwwNJhMXFsKo8spE1CkbB7rxxDxOXRA7BfDWjuXaNdcoB7xzLfrvlvITzqGj
         GRDhl86kJpFQABV/jgrZEMNArbKiAHRlWiOkJuHnOqoDLPX8y/BKcsiIq/fZA9FWsRgS
         M6x3a8yUDx3NluBpbUUiWoIc4eo6aHzDUy3W/pNCYGkvOGYvjt9nct4K+D71V8iCXDLZ
         4eXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GmXNnj8j0/DuRakjHfxnYDbYR3/p1C2Z1WRm/EsJUCQ=;
        b=U/aX3Ats2hcNjzSDrNgXXymu9CM154CQ5DCLhi9uoSmSU8M+0d477OOmg5hJ0vbKmd
         46DxBbS9W/4B4JUB+02Wg+FEVxgOgONrbqUlex7+BVlP1AK1mYSXnil1czCNGS1awMu1
         u8wSUef2ccHjaXJ5EL3oUTGv7E4wnhj8GogSXcmf/8ze21dkLfaMVAca5EKETw1NWvO5
         ngKHjECKqLZJ/pbMJ+D/coW6vFWpVsYVra3etA3WzM5cAXT7G8zTPePzCl89rLkJSlWO
         SGLFZZDRqW4NAIk6w4l1W48e9tymdNduyDMJWbO8XEnP7vQnIaFMVKSiSYkTNYxk7VIb
         q6EA==
X-Gm-Message-State: AGi0PubPLkRh0M3vCLZCVj/KTSa9hvYVAx2SEcIYP64usfA3eU87z8W8
        Ma64lEUXLFpsK7Rdlslg/XOx5ZcmcKOQpSbzCnJnxw==
X-Google-Smtp-Source: APiQypJHsy1ID5UWXbduZedwCawN698UUwnJAsyuBfNBmcx4c7aVWyTBXfSDemrrZVvNV8ztJq5Z7EWAvNiviNgU3nE=
X-Received: by 2002:a5d:91c6:: with SMTP id k6mr18867980ior.13.1589263490440;
 Mon, 11 May 2020 23:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200511150759.18766-1-brgl@bgdev.pl> <20200511150759.18766-6-brgl@bgdev.pl>
 <20200511.134117.1336222619714836904.davem@davemloft.net>
In-Reply-To: <20200511.134117.1336222619714836904.davem@davemloft.net>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 May 2020 08:04:39 +0200
Message-ID: <CAMRc=MdUCkgCo8UndDbhQRZt_tXJJjtR4uM2g05N5ti7Hw1f2w@mail.gmail.com>
Subject: Re: [PATCH v2 05/14] net: core: provide priv_to_netdev()
To:     David Miller <davem@davemloft.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabien Parent <fparent@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Edwin Peer <edwin.peer@broadcom.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 11 maj 2020 o 22:41 David Miller <davem@davemloft.net> napisa=C5=82(a=
):
>
> From: Bartosz Golaszewski <brgl@bgdev.pl>
> Date: Mon, 11 May 2020 17:07:50 +0200
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Appropriate amount of extra memory for private data is allocated at
> > the end of struct net_device. We have a helper - netdev_priv() - that
> > returns its address but we don't have the reverse: a function which
> > given the address of the private data, returns the address of struct
> > net_device.
> >
> > This has caused many drivers to store the pointer to net_device in
> > the private data structure, which basically means storing the pointer
> > to a structure in this very structure.
> >
> > This patch proposes to add priv_to_netdev() - a helper which converts
> > the address of the private data to the address of the associated
> > net_device.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Sorry, please don't do this.  We had this almost two decades ago and
> explicitly removed it intentionally.
>
> Store the back pointer in your software state just like everyone else
> does.

I will if you insist but would you mind sharing some details on why it
was removed? To me it still makes more sense than storing the pointer
to a structure in *that* structure.

Bart
