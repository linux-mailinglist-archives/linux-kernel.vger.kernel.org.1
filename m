Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831F921EC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGNJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 05:13:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgGNJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:13:28 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594718006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ad5Ds6y4Cwxz0EA9bWnm/7kcoiw95HIzl75sRuD+Ac=;
        b=RK1/AHX1Rve2bsD2WogQoxhSXwX9sHKm7rT41BX+73vjXmCqdEynjA8IQj8sv9s/3MRJkl
        7wsONs10Lnv6MxBX8s3p0LVcNZI7hiUXqFGcWPjPdinhNN16X8KpS71PVSUoBtz4j6dOxQ
        tlRnv6LI3eewOUpA85L6bGhr/sUEhcvrry5tUswQ7krfEMAWLvSFUx5pUZ5TZjFgEoHNMo
        SkAwHf/xxr5XA34UaVcmCuD7P9KDGK4C+5iMRD2WT1IVIK8HFezod7Fmk4umFc884QNUgg
        KT/+MGsgLEiwV34COnPbAfvYmgVfH3x7XAI2FPdc40OlkVIQ8CIT0V8YEpoxsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594718006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ad5Ds6y4Cwxz0EA9bWnm/7kcoiw95HIzl75sRuD+Ac=;
        b=UF/8CrTM1V/tJQbuBTT0/KNsCOaRx49ZdJWeyJxpZ0WhtFKXq6SR6DuOscvYQbSmZ8sw7b
        uITmx7VQkw60JaAA==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH 2/9] timer: Add comments about calc_index() ceiling work
In-Reply-To: <20200707013253.26770-3-frederic@kernel.org>
References: <20200707013253.26770-1-frederic@kernel.org> <20200707013253.26770-3-frederic@kernel.org>
Date:   Tue, 14 Jul 2020 11:13:26 +0200
Message-ID: <87tuyav4qx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Weisbecker <frederic@kernel.org> writes:
>  static inline unsigned calc_index(unsigned expires, unsigned lvl)
>  {
> +	/*
> +	 * Time may have past since the clock last reached an index of
> +	 * this @lvl. And that time, below LVL_GRAN(@lvl), is going to
> +	 * be substracted from the delta until we reach @expires. To
> +	 * fix that we must add one level granularity unit to make sure
> +	 * we rather expire late than early. Prefer ceil over floor.

This comment confuses the hell out of me.

        /*
         * The timer wheel has to guarantee that a timer does not fire
         * early. Early expiry can happen due to:
         * - Timer is armed at the edge of a tick
         * - Truncation of the expiry time in the outer wheel levels
         *
         * Round up with level granularity to prevent this.
         */

Hmm?

Thanks,

        tglx
