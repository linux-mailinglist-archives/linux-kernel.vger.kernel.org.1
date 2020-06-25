Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4BD209BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390823AbgFYJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgFYJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:16:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD753C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:16:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so5246556iom.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XiSuE1sOXIBipbRmQaXWKIM5hIBA/1GaMgH8/QBx+Fg=;
        b=iB+W7XizU/ZyE68RYq0Wy4WGwaVug8o35XV3WoVujzhd4fj/jviokDCLfKsAQNC/CD
         MyjHMfGahHsCmh+oNfL4i4fg/Hb/6rvxRKd7w2PvYmqMcysZPcQJBmTMsBPhx+WOoEsx
         sYURxtLFEFzEW28VjADaxTZh/LDWcFA4+Q7lAQjdn+vsj3IgSUam5KQTIduedT/ZowyW
         BerGQgVSZmKKMJoRZikaa7enYMqpZrY1zQ9+Qw8deZc/FMtg+PJ/JBKKtQRGBgloKC7o
         MRB8xVCpEPuusL9dD5xscCw3iNFGIq00p9DefAs9DqKlrMYOfvBO4YsPKk+Q8tJ/ZxEN
         w2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XiSuE1sOXIBipbRmQaXWKIM5hIBA/1GaMgH8/QBx+Fg=;
        b=T4TczYCaCIqV1yTUACtLF0Kkmyx91KnqTp2rsjplMvVmiFdDteS3UELoniLFQ23Zbh
         k24yKHdIYiEMP8hSOhCJqzEKw4CRvZFnn4No00NUlnKR25UZKeN0ceMPOtVtgTkGsSjJ
         +rvyR81QKqOmHD/7ZBWuA5MUaFWeYpyqgFYcruJ/i6/viUXK2xY2+Ml+Wsjv9iNROSeB
         7XXQe2n5elcqHihce/7sfUq4OCGNw/xZdFV7IVdWwMSyQXZI3Wr0Zsaojm6OO8ZofeYK
         M+8E/Gie0JE6d8jAF645pNn3i3BiA3o7uTYWw6R5REJfrNuZgYEjBXGR/1g03vGx2H39
         YBFQ==
X-Gm-Message-State: AOAM533CDq+vRQQ6yaVPdj+wPrvpHY0JfZfsagqgvRAm85j/hVyDk0FS
        SwYwcCO5eTSvIGZAti+GGTNbrbXZxHrthaSXC0PT3g==
X-Google-Smtp-Source: ABdhPJxfpwzz3MthY2lWlmiAjEp1yFspUytO7/QblbPNv/YGcRZeoCZxvPdkVQWmmMe0TIcWMFI5nbF4CoLcMrctrC0=
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr71189jan.57.1593076573834;
 Thu, 25 Jun 2020 02:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200622100056.10151-1-brgl@bgdev.pl> <20200622100056.10151-7-brgl@bgdev.pl>
 <39e761f3-6607-d209-61df-535330f50db3@gmail.com>
In-Reply-To: <39e761f3-6607-d209-61df-535330f50db3@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 25 Jun 2020 11:16:02 +0200
Message-ID: <CAMRc=MfE9JjNiZr9_nL37Zbgz_OpKXW1sbdWvbTeq2_orOBKAw@mail.gmail.com>
Subject: Re: [PATCH 06/11] phy: un-inline devm_mdiobus_register()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 1:55 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 6/22/20 3:00 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Functions should only be static inline if they're very short. This
> > devres helper is already over 10 lines and it will grow soon as we'll
> > be improving upon its approach. Pull it into mdio_devres.c.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/net/phy/Makefile      |  2 +-
> >  drivers/net/phy/mdio_devres.c | 18 ++++++++++++++++++
> >  include/linux/phy.h           | 15 ++-------------
> >  3 files changed, 21 insertions(+), 14 deletions(-)
> >  create mode 100644 drivers/net/phy/mdio_devres.c
>
> This would likely require an update to the MAINTAINERS file for this new
> file to be picked up by the correct entry.

It's already included in drivers/net/phy/ in the ETHERNET PHY LIBRARY entry.

Bartosz
