Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD22BB8AA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKTWBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:01:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:43510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbgKTWBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:01:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8CD39AC23;
        Fri, 20 Nov 2020 22:01:39 +0000 (UTC)
Date:   Fri, 20 Nov 2020 13:38:28 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Waiman Long' <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH 5/5] locking/rwsem: Remove reader optimistic spinning
Message-ID: <20201120213828.n7f23qy75hduommo@linux-p48b.lan>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-6-longman@redhat.com>
 <20201118053556.3fmmtat7upv6dtvd@linux-p48b.lan>
 <ee34bc01-9fef-23ff-ada1-1ec2d39533c9@redhat.com>
 <5fe76531782f4a8492b341d5f381147b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5fe76531782f4a8492b341d5f381147b@AcuMS.aculab.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020, David Laight wrote:
>I got massive performance improvements from changing a driver
>we have to use mutex instead of the old semaphores (the driver
>was written a long time ago).
>
>While these weren't 'rw' the same issue will apply.
>
>The problem was that the semaphore/mutex was typically only held over
>a few instructions (eg to add an item to a list).
>But with semaphore if you got contention the process always slept.
>OTOH mutex spin 'for a while' before sleeping so the code rarely slept.

The caveat here is if you are using trylock/unlock from irq, which
is the only reason why regular semaphores are still around today. If
not, indeed a mutex is better.

Thanks,
Davidlohr
