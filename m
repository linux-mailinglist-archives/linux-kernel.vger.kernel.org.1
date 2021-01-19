Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03FB92FB6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbhASJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:25:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33432 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbhASIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:55:51 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611046488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MbaMnom2K7PhdZRqxLxAfNSuvZ5xFrlBT8r1CAnJI0=;
        b=j+YYWWVUXysN4rhWK6ZkteYIJage8SlMS9C1YixUA8rzRTjzNC/vLJGQ5WudQVcZYlcCep
        bTa6zc0W2oCkVi8OwFtG/LsyP6zN8AEhZxlIgYSYYoMi+aTyNLeotmsd2xUMKVCKfxiNln
        ftjEyIFuxDlBZxZSAWUJPQXgBEnXQn++XC6b7X4AIrKO2wvmFZYuzti5aLUuMAhM5a5eUk
        jZ1Jwtg1H0c6EU/DyEyYXG+6sWVCBI7hgnIlT0uFg511xiiYXCdBQzDakqqnh/mAKOhMOu
        QEMy20lz86VIHxl5DX/+u/B/SUJezqJNz2xXctXuVydi5N5LwwKE069g/Dxlyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611046488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MbaMnom2K7PhdZRqxLxAfNSuvZ5xFrlBT8r1CAnJI0=;
        b=5+1x2VrnYSkxyyJXDMXfHYJ/N1Jg5uYARPAXCOsmB8dUgtESeIhOoCGd6nANdMaECTS0g1
        1GSLwsmjQ0oTh5AQ==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
In-Reply-To: <YAYriDiAl7lajty9@jagdpanzerIV.localdomain>
References: <20210114170412.4819-1-john.ogness@linutronix.de> <YAGE1O/nG57hyRs4@alley> <YAGFebfPNLwjyhcl@alley> <YAYriDiAl7lajty9@jagdpanzerIV.localdomain>
Date:   Tue, 19 Jan 2021 10:00:47 +0106
Message-ID: <87r1mh5mso.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-19, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> John, how did you spot these problems?

I am preparing my series to remove the logbuf_lock, which also refactors
and consolidates code from syslog_print_all() and
kmsg_dump_get_buffer(). While testing/verifying my series, I noticed the
these oddities in the semantics and decided I should research where they
came from and if they were actually necessary.

I wouldn't say the oddities are necessary (in fact, they are quite
annoying), but we have decided to keep them in out of fear of breaking
out-of-tree modules and/or interesting userspace code.

One positive effect of the rework is that we are finding these oddities
and documenting them. I think you and Petr are going down a similar path
with the console registration stuff now.

John
