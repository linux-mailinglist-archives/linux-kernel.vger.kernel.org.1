Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67082D24CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgLHHnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:43:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgLHHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:43:40 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607413378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FiUfOe1m4zmK5rloas3mUpAaYXEafQsN3Pdg2nM09g=;
        b=melhXpYO30SCRb7mdPnLU8RCJpJt3Qve8Hx00aMH1lc/7t6/6aZTYab8iRNi8FNj7k9MBd
        WyWcmqe+cxnXiRmdf5O8+oAM09GAU1nbpoDO6fjtpnWA/KxyQ8iupCsBWOOq8czX2qtoFx
        fuV7pkqJ93HOSB8O9UzKL2r0iODGrBS3ASciVUGBlHO+RXDUERmYmg6w+5EY7znrK9Nl7q
        TFYEX7rvGcuFNUyZ51RqDHUmXwW54l6eMVDv/U7wmG4RnsqDMu05AI6uQ4tNvTuJRNuHz0
        RurdlM2LpwN2bImyyusQCizug6eqHDZ55cBsXd8gvsC/jGcdjvhvvdr/nOOong==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607413378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4FiUfOe1m4zmK5rloas3mUpAaYXEafQsN3Pdg2nM09g=;
        b=r4FvqJ+deb819UadigBkS9YoOBzZ23ieBW/86XIczrge0NYbu5pIwnDMEvj2+kevd1AkqU
        C3lLmFy83wM6flDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 2/3] printk: define CONSOLE_LOG_MAX in printk.h
In-Reply-To: <20201207222020.2923-3-john.ogness@linutronix.de>
References: <20201207222020.2923-1-john.ogness@linutronix.de> <20201207222020.2923-3-john.ogness@linutronix.de>
Date:   Tue, 08 Dec 2020 08:48:57 +0106
Message-ID: <87k0tsd9q6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07, John Ogness <john.ogness@linutronix.de> wrote:
> CONSOLE_EXT_LOG_MAX for extended console messages is already defined
> in printk.h. Define CONSOLE_LOG_MAX there as well so that future
> changes can make use of the constant for non-extended console
> messages.

Actually this patch is not necessary for this series. Also, this patch
should probably modify all the "LOG_LINE_MAX + PREFIX_MAX" calls as
well.

John Ogness
