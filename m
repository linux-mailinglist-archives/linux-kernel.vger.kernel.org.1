Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4DC2C872D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgK3OxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:53:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49240 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgK3OxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:53:12 -0500
Date:   Mon, 30 Nov 2020 15:52:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606747950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqYOmy7AsvS+8wcOaYtUA3RjkAkwu7jtiKhNU8ZLeAc=;
        b=C3HNtI8Z0c+cX8DT+3eM0ZoKKBwdXq/0KEAJ7AfOtNKL21z77XU+8noKwyurjwWnsYWjRp
        Sokk6MwgmagA+OtiJ1RTJSAB2Ev3Jy9Xo+K4Owy41kLPI/y0/XaHqU3B8XR1ziD0Jj45OC
        PJLGogsQOTkOn27yr3zo2jERYoOs8OsWgPdH7FN1XzA+8fWIYiuaY73ismRAIPeUn8FYuy
        A5RQfIIs5LZeo+X6RADmR2xdmtB6QHL9n0O8RxkodBt6sxHJKcKWg8i1T2DPnfhBS8BAPe
        VoefZiLFXRTRqAYUHR6u6GFtg+k+obiotrgLzQ0hIACfpbmwPuqTsfkkXeuHZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606747950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqYOmy7AsvS+8wcOaYtUA3RjkAkwu7jtiKhNU8ZLeAc=;
        b=N7PVC7972LE2ln4ZEUrhBw/GJV2UZWO7V0X0J6JqMaC/SJfqQPaU4LLT+eZpWMUWIYCkhG
        o8hAloiZt+T8dlDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
References: <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
 <20201128142723.zik6d5skvt3uwu5f@spock.localdomain>
 <15171df044b167351e7f6a688aabd71bade9ae2a.camel@gmx.de>
 <79ee43026efe5aaa560953ea8fe29a826ac4e855.camel@gmx.de>
 <f1c39a0504310a97e42b667fc4d458af4a86d97a.camel@gmx.de>
 <e38055ffe19751ba63f1c9beceae222438bcac59.camel@gmx.de>
 <20201129112922.db53kmtpu76xxukj@spock.localdomain>
 <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
 <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-30 15:42:46 [+0100], Mike Galbraith wrote:
> This explodes in write_unlock() as mine did.   Oleksandr's local_lock()
> variant explodes in the lock he added.  (ew, corruption)
>=20
> I think I'll try a stable-rt tree.  This master tree _should_ be fine
> given it seems to work just peachy for everything else, but my box is
> the only one making boom... and also NOT making boom with the zbud
> compressor.  Hrmph.

How do you test this? I triggered a few oom-killer and I have here git
gc running for a few hours now=E2=80=A6 Everything is fine.

Sebastian
