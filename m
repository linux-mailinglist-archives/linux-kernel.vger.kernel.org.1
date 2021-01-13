Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115D52F4F4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbhAMPyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:54:39 -0500
Received: from netrider.rowland.org ([192.131.102.5]:59613 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727134AbhAMPyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:54:39 -0500
Received: (qmail 1282043 invoked by uid 1000); 13 Jan 2021 10:53:57 -0500
Date:   Wed, 13 Jan 2021 10:53:57 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+4feb9bb7280fb554f021@syzkaller.appspotmail.com>
Cc:     eli.billauer@gmail.com, gregkh@linuxfoundation.org,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Subject: Re: WARNING in corrupted/usb_submit_urb (2)
Message-ID: <20210113155357.GB1281761@rowland.harvard.edu>
References: <0000000000001cc99505b48b5094@google.com>
 <000000000000039dd005b8c14b6e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000039dd005b8c14b6e@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:20:10PM -0800, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit c318840fb2a42ce25febc95c4c19357acf1ae5ca
> Author: Alan Stern <stern@rowland.harvard.edu>
> Date:   Wed Dec 30 16:20:44 2020 +0000
> 
>     USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a8972f500000
> start commit:   cd796ed3 Merge tag 'trace-v5.10-rc7' of git://git.kernel.o..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59df2a4dced5f928
> dashboard link: https://syzkaller.appspot.com/bug?extid=4feb9bb7280fb554f021
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1653b8a7500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170d946b500000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: USB: Gadget: dummy-hcd: Fix shift-out-of-bounds bug
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I strongly believe that syzbot's conclusion is wrong.  The commit it 
identified has nothing to do with the original problem.

Alan Stern
