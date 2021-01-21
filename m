Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165342FE1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbhAUFpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbhAUFob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:44:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87EC0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 21:43:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611207826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7IiZGf/+GOnr5xgrwi4Q9Z2vC4T67Wwl5jrIrHAPII=;
        b=XrfQXuFElNFH0O/8QQFbRtJMiZFGumkps1laXQW/UJIksvhYp3xDk0y0Xt+5/p3TfopRaM
        yuW8ism7KM3Imu4sZO81bgVCz0GRJf0N4lxLLcXvMmqZEU2mKeJXVdFpG224FN0TbMUDDl
        pRdlfqKorswAD4OB/CTvpldVC7KgpP7jZ8h9pJQy0hlWaa+rVItk8kX3Y6QQpFPMnb5sAJ
        q/LH8xcY8J73mukXE9ctHORvqEDLX7Z+oMvZDBxBtrYHYKdsaQ1EfsR79DATPHDOhXmgZe
        Its1bD4eCCqEkIYK/StkCGQHbM4AzAiY8u0J/qzk6VEUNkVNKXVo2t9mg/C6GQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611207826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7IiZGf/+GOnr5xgrwi4Q9Z2vC4T67Wwl5jrIrHAPII=;
        b=Br0UXqyb3FPuvHHussnvE/eazltW3hOMjP6CS4usMtkyiFU+CeOs3ngu5qOLYbn/92H0np
        Qx5s0sqcpsOPLCAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] printk: fix syslog_print_all() 1024-byte edge case
In-Reply-To: <20210120194106.26441-2-john.ogness@linutronix.de>
References: <20210120194106.26441-1-john.ogness@linutronix.de> <20210120194106.26441-2-john.ogness@linutronix.de>
Date:   Thu, 21 Jan 2021 06:49:46 +0106
Message-ID: <87sg6uq1yl.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20, John Ogness <john.ogness@linutronix.de> wrote:
> If klogctl(SYSLOG_ACTION_READ_ALL) is called with a buffer size
> of 1024 and the message data will exactly fill 1024 bytes and the
> last message of that is multi-line, the last line of the last
> message will be silently dropped.

Sorry, please disregard this patch. The problem is not because of the
size-1 behavior of record_print_text(). It is because syslog_print_all()
is allocating a temp buffer that is not large enough to hold multi-line
syslog-expanded records.

That problem can be solved another day, if we even want to consider it a
problem.

Sorry for the noise.

John Ogness
