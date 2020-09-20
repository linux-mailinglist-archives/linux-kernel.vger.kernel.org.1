Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0DC271798
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgITTfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 15:35:30 -0400
Received: from smtp.infotech.no ([82.134.31.41]:44920 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgITTfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 15:35:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 9DDD020424C;
        Sun, 20 Sep 2020 21:35:28 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iBvNNGn0a9mC; Sun, 20 Sep 2020 21:35:22 +0200 (CEST)
Received: from [192.168.48.23] (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id 38CFD204172;
        Sun, 20 Sep 2020 21:35:20 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] lib/scatterlist: Fix memory leak in sgl_alloc_order()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
References: <e69e9865-a599-5bd9-95b1-7d57c7e2e90c@web.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <1608a0b7-6960-afce-aa39-6785036b01e0@interlog.com>
Date:   Sun, 20 Sep 2020 15:35:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e69e9865-a599-5bd9-95b1-7d57c7e2e90c@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-20 1:09 p.m., Markus Elfring wrote:
>> Noticed that when sgl_alloc_order() failed with order > 0 that
>> free memory on my machine shrank. That function shouldn't call
>> sgl_free() on its error path since that is only correct when
>> order==0 .
> 
> * Would an imperative wording become helpful for the change description?

No passive tense there. Or do you mean usage like: "Go to hell" or
"Fix memory leak in ..."? I studied French and Latin at school; at a
guess, my mother tongue got its grammar from the former. My mother
taught English grammar and the term "imperative wording" rings no
bells in my grammatical education. Google agrees with me.
Please define: "imperative wording".
> * How do you think about to add the tag “Fixes” to the commit message?r

In the workflow I'm used to, others (closer to LT) make that decision.
Why waste my time?

> * Will an other patch subject be more appropriate?

Twas testing a 6 GB allocation with said function on my 8 GB laptop.
It failed and free told me 5 GB had disappeared (and
'cat /sys/kernel/debug/kmemleak' told me _nothing_). Umm, it is
potentially a HUGE f@#$ing memory LEAK! Best to call a spade a spade.

Doug Gilbert

