Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25262EA638
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbhAEIA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:00:29 -0500
Received: from verein.lst.de ([213.95.11.211]:60433 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbhAEIA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:00:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 804D067373; Tue,  5 Jan 2021 08:59:46 +0100 (CET)
Date:   Tue, 5 Jan 2021 08:59:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Does uaccess_kernel() work for detecting kernel thread?
Message-ID: <20210105075946.GC30414@lst.de>
References: <0bcc0c63-31a3-26fd-bccb-b28af0375c34@i-love.sakura.ne.jp> <20201223075307.GA4185@lst.de> <239a6775-c514-e752-2520-16668b8bc344@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <239a6775-c514-e752-2520-16668b8bc344@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 07:11:38PM +0900, Tetsuo Handa wrote:
> due to commit 5e6e9852d6f76e01 ("uaccess: add infrastructure for kernel
> builds with set_fs()") and follow up changes. Don't we need to change this
> "uaccess_kernel()" with "(current->flags & PF_KTHREAD)" ?

No.  The real problem here is that when a this funtion is called under
set_fs it allows kernel memory access for all user pointers, and due to
the indirection in the playload allows reading or changing kernel
memory.  A kthread does not have that issue.

> >> For another example, if uaccess_kernel() is "false" due to CONFIG_SET_FS=n,
> >> isn't TOMOYO unexpectedly checking permissions for socket operations?
> > 
> > Can someone explain WTF TOMOYO is even doing there?  A security module
> > has absolutely no business checking what context it is called from, but
> > must check the process credentials instead.
> > 
> 
> TOMOYO distinguishes userspace processes and kernel threads, and grants
> kernel threads implicit permissions to perform socket operations.

And this is the problem we need to fix.  A kernel thread can't just have
implicit permissions only because it is a kernel thread.  Think of e.g.
the io_uring service threads.
