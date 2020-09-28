Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6BC27B28C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgI1Qtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgI1Qtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:49:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE509C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:49:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lo4so9492100ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OjaO7kUDshEkXyX/sIanQwh9RsbMzawXkJFVu2Elacw=;
        b=BOQKe+ZZ13ve03VzZj6TWYxlDnAhDhd6J4X/++n58Bn9kjGDh4BkGap7yChnaVQsFA
         slKF5YRlSNSPx6F3iB4RICABtFrb/de4KEsnT4e1yDwXMOCtD/Tq4UN8tBXACn0pziet
         ovkON6pPO40sy1O5XKRrymtshV1Lm12f3u4m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OjaO7kUDshEkXyX/sIanQwh9RsbMzawXkJFVu2Elacw=;
        b=ZkmHLCHtrLLiMWVMfUrPgVza2kA0QADda8LMmLMNVn4a4BG7WFql19CxY24rCY47Je
         xDd4s16yVJPO1quaqAswOjvuPfckeaNrpD2QaCTRhdY6L9Bs6jBTmtYPyabAj4MEfIXV
         rlp9ApyCuGgjg90SwceKpDdo+x+5UHyMyOx40Xi43cDg2Z4gU3eGBi0tJ3DBcH0/dheh
         iDx+scOgS0v+ZOPAvzFbwevS8M+UiiHaszowIUDaWb2kOZfGR/mYytnoHodnGWqqJzHr
         bb7mib1Xe1SJeySis5TObjmKEDfOY0uCZEsfnCDmUUxZNLz1srV0nPnE9mBfo3mhbY2/
         4stA==
X-Gm-Message-State: AOAM531rM3tnKauA3DxWEZwsdDyPdYgUDunnCiudERSGC12VD3Ci9v7F
        K3A4kb+uNxcWn+sogMDTw80/ewqB9RHKVA==
X-Google-Smtp-Source: ABdhPJyKJDbpEPDZo3wYkVdcHjCfHufCDLc73dhPjN+AIxBqP3y7FT+wZv4v3UxxBpE1nWGCAg2xsw==
X-Received: by 2002:a17:906:1484:: with SMTP id x4mr2438014ejc.81.1601311782184;
        Mon, 28 Sep 2020 09:49:42 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id dc22sm2059960ejb.112.2020.09.28.09.49.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 09:49:41 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id w5so2107540wrp.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:49:40 -0700 (PDT)
X-Received: by 2002:a5d:660f:: with SMTP id n15mr2859213wru.103.1601311780342;
 Mon, 28 Sep 2020 09:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200903081550.6012-1-sakari.ailus@linux.intel.com>
 <f4b82baa-66b7-464e-fd39-66d2243a05ef@lucaceresoli.net> <20200911130104.GF26842@paasikivi.fi.intel.com>
 <6dea1206-cfaa-bfc5-d57e-4dcddadc03c7@lucaceresoli.net> <20200914094727.GM26842@paasikivi.fi.intel.com>
 <20200926123807.GA3781977@chromium.org> <20200927193900.GA30711@kunai>
 <CAAFQd5Be5sUQYtXapcSOu8CVffW2LuLog9qh71-+mxze9WYUVQ@mail.gmail.com> <CAJZ5v0hKQNv+qj-7EQ2Dmtk=UamtVKHBXDCjqo-48Qj13yY+cw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hKQNv+qj-7EQ2Dmtk=UamtVKHBXDCjqo-48Qj13yY+cw@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 28 Sep 2020 18:49:22 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CP7bg+UQEp5uzuQY5a_xHLAB4ct81pkO0naAou=-QyKw@mail.gmail.com>
Message-ID: <CAAFQd5CP7bg+UQEp5uzuQY5a_xHLAB4ct81pkO0naAou=-QyKw@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] Support running driver's probe for a device
 powered off
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 4:18 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sun, Sep 27, 2020 at 9:44 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Sun, Sep 27, 2020 at 9:39 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> > >
> > >
> > > > I think we might be overly complicating things. IMHO the series as is
> > > > with the "i2c_" prefix removed from the flags introduced would be
> > > > reusable as is for any other subsystem that needs it. Of course, for
> > > > now, the handling of the flag would remain implemented only in the I2C
> > > > subsystem.
> > >
> > > Just to be clear: you are suggesting to remove "i2c" from the DSD
> > > binding "i2c-allow-low-power-probe". And you are not talking about
> > > moving I2C_DRV_FL_ALLOW_LOW_POWER_PROBE to struct device_driver? I
> > > recall the latter has been NACKed by gkh so far.
> > >
> >
> > I'd also drop "I2C_" from "I2C_DRV_FL_ALLOW_LOW_POWER_PROBE", but all
> > the implementation would remain where it is in the code. IOW, I'm just
> > suggesting a naming change to avoid proliferating duplicate flags of
> > the same meaning across subsystems.
>
> But that would indicate that the property was recognized by other
> subsystems which wouldn't be the case, so it would be confusing.
>
> That's why it cannot be documented as a general property ATM too.

I guess that's true. Well, this is kAPI in the end, so if we have more
subsystems, it could be always renamed. So feel free to ignore my
previous comment.

Best regards,
Tomasz
