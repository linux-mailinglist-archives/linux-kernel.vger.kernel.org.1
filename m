Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5337E29709A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460375AbgJWNeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:34:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374889AbgJWNeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:34:18 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA403208E4;
        Fri, 23 Oct 2020 13:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603460057;
        bh=7eQtJoVmIMTo7e8Y6WJkaUdqqV3l8+PLwGaGBAWFkDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=djUgxnrTacNjrwCVRDLI4tfxJgb0Q76NSSIGj7rMhPkEAx7usTcnQIDq6HoUII+UP
         KswHxaaSu52hRDxdCsmLUzoze2DbnYLChgjT2AbOxDrwBwXX2wPy+C+kn4QHwKTM8L
         7hDXkYnzczjb1q4NY+U7RS1K8VL7f/Uq/ReiyhH4=
Received: by mail-ot1-f47.google.com with SMTP id k68so1325590otk.10;
        Fri, 23 Oct 2020 06:34:17 -0700 (PDT)
X-Gm-Message-State: AOAM533Mw3ZsljDtfrzq/DDU5ehNPzE2mJPTNrLj+3ITFFKOu7hPSk9o
        gCBepx0I9MIJmGO/s8Bk4zJWtEUUbdktTxVP1Q==
X-Google-Smtp-Source: ABdhPJwsA7aA3EpRXIq17urxRg7iDxo9PS5jzKuDCsfwLlRVu0Ge5cwoN3ozsZ6Xs099+dOQmwyIpSjBc2mDiBJeb3M=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr1637520otm.129.1603460056981;
 Fri, 23 Oct 2020 06:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201020203710.10100-1-sudeep.holla@arm.com> <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
 <20201021181951.xu2igea2qbca3alf@bogus>
In-Reply-To: <20201021181951.xu2igea2qbca3alf@bogus>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Oct 2020 08:34:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0OO68AbML7osOU3fNzJk3NhXYrWVmNwn8mwtNzSuf8g@mail.gmail.com>
Message-ID: <CAL_JsqJ0OO68AbML7osOU3fNzJk3NhXYrWVmNwn8mwtNzSuf8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 1:19 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Oct 21, 2020 at 11:20:27AM -0500, Rob Herring wrote:
> > On Tue, Oct 20, 2020 at 3:37 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
>
> [...]
>
> >
> > When is this not 1 (IOW, you only need this if variable)? How would it
> > be used outside SCMI (given it has a generic name)?
> >
> > > +
> > > +* Property arm,scmi-perf-domain
> >
> [...]
>
> > Really though, why can't you give SCMI a CPUs MPIDR and get its domain?
> >
>
> Now I remembered why we can't use MPIDR. The spec talks about perf domains
> for devices in generic. CPU is just a special device. We will still need
> a mechanism to get device performance domain. So MPIDR idea was dropped to
> keep it uniform across all the devices.

What implications to the binding are there for non-CPU devices? Do
they need more cells? How does this integrate our plethora of other PM
related bindings?

So somewhere in the firmware we're defining device X is domain 0,
device Y is domain 1, etc. Then we do this again in DT. Seems fragile
to define this information twice. I guess that's true for any number
space SCMI defines.

Rob
