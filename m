Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CDC25304A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbgHZNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:49:13 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33488 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730058AbgHZNsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:48:12 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U6wCMsX_1598449687;
Received: from xunleideMacBook-Pro.local(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0U6wCMsX_1598449687)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Aug 2020 21:48:07 +0800
Reply-To: xlpang@linux.alibaba.com
Subject: Re: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826081102.GM22869@dhcp22.suse.cz>
 <99efed0e-050a-e313-46ab-8fe6228839d5@linux.alibaba.com>
 <20200826110015.GO22869@dhcp22.suse.cz>
 <f0122b2d-4740-2caf-3c4f-009a513426e3@linux.alibaba.com>
 <20200826120740.GP22869@dhcp22.suse.cz>
 <19eb48db-7d5e-0f55-5dfc-6a71274fd896@linux.alibaba.com>
 <20200826124810.GQ22869@dhcp22.suse.cz>
 <061e8600-e162-6ac9-2f4f-bf161435a5b2@linux.alibaba.com>
 <20200826132620.GR22869@dhcp22.suse.cz>
From:   xunlei <xlpang@linux.alibaba.com>
Message-ID: <cbf64fdf-65a5-bda3-7a60-9b3ca70a16c9@linux.alibaba.com>
Date:   Wed, 26 Aug 2020 21:48:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826132620.GR22869@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/26 ÏÂÎç9:26, Michal Hocko wrote:
> On Wed 26-08-20 21:16:28, xunlei wrote:
> [...]
>> oom_reaper also can't get scheduled because of 1-cpu, and the mutex
>> uses might_sleep() which is noop in case of "CONFIG_PREEMPT_VOLUNTARY is
>> not set" I mentioned in the commit log.
> 
> OK, I see. I have clearly missed the 1cpu configuration. Sorry about
> that.
> 
> Thanks for bearing with me.
> 

Thanks for the confirmation, has sent v2.
