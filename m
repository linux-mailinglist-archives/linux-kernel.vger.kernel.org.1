Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F426A38F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIOKrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:47:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41174 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgIOKqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:46:53 -0400
Date:   Tue, 15 Sep 2020 12:46:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600166809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xh3EHrRe5z7maxUqybrrB3If+k26a9+UUQ5dxMca94k=;
        b=CN1wSm7whjXDxrCrkgRSy4T34f7EI1hIvTT9Dk2zS4d/x4wuLx7Fj/WpcTaWAhGMCIsHRG
        2HeWLcIVqM6FrJbrLQqV0MB9vnyqTyOVefFe/rtOpCzP4CHnlvi6meQJ8psOz47r6Vh7Mj
        zKjsWZ+NOM1DzZF6zfTg8wmEI8ZQAw/PnGkJtnqVsVBOXsKW/Ih9fyULQe7A3eL4xXKKIg
        02LyS0ZBQSu7W1AV9cLXBpcUxbZG9aP0gpxIRyUvUh1+kzZayOS203QxZsq3me0Ajq4Vgj
        QsF69nPTkUKMFIgs/eO1BkBcaAJmweHtTCjv9lhKmQZgXTEfDROt+hTrLgYVcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600166809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xh3EHrRe5z7maxUqybrrB3If+k26a9+UUQ5dxMca94k=;
        b=XGo40s2BG8WK3B0vXVpyuGVChnuLnuJavmH0tkBUCwvO9Xi7FvC6gKQsXGWpDnRubcMLsC
        RWjKFJpRlK3iMaAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing: Make the space reserved for the pid wider
Message-ID: <20200915104648.hac2ljgzrqc7z244@linutronix.de>
References: <20200904082331.dcdkrr3bkn3e4qlg@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904082331.dcdkrr3bkn3e4qlg@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-04 10:23:31 [+0200], To linux-kernel@vger.kernel.org wrote:
> For 64bit CONFIG_BASE_SMALL=0 systems PID_MAX_LIMIT is set by default to
> 4194304. During boot the kernel sets a new value based on number of CPUs
> but no lower than 32768. It is 1024 per CPU so with 128 CPUs the default
> becomes 131072 which needs six digits. 
> This value can be increased during run time but must not exceed the
> initial upper limit.
> 
> Systemd sometime after v241 sets it to the upper limit during boot. The
> result is that when the pid exceeds five digits, the trace output is a
> little hard to read because it is no longer properly padded (same like
> on big iron with 98+ CPUs).
> 
> Increase the pid padding to seven digits.

ping

Sebastian
