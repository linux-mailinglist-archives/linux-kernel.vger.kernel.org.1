Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5969A2205FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 09:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgGOHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 03:15:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49162 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgGOHPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:15:53 -0400
Date:   Wed, 15 Jul 2020 09:15:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594797351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4vGwuPOEebYDmPLJLztvnnie4vL7fUD0Df41uFyJ6k=;
        b=RSTYmoeT0rMADn7HAmaSp3bKGH9e68h28IWJ8Z7X5UKErEGLaNcDiEkIDsgzgTYRMHIkQZ
        m90LPXQdW3ZQplJ44Bm9F7i3fX/pylYQ7cOLon/f0S1Mu06N6KGiGmVDlmUFlKgvIVkcSa
        dAehFI3rnACRSlehLXYGRZi5BEnGkGd6XBn6Mvmw8leMyq2ejohjpz80helsHvtM5YUmAr
        q1tzoChMXiPv2EwZ9LnXpO+mL7xCkF7boQXJTbHH5cbKVzCXLKfGyoUjRzbUI6WKnEjZwD
        7Y43nDv3sd1xlaBxKakPOMuoThlUw7Vd8R/y0i78bDKm38M7QGeZlsIj5X3J3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594797351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q4vGwuPOEebYDmPLJLztvnnie4vL7fUD0Df41uFyJ6k=;
        b=rCBuXdy1lGMbQtKWt1T9Is6I/hm0dhfaj5zXHq3sSLshhIbd8mxclYL7pNtgkYAFwHePAD
        mVrVvX7RW1TwxbDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, arnd@arndb.de, elver@google.com, ethp@qq.com,
        frederic@kernel.org, jbi.octave@gmail.com, joel@joelfernandes.org,
        lihaoliang@google.com, madhuparnabhowmik10@gmail.com,
        mchehab+huawei@kernel.org, peter.enderborg@sony.com,
        rdunlap@infradead.org, richard.weiyang@linux.alibaba.com,
        urezki@gmail.com, zou_wei@huawei.com, tglx@linutronix.de
Subject: Re: [GIT PULL tip/core/rcu] RCU commits for v5.9
Message-ID: <20200715071548.fwuaafy7elkkkdpr@linutronix.de>
References: <20200714172701.GA31369@paulmck-ThinkPad-P72>
 <20200714181426.hhguqzrcqdubyvae@linutronix.de>
 <20200714182732.GU9247@paulmck-ThinkPad-P72>
 <20200714190253.ylqjif7frqs2rq7x@linutronix.de>
 <20200714205326.GY9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714205326.GY9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-14 13:53:26 [-0700], Paul E. McKenney wrote:
> Are you good with giving Ulad a few days to produce his patch?

Yes, why not. 

> 						Thanx, Paul
Sebastian
