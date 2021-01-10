Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417C92F08E4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 18:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAJRys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 12:54:48 -0500
Received: from pi3.com.pl ([185.238.74.129]:56114 "EHLO pi3.com.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbhAJRyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 12:54:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by pi3.com.pl (Postfix) with ESMTP id 371294C1078;
        Sun, 10 Jan 2021 18:54:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1610301244; bh=mWE84DOHbPwW/vozjGXlD8cEVFb7hYv77ntONA/4Bp0=;
        h=Date:From:To:Cc:Subject:From;
        b=Lo6miSoXAh24qp6c5AkpxUrZdWETVR+gcvCavBxAk0VgNNo7RjyEhSCQ1MtsP2j5H
         n3EYawPjVqG1E9X3LsestqRPZa7uRyzsP9nD5d8PVZZLaiYiS9qVhiEs4/JkhnlikN
         7SGcLQfIpKuZb2nZKn90/ddixvxxP9LvvpHLWGgrHn1233LND0St8bBHbpUn9fLEnB
         ARVpaVylO4dVUou3fyqqXjDAJrQ5yZCvMR7wPmu6p8oCbuQpOz3x/aMLGRhDO4Y1iO
         gM4U6+3CSIbIQL1Q2nO+h9Jj9XwaHokB+gj9KA5Ie8dp+41uO3szZ8KsvAmrvUCSeD
         G9tDBKtRe4pkQ==
X-Virus-Scanned: Debian amavisd-new at pi3.com.pl
Received: from pi3.com.pl ([127.0.0.1])
        by localhost (pi3.com.pl [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AopTYEpqEsLV; Sun, 10 Jan 2021 18:54:01 +0100 (CET)
Received: by pi3.com.pl (Postfix, from userid 1000)
        id 57EF74C1518; Sun, 10 Jan 2021 18:54:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pi3.com.pl; s=default;
        t=1610301241; bh=mWE84DOHbPwW/vozjGXlD8cEVFb7hYv77ntONA/4Bp0=;
        h=Date:From:To:Cc:Subject:From;
        b=BOWy7L0xrbrjvTiU5OutAS8JZbUHic3X2hK2d80euXy/8uBemz5/hruBu3wnlUc7O
         uIWBnIh6yKX5sa9Pg8TJGMqgoMZ+vON9ZNyOxL/X7lYmB3B949FymJGE3MLUgp8UuI
         E4NyqH8VvECx3FcDLn2853xb4jhmjFzp+lpT9dBjIecz13kQDJv+HssItdhX5akken
         wWvyup7iVlFf3oDqpLrQz/x2CwpNSa2sQFBibxrk79MCjU/x0g0jhjVwvoyp7B0Wcs
         SZa4NUQy4r0/G8yMVTQe8eZz/IoqE7H6Xxsax6ydiIVc+wGF2J43nFmubjrCsGaV7K
         z1qvBnT5s4L4w==
Date:   Sun, 10 Jan 2021 18:54:01 +0100
From:   Adam Zabrocki <pi3@pi3.com.pl>
To:     Jessica Yu <jeyu@kernel.org>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Solar Designer <solar@openwall.com>
Subject: Linux Kernel module notification bug
Message-ID: <20210110175401.GB32505@pi3.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I believe that the following commit does introduce a gentle "functionality 
bug":

"module: delay kobject uevent until after module init call":
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/kernel/module.c?id=38dc717e97153e46375ee21797aa54777e5498f3

The official Linux Kernel API for the kernel module activities notification has
been divided based on the readiness 'stage' for such module. We have the
following stages:

        MODULE_STATE_LIVE,      /* Normal state. */
        MODULE_STATE_COMING,    /* Full formed, running module_init. */
        MODULE_STATE_GOING,     /* Going away. */
        MODULE_STATE_UNFORMED,  /* Still setting it up. */

LIVE means that the kernel module is correctly running and all initialization
work has been already done. Otherwise, we have event 'COMING' or 'UNFORMED'.

In the described commit, creation of the KOBJECT has been moved after invoking
a notficiation of the newly formed kernel module state (LIVE). That's somehow
inconsistent from my understanding of the kernel modules notifiers logic.
Creation of the new objects (like KOBJ) should be done before notification of
the stage LIVE is invoked.

This commit breaks some of the projects that rely on the LIVE notification to
monitor when the newly loaded module is ready.

I believe that the latest time when 'kobject_uevent' function can be called is
just before invoking 'blocking_notifier_call_chain', e.g:

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

Thanks,
Adam

--
pi3 (pi3ki31ny) - pi3 (at) itsec pl
http://pi3.com.pl

