Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7372EF6D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbhAHR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbhAHR6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:58:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780AC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 09:57:26 -0800 (PST)
Date:   Fri, 8 Jan 2021 18:57:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610128645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=C2y4+ecKpsmHcb/3eNFWG1CKXZN48EwfB8bnapJyrW0=;
        b=rvlPk4NZ3Z04WeurV7XZLAhWnp5l5D2U0jr69C/hTBA4Utz5o6sppQGx12iG0r0GXg9cA6
        oHZwjilWYu9rlj9zDt4baCETXxv00vn1iy8N4yyhxt4qVdOwRTQ1K/Adv9SvK38gTj28uY
        HjpUKnHKQlWY7PSo7JhcHKRrW/ZsINk5rzRkIKLY5l7mCYePb3PqxYx9p6N56yH2Rzv2Lr
        niHmlfS4VrqnMYoXxsSu9WhKSUZM605tkmGTkiI4HtibWgMSc7Yp1+ZZDWiH0wuOAyRfKS
        sEyQGtygu5on5rz2Ivloyaa76Me7CemjwxMH6oP438mGSpEwcaND7L7BLDDj5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610128645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=C2y4+ecKpsmHcb/3eNFWG1CKXZN48EwfB8bnapJyrW0=;
        b=oWdB8WKCFDDUGKwK3BhuvX7CaLQ/aYJceO44Sd18msi998myRq86qgSx23bGTLWVtuT1Jw
        MrhG4qr6H0ifTQCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC] The purpose of raw_spin_lock_bh()
Message-ID: <20210108175723.d6r7omgoq3qv5wb7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed that we have raw_spin_lock_bh() and it has a few users.
My guess is that the API should be removed and the existing user(s)
should be moved to spin_lock_bh() / spinlock_t instead.
On !RT it works as expected and there is no difference compared to
spinlock_t.
On RT it is kind of broken: It uses a raw_spinlock_t, disables BH but
does not disable preemption. So it will spin on the lock but the owner
could be scheduled out.

I could (of course) make raw_spin_lock_bh() do the right thing on RT
but from a quick look in sock_map_update_common() there is at least
  raw_spin_lock_bh(&stab->lock);
    -> sock_map_add_link()
       -> spin_lock_bh(&psock->link_lock);

which would then trigger a might_sleep().

Sebastian
