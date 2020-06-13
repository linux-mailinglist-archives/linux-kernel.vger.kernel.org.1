Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBD1F83F1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 17:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFMPbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 11:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMPbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:31:13 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195E7C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:31:13 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jk87a-008E71-Sq; Sat, 13 Jun 2020 15:31:03 +0000
Date:   Sat, 13 Jun 2020 16:31:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200613153102.GG23230@ZenIV.linux.org.uk>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <20200613125126.GE23230@ZenIV.linux.org.uk>
 <20200613125615.GF23230@ZenIV.linux.org.uk>
 <20200613134236.GA4086@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613134236.GA4086@afzalpc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 07:12:36PM +0530, afzal mohammed wrote:
> Hi,
> 
> On Sat, Jun 13, 2020 at 01:56:15PM +0100, Al Viro wrote:
> 
> > Incidentally, what about get_user()/put_user()?  _That_ is where it's
> > going to really hurt...
> 
> All other uaccess routines are also planned to be added, posting only
> copy_{from,to}_user() was to get early feedback (mentioned in the
> cover letter)

Sure, but what I mean is that I'd expect the performance loss to be
dominated by that, not by copy_from_user/copy_to_user on large amounts
of data.  Especially on the loads like kernel builds - a lot of stat()
and getdents() calls there.
