Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1170B2BAB87
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbgKTNuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 08:50:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:54204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgKTNun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 08:50:43 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817432237B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 13:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605880242;
        bh=f6xBhQjFHZHT2Zc1ws1L9vpZkO6KGJ0FWqd/uG4RvtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IEejbmVdnjipH/IgCJLOm6y8+6upr3XjW8HTsZ+pPb8QK//V/Wy5saOibpAEZesk4
         wlEm06pclyLukW/MdWBE2LqBnALMwWbXD3t9r/UgTA681sh6aizeZP60r8WKiirqvW
         5diTcBivCl6PbkHppXOK8ioYRyV1wxXo3z686Bk0=
Received: by mail-ot1-f41.google.com with SMTP id k3so8718719otp.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 05:50:42 -0800 (PST)
X-Gm-Message-State: AOAM533un7wi4llOM7Gs53UtwKud2MPp0XgyBMbIi2TVNDW3UoBnXvX7
        /MWuo1WxCnc7ZTyduSjuYKqdg58CLdP0zauE5A==
X-Google-Smtp-Source: ABdhPJyWx+Oo07yDMVnsmwBDn0MHnJku7/M02ZSTKtAjhAk2TOCgDgruu5oBtxw60kff0ShcePM9O+g9/ccCw71/1Ew=
X-Received: by 2002:a05:6830:2f8:: with SMTP id r24mr13986514ote.129.1605880241696;
 Fri, 20 Nov 2020 05:50:41 -0800 (PST)
MIME-Version: 1.0
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
 <20201103155952.GA4335@sequoia> <20201104120812.GA6632@willie-the-truck>
 <20201105054009.GA4472@sequoia> <20201105095853.GA7952@willie-the-truck> <20201105152836.GB4472@sequoia>
In-Reply-To: <20201105152836.GB4472@sequoia>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Nov 2020 07:50:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLUZXHEJmqtqn+V7VEhazBOgpX1dtAXb25SwPY_0rJvLg@mail.gmail.com>
Message-ID: <CAL_JsqLUZXHEJmqtqn+V7VEhazBOgpX1dtAXb25SwPY_0rJvLg@mail.gmail.com>
Subject: Re: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 9:28 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
>
> On 2020-11-05 09:58:54, Will Deacon wrote:
> > On Wed, Nov 04, 2020 at 11:40:09PM -0600, Tyler Hicks wrote:
> > > On 2020-11-04 12:08:12, Will Deacon wrote:
> > > > On Tue, Nov 03, 2020 at 09:59:52AM -0600, Tyler Hicks wrote:
> > > > > On 2020-09-21 14:15:55, Tyler Hicks wrote:
> > > > > > Provide the CONFIG_CMDLINE_EXTEND config option for arm64 kernels. This
> > > > > > config option can be used to extend the kernel command line parameters,
> > > > > > specified by the bootloader, with additional command line parameters
> > > > > > specified in the kernel configuration.
> > > > >
> > > > > Hi Catalin and Will - Friendly ping on this series now that we're
> > > > > on the other side of the 5.10 merge window. I hope it can be considered
> > > > > for 5.10+1. Let me know if I need to rebase/resubmit. Thanks!
> > > >
> > > > Can you use bootconfig to achieve what you need?
> > >
> > > Thanks for mentioning bootconfig. I hadn't considered it.
> > >
> > > After reading the docs and code, I see a few reasons why I can't use it
> > > out of the box:
> > >
> > >  1) It requires "bootconfig" to be appended to the kernel command line.
> > >     My proposed patch series makes it possible to append new options to
> > >     the kernel command line in situations where the bootloader is not
> > >     interactive. This presents a circular dependency problem for my use
> > >     case.
> > >
> > >     A new config option could be added to force the enablement of
> > >     bootconfig but that would sort of be a single-use duplicate of
> > >     CONFIG_CMDLINE_EXTEND's functionality.
> > >
> > >  2) Not all kernel command line options can be configured using
> > >     bootconfig. For example, the "nokaslr" and "crashkernel=" parameters
> > >     are parsed/handled before setup_boot_config() is called. KASLR can
> > >     be disabled via a kernel config change but there's no config option
> > >     equivalent for "crashkernel=". Changing the "crashkernel=" command
> > >     line option is something that I need to support because a
> > >     development/debug kernel build often requires a larger reservation
> > >     and we find ourselves adjusting the "crashkernel=" value fairly
> > >     often.
> > >
> > >  3) External FIT image build systems do not yet support bootconfig since
> > >     it is so new. It is completely fair if you file this away in your
> > >     not-my-problem folder but simple kernel config modifications, as
> > >     needed for CONFIG_CMDLINE_EXTEND, are something that every image
> > >     build system is likely to support today.
> > >
> > > All that said, I do really like the look of bootconfig. Unfortunately,
> > > it doesn't let me achieve everything I need.
> >
> > Ok, well thanks for having a look. A follow-up question I have is how is
> > this handled on x86? They don't appear to have CONFIG_CMDLINE_EXTEND either
> > afaict. Is it because their bootloader story tends to be more uniform?
>
> x86's equivalent was implemented by commit 516cbf3730c4 ("x86, bootup:
> add built-in kernel command line for x86 (v2)"). To summarize, you have
> to enable CONFIG_CMDLINE_BOOL and then that lets you define built-in
> command line parameters in CONFIG_CMDLINE. However, it is backwards in
> that the command line provided by the bootloader is appended onto the
> end of CONFIG_CMDLINE.
>
> This doesn't seem as useful to me because, using the crashkernel=
> example from above, the bootloader provided crashkernel= value may need
> to be overridden by the built-in command line to provide a different
> crashkernel= value for the particular kernel build being booted. Most
> kernel command line parameter parsers are implemented in a way that
> supports multiple instances of the parameter while only honoring the
> last instance.

These config options should be common IMO. It's a minefield though.
You might want to look at this prior attempt[1].

Rob

[1] https://lore.kernel.org/lkml/20190319232448.45964-2-danielwa@cisco.com/
