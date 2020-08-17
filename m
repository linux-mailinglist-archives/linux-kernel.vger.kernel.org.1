Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE58B2463DD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 11:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHQJ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 05:58:26 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36239 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726366AbgHQJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:58:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U6.NLKV_1597658301;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U6.NLKV_1597658301)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 17:58:22 +0800
Date:   Mon, 17 Aug 2020 17:58:21 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
Message-ID: <20200817095821.GA29756@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 11:47:56AM +0800, Alex Shi wrote:
>pageblock_flags is used as long, since every pageblock_flags is just 4
>bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
>that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
>flags. It would cause long waiting for sync.
>
>If we could change the pageblock_flags variable as char, we could use
>char size cmpxchg, which just sync up with 2 pageblock flags. it could
>relief much false sharing in cmpxchg.
>

If my understanding is correct, CPU reads data in the size of cacheline.
Define a variable a char or other, doesn't help on false sharing. 

Correct me, if not.

-- 
Wei Yang
Help you, Help me
