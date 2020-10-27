Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D285629A162
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 01:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502134AbgJ0AjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 20:39:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44162 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409696AbgJ0Ack (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 20:32:40 -0400
X-Greylist: delayed 1629 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 20:32:39 EDT
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXCYC-009W8g-Hf; Tue, 27 Oct 2020 00:09:20 +0000
Date:   Tue, 27 Oct 2020 00:09:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Kyle Huey <me@kylehuey.com>
Subject: Re: [PATCH] Fix compat regression in process_vm_rw()
Message-ID: <20201027000920.GE3576660@ZenIV.linux.org.uk>
References: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f69575e0-5170-2d51-8d74-8b3453723aa3@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:03:18PM -0600, Jens Axboe wrote:
> The removal of compat_process_vm_{readv,writev} didn't change
> process_vm_rw(), which always assumes it's not doing a compat syscall.
> Instead of passing in 'false' unconditionally for 'compat', make it
> conditional on in_compat_syscall().
> 
> Fixes: c3973b401ef2 ("mm: remove compat_process_vm_{readv,writev}")
> Reported-by: Kyle Huey <me@kylehuey.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

ACK with some reservations - I suspect that we want an explicit flag
for process_vm_{read,write}v() that would force the 64bit layout for
the vector refering to the foreign process.  It's not relevant for
regression fix; however, as it is these syscalls are not usable for
32bit process trying to access memory of 64bit one - there's no way
to specify the addresses past 4G.
