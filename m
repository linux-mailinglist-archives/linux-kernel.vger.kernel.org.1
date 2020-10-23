Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E845296BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461001AbgJWJBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S460858AbgJWJBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:01:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BCAC0613CE;
        Fri, 23 Oct 2020 02:01:10 -0700 (PDT)
Date:   Fri, 23 Oct 2020 11:01:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603443669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=by2GFgbRZ/dj7bmTE0Htiaizc6lllZpv9RghLyuZt2M=;
        b=w9KXDgAbuEgZmQ7408c2pKXcdzKJEHDerrFs2PNNsTckAIs7vCUb+EeD2wKImb9fjohNWq
        GwCqUCVJC+T2YtWFzLgQYliDVQFzdpW/ftvo5XZnWT+gqUNt4L5NQdl8o3jkZY1xfy5WaV
        /S2ZGbTmxzr201DQE9JOzK2oOt79k1idwz2VQHO8/dt/m3E3XypKmD8dH+7wVr08Nk3PDv
        ur7hnICMZMSVKoJRJ0TYfb9K+CHecIoWQ5f7IwK6DAYcSKazRoQeWV8OKr1x33orqmM1wj
        Z6faAWCHdPbzt2a1+9jI7UlR0jDhc6hh1Urd+Kom8aVz2JYfEOJoDEhoin7kmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603443669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=by2GFgbRZ/dj7bmTE0Htiaizc6lllZpv9RghLyuZt2M=;
        b=0bBhdwgHFAnmqncERKGjcGPDsJN8ckVbN7sxpmv5jbpObENkmHwb2TTlfBcjSY+Q5jl01b
        3QG7f3j+bdlLtPAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kvm+nouveau induced lockdep  gripe
Message-ID: <20201023090108.5lunh4vqfpkllmap@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-22 07:28:20 [+0200], Mike Galbraith wrote:
> I've only as yet seen nouveau lockdep gripage when firing up one of my
> full distro KVM's.

Could you please check !RT with the `threadirqs' command line option? I
don't think RT is doing here anything different (except for having
threaded interrupts enabled by default).

Sebastian
