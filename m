Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDD1CBB4D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 01:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgEHXhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 19:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgEHXhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:37:14 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3242621974;
        Fri,  8 May 2020 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588981034;
        bh=TTmQy61+zMJ0ALWgDCPYoVDJHD0JlRbB+Qz6kqRgTT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7LKO1YUXULcfyT7oCMVxpJm4O43hQ5MepZs+5JNDLT0UoYdHOJO/0YBOi0ajI8F8
         kzSFFvVY6WVPPt9hvhYBYL6tJXPEImQaIdTxPqFzrofjdAEic9WB3Slxj6TRrXCBcm
         THk1XoB/eUnT1lnJb/Tz24SWWPKq37jGCdPq6J3A=
Date:   Fri, 8 May 2020 18:41:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] efi: Replace zero-length array with flexible-array
Message-ID: <20200508234142.GA27139@embeddedor>
References: <20200507192712.GA16805@embeddedor>
 <CAHk-=wh-Ym=onfkMyMmOZUr6cFGQUD8kMowX6OcE-A-H2efkMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-Ym=onfkMyMmOZUr6cFGQUD8kMowX6OcE-A-H2efkMg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 10:26:40AM -0700, Linus Torvalds wrote:
> On Thu, May 7, 2020 at 12:22 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99 [...]
> 
> Why is this called an "efi" patch, when it doesn't appear to be so at all:
> 
> >  include/linux/dma/ti-cppi5.h                   |    4 ++--
> >  include/linux/efi.h                            |    2 +-
> >  include/linux/mailbox/zynqmp-ipi-message.h     |    2 +-
> >  include/linux/platform_data/cros_ec_commands.h |    4 ++--
> >  include/linux/platform_data/cros_ec_proto.h    |    2 +-
> >  kernel/params.c                                |    2 +-
> >  kernel/tracepoint.c                            |    2 +-
> >  scripts/kallsyms.c                             |    2 +-
> >  8 files changed, 10 insertions(+), 10 deletions(-)
> 
> Yes, one line of the patch is EFI code. The rest are not.
> 

Yeah. It seems the script needs some improvement. I'll split this
patch up into multiple patches.

Thanks
--
Gustavo
