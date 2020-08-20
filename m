Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D79624B600
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 12:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgHTKbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgHTKa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:30:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24386C061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:30:57 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597919455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7cfqGZkgK3wnJB9jJTRyVdxfvxLDto1zNe1KaB54CQ=;
        b=3EPV3knAsfXh9CLr4dbF2tNW9e0Oq2HfDbBKBMYqfoaDIbXFkTdm/EytFwE5I24IwNgnuq
        FuUWBh8VVEpQyS1FqxeyaEag7nXK22qb5G80yozV/xLh3srD/lZ0axqKQQgbcbXQHVPbuS
        xSaLNSkuwt5T6Yg2hM8LRFUaExEwNRPrSIMeHZ+k1i6lGHyn/U51Jn4TTiQAkN5Rl1oqhp
        mkZp4L95aPKQ2y+Q6/i/1u7hTcKjAwFnB9PxdNEIBPyCVi489i6KCYnqBkRJM0O5PvE0FV
        j/kl3aHFTotsHiJJBFaw9gso3GHgMGndn/eDSsMrcuqZyKDSYaVgtFaZzy35uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597919455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7cfqGZkgK3wnJB9jJTRyVdxfvxLDto1zNe1KaB54CQ=;
        b=ULPUuc9eUbDuKNnt9MihP1T/D8RAv4BzOgvJSfu8MvLnf9XATyA9okQkvpn1/9lrMsYkxq
        kNlGeL7PLbFiRcAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org
Subject: Re: [patch 0/2] timekeeping: NMI safe timekeeper enhancements
In-Reply-To: <20200820084738.GD4353@alley>
References: <20200814101933.574326079@linutronix.de> <20200820084738.GD4353@alley>
Date:   Thu, 20 Aug 2020 12:30:55 +0200
Message-ID: <878se9ip7k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr,

On Thu, Aug 20 2020 at 10:47, Petr Mladek wrote:
> The interface is perfectly fine for printk() needs.

Good. So I suggest that I apply that on top of rc1 somewhere in tip and
tag the top commit. So you can pull that tag into your printk branch and
go wild.

Thanks,

        tglx


