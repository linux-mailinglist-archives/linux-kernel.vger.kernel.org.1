Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4A1E5240
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 02:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgE1AdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 20:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE1AdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 20:33:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AADC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 17:33:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c8so7777549iob.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k/vP5W2oMukw5SIwIRY9OsaBo8uyFKNFoJtfdNmBMYk=;
        b=rxHsPdkLq1ts/2tzkmOe4WkG1FvNXDNy/yZj1s9RpNaRLtuPOc8VNxOIC5tiY547dT
         N5ESj2CYtY7NUl+3UkYEJO4Gzlbc295oM92aQ89gdOV4gPmJOsnXfUuGsUf7LpXelUmQ
         xH7YEu+CbAqBmB+ZQyPNdh80CeiqpLhRPHiMiGFQB2zOxRDHigMJeJmt3Q4NvN5ovgUP
         E3pW3RIeGbdWoCyjyJsVidjYc/QNS33W8QrCyQLkQGQDmGrzNSyNrwb3KYwxucJ0FG/v
         by+7XyAh5WOsMnr+ZW3T81qrYltgdBf2LwWgfqEMa7EI/LI8yCBbMn8ic59jmxJCkEzE
         XJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k/vP5W2oMukw5SIwIRY9OsaBo8uyFKNFoJtfdNmBMYk=;
        b=IUKhPPB2WY3ThHM3NvpTFrF4GKhVyfSzjTD2++iqEosAYOOpvbmBz7PJM8QcEKPfKB
         DXbcPQhi7SNFeI38Mo205n18jMaM7N01SljtpQbq8P2Uq7iJwuyNCrE1kVxMrna1F8c9
         wTVHtAKJSlYAYETmWLURS76FEQilDkZXaGG6dxENrGAtg73WBrgVBO6lHbGmUx0ZY49z
         t2KhepJd6jpBC+lbWcGYUAMja5Fx+x7wzb+/Q1riWp2acHlclqlrQOp91b25AjG94PwG
         sWVcz00Q/VwTRFdv/l1oDKyJ80yp8mc9rFTFSejRhO40lM21lgFbk5nMbakuSAzq6yf0
         r7Tg==
X-Gm-Message-State: AOAM530piFlfPGVwGMcoX/jSDtfUOXOp5BtRuKVoVZ6HwU9QmHSfYrAo
        wehAVDHKHg19fcWrWDCyoaTTzjBa3cQN9X4BOdv4LQ==
X-Google-Smtp-Source: ABdhPJyvOD2zVm2shSVFxqad3tbL55Lbgi4E5Mksvhir84sQrGtDQMgQRsvCi9Ie3v8iz1Kj7e961LqxAyM5s/g8fhE=
X-Received: by 2002:a5e:a61a:: with SMTP id q26mr417152ioi.207.1590625994586;
 Wed, 27 May 2020 17:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200527194633.1660952-1-bigeasy@linutronix.de> <20200527194633.1660952-3-bigeasy@linutronix.de>
In-Reply-To: <20200527194633.1660952-3-bigeasy@linutronix.de>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 28 May 2020 08:33:03 +0800
Message-ID: <CAJhGHyCxR2RgvwMQrNT-82qHKJ-Cok4d2sWy4q7mgtZ_CtXA+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] workqueue: Convert the pool::lock and
 wq_mayday_lock to raw_spinlock_t
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 3:47 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The workqueue code has it's internal spinlocks (pool::lock), which
> are acquired on most workqueue operations. These spinlocks are
> converted to 'sleeping' spinlocks on a RT-kernel.
>
> Workqueue functions can be invoked from contexts which are truly atomic
> even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
> contexts is forbidden.
>
> The pool::lock hold times are bound and the code sections are
> relatively short, which allows to convert pool::lock and as a
> consequence wq_mayday_lock to raw spinlocks which are truly spinning
> locks even on a PREEMPT_RT kernel.
>
> With the previous conversion of the manager waitqueue to a simple
> waitqueue workqueues are now fully RT compliant.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/workqueue.c | 176 ++++++++++++++++++++++-----------------------
>  1 file changed, 88 insertions(+), 88 deletions(-)
>

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
