Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD832F9A63
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbhARHSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbhARHSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:18:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3901223DB;
        Mon, 18 Jan 2021 07:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610954274;
        bh=u2aJaxNkw6V4r0gmeGHfPRdtwi/66rAxhu9CoUSxk/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vl0IrLr2hx0DscnI1vi7BfZ5CK/+qI4i508vXTVCRX8wkrc6Gc0YMB+l+YtPWogAL
         20JxJuYTbEk1ILOUx/zlh645gf5SX5x+ZMA6Ph8JuzmOhym7kxTjE98s1b5BV0K4gW
         Em8DLUvm1crtOV9FXgfudAEZmhsrz4mAUaE1Wox4=
Date:   Mon, 18 Jan 2021 08:17:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Desmond Yan <desmond.yan@broadcom.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Broadcom Kernel Feedback List 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v8 00/13] Add Broadcom VK driver
Message-ID: <YAU2HnpwqGSNi3zF@kroah.com>
References: <20201130184200.5095-1-scott.branden@broadcom.com>
 <CAOesGMjzUfNOEd4U20sAiyEFkYPai8asAC=kaWHG-PR0XE3pEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjzUfNOEd4U20sAiyEFkYPai8asAC=kaWHG-PR0XE3pEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 10:47:59AM -0800, Olof Johansson wrote:
> Hi,
> 
> On Mon, Nov 30, 2020 at 10:42 AM Scott Branden
> <scott.branden@broadcom.com> wrote:
> >
> > This patch series drops previous patches in [1]
> > that were incorporated by Kees Cook into patch series
> > "Introduce partial kernel_read_file() support" [2].
> >
> > Remaining patches are contained in this series to add Broadcom VK driver.
> > (which depends on request_firmware_into_buf API addition which has
> > now been accepted into the upstream kernel as of v5.10-rc1).
> >
> > [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> > [2] https://lore.kernel.org/lkml/20201002173828.2099543-1-keescook@chromium.org/
> 
> 
> I've been following this series for some time, and I think the code is
> ready to go in.
> 
> Greg, mind queuing this up in the misc tree?

I will need a new version, this is long gone from my queue.

And hopefully the tty layer abuse is gone... :)

thanks,

greg k-h
