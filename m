Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1BF2CA66B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391714AbgLAO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:58:28 -0500
Received: from nautica.notk.org ([91.121.71.147]:33666 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389268AbgLAO62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:58:28 -0500
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 9C8B2C009; Tue,  1 Dec 2020 15:57:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1606834663; bh=KWM9/yD4Vf2GzZmCpfsa4i12NAQl3U3t4hvjjC22bOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MFKTVGZOh4oWAw0CakGRic0UDGpkp8pWIkr8bX5tDScoKsPIdHhLZAWk7YX8av9En
         mlfIhkeYy0qBFbIT23fFHxnHdHnNW2RP3QYYhvN40UAT1k/oKigfn5rXuYTYdCFo/u
         Uk/Y/NQ9nUNrFo5toEIyczPDT+ggFf72SRjtAFMByDL+EHqSaRz7leYda06Aa3V7fY
         xKJjo8o7sfWmrFr2M7TcGruAXAKoubEHJFdiiPXc+0n9rAb2qtKfU2zPnTDR5F2MMe
         14G80x3mJEutD6kVcO3yL0lpLwdNl0Z5/J2KXRLk38BtUTk1ugGO/84EPtmqLydnMX
         UWifdvQnHNoZw==
Date:   Tue, 1 Dec 2020 15:57:28 +0100
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: 9p: add generic splice_read file operations
Message-ID: <20201201145728.GA11144@nautica>
References: <20201201135409.55510-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201135409.55510-1-toke@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Toke Høiland-Jørgensen wrote on Tue, Dec 01, 2020:
> The v9fs file operations were missing the splice_read operations, which
> breaks sendfile() of files on such a filesystem. I discovered this while
> trying to load an eBPF program using iproute2 inside a 'virtme' environment
> which uses 9pfs for the virtual file system. iproute2 relies on sendfile()
> with an AF_ALG socket to hash files, which was erroring out in the virtual
> environment.
> 
> Since generic_file_splice_read() seems to just implement splice_read in
> terms of the read_iter operation, I simply added the generic implementation
> to the file operations, which fixed the error I was seeing. A quick grep
> indicates that this is what most other file systems do as well.

Good catch, might as well do that.
I'm surprised you didn't hit the same problem with splice_write?

I see iter_file_splice_write being used for it on many filesystems,
it's probably better to add both?


> The only caveat is that my test case was only hitting the
> v9fs_file_operations_dotl implementation. I added it to the other file
> operations structs as well because it seemed like the sensible thing to do
> given that they all implement read_iter, but those are only compile tested.

The logic is close enough that it should work, I'll run it through in
cached mode at least first though (just mount with cache=loose or
cache=fscache to hit v9fs_cached_file_operations_dotl yourself if you
want to)
non-dotl operations are harder to test, I don't have any server
compatible either so we'll have to trust it works close enough...

(note you can write comments such as this one after the three dashes
line before the diff chunk so maintainers can reply without having it in
commit message itself)

-- 
Dominique
