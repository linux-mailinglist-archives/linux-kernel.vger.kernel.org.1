Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844FF2D0269
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgLFKGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgLFKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:06:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20172C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 02:05:49 -0800 (PST)
Date:   Sun, 6 Dec 2020 11:05:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607249147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7OpfGnXnsGRxQFzbsUl4Zk3YhRudufVADXrZ2o6iJ4=;
        b=LAvhPF7j2yS8X+y7oD9cwE4SK4PiZwc8hVmWYMDpWB6K/G5nr/Wh+06PcmGkP/b0CV8BTI
        y7wuqloxA1FfoWNEymn6u6cxj0SU3GVQt4HNFUJv0q4AJafVw3cIh5pIFhaMACFdb/Yjrw
        1k/e1BS8Vl+rsG7HlpMuvZ5EynqhM1BuVm8kWPcFYpnEa4a4p9Tsp/k/W6cOC04dpSVjmA
        /QWFbFzexIKpU8MNq0M0aLC4ZSi9DKSiV9bgLMrHBXvwfQHqY4F2X6c+A5UarwQBEf8vKr
        h9rTuwpecSZGWWu+8XUsRsd2/adlVqPCs3xmVHISVOrugGvMlU6q06yDp0Kf1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607249147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7OpfGnXnsGRxQFzbsUl4Zk3YhRudufVADXrZ2o6iJ4=;
        b=YI0z8ZViH1qVuXkEbskyQ35qRx3Lk1uoCunknoF1chzVoLunjhym4EABNlowJxvsc7lFhx
        inN0NGQrVRJVurDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [patch V2 0/9] softirq: Make it RT aware
Message-ID: <20201206100545.f37qufqbzytkjf6n@linutronix.de>
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201204170151.960336698@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04 18:01:51 [+0100], Thomas Gleixner wrote:
> The RT variant has sucessfully been tested in the current 5.10-rt
> patches. For non-RT kernels there is no functional change.

this series is part of v5.10-rc6-rt14.

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Thanks,
> 
> 	tglx

Sebastian
