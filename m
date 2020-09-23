Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F927596D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 16:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIWOIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWOIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:08:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A126C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 07:08:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600870119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+NmF1c2oykl615YqVUZ5t+8/FEftRhEhxQlFATpfy2Q=;
        b=NZvi+cxBIG2nB9wlS7e3dmmNWPyktR5CbxIYNS4r5qC9j5PoHV/UgtzD3HL+bYISXe7fw0
        2swAbI7XJV8V5JaJNiTn9czanudo/TOqBsuDor+g0OvNe4ej9BHZHmk9swMpicd98h1C+K
        W/g/RSQ5BdVZF1jOQg2Ur7QCSFHYBqknlDe2MKfqlFTiNQZGE03llBE1Ofmjan3JgW0Z68
        HjSS8jufvkgzKQIdCtV4z28fZUSCY3osCLXzCNaftrH8y1yOa7OFfK9cu1ZA10X7Fwh5mO
        yAT0hA6hU4n/SlaM7z/OCUdAaPFmH4Um8Jw3+u9zDcWw62eSDHuzKuUlB2Uk1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600870119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+NmF1c2oykl615YqVUZ5t+8/FEftRhEhxQlFATpfy2Q=;
        b=3QyFZ6GaCMzWmG7z+eo0hW5QxojixkV7NO9wezWIo0hOLyDtsyCQrRxoFNg9RlsRCa2+xZ
        r2AX4Az25SMPppDw==
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 2/9] sched: Fix balance_callback()
In-Reply-To: <20200921163845.457569309@infradead.org>
References: <20200921163557.234036895@infradead.org> <20200921163845.457569309@infradead.org>
Date:   Wed, 23 Sep 2020 16:08:39 +0200
Message-ID: <87d02ca8m0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21 2020 at 18:35, Peter Zijlstra wrote:
>  	return 0;
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1220,6 +1220,8 @@ static inline void rq_pin_lock(struct rq
>  #ifdef CONFIG_SCHED_DEBUG
>  	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
>  	rf->clock_update_flags = 0;
> +
> +	SCHED_WARN_ON(rq->balance_callback);

fails to compile on !SMP

Thanks,

        tglx
