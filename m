Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171D4243504
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 09:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMHde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 03:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:33:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B2C061757;
        Thu, 13 Aug 2020 00:33:33 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597304012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbGNOc0NhQlgScUYSHrpvG2LTitDuXz5jjuVBcU84Wc=;
        b=MYo8X8/Xl6Ybn21MrKqRt2x/2iGXEIdOdn+XjOMISckOyfKjX53VuCyTi9+U0TGwR+xVk8
        seFBtglj+BaBCmu0nBdIV3emZyRDJvJ3rEbSWpctdqv5jCFoQx8D9xgDMiVVNPLNpmN++I
        7SbIDDv2IYtRi29Qgv0969DVrzRoLqmHjmYIHun+SYfqK1B0sdBYiX3SIyzcrOFOeAAabQ
        gVCdPq9cw5xSKGJz8TF7UMp0GQubj3MYRwUWdOFsYSNMrYbrUWkF+mdWb2vJKTRfdLKjVz
        ZV7T6bO7ONOfrArRbHNSYA1YDq5aURtZdxJZsCJSBTzqfNsBrYHtl45dRtA5zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597304012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbGNOc0NhQlgScUYSHrpvG2LTitDuXz5jjuVBcU84Wc=;
        b=UaBJ5EdU4jb/ZnyCzVoPqLjNPUCod5irswDdXHkG9POUhIu54M4g8cGlmipQFdxUfKC5cm
        4/rgvcPU+Eo3wtBQ==
To:     Jiafei Pan <Jiafei.Pan@nxp.com>, peterz@infradead.org,
        mingo@kernel.org, rostedt@goodmis.org, romain.perier@gmail.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        jiafei.pan@nxp.com, leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        Jiafei Pan <Jiafei.Pan@nxp.com>
Subject: Re: [PATCH] softirq: add irq off checking for __raise_softirq_irqoff
In-Reply-To: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
References: <20200806040729.39186-1-Jiafei.Pan@nxp.com>
Date:   Thu, 13 Aug 2020 09:33:31 +0200
Message-ID: <87bljf57as.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiafei Pan <Jiafei.Pan@nxp.com> writes:
> __raise_softirq_irqoff will update per-CPU mask of pending softirqs,

Please write __raise_softirq_irqoff() so it's clear that this is about a
function.

>  void __raise_softirq_irqoff(unsigned int nr)
>  {
> +	/* This function can only be called in irq disabled context,
> +	 * otherwise or_softirq_pending will be interrupted by hardware
> +	 * interrupt, so that there will be unexpected issue.
> +	 */
> +	WARN_ON_ONCE(!irqs_disabled());

Please use lockdep_assert_irqs_disabled() instead.

Thanks,

        tglx
