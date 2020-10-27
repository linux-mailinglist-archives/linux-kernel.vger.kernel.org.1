Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EB629AC00
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbgJ0MXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1749431AbgJ0MXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:23:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CF022450;
        Tue, 27 Oct 2020 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603801424;
        bh=KEn1p/EFbKzzIhU4vN1pyAkXI5buPFNnZeWdmfkrF58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rB+G0feEu0i5T//isXvB3sut+XuwdE2QXicbFGfKfVJXDzBSrSRin2ULWOvJvevFh
         4+QhdXe62QOEW10D6DOnOq7BBk1JVHCepT2OuP8gw0q1pqHIa5Zq7VxuKpKvdoKQtm
         nDVqMIivRwQXENPVRm+eE+ZapU3HpvypI7vXlqWc=
Date:   Tue, 27 Oct 2020 13:24:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] staging: wfx: avoid uninitialized variable use
Message-ID: <20201027122439.GA670469@kroah.com>
References: <20201026160243.3705030-1-arnd@kernel.org>
 <1716365.mxtkSTacob@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1716365.mxtkSTacob@pc-42>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 05:11:11PM +0100, Jérôme Pouiller wrote:
> On Monday 26 October 2020 17:02:22 CET Arnd Bergmann wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Move the added check of the 'band' variable after the
> > initialization. Pointed out by clang with
> > 
> > drivers/staging/wfx/data_tx.c:34:19: warning: variable 'band' is uninitialized when used here [-Wuninitialized]
> >         if (rate->idx >= band->n_bitrates) {
> 
> Hello Arnd,
> 
> This patch has already been submitted[1]. I think it is going to be
> applied to staging very soon.
> 
> Sorry for the disturbing.
> 
> [1] https://lore.kernel.org/driverdev-devel/20201019160604.1609180-1-Jerome.Pouiller@silabs.com/

Sorry for the delay, had to wait until -rc1 was out.

Now queued up in my tree.

greg k-h
