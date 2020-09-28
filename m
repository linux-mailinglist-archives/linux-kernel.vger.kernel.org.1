Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70CFB27B062
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgI1O6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgI1O6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:58:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA97C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 07:58:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601305089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HgXXMv78VixGy49hlVFOjc4mN7Se0EDCWad0ffrTWk=;
        b=dDZoOPTdOErYfdhAx+y8kuCc4gjWuXD//KVh7ErocH9mBR3pWdvO/LAALYFJL8ktMiUJhZ
        AlnNqGq2colWVNzWshdIWF9nCQuwC9LtCvyE95jbYOvZQA+z9eOBSWMOpebui3ePZdAnDr
        rIAEz6zmL3dcwhcAYzrIfEeov1GcjZkLlkf1aKGL1Varj+UCO7/T6bzX8AQJ36OtY4X6Xe
        RO65jZanwotvz1tqczbFPS6Gqbe7HVoQuG76leOH9bHehlu7nSeUVdceUjopc+s9QuiMGh
        56QxdOLTnmYzmyo5waVQu3SuqHfL9zGcwBUINXVk71ENty865SMnh9DHDlIqHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601305089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HgXXMv78VixGy49hlVFOjc4mN7Se0EDCWad0ffrTWk=;
        b=3x4B6rmhAwnabkNSxbtBbfuPQk4RQNTVpsWLc/xGxjFJ8qGMdL2hJaXmfRNwUUxkh0qaHn
        +3A2AMEJVBHGokCg==
To:     Prasad Sodagudi <psodagud@codeaurora.org>, rostedt@goodmis.org,
        qais.yousef@arm.com, peterz@infradead.org, mingo@kernel.org,
        cai@lca.pw, tyhicks@canonical.com, arnd@arndb.de
Cc:     rameezmustafa@codeaurora.org, linux-kernel@vger.kernel.org,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCH 1/2] cpu/hotplug: Add cpuhp_latency trace event
In-Reply-To: <1600904266-102397-2-git-send-email-psodagud@codeaurora.org>
References: <1600904266-102397-1-git-send-email-psodagud@codeaurora.org> <1600904266-102397-2-git-send-email-psodagud@codeaurora.org>
Date:   Mon, 28 Sep 2020 16:58:09 +0200
Message-ID: <87tuvij6da.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23 2020 at 16:37, Prasad Sodagudi wrote:
> Add ftrace event trace_cpuhp_latency to track cpu
> hotplug latency. It helps to track the hotplug latency
> impact by firmware changes and kernel cpu hotplug callbacks.

Why?

And even if that makes sense, the implementation makes absolutely no
sense at all.

      trace_cpuhp_callback_enter();
      callback();
      trace_cpuhp_callback_exit();

No point in all this start time and conditional sched_clock() muck.

But then again, hotplug is slow by definition and nobody cares.

Thanks,

        tglx
