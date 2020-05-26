Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468001DF6A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 12:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgEWKlf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 23 May 2020 06:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgEWKle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 06:41:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79523C061A0E;
        Sat, 23 May 2020 03:41:34 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jcRar-00011s-Cd; Sat, 23 May 2020 12:41:29 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     <wang.yi59@zte.com.cn>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <xue.zhihong@zte.com.cn>,
        <jiang.xuexin@zte.com.cn>, <wang.yong12@zte.com.cn>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RT PATCH] Fixed: line break of pr_cont not take effect
References: <202005231419598080913@zte.com.cn>
Date:   Sat, 23 May 2020 12:41:27 +0200
In-Reply-To: <202005231419598080913@zte.com.cn> (wang's message of "Sat, 23
        May 2020 14:19:59 +0800 (CST)")
Message-ID: <87imgnndbc.fsf_-_@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you. I added Sebastian Siewior and linux-rt-users to the addresses
since this is a patch against PREEMPT_RT.

On 2020-05-23, <wang.yi59@zte.com.cn> wrote:
> Line break of pr_cont not take effect.
> Use several pr_cont to print continuous paragraph, it is expected to
> have line break when line ends up with  '\n', however the paragraph
> does not have line break
> -printk_kthread_func will not print info before log_store insert msg
>  into printk_rb, and pr_cont calls cont_add to keep data in buffer.
>  cont_add only when the following conditions are met insert msg to
>  printk_rb
>  1.cpu != c->cpu_owner || !(flags & LOG_CONT)
>  2.c->len + len > sizeof(c->buf)
>
> Signed-off-by: 汪勇10269566 <wang.yong12@zte.com.cn>

Acked-by: John Ogness <john.ogness@linutronix.de>

@Sebastian: The original patch submission is here[0].

Thanks,
John Ogness

[0] https://lkml.kernel.org/r/1590025064-14433-1-git-send-email-wang.yi59@zte.com.cn
