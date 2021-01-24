Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4284301A7A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 09:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbhAXIOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 03:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbhAXIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 03:14:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F0C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 00:13:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611476021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6ARxzSACzyN+3uDousJyVDfsRj+7AoBf0/EqK7Wevo=;
        b=ju2C0Bpuk+7J6SdtXoy1c/2wdsIrYKvl68F2WVm2dF5KsWz6PJcpN4zXr6giuGOlmHaji4
        GdQXWJ7k8bUDu+n9rqPdeqUpnmqtL0MiLH2zYYCKuDjNDA9Hown7jYKLTbAtk1Ap3/xJag
        eAY2FKjzwHPtT9yq1+HdPMMdZmJoop+nuCnG/Y9rpCvuDQGs0PMZjPJUYYkXnBUXuJpDT+
        wRi3BqTnMzDXIvSmYR+UPs1SY1Y/1iQR1NgJgVLPhwOD8N5IXkmaxlEJ5ukwuAkmhqGcZx
        c0tQCpbnQ9zUf9FvpHHpSv62/3oSKCJKBgf2KhMZdFT/6aUaOXOHCt9+TXBh9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611476021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b6ARxzSACzyN+3uDousJyVDfsRj+7AoBf0/EqK7Wevo=;
        b=ZVApe2/BGMB8Z9yvEQPOFkfDD8fQeODI2LIeNozQvLfSfbiaCO6tUMqgGt/fYne++hBlen
        BavINN/sX6n4CcAw==
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix buffer overflow potential for print_text()
In-Reply-To: <yt9d8s8je3gc.fsf@linux.ibm.com>
References: <20210114170412.4819-1-john.ogness@linutronix.de> <yt9dk0s48y70.fsf@linux.ibm.com> <87v9bomtd0.fsf@jogness.linutronix.de> <yt9deeibe4ia.fsf@linux.ibm.com> <yt9d8s8je3gc.fsf@linux.ibm.com>
Date:   Sun, 24 Jan 2021 09:19:40 +0106
Message-ID: <87k0s2n45n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

Thanks for the outstanding analysis!

On 2021-01-23, Sven Schnelle <svens@linux.ibm.com> wrote:
>> 1401		if (buf_size > 0)
>> 1402			text[len] = 0;
>
> I don't think i have really understood how all the printk magic works,
> but using r->text_buf[len] seems to be the correct place to put the
> zero byte in that case?

Yes, you are correct! @text is pointing to the beginning of the
currently processed line, not the beginning of the buffer.

I will submit a patch to fix our recent fix (unless you would like to do
that).

Thank you for all your help with this!

John Ogness
