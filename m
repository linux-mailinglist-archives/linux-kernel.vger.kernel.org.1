Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCC2C86D5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgK3Oct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgK3Ocs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:32:48 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4434CC0613D2;
        Mon, 30 Nov 2020 06:32:08 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id d9so14361294oib.3;
        Mon, 30 Nov 2020 06:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWBwzvixWL78cCxOpMok96GDWyNbzEWdmxVeWzHH/Mk=;
        b=O8GrnFeywexxa0vjyRVV90d1wEnYBROYo1IrSynNjfNpbRvDVtJs9nrfz+96SxCGF0
         rEu2yyecNemjnyIeFlgwTs6t5KYmc7JAiGzLhMpNPFPrIJIKlSRWv7Y+roT3iBKNFgdg
         Qr6czqX3CYER1KUrccjXSy/gnws20q6xfPRTwHhgioGDSZP98nGQplCRRNjY8mWv+Gs0
         4EvMN1n3rXT0Ti/VChYIh6t4ysicltv3pRgfXBSa4Gspp9a6Dxyx2qPRx68stbIbxwU2
         3UR/6yYONKv/VtyB1byobV3wpO1NzN3PiMoBxvaTbkDItSqXz3IkrAk+ku+e8DlhDZht
         2cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWBwzvixWL78cCxOpMok96GDWyNbzEWdmxVeWzHH/Mk=;
        b=L+fSCy/WLNRe5pijYJFvKRoc/x42S24VhK8qgxk7slFfC/YBYzjk9r3pVtaqxk9HZM
         X27j2DpZ/f6eoy7mhvNfGYPdHVhKHzjY824dZTBIpJKUxKGNXEGp02eD+vfVB1rjTr1x
         dRxu1DwKW0hIhHvaE17M9BFp76/tbuZCQWBE3YvPYMKMv2j5tUPInzz6STzkfgmwW5rz
         vmH2U1S0GAYBi8CRSAnzsIaax9JMCrmEfqVV3Hbn/rubCwN5ZbaYWVjKsIdNcmpQbPWk
         5T2V/+cFgiSf/BOhLd1UltPp5+ilHvXHJL01EfU1yfCiY/tT9T66ZCzryQDS51do5UNM
         S4SA==
X-Gm-Message-State: AOAM532SRuFtnl0fyGWFmkZcgn4scOMpxLTX6tjVYf6aF6N/MDNDc9zb
        AkX2mjEDaabUAkDMesbN6uiU5rYjwQWDKLqJ/z4=
X-Google-Smtp-Source: ABdhPJwtV0T5R/UhLrSXzzrC7wmiBU0e/hTGeT9OdlV4+76hSYmFaSHFcvaZ1IBXDebGgJgoFmCiPVJHaGFToadkZGQ=
X-Received: by 2002:aca:f407:: with SMTP id s7mr14675175oih.23.1606746727547;
 Mon, 30 Nov 2020 06:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20201121155037.21354-1-sergio.paracuellos@gmail.com> <20201130104837.GO8403@vkoul-mobl>
In-Reply-To: <20201130104837.GO8403@vkoul-mobl>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 30 Nov 2020 15:31:55 +0100
Message-ID: <CAMhs-H_kWv=JRdr+6+ejcM14gEj5edBLd2RbC0ad+LQx9F2Jbw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] MT7621 PCIe PHY
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Mon, Nov 30, 2020 at 11:48 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 21-11-20, 16:50, Sergio Paracuellos wrote:
> > This series adds support for the PCIe PHY found in the Mediatek
> > MT7621 SoC.
> >
> > There is also a 'mt7621-pci' driver which is the controller part
> > which is still in staging and is a client of this phy.
> >
> > Both drivers have been tested together in a gnubee1 board.
> >
> > This series are rebased on the top of linux-phy:
> > commit 768a711e2d4b ("phy: samsung: phy-exynos-pcie: fix typo 'tunning'")
>
> Applied, thanks

Thanks for letting me know.

Best regards,
    Sergio Paracuellos
>
> --
> ~Vinod
