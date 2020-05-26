Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824831A7309
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 07:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405534AbgDNFd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 01:33:28 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:34548 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405521AbgDNFd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:33:27 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 03E5VJbJ020951;
        Tue, 14 Apr 2020 07:31:19 +0200
Date:   Tue, 14 Apr 2020 07:31:19 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Ian Molton <spyro@f2s.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <rth@twiddle.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>, x86@kernel.org
Subject: Re: [PATCH 00/23] Floppy driver cleanups
Message-ID: <20200414053119.GB20927@1wt.eu>
References: <20200331094054.24441-1-w@1wt.eu>
 <ae23d88d-fc21-6f46-7c27-ea0adf6211e5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae23d88d-fc21-6f46-7c27-ea0adf6211e5@kernel.dk>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Mon, Apr 13, 2020 at 04:46:41PM -0600, Jens Axboe wrote:
> I'll be happy to queue these up for 5.8 when ready. Would be handy
> if you could resend a v2 patchset with the extra patches, makes my
> life so much easier...

Sure, will do once Denis confirms he's done with the review and is
OK with the series.

Thanks!
Willy
