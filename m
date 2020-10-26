Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47142993BE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787763AbgJZR0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:26:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774755AbgJZR0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:26:05 -0400
Date:   Mon, 26 Oct 2020 18:26:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603733163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w09g9ntG++KbDwWTJng4haKq82uB5PtCQULLzShi/Ms=;
        b=3IJBa23H363tO2mHGaelE0hr1jeHXjV39RgpGjFA/SDNCN/Byl5yh/UEpCWEfQxbGX8ZAZ
        DH0idBMZem248bzek9mcjaTHr+8TBt+jjVN33sDe2d26n7ldr1IfkFBEVojXLtX5X6YiQ8
        V5kdcq25I98QIJBP06QCSOG9Xl3Rt9Pm/3SfDF1XgM6JyVoyEpkHgW2OH2UqRkmTMOQ2wl
        EMXwqdzEUoKmRj1rLfNPJZ8Y57BCpX7bQm65Pj4Iojp6PqqmK9CcFQoZoOjk5fkMBisYM8
        zGdlQtwPhkBvJosE/TdbQ369Z7bYMSj2R1amGQEZHB4F0nVP6g/cFyV3Zkl0+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603733163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w09g9ntG++KbDwWTJng4haKq82uB5PtCQULLzShi/Ms=;
        b=gAkeEEJtqD7EH8m+mzfcZxo/1HPjkxirqbssMudnT5uScRe4Ckr8hvgIryiYbPeu3ni+Wv
        kSkvQAwAQzUdYHAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: kvm+nouveau induced lockdep  gripe
Message-ID: <20201026172602.kedrnefiaqzrwoot@linutronix.de>
References: <20201021125324.ualpvrxvzyie6d7d@linutronix.de>
 <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
 <20201023090108.5lunh4vqfpkllmap@linutronix.de>
 <20201024022236.19608-1-hdanton@sina.com>
 <20201024050000.8104-1-hdanton@sina.com>
 <20201024094224.2804-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201024094224.2804-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-24 17:42:24 [+0800], Hillf Danton wrote:
> Hmm...sounds like you learned English neither at high school nor
> college. When did you start learning it?

He learned enough to submit valid bug report where you could reply with
	Thank you Mike!

Sebastian
