Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC652A7718
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgKEFka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:40:30 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34388 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEFka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:40:30 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id C9AF720B4905;
        Wed,  4 Nov 2020 21:40:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C9AF720B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1604554829;
        bh=nycdqD/aGTqhH/3wzV/NMDtydgpe4EqjBTUc+O8mIyk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/I4mVvo8ADCOQLLkCUKLY5W1CGEy9eEyeUrUCuQ9zbeTfZaEV3FZIFn8u523luii
         mMKQ6yAbO+m7c12HpuvB3dwDMwMM2+/klhPXfbHCyJeZB395gX35k7KjCJU5fZd8hb
         MzLEUS1CD8yeo6Lim5tj5Ek+W9YsSkK/yhzgz7Sg=
Date:   Wed, 4 Nov 2020 23:40:09 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
Message-ID: <20201105054009.GA4472@sequoia>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
 <20201103155952.GA4335@sequoia>
 <20201104120812.GA6632@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104120812.GA6632@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-04 12:08:12, Will Deacon wrote:
> On Tue, Nov 03, 2020 at 09:59:52AM -0600, Tyler Hicks wrote:
> > On 2020-09-21 14:15:55, Tyler Hicks wrote:
> > > Provide the CONFIG_CMDLINE_EXTEND config option for arm64 kernels. This
> > > config option can be used to extend the kernel command line parameters,
> > > specified by the bootloader, with additional command line parameters
> > > specified in the kernel configuration.
> > 
> > Hi Catalin and Will - Friendly ping on this series now that we're
> > on the other side of the 5.10 merge window. I hope it can be considered
> > for 5.10+1. Let me know if I need to rebase/resubmit. Thanks!
> 
> Can you use bootconfig to achieve what you need?

Thanks for mentioning bootconfig. I hadn't considered it.

After reading the docs and code, I see a few reasons why I can't use it
out of the box:

 1) It requires "bootconfig" to be appended to the kernel command line.
    My proposed patch series makes it possible to append new options to
    the kernel command line in situations where the bootloader is not
    interactive. This presents a circular dependency problem for my use
    case.

    A new config option could be added to force the enablement of
    bootconfig but that would sort of be a single-use duplicate of
    CONFIG_CMDLINE_EXTEND's functionality.

 2) Not all kernel command line options can be configured using
    bootconfig. For example, the "nokaslr" and "crashkernel=" parameters
    are parsed/handled before setup_boot_config() is called. KASLR can
    be disabled via a kernel config change but there's no config option
    equivalent for "crashkernel=". Changing the "crashkernel=" command
    line option is something that I need to support because a
    development/debug kernel build often requires a larger reservation
    and we find ourselves adjusting the "crashkernel=" value fairly
    often.

 3) External FIT image build systems do not yet support bootconfig since
    it is so new. It is completely fair if you file this away in your
    not-my-problem folder but simple kernel config modifications, as
    needed for CONFIG_CMDLINE_EXTEND, are something that every image
    build system is likely to support today.

All that said, I do really like the look of bootconfig. Unfortunately,
it doesn't let me achieve everything I need.

Tyler

> 
> Will
> 
