Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0FC2B98B6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgKSQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:56:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51114 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgKSQ4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:56:16 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8ABEE20B717A;
        Thu, 19 Nov 2020 08:56:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8ABEE20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605804975;
        bh=ToNxDyfGA4wixS43zJTeceyWT80apD0yIIOjKTZu5rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5ksUOWchJroHHytE3K+6dqWBFzXYVxjICKBXfBV6SRBRhc+v1WETY5j8vacFlpz8
         V7I/1mwfrfXx/DQFN52nQD4CrSoedHaaOdYeTiXkXLNMIQLOYt0h9o4jtUglbkbDiU
         YAY1kUGNZNcd3uDvxnybPt8ipohfRPLHaVRxbKPA=
Date:   Thu, 19 Nov 2020 10:56:12 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: Implement CONFIG_CMDLINE_EXTEND
Message-ID: <20201119165612.GB3973@sequoia>
References: <20200921191557.350256-1-tyhicks@linux.microsoft.com>
 <20201103155952.GA4335@sequoia>
 <20201104120812.GA6632@willie-the-truck>
 <20201105054009.GA4472@sequoia>
 <20201105095853.GA7952@willie-the-truck>
 <20201105152836.GB4472@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105152836.GB4472@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-05 09:28:38, Tyler Hicks wrote:
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

Hey Will - Do you any additional concerns that I should look into?

Thanks!

Tyler

> 
> Tyler
> 
> > 
> > Will
> > 
