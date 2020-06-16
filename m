Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E491FC031
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 22:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgFPUqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 16:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgFPUqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 16:46:53 -0400
Received: from localhost (lfbn-ncy-1-150-120.w83-194.abo.wanadoo.fr [83.194.232.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC752080D;
        Tue, 16 Jun 2020 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592340413;
        bh=2dvEAqyxOW3qcudKHZlBAh3MG+XCmSm3T63qebwF9vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNtmy1s94C9sPECtyji/NqSJXzBEA2tVsgqMAx0irX0PpQ3zUuO4wwLBSq1qep7Qf
         GuHSjQyA54IOnPNDpF4Pe0JiaCUiS6Oc7UXkAl1lznHIygYsYocEoY30j5k765MS0K
         N/SD81SnKiuxXRTFqGuPZ4R2tVF343/nyRqg/sG8=
Date:   Tue, 16 Jun 2020 22:46:51 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200616204649.GA4914@lenoir>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
 <20200615210743.GA21371@lenoir>
 <20200616065757.GA446382@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616065757.GA446382@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:57:57AM +0200, Juri Lelli wrote:
> Sure. Let me know if you find anything.

I managed to reproduce. With "threadirqs" and without
"tsc=reliable". I see tons of spurious TIMER softirqs.
Investigation begins! I'll let you know.

Thanks!
