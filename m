Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06F2907F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409791AbgJPPF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 11:05:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409774AbgJPPF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 11:05:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602860756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=W0KWcS5Ma84IiGqrEBo/7gmz2luRC/My3voCf8ImekY=;
        b=JaIdMPx78M/yQDbeHks3r9A+X+1r4n5a2z4lVbQPgVcorDokVFOCdkyRQqVkemIwSVvwp9
        n0QDYO3R7XjZPCZX1M+Gs2RU1TvQRXvyeLbX5B9LSVuLIACAF/1iN316T0MPqSfn8pywqx
        TUhmT1+RK+j0xcovtLcDnp+dMtq8DRA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03003AF9A;
        Fri, 16 Oct 2020 15:05:56 +0000 (UTC)
Date:   Fri, 16 Oct 2020 17:05:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] printk for 5.10 (includes lockless ringbuffer)
Message-ID: <20201016150554.GI8871@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull one printk hot-fix from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux tags/printk-for-5.10-fixup

----------------------------------------------------------------

- Prevent overflow in the new lockless ringbuffer.

----------------------------------------------------------------
Petr Mladek (1):
      printk: ringbuffer: Wrong data pointer when appending small string

 kernel/printk/printk_ringbuffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
