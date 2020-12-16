Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1513E2DC554
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgLPR2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgLPR2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:28:37 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC986C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 09:27:56 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p14so14211057qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 09:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbVVb/3tBHQOeW2N0lGixFal7rrlyqRe0NYW7h5mJws=;
        b=df7mMBu2TQ/GxHbt3CKlE9kBX3thvKUQtLR6UQ0lqs1fISdjOZScd52uzgwcN83k8Q
         UEO8SFUp7FaxL9CZudC5Ze00tfKvOgeQo+eGDZtPLRAWElRDEEpHeErhKeYd/rXD+RIJ
         XEyTkZHSU4ZD0JXQhjKUL8VU+XijhQbYqNucF9P+kHeFMcsfzQJ5VmwCYupuEIjWSeV7
         AzDihoBDFLgx8xeTHPgRf+wBGnwJxT5UK81aol/KFgzR+fa7DWTxkh+FFThIpRLUpecK
         AI07lPfsqZpdfaBThI6NM6GC3Rcps+K9yBXbq6Y26LveZ2CueiK8aAlBxmbLh3oRIO/D
         7+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbVVb/3tBHQOeW2N0lGixFal7rrlyqRe0NYW7h5mJws=;
        b=UeFy/54BXJL9kbbaPWpadhFNUZft4tdBnX/rLZt5WrcitnHRWkl3wtMP1qqcKvNis+
         9vc3H+snWsegDxV/OiqbQnJAKd2p2dmZKbeTLJcoWOPBWR32iSaMTmkwbBcvcY44mxEX
         cCvXmse7jmkcNTd7AZfaEQe3eQryK3odhbCNXRYn7dRc6TlDHydOPXnvTU5m0jsnC00c
         vf+GW9cjzqlc1HHZwlBwyzkrhQvs7FH12wwSKkd8mj/fTSgRWaC9KgTra/drh5Z9dfdp
         7BjWSKgQ/p6488GHlIZrW/MFQYz+PDTmiqBANQ4sXog7MH3fs7AcNMDWzW5OPeAD/PUb
         gOCQ==
X-Gm-Message-State: AOAM532313GQ1OlGGPYooNgLip5uNEqCtX2RUrhlCdEX3uUgROWvrLsk
        Gpjz6P7nouxBRMG0Uq1OkceJtBSPVxX1aTxuNKGNpA==
X-Google-Smtp-Source: ABdhPJyKQE12XBOKvOQ1FMhyqrjGDCwscGWGuZr8KvzYRLNW9jyIe1uKwdJnLz5j9Wrf4O7RcY8Gm+wmO7GQib9dQpI=
X-Received: by 2002:a37:b982:: with SMTP id j124mr46935220qkf.1.1608139675605;
 Wed, 16 Dec 2020 09:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20201216163103.GA59351@roeck-us.net>
In-Reply-To: <20201216163103.GA59351@roeck-us.net>
From:   Kun Yi <kunyi@google.com>
Date:   Wed, 16 Dec 2020 09:27:28 -0800
Message-ID: <CAGMNF6V-w47SDAUgVAtG+Xrp0ECNOvVV1Xy5=FsXTwqc-c3NbQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: SENSORS_SBTSI should depend on X86
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 8:31 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Dec 16, 2020 at 02:46:41PM +0100, Geert Uytterhoeven wrote:
> > The AMD SB Temperature Sensor Interface (SB-TSI) is only present on AMD
> > X86 SoCs.  Hence add a dependency on X86, to prevent asking the user
> > about this driver when configuring a kernel without AMD X86 platform
> > support.

Sorry, I think there is some confusion. AMD SoC is a 'remote sensor',
or the client, whereas the device using the SB-TSI hwmon driver is the
master.
In industry, a typical scenario is ARM-based Board Management
Controllers (BMCs) using SB-TSI to monitor the host CPU temperature.

> >
> > Fixes: e7bb1a2ab8c4b156 ("hwmon: (sbtsi) Add basic support for SB-TSI sensors")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Makes sense. Applied.
>
> Thanks,
> Guenter
>
> > ---
> >  drivers/hwmon/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 1ecf697d8d99b70c..63d28f98108d4bb5 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -1536,6 +1536,7 @@ config SENSORS_SL28CPLD
> >  config SENSORS_SBTSI
> >       tristate "Emulated SB-TSI temperature sensor"
> >       depends on I2C
> > +     depends on X86 || COMPILE_TEST
> >       help
> >         If you say yes here you get support for emulated temperature
> >         sensors on AMD SoCs with SB-TSI interface connected to a BMC device.
> > --
> > 2.25.1
> >



-- 
Regards,
Kun
