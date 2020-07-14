Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21221F2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 15:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgGNNha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 09:37:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52875 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgGNNh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:37:29 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06EDbQxS094750;
        Tue, 14 Jul 2020 22:37:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Tue, 14 Jul 2020 22:37:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06EDbQm9094743
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 14 Jul 2020 22:37:26 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] fbdev: Detect integer underflow at "struct
 fbcon_ops"->clear_margins.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        George Kennedy <george.kennedy@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
 <CGME20200714072231eucas1p17c53f0a661346ebfd316ebd5796ca346@eucas1p1.samsung.com>
 <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
 <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
Message-ID: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
Date:   Tue, 14 Jul 2020 22:37:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/14 19:27, Tetsuo Handa wrote:
> On 2020/07/14 16:22, Bartlomiej Zolnierkiewicz wrote:
>> How does this patch relate to:
>>
>> 	https://marc.info/?l=linux-fbdev&m=159415024816722&w=2
>>
>> ?
>>
>> It seems to address the same issue, I've added George and Dan to Cc:.
> 
> George Kennedy's patch does not help for my case.
> 

OK. You can add

Reported-and-tested-by: syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>

to my patch.

By the way, if

  /* bitfill_aligned() assumes that it's at least 8x8 */

is true, don't we need to also check that the rect to fill is at least
8x8 in bit_clear_margins() ? (Well, I feel did it mean multiple of 8x8 ?
Then, what is bitfill_unaligned() for ?)
