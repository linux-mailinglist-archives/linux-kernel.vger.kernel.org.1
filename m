Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E92A2AF6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgKBMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:49:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:42488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgKBMtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:49:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7BDFAD5C;
        Mon,  2 Nov 2020 12:49:14 +0000 (UTC)
Subject: Re: [PATCH v5 1/1] mmap_lock: add tracepoints around lock acquisition
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Rientjes <rientjes@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20201027230711.2180435-1-axelrasmussen@google.com>
 <20201027230711.2180435-2-axelrasmussen@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1ce6927b-32a6-b59f-7b6b-6474000f44db@suse.cz>
Date:   Mon, 2 Nov 2020 13:49:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027230711.2180435-2-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 12:07 AM, Axel Rasmussen wrote:
> The goal of these tracepoints is to be able to debug lock contention
> issues. This lock is acquired on most (all?) mmap / munmap / page fault
> operations, so a multi-threaded process which does a lot of these can
> experience significant contention.
> 
> We trace just before we start acquisition, when the acquisition returns
> (whether it succeeded or not), and when the lock is released (or
> downgraded). The events are broken out by lock type (read / write).
> 
> The events are also broken out by memcg path. For container-based
> workloads, users often think of several processes in a memcg as a single
> logical "task", so collecting statistics at this level is useful.
> 
> The end goal is to get latency information. This isn't directly included
> in the trace events. Instead, users are expected to compute the time
> between "start locking" and "acquire returned", using e.g. synthetic
> events or BPF. The benefit we get from this is simpler code.
> 
> Because we use tracepoint_enabled() to decide whether or not to trace,
> this patch has effectively no overhead unless tracepoints are enabled at
> runtime. If tracepoints are enabled, there is a performance impact, but
> how much depends on exactly what e.g. the BPF program does.
> 
> [ rostedt@goodmis.org: in-depth examples of tracepoint_enabled() usage,
> 	and per-cpu-per-context buffer design ]

Great, thanks Steven.

> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

