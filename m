Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF52F9421
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 18:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbhAQRQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 12:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbhAQRQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 12:16:27 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC4FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 09:15:46 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id b10so15800738ljp.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRrXXlB0SlhsMGxZpyUDf3iYlu9jA32sbaiCZc/Xe2k=;
        b=VvSU+ft+YquGegQ3KmUxVPGnYCjDQoGgpcQ3zjjVcUBi1+Z9emAIVks+mqbNME1Rwz
         7teHdkeKNxWLCkO4+ilGbZntDAVqHDAMqX/hR6695fXUautQKJa4cPOjjD79gDKFQEpj
         ft2laAKIQVj3gm4u/o4sET4wywLAsR6Uqkbuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRrXXlB0SlhsMGxZpyUDf3iYlu9jA32sbaiCZc/Xe2k=;
        b=Uq0CigivPWBjISDFqmqKO51g4vlLSg4sGZdGnBzgZPybDuoix8HeVOAD7Nxq0UZHqN
         n+hAUNLeAkh7sYav4lS73YIksS0VRxX/hcjNCliMkTDiOT7uDTmh8BvZh31jPdFwcbIT
         NvdVQbTmqbo2E/8KF3oaHLuw91FBck75oL3ZG2FJ9EGaNnU6PtTQ5gRq30px8ZhnDgO9
         Ht1ArWC0qQblGyHaidm4PvvH808YMR9lKp8MhpeTYp9m1wRuEk8F/ep74X+SKNrO3Hfu
         5VmHrVI+2Rq6WkqVMHpmUFLPNbvvxbSHTplDSYw7RBNBiiwPsEQXc5ZuEzMboO6bEOKF
         +4vw==
X-Gm-Message-State: AOAM533EVS1VjwYD3YB94KcMs3O1Q3yZqXaf92vC8pElNwQnMgYD9rKH
        f2E1wyXJcGGeHId6j+rfjpaME9Dzq09V/g==
X-Google-Smtp-Source: ABdhPJwszn7UGBoIJtZuJbCH2vgWo3OFBaI8RuP6wHzxu7vdDJ+lm3P0jPgw9vx8QN09q6/Gs3fANg==
X-Received: by 2002:a2e:501e:: with SMTP id e30mr8736879ljb.387.1610903745050;
        Sun, 17 Jan 2021 09:15:45 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id f7sm1442066ljk.4.2021.01.17.09.15.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 09:15:43 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id p13so15851550ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 09:15:43 -0800 (PST)
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr8809120ljn.315.1610903742948;
 Sun, 17 Jan 2021 09:15:42 -0800 (PST)
MIME-Version: 1.0
References: <20201118234025.376412-1-evgreen@chromium.org> <20201118153951.RESEND.v3.2.Idef164c23d326f5e5edecfc5d3eb2a68fcf18be1@changeid>
 <20210117115426.GH1983@ninjato>
In-Reply-To: <20210117115426.GH1983@ninjato>
From:   Evan Green <evgreen@chromium.org>
Date:   Sun, 17 Jan 2021 09:15:06 -0800
X-Gmail-Original-Message-ID: <CAE=gft6qb9aBJTrTL_QE=LATh+1+J1gaWjtXs_OXhEbCdgm0jw@mail.gmail.com>
Message-ID: <CAE=gft6qb9aBJTrTL_QE=LATh+1+J1gaWjtXs_OXhEbCdgm0jw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] i2c: i2c-mux-gpio: Enable this driver in
 ACPI land
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 3:54 AM Wolfram Sang <wsa@kernel.org> wrote:
>
> On Wed, Nov 18, 2020 at 03:40:25PM -0800, Evan Green wrote:
> > Enable i2c-mux-gpio devices to be defined via ACPI. The idle-state
> > property translates directly to a fwnode_property_*() call. The child
> > reg property translates naturally into _ADR in ACPI.
> >
> > The i2c-parent binding is a relic from the days when the bindings
> > dictated that all direct children of an I2C controller had to be I2C
> > devices. These days that's no longer required. The i2c-mux can sit as a
> > direct child of its parent controller, which is where it makes the most
> > sense from a hardware description perspective. For the ACPI
> > implementation we'll assume that's always how the i2c-mux-gpio is
> > instantiated.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> Applied to for-next, thanks! The code Andy mentioned can still be
> refactored later if new ACPI helpers appear in the future.

Thanks Wolfram and Peter!
