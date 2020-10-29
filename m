Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2121629F04D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgJ2PnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:43:03 -0400
Received: from foss.arm.com ([217.140.110.172]:39606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgJ2PnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:43:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F77931B;
        Thu, 29 Oct 2020 08:43:02 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2B1A3F66E;
        Thu, 29 Oct 2020 08:43:00 -0700 (PDT)
References: <20201029151103.373410-1-colin.king@canonical.com> <jhjft5xoxtd.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] sched/debug: fix memory corruption caused by multiple small reads of flags
In-reply-to: <jhjft5xoxtd.mognet@arm.com>
Date:   Thu, 29 Oct 2020 15:42:58 +0000
Message-ID: <jhjeelhox6l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/20 15:29, Valentin Schneider wrote:
>> @@ -269,17 +269,17 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
>>               return 0;
>>       }
>>
>> -	tmp = kcalloc(data_size + 1, sizeof(*tmp), GFP_KERNEL);
> [...]
>> -	tmp += *ppos;
> [...]
>> -	kfree(tmp);
>
> Yeah, that's downright sloppy :( I can't remember which one it was in a
> hurry, but I was "inspired" by another proc handler somewhere; I'll try to
> find out if there's any issue in that one or if I really cannot shift the
> blame elsewhere.

Nope, blame is all mine.
