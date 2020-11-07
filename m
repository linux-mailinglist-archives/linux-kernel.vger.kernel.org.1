Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC6D2AA7A3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 20:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgKGTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 14:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgKGTa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 14:30:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFCF320723;
        Sat,  7 Nov 2020 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604777426;
        bh=EQMjDRBd8BSlKp/VlSTumlRp+3ncqT09LVmSQ8AJGGI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a1OnXJ9CPCARVo/gAYW2MQ/XUG5Vowdybylwa31Z7i9n4cUP8LfrHGGherXaUcqa+
         UllDxEv13hEhFSoyoqE5oMB48rxq8iPkPusYlRqeonSNrEaeRuwI+YjdEF+hAO9zfY
         hEOPYB6dRx8IzKuDXdqnbwdiL7rJvjrvRC9WtMsE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 78C0335225E2; Sat,  7 Nov 2020 11:30:26 -0800 (PST)
Date:   Sat, 7 Nov 2020 11:30:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking: remove duplicate include of percpu-rwsem.h
Message-ID: <20201107193026.GE3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1604737443-16241-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604737443-16241-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 04:24:03PM +0800, Wang Qing wrote:
> Remove duplicate header include which is unnecessary.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Queued for further review and testing, thank you!

I had to apply against v5.10-rc1 and then cherry-pick the result, which
did work fine.  However, in the future, could you please post patches
against the -rcu tree's "dev" branch?

Please see https://kernel.org/pub/linux/kernel/people/paulmck/rcutodo.html
for more information.

And as always, I could not resist a bit of wordsmithing, so please see
below and let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit ad6dcb7c338ad322ddeeb75594bc77dcdbeb43de
Author: Wang Qing <wangqing@vivo.com>
Date:   Sat Nov 7 16:24:03 2020 +0800

    locking: Remove duplicate include of percpu-rwsem.h
    
    This commit removes an unnecessary #include.
    
    Signed-off-by: Wang Qing <wangqing@vivo.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index fd838ce..0ab94e1 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -27,7 +27,6 @@
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
 #include <linux/reboot.h>
 
