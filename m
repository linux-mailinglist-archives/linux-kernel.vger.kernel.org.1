Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA307293A60
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393944AbgJTL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:59:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393937AbgJTL7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:59:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6ACB0AD82;
        Tue, 20 Oct 2020 11:59:47 +0000 (UTC)
Subject: Re: [PATCH 1/3 v2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <20200925211206.423598568@goodmis.org>
 <20200925211819.767526657@goodmis.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8b122215-867a-2517-f754-fbe87118f00c@suse.cz>
Date:   Tue, 20 Oct 2020 13:59:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20200925211819.767526657@goodmis.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/20 11:12 PM, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As tracepoints are discouraged from being added in a header because it can
> cause side effects if other tracepoints are in headers, as well as bloat the
> kernel as the trace_<tracepoint>() function is not a small inline, the common
> workaround is to add a function call that calls a wrapper function in a
> C file that then calls the tracepoint. But as function calls add overhead,
> this function should only be called when the tracepoint in question is
> enabled. To get around this overhead, a static_branch can be used to only
> have the tracepoint wrapper get called when the tracepoint is enabled.
> 
> Add a tracepoint_enabled(tp) macro that gets passed the name of the
> tracepoint, and this becomes a static_branch that is enabled when the
> tracepoint is enabled and is a nop when the tracepoint is disabled.
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Nice! I'm late here, but you mentioned a v3, so FWIW:

Acked-by: Vlastimil Babka <vbabka@suse.cz>
