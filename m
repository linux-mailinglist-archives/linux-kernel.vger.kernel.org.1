Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC75D235719
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHBNYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 09:24:49 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:50483 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgHBNYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:24:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0U4TmhiN_1596374683;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4TmhiN_1596374683)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 21:24:43 +0800
Subject: Re: [PATCH 4/4] mm/thp: narrow lru locking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <1596254957-22560-1-git-send-email-alex.shi@linux.alibaba.com>
 <1596254957-22560-4-git-send-email-alex.shi@linux.alibaba.com>
 <20200802110925.GW23808@casper.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <2504ea84-110c-cf8e-d2f7-0aab97f6121a@linux.alibaba.com>
Date:   Sun, 2 Aug 2020 21:24:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200802110925.GW23808@casper.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/8/2 ÏÂÎç7:09, Matthew Wilcox Ð´µÀ:
> You're playing games with separating interrupt disabling from spinlocks.
> Have you got any feedback from -rt people on this?

Is there other suggestions to remove local_irq_disable?

Just check again on kernel/mm directory on linux-next. there are still
much local_irq_disable there.

Guess we need a final solution instead of block new one.

Thanks
Alex
