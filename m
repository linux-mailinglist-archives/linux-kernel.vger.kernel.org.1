Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1828CFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbgJMOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388308AbgJMOLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:11:30 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E050247D6;
        Tue, 13 Oct 2020 14:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602598289;
        bh=ZEm4qyv0rsNaiXITpPHDZWzgAu0znXbk6n4+ypGmOLA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MfLofHiCE1CcxBehDwhDaCUB8io9lEWPSt+vXHP+HEfwyRNNUXbecG3eRfqdVh9ws
         g8b2ZY0eoFr3bR52uVJTtPE+6nA3w/7CN3C8sb2nF8oZ8NOjd4rSdIwIlcBM8sfzT+
         oK32818AOC6kX748rZe3U7dg3stjNt8UJHGlKqVY=
Received: by mail-ot1-f45.google.com with SMTP id 32so108351otm.3;
        Tue, 13 Oct 2020 07:11:29 -0700 (PDT)
X-Gm-Message-State: AOAM532JHqK0mp5tCmTcLi707cqyJUHyjmf7JfikydzgQUFmDrCPTWAA
        0U5sha6u4egTaOwq1HE9ueeWEwLQONyCUl8cdw==
X-Google-Smtp-Source: ABdhPJxBUmRbPMpwpE7ZGcLIsKkXQrHRXmZqq9KlY9ofRDlt+UbBHiSqD1X5MKFiKGZhA3PyOK+YrVzyCmJoZsNFR+A=
X-Received: by 2002:a9d:1c90:: with SMTP id l16mr22887593ota.192.1602598288568;
 Tue, 13 Oct 2020 07:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com> <20201008074600.GA247486@kroah.com>
In-Reply-To: <20201008074600.GA247486@kroah.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Oct 2020 09:11:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLMEzOT2_FomwDUhyYe7EV-jEL=A8CwDxngbwJJyJ_eCA@mail.gmail.com>
Message-ID: <CAL_JsqLMEzOT2_FomwDUhyYe7EV-jEL=A8CwDxngbwJJyJ_eCA@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] TCPM support for FRS and AutoDischarge Disconnect
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 2:45 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 07, 2020 at 11:15:41PM -0700, Badhri Jagan Sridharan wrote:
> > Hi,
> >
> > Made two changes:
> >
> > 1. Added "additionalProperties: false" as suggested by Rob Herring in
> > https://lore.kernel.org/linux-usb/20201005144618.GA154206@bogus/
> >
> > 2. Removed FRS dts binding constants to address Rob Herring's comment in
> > https://lore.kernel.org/linux-usb/20201006182940.GA2574941@bogus/

And didn't address my other comments...

> That worked better.  I've applied the patches that Heikki had reviewed
> to my usb-testing branch now.

Why is the driver being applied without the binding? Bindings come
first. The binding and driver don't even agree on the compatible
string (maxim,tcpci vs. maxim,tcpc), neither of which are right.

The FRS bindings need to be sorted out too as we have multiple folks
proposing bindings for it. I wish someone would review all these TypeC
related bindings because I'm getting a continual stream of piecemeal
additions with no coordination and I don't have knowledge on TypeC nor
bandwidth to review it all.

Rob
