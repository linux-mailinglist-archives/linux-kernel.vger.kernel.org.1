Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA330262E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbhAYORf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbhAYOJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:09:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03ED12145D;
        Mon, 25 Jan 2021 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611583700;
        bh=OvS6YJLr/vKp0c5P4TYdr+9ctcl9Nkqj0yOfYVirDXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQlKE63x5yFRjC4SfMJEjHb32OLQAA9iUdxuqjY7zZGRj8GE5YvbayQlXTOTWyLSY
         oQRYRCOMUSCtETKWHl5x6F+94wBQbmRhJ2rP6UV6UyS/OsPoh0pfEzcSbKBjEV6Jn3
         5uIKjtckfZB8928sUdlBfJkxD2+bn6cgMYyH4LIQ=
Date:   Mon, 25 Jan 2021 15:08:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.11-rc5
Message-ID: <YA7Q0XZMIdudb6x9@kroah.com>
References: <YA1u24kUPB+B7gKY@kroah.com>
 <CAHk-=whe0kHRKsNegF+JxCooS_Z0otcEX_Ggz=iN2v3D1Rssxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whe0kHRKsNegF+JxCooS_Z0otcEX_Ggz=iN2v3D1Rssxg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 11:31:59AM -0800, Linus Torvalds wrote:
> On Sun, Jan 24, 2021 at 4:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > David Lechner (1):
> >       counter:ti-eqep: remove floor
> 
> I'm not sure why that ti-eqep counter driver seems to be in your
> "iio/staging" pile rather than "char/misc", but whatever..

Jonathan said why that was needed, I think it was due to fixes in the
counter core code, but he can verify this better than I can...

thanks,

greg k-h
