Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2527AB84
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgI1KJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:09:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37872 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgI1KJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:09:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601287767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwy7IibwssTuJNrhkCenCV+cTOgb8HHwMX+CkUrSOv4=;
        b=tH9URa5KI7ZrbLKM/4C9qePajXIhXCfvZOrqqHXtcJzribLc3UJgnJ/nLKZdKghk0Gtuek
        rw9Mi0JiE7AhrTccsx9RbAaBNM48h/MsPJyBx0CQMSRxHnk/hgZsjMsijQlraJVvCmY3Qp
        srhOxUwolyOYRxkU6oqsmwxl7Ox61z9oKJs3dEdnm0s9HRfexyyHd/ELfcY1TNFSFS3Mgk
        2la3RvHPYttFqbYS3DHhUalyY/+KYZl84RQLqeswBDnLZC3Yir2eqGEV3hlS1LGDYKuvgZ
        TcCQLXzridFHrmDB+DFN64wZmnG1pJ2WerMj80wzK1iKizcNZ/X2KLDH0k8Fug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601287767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwy7IibwssTuJNrhkCenCV+cTOgb8HHwMX+CkUrSOv4=;
        b=+iZRKZoxg19ONxCC1hW1wFpwuHUEKczRrAt83Qs8JmSWTueLi6SgTkoPT2fMnJZEc88llN
        cUJjc2HSBR5UZ5Bw==
To:     Peter Zijlstra <peterz@infradead.org>, qianjun.kernel@gmail.com
Cc:     will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing loop
In-Reply-To: <20200928092249.GC2628@hirez.programming.kicks-ass.net>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com> <20200915115609.85106-5-qianjun.kernel@gmail.com> <20200928092249.GC2628@hirez.programming.kicks-ass.net>
Date:   Mon, 28 Sep 2020 12:09:27 +0200
Message-ID: <87k0wekyaw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28 2020 at 11:22, Peter Zijlstra wrote:

> On Tue, Sep 15, 2020 at 07:56:09PM +0800, qianjun.kernel@gmail.com wrote:
>> +/*
>> + * The pending_next_bit is recorded for the next processing order when
>> + * the loop is broken. This per cpu variable is to solve the following
>> + * scenarios:
>
> This, that adds all that complexity, and I think it's wrong. The
> softirqs are priority ordered. Running then again from 0 up if/when you
> break seems 'right'.

No. If you break the loop and then restart from 0 you can starve the
higher numbered ones if the next loop terminates on early because one of
the lower one takes too long. Made that happen with networking :)

See the variant I proposed :)

Thanks,

        tglx
