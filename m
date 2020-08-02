Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465832355D3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 09:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHBHbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 03:31:42 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56824 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgHBHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 03:31:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=wenan.mao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U4Spuqd_1596353498;
Received: from B-W105MD6R-2041.local(mailfrom:wenan.mao@linux.alibaba.com fp:SMTPD_---0U4Spuqd_1596353498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 15:31:39 +0800
Subject: Re: [PATCH -next v2] virtio_net: Avoid loop in virtnet_poll
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200802003818-mutt-send-email-mst@kernel.org>
 <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
 <20200802022549-mutt-send-email-mst@kernel.org>
From:   maowenan <wenan.mao@linux.alibaba.com>
Message-ID: <6543a874-7f2f-ea73-8c24-b75788ea6379@linux.alibaba.com>
Date:   Sun, 2 Aug 2020 15:31:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802022549-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/20 2:26 PM, Michael S. Tsirkin wrote:
> 
> Just noticed the subject is wrong: this is no longer
> a virtio_net patch.

thanks, I will change the subject and send v3.
