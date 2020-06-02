Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F971EBA62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 13:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgFBL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 07:29:57 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:49569 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgFBL35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:29:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U-NArnr_1591097390;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U-NArnr_1591097390)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Jun 2020 19:29:51 +0800
Subject: Re: [PATCH] mm/compaction: avoid VM_BUG_ON(PageSlab()) in
 page_mapcount()
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <158937872515.474360.5066096871639561424.stgit@buzz>
 <alpine.LSU.2.11.2005231650070.1171@eggly.anvils>
 <alpine.LSU.2.11.2006012022440.1288@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <7a02e2f6-6fa8-3727-1718-887c0d1dc1cb@linux.alibaba.com>
Date:   Tue, 2 Jun 2020 19:28:30 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006012022440.1288@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/6/2 ÏÂÎç12:05, Hugh Dickins Ð´µÀ:
> Cc'ing Alex Shi, because I noticed this when trying his v11 per-memcg
> lru_lock series (which appears to be a big improvement over earlier
> versions, thanks in particular to Johannes's memcg swap simplifications);
> and Alex's 12/16 makes a change on top of Konstantin's latter check,
> which will now just be reverted. I'm not yet confident in Alex's
> isolate_migratepages_block(), in part because this muddle.

Hi Hugh,

Yes, this could make a very tricky change on compaction behavior. I will update
the patchset after next update.

Thanks a lot for notice this! And looking forward to more comments on per memcg
lru_lock patchset! :)

Thanks
Alex
