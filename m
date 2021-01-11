Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC72F1C55
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389416AbhAKR2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbhAKR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:28:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1575DC061795;
        Mon, 11 Jan 2021 09:28:05 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id j16so615052edr.0;
        Mon, 11 Jan 2021 09:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k7FI2c9fe6irU/poD9k7dSTlxJqmLC3m6XaRcrDW52A=;
        b=QFXNJEHj+dKl36IvXMe0WYZRI6mP7oH+GCxst0Pk0RtQNfSTl6pMZHpCaHNscP49Sh
         KRF60QWDT2ZCNTJhBfsENdI/gf65qqKkY/UfBorDGWqc9RXQr8aw/T4X30RtPWG5DEcT
         CZRFs7p3EHdMpF7HWQMcv60m89hixZy+JuMY+ofzS24/fl2CsLqgGBmyDSyO2Jc5B3l6
         VSIyHj9XK+3g24jna/o/SsPJK+OBHn2eocWqjEO8b6YFukZk8rkfretEgnNPPXHKcRnk
         YvM0tt7x/UEj/5M4W5RmM4Ufc6Wh3Uqb58lxl3UeXiNrqhuKCa9D1XbqjiPt+u+ElyzZ
         pcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k7FI2c9fe6irU/poD9k7dSTlxJqmLC3m6XaRcrDW52A=;
        b=WbOVixd2sWn/LaPp0o+gNk2JfnYtp7V/OGGO0Mc+fuMY6hL6h5ikRNAlof3KcSrC3a
         JVAoOXJidy3Mj2bKGRZ2UbojhqT6J7oPl8+LAqxw83ofILxlrm71ULQu65ix8JLwAMOl
         fo6KbqzqKSNEtv8sOQ/WQHcHzzfKis1AEpiIT2z836BO9+Wbw0oN+w2xHfz4ffdfOmIE
         qjdpNiONVUyBxPYmWevHNYsqrBltoGz1DjXzxW8Fjs6h39RJhByT62TUN3qQoebdlmpO
         F3AOhL6FCL6baQRbFze//GvzkwrtnLtpaVkWQLRBM8b05GlDd0Nk69FMn7NdYWDYkFPG
         1k3A==
X-Gm-Message-State: AOAM530mai7nxMHAOpgjpdVYbu4f3iddsohZY/Rbq/9Iiv04GEX6JdYv
        WamIxvDUlV5gNaMdZdHlryGRvb+L07aPDFe1V3A=
X-Google-Smtp-Source: ABdhPJyefbADuLwuhekJ3EtVcz9AWeICjifrYauEFUemP/5GUMJ0ZWHv055olOL0MOZD1JY0H4KwrfuxEI1UcRA9Ouw=
X-Received: by 2002:aa7:d9c1:: with SMTP id v1mr320136eds.115.1610386083808;
 Mon, 11 Jan 2021 09:28:03 -0800 (PST)
MIME-Version: 1.0
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
 <20210108225006.153700-4-adrien.grassein@gmail.com> <20210111172019.GH4728@sirena.org.uk>
In-Reply-To: <20210111172019.GH4728@sirena.org.uk>
From:   Adrien Grassein <adrien.grassein@gmail.com>
Date:   Mon, 11 Jan 2021 18:27:52 +0100
Message-ID: <CABkfQAGUkUwS9UKOVY5xP2UYc+zUHL=t7EMPYWTyQ_Pw-v3TOA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] regulator: dt-bindings: pf8x00: remove nxp,ilim-ma property
To:     Mark Brown <broonie@kernel.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there a way to declare it deprecated in the DTB ?
I never saw a deprecated value.

Thanks,

Le lun. 11 janv. 2021 =C3=A0 18:20, Mark Brown <broonie@kernel.org> a =C3=
=A9crit :
>
> On Fri, Jan 08, 2021 at 11:50:03PM +0100, Adrien Grassein wrote:
> > This property seems useless because we can use the
> > regulator-max-microamp generic property to do the same
> > and using generic code.
>
> This made it into a kernel release so we should continue to honour it,
> it's fine to deprecate it though.
