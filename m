Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC58207AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 19:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405892AbgFXRzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 13:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405677AbgFXRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:55:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:55:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so3543932ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9b/ETvzZZqxzHRa7XzrsxqcJghZu4Z4JykU3YO5w5U=;
        b=s6yoSvZtDJ3YgtJ5gZRLcGMHMYlxQnOsZ6G3N0jYowi8bc1Hz5mZVU/SAH2chXsyCi
         0F1Dj+SWwODQtgK2lCJYZPg9x0+hFDTvLl0BJeLk7ZSCrQ/S3L1My0/M9mjcC8DAkKy7
         1B13GKB14ehJatpcWIt3WKc5hHlPqhaQ+Vq8m+r0bIVuj81q0NU5v1atZEjKZmMxH07L
         /FM68nIALjryfwJex1g6PVMDer7WHZCldlDnEKaB2FnI54cCztZtz/QfqF/hY85Otmja
         9sNbtLlR9oZQD60XSbS0pJmP/0rigQJb+uhpgGpU6x50tBtZqKjZhNI+9Rj77ab0Wp35
         9DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9b/ETvzZZqxzHRa7XzrsxqcJghZu4Z4JykU3YO5w5U=;
        b=n2X3tH/ICaBHeAtyJTFIMyOAYybZ/0hNUuZxsquSFUMb76zNpkJNNu+rdy3CPaF8hO
         uTMvNfUfc5OjQ6Ia2kGHIcEXm2X/YEd6Dr52RaGA38t2SqbBL8udqo40J5BgSNwLZjOq
         XhY4shjA4iBZ+sNhsnTKOq18i2W59dTZhcw0r7Uxzj5Df2nFdiLacFDxlMeNOwWZ+ifR
         MWIkHIIEpakUsNfjVGGIZO0YcHaj7sjyPuXtdxWCpysVWRTzEJ2kNFcGq/t3aURSyQJO
         6QDGI3ySjwrb/nCl9SO7X8snXqIPHOqmd1oy/6zeCklw30r56gKYJlM9SmiRd6POMmY8
         ZMqg==
X-Gm-Message-State: AOAM532fMh/F0RuY3RHlkmNQ0r3bPNt+Wtbtw9O/6PyoOnfnfK5V4Rpb
        efituLaerQeYKfAiLSDil3KOC4J1QjggOZZGPmc=
X-Google-Smtp-Source: ABdhPJylsyXcKtarF+R5YOs9n6xSH8+cUIZN9zroGQoz5V0knIVBZAGj1Jntqua9BTaHrioZUIEPLb2chO0YmQhJ36A=
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr15162685ljc.403.1593021328633;
 Wed, 24 Jun 2020 10:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200624152256.21937-1-TheSven73@gmail.com>
In-Reply-To: <20200624152256.21937-1-TheSven73@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 24 Jun 2020 14:55:17 -0300
Message-ID: <CAOMZO5Ca8D-eBe9iKsDnc=zRnasUN2d0WttDS8XEcGmF_H2gEQ@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx6plus: enable internal routing of clk_enet_ref
 where possible
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Fugang Duan <fugang.duan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Wed, Jun 24, 2020 at 12:23 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> +       /*
> +        * On imx6 plus, enet_ref from ANATOP/CCM can be internally routed to
> +        * be the PTP clock source, instead of having to be routed through
> +        * pads.
> +        * Board designs which route the ANATOP/CCM clock through pads are
> +        * unaffected when routing happens internally. So on these designs,
> +        * route internally by default.
> +        */
> +       if (clksel == IMX6Q_GPR1_ENET_CLK_SEL_ANATOP &&
> +                       of_machine_is_compatible("fsl,imx6qp")) {
> +               if (!IS_ERR(gpr))

We could avoid checking for if (!IS_ERR(gpr)) two times in a row if
the following patch is applied before yours:
https://pastebin.com/raw/Ftkq2VVp

What do you think?

Thanks
