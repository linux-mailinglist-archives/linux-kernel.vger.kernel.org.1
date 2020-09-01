Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877EA258E1F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIAMWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 08:22:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbgIAMLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:11:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67F81AEE2;
        Tue,  1 Sep 2020 12:11:18 +0000 (UTC)
Date:   Tue, 1 Sep 2020 14:11:17 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] docs: vmcoreinfo: add lockless printk ringbuffer
 vmcoreinfo
Message-ID: <20200901121116.GL4928@alley>
References: <20200814213316.6394-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814213316.6394-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-08-14 23:39:16, John Ogness wrote:
> With the introduction of the lockless printk ringbuffer, the
> VMCOREINFO relating to the kernel log buffer was changed. Update the
> documentation to match those changes.
> 
> Fixes: ("printk: use the lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>

The patch is committed in printk/linux.git, branch printk-rework.

Best Regards,
Petr
