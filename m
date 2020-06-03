Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB01EC637
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 02:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgFCAUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 20:20:25 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51420 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgFCAUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:20:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 68E8629AF2;
        Tue,  2 Jun 2020 20:20:22 -0400 (EDT)
Date:   Wed, 3 Jun 2020 10:20:21 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS
 support
In-Reply-To: <20200602161225.GJ23230@ZenIV.linux.org.uk>
Message-ID: <alpine.LNX.2.22.394.2006031002550.8@nippy.intranet>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com> <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com> <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com> <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
 <20200602161225.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020, Al Viro wrote:

> I have done that on aranym (which is how I'd been doing all testing for 
> e.g. signal-related m68k patches) and I've seen references to some 
> out-of-tree qemu variant doing quadra, but nothing for amiga 
> emulators...
> 

Laurent Vivier's Quadra 800 emulation is no longer out of tree. It 
appeared in QEMU v4.2.0 and ethernet support was stabilized in QEMU 
v5.0.0.
