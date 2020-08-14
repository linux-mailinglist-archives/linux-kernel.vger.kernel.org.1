Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86896244C60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 18:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgHNQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 12:00:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:00:36 -0400
Date:   Fri, 14 Aug 2020 15:58:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597420834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6t+jR2il3zVScXYH6J6JnpEfxWy4p58re3TI107BQ4E=;
        b=Kab2i3ZZDb/n3DxfaZIiUh81P4xGk6yGTnDPb3S++DKpSFkbKWwDknCsxcQhXaEj9GOpP7
        OCOWPjUBsYtKDWQfVU2wBSDe30aL34bpyrkHunEdzSkmRDHTNWj1xngdgIP2uz+ynE4bmt
        s8zlg5N22xckkhPgd6k1oIOGRCp9IkM0EGSTqFvwf6YYWOCi8uNsYa6tWlTjUNRIq6SQXJ
        mzFk6tqrQPGIdFik506VzgqPme1OplIPv2vDyfl0dfEGHXbFAP9HTApZrSciVzTlOT6VQl
        KQ35aWe8dDedJ/aUrvifztO+3nEpga75koLtazmhOhYeYl4i3tOs/otUQeellQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597420834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6t+jR2il3zVScXYH6J6JnpEfxWy4p58re3TI107BQ4E=;
        b=kUo8DolQGhidRgrxaiwwr8ZF1lzGU3sFpUZti+NBQhZm/YfJ5jeMXCivuaIknGnLvH2VXm
        OIA2TkkscTEPYoDg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v5.9-rc1
Message-ID: <159742071192.30851.2328227964586183297.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-08-14

up to:  f107cee94ba4: genirq: Unlock irq descriptor after errors

Two fixes in the core interrupt code which ensure that all error exits
unlock the descriptor lock.

Thanks,

	tglx

------------------>
Guenter Roeck (2):
      genirq/PM: Always unlock IRQ descriptor in rearm_wake_irq()
      genirq: Unlock irq descriptor after errors



