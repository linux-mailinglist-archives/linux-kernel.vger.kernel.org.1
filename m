Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9F128C763
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgJMCzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:55:33 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:43451 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgJMCzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:55:32 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 09D2tTNR012025;
        Tue, 13 Oct 2020 04:55:29 +0200
Date:   Tue, 13 Oct 2020 04:55:29 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: about prandom vs __this_cpu_read()
Message-ID: <20201013025529.GA12006@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

the latest prandom series I sent you changes __this_cpu_read() to
this_cpu_read() since LKP returned the following trace on i386:

[    9.061912]  dump_stack+0x54/0x6e
[    9.061912]  check_preemption_disabled+0xb1/0xc0
[    9.061912]  __this_cpu_preempt_check+0xf/0x11
[    9.065516]  __igt_reserve+0x91/0x580
[    9.065516]  igt_reserve+0x5b/0xc0
[    9.065516]  test_drm_mm_init+0x78/0xa9

I got another report that it breaks on ARC (trivial fix consists in
adding irqflags.h in prandom.h) but that made me wonder, we're using
this to access and update the net_rand_noise variable only, wouldn't
it be better to use the faster raw_cpu_read()/raw_cpu_write() there,
considering we don't care about concurrent accesses since they simply
add even more impredictability to the noise ?

If so, I'll update this branch and will send you another PR.

Thanks,
Willy
