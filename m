Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6022EDA2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 15:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgG0Njr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 09:39:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgG0Njo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:39:44 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595857181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbeOweV7BUtlk+ll/+wND848lKwzOjlmIST9iuJEcQA=;
        b=FL5VaZqjrCpsgtmGXZR/Hd/pjLJJF21ewF45VZ3PxsPZ/e8OVR0Ii/Q++yZhhheThPqgzm
        EJJIqm9PZ6syk/5KXSvtNv9cbh386yyOXVSMYddnO0Qol2IQ4w8B9y+11QCVJWTZmFzgpQ
        aHKb6Fai86hkA9j/dqvX5Wd+AxZKlqXt4fNo/yjaDjH6DstEYtcW/pA94sNA91tLxPyLjs
        DooQhVoPPVzh9PHYULku/wkQ1xyHxldFHOzQnZtxAQeBF9eswHHEqvSVFyj+wRdb/O13Lr
        FsUlt71QrCBSQd34qt8gR0L2zs4o0o8Gb1nIgAlPA1r95dD9yln0HkQHnDBoIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595857181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QbeOweV7BUtlk+ll/+wND848lKwzOjlmIST9iuJEcQA=;
        b=ImzOUJsKnt0dOdYQBmNRkQHA+Zn3kxuT7o8tp6DEOMjfxkLtlUHDR9o6fJV7ksLjHloGHT
        wvaOG6f1at1231Cg==
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] entry: Fix CONFIG_SECCOMP assumption
In-Reply-To: <20200726174731.GA786388@gmail.com>
References: <20200725091951.744848-1-mingo@kernel.org> <20200725091951.744848-2-mingo@kernel.org> <87a6zmcs5q.fsf@nanos.tec.linutronix.de> <20200726174731.GA786388@gmail.com>
Date:   Mon, 27 Jul 2020 15:39:41 +0200
Message-ID: <87y2n5axgi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> Ingo Molnar <mingo@kernel.org> writes:
>> > The __secure_computing() callback only exists on CONFIG_SECCOMP=y,
>> 
>> No. There is a stub function for the SECCOMP=n case.
>
> Which was buggy:
>
>   static inline int __secure_computing(void) { return 0; }

Yes. I screwed that up and fixing that is the right thing to do.
