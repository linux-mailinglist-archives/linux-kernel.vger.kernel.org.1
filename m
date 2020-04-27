Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC71B9661
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 07:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgD0FDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 01:03:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63442 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgD0FDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 01:03:33 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03R53HRg000862;
        Mon, 27 Apr 2020 14:03:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Mon, 27 Apr 2020 14:03:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03R53GLu000850
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 27 Apr 2020 14:03:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <fed6a727-1005-cb12-0ad0-4d9a6bb06564@I-love.SAKURA.ne.jp>
Date:   Mon, 27 Apr 2020 14:03:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/27 12:12, David Rientjes wrote:
> Tetsuo: the specific allocation that triggers a page allocation failure is 
> not interesting; we have tens of thousands of examples.  Each example is 
> simply the unlucky last GFP_ATOMIC allocation that fails; the interesting 
> point is the amount of free memory.  In other words, when free memory is 
> below ALLOC_HIGH watermarks, we assume that we have depleted memory 
> reserves *faster* than when user allocations started to fail.  In the 
> interest of userspace being responsive, we should oom kill here.

My interest is, which function (and which process if process context) is [ab]using
GFP_ATOMIC (or __GFP_MEMALLOC) allocations enough to hit memory allocation failure.
GFP_NOWAIT (or __GFP_NOMEMALLOC) could be used if that allocation can't sleep and
can't shortly recover free memory.

