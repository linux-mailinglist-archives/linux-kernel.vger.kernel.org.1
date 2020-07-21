Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8B227AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 10:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgGUInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbgGUIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:43:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17758C0619D7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:43:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q17so9949164pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=LDyYq7mGwU/io/5kwm3whsJhqDFrwNw4M+0gHu2yWNM=;
        b=X9SVl1noxhxAJSxVLxnUk8o/KVL6aNK/lBRqGdm26YT8FAGcP40UJUB4BB2eG9FC9R
         7cY73a/L9bOTX3FMGx+9yNjqfED2E3hwadYVHTGyX9aEqhrcpcKsT8Q7Gykux3FwOouw
         2QGN+kC97nd84cz5yCXtzKOKY+5Dy6TvR83fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=LDyYq7mGwU/io/5kwm3whsJhqDFrwNw4M+0gHu2yWNM=;
        b=NUqRcic4pk89Hgw/GalSflwUk8k14XIbqzUsPXHXNEo0SIACha/K9hsMTJWDwSEJOJ
         yXSyNBA3hgJPyrIOhtx/1ydAu25y2HMuLo0L9UPodHWhWWc1JfucwTx1kvK5Ga6Z9Erm
         pBdpTYgqeEm752V7IJ53epkI9NXU+WKem75UjtqrgbGPrdtyv8tpZj7gtMozqxrA8FfE
         lO5JFhdBoAaSk7darWZoh3B+gpriDLOw6v19YRg4d7xdipFRvJfbTrshuoH0ym0NHUZa
         qUrBY0M7p98gZPRGIqc9fX4Q/Je6D/DuU8MZXrWICjxm0xbrlTSrlEXsrTA2pNgH4zul
         qXgA==
X-Gm-Message-State: AOAM533bb6lGOajuuCjHKIeDrn192Ulsyfj0448wBcbw8qGZEPInNTEX
        +HlHobk7NFTJXEMcR/TTnFELYA==
X-Google-Smtp-Source: ABdhPJy4aKFmpB5Dgc+0DC8B10/KpMNM/Ag1dR6K/OxvywuhrosN4V4qOP35QJiccdOAUxzwf8dn0g==
X-Received: by 2002:a17:90a:6888:: with SMTP id a8mr3579090pjd.59.1595321015512;
        Tue, 21 Jul 2020 01:43:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id r191sm19920333pfr.181.2020.07.21.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:43:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200630030552.cfp5oh33qde6nlnf@vireshk-i7>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org> <1592222564-13556-2-git-send-email-rnayak@codeaurora.org> <159347264530.1987609.11350620235820019545@swboyd.mtv.corp.google.com> <a3d53f82-b29d-97ef-3ba1-ca9bd650d354@codeaurora.org> <20200630030552.cfp5oh33qde6nlnf@vireshk-i7>
Subject: Re: [PATCH v6 1/6] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        robdclark@chromium.org, robdclark@gmail.com,
        stanimir.varbanov@linaro.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 21 Jul 2020 01:43:33 -0700
Message-ID: <159532101373.3847286.9695594340556014384@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2020-06-29 20:05:52)
> On 30-06-20, 08:31, Rajendra Nayak wrote:
> >=20
> >=20
> > On 6/30/2020 4:47 AM, Stephen Boyd wrote:
> > > Quoting Rajendra Nayak (2020-06-15 05:02:39)
> > > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/se=
rial/qcom_geni_serial.c
> > > > index 457c0bf..a90f8ec 100644
> > > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > > @@ -9,6 +9,7 @@
> > > >   #include <linux/module.h>
> > > >   #include <linux/of.h>
> > > >   #include <linux/of_device.h>
> > > > +#include <linux/pm_opp.h>
> > > >   #include <linux/platform_device.h>
> > > >   #include <linux/pm_runtime.h>
> > > >   #include <linux/pm_wakeirq.h>
> > > > @@ -962,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct=
 uart_port *uport,
> > > >                  goto out_restart_rx;
> > > >          uport->uartclk =3D clk_rate;
> > > > -       clk_set_rate(port->se.clk, clk_rate);
> > > > +       dev_pm_opp_set_rate(uport->dev, clk_rate);
> > >=20
> > > If there isn't an OPP table for the device because it is optional then
> > > how can we unconditionally call dev_pm_opp_set_rate()?
>=20
> Looks like some *Maintainers* aren't paying enough attention lately ;)
>=20
> Just kidding.
>=20

It seems that dev_pm_opp_set_rate() calls _find_opp_table() and finds
something that isn't an error pointer but then dev_pm_opp_of_add_table()
returns an error value because there isn't an operating-points property
in DT. We're getting saved because this driver also happens to call
dev_pm_opp_set_clkname() which allocates the OPP table a second time
(because the first time it got freed when dev_pm_opp_of_add_table()
return -ENODEV because the property was missing).

Why do we need 'has_opp_table' logic? It seems that we have to keep
track of the fact that dev_pm_opp_of_add_table() failed so that we don't
put the table again, but then dev_pm_opp_set_clkname() can be called
to allocate the table regardless.

This maintainer is paying very close attention to super confusing code like
this:

	if (drv->has_opp_table)
		dev_pm_opp_of_remove_table(dev);
	dev_pm_opp_put_clkname(drv->opp_table);

which reads as "if I have an opp table remove it and oh by the way
remove the clk name for this opp table pointer I also happen to always
have".

Maybe I would be happier if dev_pm_opp_of_table() went away and we just
had dev_pm_opp_add_table(const struct opp_config *config) that did all
the things for us like set a clk name, set the supported hw, set the
prop name, etc. based on the single config struct pointer and also
parsed out the OPP table from DT or just ignored that if there isn't any
operating-points property. Then the caller wouldn't need to keep track
of 'if has_opp_table' because it doesn't seem to actually care and the
core is happy to allocate a table for the device anyway so long as it
sets a clk name.
