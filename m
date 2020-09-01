Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D04258E43
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 14:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIAMdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 08:33:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgIAMbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:31:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD17FAEF8;
        Tue,  1 Sep 2020 12:31:14 +0000 (UTC)
Date:   Tue, 1 Sep 2020 14:31:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        John Ogness <john.ogness@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
Message-ID: <20200901123113.GO4928@alley>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
 <20200821080813.GM4353@alley>
 <d81e8b0d-fa7f-1da1-671f-0541b94ad349@siemens.com>
 <a5f4c178-9b3c-6ccd-9ea1-24d8fdc13273@kernel.org>
 <20200825123542.GU4353@alley>
 <20200825171756.830d5895eb40d2dded2803ae@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825171756.830d5895eb40d2dded2803ae@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-25 17:17:56, Andrew Morton wrote:
> On Tue, 25 Aug 2020 14:35:42 +0200 Petr Mladek <pmladek@suse.com> wrote:
> 
> > Andrew, would you mind when I take the three gdb/lockless-printk
> > related changes via printk tree to avoid synchronization problems?
> 
> No probs.  If such patches turn up in linux-next I just drop my copy.
> After checking that the patches fully match...

I have just pushed the two patches into printk/linux.git, branch
printk-rework.

Andrew's typo fix has been squashed into the 2nd patch.

Best Regards,
Petr
