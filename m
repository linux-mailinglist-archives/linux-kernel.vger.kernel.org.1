Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6929DD25
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgJ2AfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731913AbgJ1WT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:19:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F120C0613CF;
        Wed, 28 Oct 2020 15:19:26 -0700 (PDT)
Date:   Wed, 28 Oct 2020 21:24:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603916642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6YhIGdNQ5rBLEhRQpo5JZ6jxzEoNLg4mGh4uT8QOFo=;
        b=bQ7KKjaKvTATCslxvYVv738SVtO0oSRAdN/5+ofh1b95Bit5y2BuTMzrockvrVwBsgcLXs
        T2hnGbZ7s/f7QioFkG+gEDFQaSm47PQm/LRhp94xZewPmxLXFCWtZrwknGTY4LYAP3fUAp
        1GPXz2RoQ0Tdn87BIZ9egkUym7qmrfzrm4KKXAmyxz/ugypL7Bp4QDmGcz3h1drnOOm7kY
        Sdr49uPMZEt2vfNB/9PAvYbXaYYBWCS5MC6Mei6wGNQZClphOnoqSubPaquYVbj/kUdPuX
        u/pJzA04mmMIiVevIFPwRZ4NgFASN7UKdPRIDV3QlVHpLntE3vAOng6WZmE3BA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603916642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6YhIGdNQ5rBLEhRQpo5JZ6jxzEoNLg4mGh4uT8QOFo=;
        b=ubOqM/XL54xJnO8hZY4Co3MX0qmXw4b5+LhRzq9oA7HHpB+LgLm/82o+ARe5DYWmJG6Nqd
        36ar7YW81FAJaGBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9.1-rt18
Message-ID: <20201028202401.jqksp2ycpbinsmzc@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <20201021131449.qlwjiq2l6embaii3@linutronix.de>
 <54d33ca5-107e-e269-8c47-a1ae0dc60b0e@ccrma.stanford.edu>
 <20201027082247.rs2h7l3wdzxc5f7i@linutronix.de>
 <bef33500-43b1-5895-2511-e39d8f1da1d0@ccrma.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bef33500-43b1-5895-2511-e39d8f1da1d0@ccrma.stanford.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 10:07:35 [-0700], Fernando Lopez-Lezcano wrote:
> The compilation process went ahead (not finished yet), let me know if there
> is a proper patch. No hurry...

I just released -rt20 and it compiles now. I looked at the code and I
wouldn't recommend to use it unless you know exactly what you do.

> Thanks!
> -- Fernando

Sebastian
