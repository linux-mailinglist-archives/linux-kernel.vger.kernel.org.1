Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148282E7CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 22:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgL3Vlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 16:41:37 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40305 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL3Vlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 16:41:37 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4CC4860003;
        Wed, 30 Dec 2020 21:40:54 +0000 (UTC)
Date:   Wed, 30 Dec 2020 22:40:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Pitre <npitre@baylibre.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] i3c/master/mipi-i3c-hci: re-fix __maybe_unused attribute
Message-ID: <20201230214053.GB110311@piout.net>
References: <20201230154304.598900-1-arnd@kernel.org>
 <orno9ppp-no44-4rp5-s6-58n46rsps045@onlyvoer.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orno9ppp-no44-4rp5-s6-58n46rsps045@onlyvoer.pbz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2020 16:23:56-0500, Nicolas Pitre wrote:
> On Wed, 30 Dec 2020, Arnd Bergmann wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > clang warns because the added __maybe_unused attribute is in
> > the wrong place:
> > 
> > drivers/i3c/master/mipi-i3c-hci/core.c:780:21: error: attribute declaration must precede definition [-Werror,-Wignored-attributes]
> > static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
> >                     ^
> > include/linux/compiler_attributes.h:267:56: note: expanded
> > 
> > Fixes: 95393f3e07ab ("i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Nicolas Pitre <npitre@baylibre.com>
> 
> This might be the 3rd patch from 3 different people fixing the same 
> thing. Looks like I3C maintainer is on vacation. Please feel free to 
> send this trivial fix upstream some other way.
> 

Isn't it already upstream?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95393f3e07ab53855b91881692a4a5b52dcdc03c

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
