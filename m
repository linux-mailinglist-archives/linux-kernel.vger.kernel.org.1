Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6AA29AD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbgJ0Nc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752128AbgJ0Nc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:32:27 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC19021707
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603805547;
        bh=CbUeUpMdw/X/SyWGfEXt6jB93bwDky53wIkxwqqVWKI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TYfKssTNNZmwDMbEYlSUpaFdFQEidgNbsrNVyHSOPsIsUzDZwv4e2qAtnxCubWTuG
         PRaymH184FNwV0nz+8UeCCydsKMZBH54Pb2kqc/+jSfKpBmmI65gdKO9+t1gVum9O4
         f8+r37c7zPiJ0iFUnfBeSmtEkxWZ6IjAGbpePWBc=
Received: by mail-qv1-f54.google.com with SMTP id bl9so615334qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:32:26 -0700 (PDT)
X-Gm-Message-State: AOAM531V3iAyOd97VeYcSjh0NJSXxYAoeK4YHADvbjle0zdemIAegPsl
        Fb5PgnyeXGJ6ETWXeHdFxnC1Ns3AQdHG/CG5uKw=
X-Google-Smtp-Source: ABdhPJyDAWO2c8YXaCfdwYDVM63x0QlLv1H0JOe+wV5o/LcUXj0FysvKlwLbUXrHqWQK5LMBfdL5V3RLe9S6E7TfRGM=
X-Received: by 2002:a0c:f447:: with SMTP id h7mr2384178qvm.7.1603805545978;
 Tue, 27 Oct 2020 06:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201026155449.3703142-1-arnd@kernel.org> <459e03f1-2a9e-5bc4-4bf6-9a0ddf5c4a70@xilinx.com>
In-Reply-To: <459e03f1-2a9e-5bc4-4bf6-9a0ddf5c4a70@xilinx.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 14:32:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2nnnh81fUbrua5eG1km=2h0BzfiDGm-axYtkdoLGw60A@mail.gmail.com>
Message-ID: <CAK8P3a2nnnh81fUbrua5eG1km=2h0BzfiDGm-axYtkdoLGw60A@mail.gmail.com>
Subject: Re: [PATCH] firmware: xilinx: fix out-of-bounds access
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rajan Vaja <rajanv@xilinx.com>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejas Patel <tejas.patel@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:53 AM Michal Simek <michal.simek@xilinx.com> wrote:
> On 26. 10. 20 16:54, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The zynqmp_pm_set_suspend_mode() and zynqmp_pm_get_trustzone_version()
> > functions pass values as api_id into zynqmp_pm_invoke_fn
> > that are beyond PM_API_MAX, resulting in an out-of-bounds access:
> >
> > drivers/firmware/xilinx/zynqmp.c: In function 'zynqmp_pm_set_suspend_mode':
> > drivers/firmware/xilinx/zynqmp.c:150:24: warning: array subscript 2562 is above array bounds of 'u32[64]' {aka 'unsigned int[64]'} [-Warray-bounds]
> >   150 |  if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
> >       |      ~~~~~~~~~~~~~~~~~~^~~~~~~~
> > drivers/firmware/xilinx/zynqmp.c:28:12: note: while referencing 'zynqmp_pm_features'
> >    28 | static u32 zynqmp_pm_features[PM_API_MAX];
> >       |            ^~~~~~~~~~~~~~~~~~
>
> Which CONFIG option/tool is reporting this issue?

This is with gcc-10. Commit 44720996e2d7 ("gcc-10: disable
'array-bounds' warning for
now") turned off this warning globally, but most of the reported warnings got
fixed in the meantime. I'm trying to take care of the rest so we can enabled it
again.

You should be able to reproduce the problem by removing the cc-disable-warning
line from the top-level Makefile.

        Arnd
