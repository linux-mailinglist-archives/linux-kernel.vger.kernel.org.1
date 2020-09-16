Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBC26C179
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 12:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgIPKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 06:06:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49453 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgIPKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 06:06:36 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 08GA6XLm039361;
        Wed, 16 Sep 2020 19:06:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Wed, 16 Sep 2020 19:06:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 08GA6WMi039358
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 16 Sep 2020 19:06:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>,
        george.kennedy@oracle.com, jirislaby@kernel.org,
        syzkaller-bugs@googlegroups.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com
References: <00000000000024be1505ad487cbb@google.com>
 <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
 <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
 <20200916082624.GC509119@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3233dcc2-31d5-42e7-3d9d-b36a65b660ea@i-love.sakura.ne.jp>
Date:   Wed, 16 Sep 2020 19:06:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200916082624.GC509119@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/16 17:26, Greg KH wrote:
> On Wed, Sep 16, 2020 at 09:01:06AM +0900, Tetsuo Handa wrote:
>> Greg, will you pick up this patch?
>>
>> It seems that finding the real cause of [3] and actually fixing [3] will be difficult.
>> Since I can't reproduce [3] locally, I will have to try flood of "#syz test" requests
>> for debug printk() patches.
> 
> I agree with Daniel here, can you retest these against Linus's latest
> tree please?
> 

syzbot already reproduced these bugs using the latest commit. ;-)

You can find

  ci-upstream-kasan-gce-root 	2020/09/15 15:18 	upstream 	fc4f28bb 

record for "KASAN: global-out-of-bounds Read in bit_putcs" and

  ci-upstream-kasan-gce-root 	2020/09/16 09:54 	upstream 	fc4f28bb

record for "KASAN: global-out-of-bounds Read in fbcon_resize".
