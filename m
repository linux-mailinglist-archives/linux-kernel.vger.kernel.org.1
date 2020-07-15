Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAF22014E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 02:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGOAYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 20:24:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53878 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgGOAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:24:11 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06F0O9m6009533;
        Wed, 15 Jul 2020 09:24:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Wed, 15 Jul 2020 09:24:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06F0O80A009529
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 15 Jul 2020 09:24:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] fbdev: Detect integer underflow at "struct
 fbcon_ops"->clear_margins.
To:     George Kennedy <george.kennedy@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <189fc902-db7c-9886-cc31-c0348435303a@i-love.sakura.ne.jp>
 <20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200712111013.11881-2-penguin-kernel@I-love.SAKURA.ne.jp>
 <CGME20200714072231eucas1p17c53f0a661346ebfd316ebd5796ca346@eucas1p1.samsung.com>
 <db4b3346-b9f8-a428-1445-1fcbd8521e1d@samsung.com>
 <e00078d1-e5fb-a019-3036-cb182ed2e40b@i-love.sakura.ne.jp>
 <c5bf6d5c-8d0a-8df5-2a11-38bf37a11d67@oracle.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a2433659-4f95-d508-11de-8273fd2b6632@i-love.sakura.ne.jp>
Date:   Wed, 15 Jul 2020 09:24:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5bf6d5c-8d0a-8df5-2a11-38bf37a11d67@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/15 2:15, George Kennedy wrote:
> Can you try the a.out built from the original Syzkaller modified repro C program? It walks 0-7 through xres and yres of the fb_var_screeninfo struct.

I'm not familiar with exploit code. What do you want to explain via this program?

>   struct fb_var_screeninfo *varp = (struct fb_var_screeninfo *)0x200001c0;
>   struct fb_var_screeninfo *starting_varp = malloc(sizeof(struct fb_var_screeninfo *));

>     memcpy(starting_varp, varp, sizeof(struct fb_var_screeninfo));

>             memcpy(varp, starting_varp, sizeof(struct fb_var_screeninfo));

At least, I suspect there is a memory corruption bug in this program
because of malloc()ing only sizeof(struct fb_var_screeninfo *) bytes.

