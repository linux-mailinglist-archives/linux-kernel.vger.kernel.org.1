Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DE126D17A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIQDNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIQDNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:13:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3815C061788
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 20:13:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e11so3462067wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bb9B11eCivxPDOxPGYCNptgsmSVh3UlA/TMn/OGTs70=;
        b=Kulw2ZgqEeM4N7LvjNnWIqASSdQbasKueZxTVDcbPfjQ42wY2942by6Y+AJjPRHlq9
         MRKwApsFEZXLlaFykfxspjQ5HzLnqkU1WZ3e5of50+K6l10f3eDRFFOLCz396J6HG8yf
         WF7QTHCHLdxhjw7dBtHP0XqnrPAkyaU1d7gak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bb9B11eCivxPDOxPGYCNptgsmSVh3UlA/TMn/OGTs70=;
        b=fmV5bJtR2Ryz5GctCk4OlYMDF3KLrxcmUX+eL9IU3G/8kp/MGVRC2I+N6elRO1QBec
         nr7oF56UTaez1st7w2yhtmo4RLs6tKhvdlYVHzmiF7LcP+kPpb4uvbT6+MmMFQZczGas
         aqkaVE4dy0ASewelSzI9SnXIm51u3181t53XUTaKG/D0ibfaS7DDz+3uaLxPdtrnI7gt
         5lTiXV3wjSbeNrsmOLG9WjTYVlLa8KbLrEjaZfy+LOjmuP7wDeNv1N32jCydWyCIVZiE
         5MfxyQrVTAp/Zpnyf86bFoCh68PdavO0K8C1sVBPDirc6VoNbgHn5bx3D9RoxUJ2J/Il
         Ac2g==
X-Gm-Message-State: AOAM533mlgrzhrGuFTxtlj5ovE+0Ai/lC0XMfwihSS1Aljyywt7LKTVe
        BmD8iFWHAxKjMv2zDoRIDDtbIz2zwpazFgOb2pSdXA==
X-Google-Smtp-Source: ABdhPJwtQYZ0nTf5HqOg6CcEOUgQq2e+8WeMNd0dXHDWv0zb/bPbYcuIA6QWamHn/aubspmbvT75A/gXYsWvjePgunc=
X-Received: by 2002:a1c:7f8b:: with SMTP id a133mr8054540wmd.155.1600312387899;
 Wed, 16 Sep 2020 20:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200915134541.14711-1-srinath.mannam@broadcom.com>
 <20200915134541.14711-4-srinath.mannam@broadcom.com> <20200917015245.GA678675@bogus>
In-Reply-To: <20200917015245.GA678675@bogus>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Thu, 17 Sep 2020 08:42:56 +0530
Message-ID: <CABe79T72=Hd7NBh664_fOudpxB5z+iiBKTBQC3=XqJRy9Oqs+A@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PCI: iproc: Display PCIe Link information
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>, linux-pci@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 7:22 AM Rob Herring <robh@kernel.org> wrote:
>
Hi Rob,
Thanks for review.
> On Tue, Sep 15, 2020 at 07:15:41PM +0530, Srinath Mannam wrote:
> > After successful linkup more comprehensive information about PCIe link
> > speed and link width will be displayed to the console.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index cc5b7823edeb..8ef2d1fe392c 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1479,6 +1479,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> >  {
> >       struct device *dev;
> >       int ret;
> > +     struct pci_dev *pdev;
> >       struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> >
> >       dev = pcie->dev;
> > @@ -1542,6 +1543,11 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
> >               goto err_power_off_phy;
> >       }
> >
> > +     for_each_pci_bridge(pdev, host->bus) {
> > +             if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> > +                     pcie_print_link_status(pdev);
> > +     }
>
> If this information is useful for 1 host implementation, why not all of
> them and put this in a common spot.
In common, pcie_print_link_status() is called during pci device caps
initialization, if the available link bandwidth is less than capabilities
of devices. Few EP drivers also used this function to print link
bandwidth info. This host can be configured for different link
speeds and link widths on different platforms so we thought
displaying link bandwidth after successful linkup is helpful to
know link details.

Thanks & Regards,
Srinath.
>
> Rob
