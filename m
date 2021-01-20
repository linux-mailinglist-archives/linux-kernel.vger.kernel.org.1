Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C572FCC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbhATIC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:02:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbhATIAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:00:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 410A02313A;
        Wed, 20 Jan 2021 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611129564;
        bh=eEJWyrqrVaGjriITxtdpVRQGIOFRYlpNHJ5gIDAfIrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPaJXNx8iVS6G5hOuKTZJO8/9ChIfvSA1m/LI16GUcZBjcH7UTcwg41c65eerfPeH
         Mr+gMTM711E9NGLLV6BR3IkvnKBYXf43CU8WWZYe2wp6n8es73Nf8GBwzdsXOTW1VF
         eHoqCMFk3Y2sXjmU7vtyIquJY2QEI5c5Lvla5q+Q=
Date:   Wed, 20 Jan 2021 08:59:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v8 00/13] Add Broadcom VK driver
Message-ID: <YAfi2JRNoKLVrvtv@kroah.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
 <CAOesGMjzUfNOEd4U20sAiyEFkYPai8asAC=kaWHG-PR0XE3pEQ@mail.gmail.com>
 <YAU2HnpwqGSNi3zF@kroah.com>
 <CAOesGMjmFPPmH6deqEwifdchpiN_xaCC362NSaJk3Tv=n-7b+g@mail.gmail.com>
 <09b6e829-75b8-4f16-3e01-c7193640d9c6@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b6e829-75b8-4f16-3e01-c7193640d9c6@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:21:32PM -0800, Scott Branden wrote:
> Hi Greg,
> 
> On 2021-01-18 3:06 p.m., Olof Johansson wrote:
> > On Sun, Jan 17, 2021 at 11:17 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >> On Sun, Jan 17, 2021 at 10:47:59AM -0800, Olof Johansson wrote:
> >>> Hi,
> >>>
> >>> On Mon, Nov 30, 2020 at 10:42 AM Scott Branden
> >>> <scott.branden@broadcom.com> wrote:
> >>>> This patch series drops previous patches in [1]
> >>>> that were incorporated by Kees Cook into patch series
> >>>> "Introduce partial kernel_read_file() support" [2].
> >>>>
> >>>> Remaining patches are contained in this series to add Broadcom VK driver.
> >>>> (which depends on request_firmware_into_buf API addition which has
> >>>> now been accepted into the upstream kernel as of v5.10-rc1).
> >>>>
> >>>> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> >>>> [2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/
> >>>
> >>> I've been following this series for some time, and I think the code is
> >>> ready to go in.
> >>>
> >>> Greg, mind queuing this up in the misc tree?
> >> I will need a new version, this is long gone from my queue.
> > I'll let Scott repost then (with acks applied etc)
> I can send another patch version with Olof's acks applied to each patch.
> Please let me know if that is what you are looking for?

Yes please.

> >> And hopefully the tty layer abuse is gone... :)
> > There's a simple tty driver as the final patch in the series, but it's
> > pretty straightforward.
> >
> > If you've still got concerns with it, the rest of the series should
> > stand on its own and should be mergeable without that piece.
> Yes, I placed the patch at the end of the series so it can be dropped
> if that is what is required to accept the rest of the patches.
> 
> There has been no viable solution suggested for replacing this functionality.
> We need a tty-like interface that works via access to the circular buffers
> in PCIe BAR space and interrupts.
> 
> The vk tty devices are a direct replacement to attaching serial cables.
> In real production environment it is not possible to attach such cables.
> 
> I can work on an alternative tty solution and send such patch later
> but I don't know what is going to prevent the tty "abuse".

I can't remember the specifics (I review hundreds of patches a week),
but please just resend and I'll deal with it then :)

thanks,

greg k-h
