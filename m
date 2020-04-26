Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896C31B8B93
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Apr 2020 05:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgDZDFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 23:05:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53142 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgDZDFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 23:05:14 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03Q34xxQ018442;
        Sun, 26 Apr 2020 12:04:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Sun, 26 Apr 2020 12:04:59 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03Q34xmY018439
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 26 Apr 2020 12:04:59 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <c2c2f453-9cb3-72b9-a484-03652e8ce10e@I-love.SAKURA.ne.jp>
Date:   Sun, 26 Apr 2020 12:04:56 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/26 9:27, Andrew Morton wrote:
> Well, what's really going on here?
> 
> Is networking potentially consuming an unbounded amount of memory?  If
> so, then killing a process will just cause networking to consume more
> memory then hit against the same thing.  So presumably the answer is
> "no, the watermarks are inappropriately set for this workload".
Maybe somebody is abusing __GFP_MEMALLOC allocations. David, please include whole
context (e.g. which function from which process) instead of only memory stat lines.
