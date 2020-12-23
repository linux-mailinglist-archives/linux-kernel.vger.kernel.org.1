Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6262E204A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgLWSHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgLWSHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:07:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42208C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 10:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0+zfOiUzZlDzLOfq1/XE/in0lna9jZAN4JnZpaidAHQ=; b=veq6cqFzRYETeA5CKr8RmXxj7e
        aUaZZxCkjIlhVuqEpluHsmID4Fndvv59UGRQnxwYrERVGgecMkIIBrcF7xdhgjGToOohNQdZPiUy+
        Ngj8VQTtY3SfV0KWIgnfxlg0W13iED92gem5wBUabHvsdzLHXEm/TrbC4zEzsDMmZnfOq5d/uG7In
        FqhHBV7pVrfdDD4wadYv1R2Y2flOCWYbkMGUg7sv2nhvVCiwlCR2c5FrrsysVE17EPHqflme9jg0f
        CNMgJFqCSbRgqeGLgEHZmRDqH/+WVKT7FLS2XsrcR2BKsUqDdOBXNO6p744XzuzKUM2auJNkm9q36
        s0NU2Svw==;
Received: from [2601:1c0:6280:3f0::64ea]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ks8Ws-0001hm-5l; Wed, 23 Dec 2020 18:06:30 +0000
Subject: Re: [PATCH] kdev_t: Always inline major/minor helper functions
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <65e00871-ee50-54a2-cec0-9e1d10e4a9b6@infradead.org>
Date:   Wed, 23 Dec 2020 10:06:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <984353b44a4484d86ba9f73884b7306232e25e30.1608737428.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/20 7:30 AM, Josh Poimboeuf wrote:
> Silly GCC doesn't always inline these trivial functions.
> 
> Fixes the following warning:
> 
>   arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0xd8: call to new_encode_dev() with UACCESS enabled
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


> ---
>  include/linux/kdev_t.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

~Randy
