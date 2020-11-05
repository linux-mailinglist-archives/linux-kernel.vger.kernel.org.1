Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95ED2A7B30
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgKEJ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgKEJ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:59:00 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602272080D;
        Thu,  5 Nov 2020 09:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604570339;
        bh=zq/J9cOox+Td+rRWi/5wLhjGbno8/li76QcghCKkxuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vgwz/+MR/PU90hHu3OEUD77rEsIS2f4BFj/XUBKnlJ8+FcHcOrw/iE8Ddgl+AIHXQ
         FedhhInxamSEIVcYSPp10HEzobws3zWxEF51VfV1UKTL5FN6Fbw5Kmt9qw2bAiB/B5
         25loWYK0+o8bybL5X7sHq5agZFDWr8PLQgWQL7Os=
Date:   Thu, 5 Nov 2020 09:58:54 +0000
From:   Will Deacon <will@kernel.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
Message-ID: <20201105095853.GA7952@willie-the-truck>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
 <20201103155952.GA4335@sequoia>
 <20201104120812.GA6632@willie-the-truck>
 <20201105054009.GA4472@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105054009.GA4472@sequoia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 11:40:09PM -0600, Tyler Hicks wrote:
> On 2020-11-04 12:08:12, Will Deacon wrote:
> > On Tue, Nov 03, 2020 at 09:59:52AM -0600, Tyler Hicks wrote:
> > > On 2020-09-21 14:15:55, Tyler Hicks wrote:
> > > > Provide the CONFIG_CMDLINE_EXTEND config option for arm64 kernels. This
> > > > config option can be used to extend the kernel command line parameters,
> > > > specified by the bootloader, with additional command line parameters
> > > > specified in the kernel configuration.
> > > 
> > > Hi Catalin and Will - Friendly ping on this series now that we're
> > > on the other side of the 5.10 merge window. I hope it can be considered
> > > for 5.10+1. Let me know if I need to rebase/resubmit. Thanks!
> > 
> > Can you use bootconfig to achieve what you need?
> 
> Thanks for mentioning bootconfig. I hadn't considered it.
> 
> After reading the docs and code, I see a few reasons why I can't use it
> out of the box:
> 
>  1) It requires "bootconfig" to be appended to the kernel command line.
>     My proposed patch series makes it possible to append new options to
>     the kernel command line in situations where the bootloader is not
>     interactive. This presents a circular dependency problem for my use
>     case.
> 
>     A new config option could be added to force the enablement of
>     bootconfig but that would sort of be a single-use duplicate of
>     CONFIG_CMDLINE_EXTEND's functionality.
> 
>  2) Not all kernel command line options can be configured using
>     bootconfig. For example, the "nokaslr" and "crashkernel=" parameters
>     are parsed/handled before setup_boot_config() is called. KASLR can
>     be disabled via a kernel config change but there's no config option
>     equivalent for "crashkernel=". Changing the "crashkernel=" command
>     line option is something that I need to support because a
>     development/debug kernel build often requires a larger reservation
>     and we find ourselves adjusting the "crashkernel=" value fairly
>     often.
> 
>  3) External FIT image build systems do not yet support bootconfig since
>     it is so new. It is completely fair if you file this away in your
>     not-my-problem folder but simple kernel config modifications, as
>     needed for CONFIG_CMDLINE_EXTEND, are something that every image
>     build system is likely to support today.
> 
> All that said, I do really like the look of bootconfig. Unfortunately,
> it doesn't let me achieve everything I need.

Ok, well thanks for having a look. A follow-up question I have is how is
this handled on x86? They don't appear to have CONFIG_CMDLINE_EXTEND either
afaict. Is it because their bootloader story tends to be more uniform?

Will
