Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D42F406E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393765AbhAMAnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 19:43:13 -0500
Received: from pi3.com.pl ([185.238.74.129]:35080 "EHLO pi3.com.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392407AbhAMAdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 19:33:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 152784C155F;
        Wed, 13 Jan 2021 01:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1610497993; bh=3GMYFpp/wbG8Z6D6XI2O885Jn+5orTUbhJhnccxH358=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ca51V4lPI1fCGxdyr252WPg2GWATr7c++/brRfmOso261/iFjyVuYm2s+RRHg8Fsr
         MLNeDHDNvwMf0nmyGELlhtiyXz4SXZfDhv3jPeluPc9jvxgPSG3Ki4l0MwBT8pxQ5n
         9NQELzqh8Kc8aPsXW3LLd5wNqlBVykls1qE90vkmB2kqrstsKs/EzG3cE5OzFcoROY
         JcR6LQeEHQY4M3UoCP8DeMg4HfemANaiTb3apo/v8KHtrKzQMXvm8+DNSVE+jER+YF
         1nLLnHfxEVujScJLDBRunYWMP7/VARUr8CVRARNFLRtj760EZ5LO7ikiL6RIFFGhpb
         wKJd4i2/CCqzA==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y2xVfl7luCgv; Wed, 13 Jan 2021 01:33:10 +0100 (CET)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 947074C140B; Wed, 13 Jan 2021 01:33:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1610497990; bh=3GMYFpp/wbG8Z6D6XI2O885Jn+5orTUbhJhnccxH358=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c33SNwuNVqNWf8FPvTEfYnc35lPN+MlXQZaOikIu/AuT+j/ERdFZgemyyDS5yYD1B
         9x2qLlncfjAiKt12sDNlsZ7D/M39gkDcYs8xyHBQnRGz44s/cxJNfj8DQm46P4Gxa6
         +IB96C8nY3tzwch/UWhIJgJsTl4M64+p+jnzOYA0WBco2psRGTnjvrcNU6JaHcyDkI
         jy9JaGSpe8r/ZcHoE9fDPewk5z+fSWeslaHh2KZxgO66cX9WdTVYMek1pu9FwlP++d
         c5rt+C+vnllHktBkWWBWapZ+BmioZPfT4iduFCGK3WP/RLZFQrjp1o4HpIBinNXcpw
         vD8QbWDQ2Vgow==
Date:   Wed, 13 Jan 2021 01:33:10 +0100
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: [PATCH] module: invoke kobject uevent before sending LIVE
 notification
Message-ID: <20210113003310.GA3040@pi3.com.pl>
References: <20210110175401.GB32505@pi3.com.pl>
 <20210111142048.GA27038@linux-8ccs>
 <20210112001559.GA20073@pi3.com.pl>
 <20210112104654.GA26122@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112104654.GA26122@linux-8ccs>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change "module: delay kobject uevent until after module init
call", while helping avoid a race between udev/systemd and the module
loader, made it unnecessarily more difficult to monitor kernel module
integrity by out-of-tree projects such as Linux Kernel Runtime Guard.

Specifically, that change delayed the kobject uevent unnecessarily too far,
to until after sending a MODULE_STATE_LIVE notification.  As the uevent
modifies internal state of the KOBJ itself, this violated the assumption
(non-guaranteed yet handy while we can maintain it) that the KOBJ remains
consistent and can be integrity-checked as soon as the module is LIVE.

To make all of these projects happy at once, move the kobject KOBJ_ADD
uevent to just before sending the MODULE_STATE_LIVE notification.

Fixes: 38dc717e9715 ("module: delay kobject uevent until after module init call")
Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
---
 kernel/module.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 4bf30e4b3eaa..7d56b1b07237 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3681,14 +3681,14 @@ static noinline int do_init_module(struct module *mod)
                dump_stack();
        }

+       /* Delay uevent until module has finished its init routine */
+       kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
+
        /* Now it's a first class citizen! */
        mod->state = MODULE_STATE_LIVE;
        blocking_notifier_call_chain(&module_notify_list,
                                     MODULE_STATE_LIVE, mod);

-       /* Delay uevent until module has finished its init routine */
-       kobject_uevent(&mod->mkobj.kobj, KOBJ_ADD);
-
        /*
         * We need to finish all async code before the module init sequence
         * is done.  This has potential to deadlock.  For example, a newly
