Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF2E2FBFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404752AbhASTVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbhASTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:13:46 -0500
Received: from forward106o.mail.yandex.net (forward106o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:13:05 -0800 (PST)
Received: from myt5-4fa6d87d1832.qloud-c.yandex.net (myt5-4fa6d87d1832.qloud-c.yandex.net [IPv6:2a02:6b8:c12:2507:0:640:4fa6:d87d])
        by forward106o.mail.yandex.net (Yandex) with ESMTP id 9C5325060D7A;
        Tue, 19 Jan 2021 22:13:02 +0300 (MSK)
Received: from myt6-9bdf92ffd111.qloud-c.yandex.net (myt6-9bdf92ffd111.qloud-c.yandex.net [2a02:6b8:c12:468a:0:640:9bdf:92ff])
        by myt5-4fa6d87d1832.qloud-c.yandex.net (mxback/Yandex) with ESMTP id YReIGUqZQY-D2Fe9MtE;
        Tue, 19 Jan 2021 22:13:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1611083582;
        bh=/MNdusjVBdqHw5qjDLgNu7ow8up6s3cMeSI0EmEjL2A=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID:Cc;
        b=dJLRIh42IpbW6waBaYOgyK61rZpTsyhkKXYgG0o4leblyFvW+yqFMeBdjHu+y1G2t
         JEYy7zMjp2sJAV/SwNauGZRCciSJNwJIbSXMttK35bbvoPyUTA6RCz7Z+Pnb7Ey6HL
         qqSl5SYdDByr6wa2E37TgJT8rVamPk8liYI2zjLE=
Authentication-Results: myt5-4fa6d87d1832.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt6-9bdf92ffd111.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id KA6voNREkq-D1IexuS7;
        Tue, 19 Jan 2021 22:13:01 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>,
        Brian Gerst <brgerst@gmail.com>
References: <f3086de0babcab36f69949b5780bde851f719bc8.1611078018.git.luto@kernel.org>
From:   stsp <stsp2@yandex.ru>
Message-ID: <65ca981d-1a23-d8fe-71fb-efe17befe8df@yandex.ru>
Date:   Tue, 19 Jan 2021 22:13:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f3086de0babcab36f69949b5780bde851f719bc8.1611078018.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.01.2021 20:40, Andy Lutomirski пишет:
> The implementation was rather buggy.  It unconditionally marked PTEs
> read-only, even for VM_SHARED mappings.  I'm not sure whether this is
> actually a problem, but it certainly seems unwise.  More importantly, it
> released the mmap lock before flushing the TLB, which could allow a racing
> CoW operation to falsely believe that the underlying memory was not
> writable.
>
> I can't find any users at all of this mechanism, so just remove it.
>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Linux-MM <linux-mm@kvack.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: x86@kernel.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Stas Sergeev <stsp@list.ru>
> Cc: Brian Gerst <brgerst@gmail.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
Acked-by: stsp2@yandex.ru

dosemu2 just uses mprotect().
The BIOSSEG stuff in vm86_32.c is also
unused btw.
