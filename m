Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A915A2C65A2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgK0MPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbgK0MPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:15:45 -0500
Received: from localhost (fer13-h02-176-173-104-11.dsl.sta.abo.bbox.fr [176.173.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCAED208D5;
        Fri, 27 Nov 2020 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606479345;
        bh=dErJubk9hpLskPjOWd8LYj3gt6yMBQuIgVy955premM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy4UwpyktUZmPl28JtQsuhIAD3SIchLMhehQRht8huK4QAV0YuVEbQFnzJiKJq6o/
         EH4HW6yoJgQN3nslde4XvM+R5Ffybd6Vb/nfKIRnDp0yZ1q9pRKqar/ZKGBR6O7qth
         /EhVyPlby5jLih9k12sHN+xBwNtrAfJ9mrELt2T0=
Date:   Fri, 27 Nov 2020 13:15:42 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: nohz: Update tick instead of restarting tick in
 tick_nohz_idle_exit()
Message-ID: <20201127121542.GA109224@lothringen>
References: <66014fea-7b84-358b-137d-d15190241528@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66014fea-7b84-358b-137d-d15190241528@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 09:22:08PM +0800, Yunfeng Ye wrote:
> In realtime scenarios, the "nohz_full" parameter is configured. Tick
> interference is not expected when there is only one realtime thread.
> But when the idle thread is switched to the realtime thread, the tick
> timer is restarted always.
> 
> So on the nohz full mode, it is unnecessary to restart the tick timer
> when there is only one realtime thread. Adding can_stop_full_tick()
> before restarting the tick, if it return true, keep tick stopped.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

We can indeed stop the tick and avoid it to be re-armed needlessly at this
point.

I'm taking your patch, I may just edit it a little and resend it.

Thanks!
