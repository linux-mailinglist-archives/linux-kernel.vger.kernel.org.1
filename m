Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43827227299
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 01:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGTXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 19:00:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53914 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgGTXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:00:47 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06KN0R9P056875;
        Tue, 21 Jul 2020 08:00:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp);
 Tue, 21 Jul 2020 08:00:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav105.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06KN0RHT056872
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 21 Jul 2020 08:00:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] vt: Reject zero-sized screen buffer size.
To:     Brooke Basile <brookebasile@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+017265e8553724e514e8@syzkaller.appspotmail.com>
References: <20200710113658.GA1238355@kroah.com>
 <20200710143455.3438-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <741c66b4-3855-9c5e-ca67-9e44eb6fa083@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4f9a7d46-223a-5178-ae82-4e973f5d8a29@i-love.sakura.ne.jp>
Date:   Tue, 21 Jul 2020 08:00:26 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <741c66b4-3855-9c5e-ca67-9e44eb6fa083@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/21 0:40, Brooke Basile wrote:
> Looks like this patch also fixes this bug reported by syzbot:
>     https://syzkaller.appspot.com/bug?id=dc5c6b1ae4952a5d72d0e82de0eeeb9e5f767efc
> 
> There's a lot of other bugs that were reported by syzbot that also touch this code, so I just wanted to give a heads up in case you weren't already aware of them.  It seems like this patch could be a fix for all of them.
> 
> Here are the links to those other bugs:
>     https://syzkaller.appspot.com/bug?id=3e2ad4922b18026c1579f50900747401842acdff
>     https://syzkaller.appspot.com/bug?id=7329638ab83b70fc8fab07e14c4b2fcdc73af21d
>     https://syzkaller.appspot.com/bug?id=01703eb07363bd1f9757bc4a54994455fc9db9dc
>     https://syzkaller.appspot.com/bug?id=7a04be77a06aae337077e00f0ecdb2239dfc2fc3
>     https://syzkaller.appspot.com/bug?id=ff1543b5ade351b9d6c4ef51c805d89422a8271d
> 

Indeed they all access around UINT_MAX address. Marked as dup. Thank you.

