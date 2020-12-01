Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16BF2CA6D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbgLAPRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:17:55 -0500
Received: from nautica.notk.org ([91.121.71.147]:54084 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387592AbgLAPRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:17:55 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 5E97BC009; Tue,  1 Dec 2020 16:17:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1606835833; bh=W1804/WmEJKiPKMrETIzFsZscClPHYpVI3Xu7UowPbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMNh4jh+h4C3tOWqO1+UCkfvkfxA/exRkYX3v1IDZEbBJISZZHYQwBBZV4HMD1AxJ
         l8hTuf3oRSqZJdIK9x+XnEQPfouUtnBRf2ezXUemULE59mWF4OKDAIbJdRBqWrbJpd
         COrSPeFg1ZdIp2W0mlvbcyo5zto3SNxzKEdElfeyNhh3awF5TnOjas5YJrI6llZ7kt
         ngjDEAgYJmS9nK4l0WvmmlsoyfdEjByOkOfDWZ3Y5tk2F/+GgdDJKOP7mHb/9DAn5H
         Y1w04hLHPXBoNGw/jucX4cAyji0OS8fNmq/28ZWrZRhVZYtrXVlM5aQl6Edj0Jus63
         3VL0z6h2MJd3g==
Date:   Tue, 1 Dec 2020 16:16:58 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH] fs: 9p: add generic splice_read file
 operations
Message-ID: <20201201151658.GA13180@nautica>
References: <20201201135409.55510-1-toke@redhat.com>
 <20201201145728.GA11144@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201145728.GA11144@nautica>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Tue, Dec 01, 2020:
> > Since generic_file_splice_read() seems to just implement splice_read in
> > terms of the read_iter operation, I simply added the generic implementation
> > to the file operations, which fixed the error I was seeing. A quick grep
> > indicates that this is what most other file systems do as well.
> 
> Good catch, might as well do that.
> I'm surprised you didn't hit the same problem with splice_write?
> 
> I see iter_file_splice_write being used for it on many filesystems,
> it's probably better to add both?

Yeah, I confirm both are needed (the second for the pipe -> fs side)

This made me test copy_file_range, and it works with both as well (used
not to)

interestingly on older kernels this came as default somehow? I have
splice working on 5.4.67 :/ so this broke somewhat recently...

I'll add an extra patch with the second and take your patch.
Thanks!

-- 
Dominique
