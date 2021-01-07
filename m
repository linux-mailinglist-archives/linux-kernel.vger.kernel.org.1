Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11F32EC737
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 01:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbhAGAHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 19:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhAGAHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:07:50 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D70C06136B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 16:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1QZxiN2Y8LEelG7OpYOldYUkGlfcW+4VFUmTA5CQW+c=; b=XK/J1qNFzLJxho9wHgBcVIyrJr
        qIXGdrmGZWYJSw6/YqYmrGDdvkSMoNyVmoG8DiOnOTDFvcb5YIrGvMdLqb/70a0QFOu0H2M5/OoLh
        DHtl9liIWd4xLDKLIhu77cklm1aJRpHLx0NlmQ5TqDJlgpCbdHMzJf9RoAMXPPwKaL4195HHDi1bQ
        emzwiWqJv6pdrN7bK9zeRG1Wj9zuyqGVbNymOW+ECbL+2PHQRBwOdUiWgOp6dmlcolFoeEVN7pozV
        pTDs+gXxSJ5I1z8qTpQxCwh5e0kNLMxDEf1h4nPl/Jom4eQxQRLN+5wLDlf/2LYsYFT/IqCJ5f2vb
        iQ7dGFiA==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxIpU-000816-69; Thu, 07 Jan 2021 00:07:04 +0000
Subject: Re: [PATCH] mm/uaccess: Use 'unsigned long' to placate UBSAN
 warnings, again
To:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dvyukov@google.com
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
 <202101061536.C4A93132@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d5b192b2-b216-57d1-4505-06233ae2b882@infradead.org>
Date:   Wed, 6 Jan 2021 16:06:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202101061536.C4A93132@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 3:37 PM, Kees Cook wrote:
> On Mon, Jan 04, 2021 at 04:13:17PM +0100, Peter Zijlstra wrote:
>> On Tue, Dec 22, 2020 at 11:04:54PM -0600, Josh Poimboeuf wrote:
>>> GCC 7 has a known bug where UBSAN ignores '-fwrapv' and generates false
>>> signed-overflow-UB warnings.  The type mismatch between 'i' and
>>> 'nr_segs' in copy_compat_iovec_from_user() is causing such a warning,
>>> which also happens to violate uaccess rules:
>>>
>>>   lib/iov_iter.o: warning: objtool: iovec_from_user()+0x22d: call to __ubsan_handle_add_overflow() with UACCESS enabled
>>>
>>> Fix it by making the variable types match.
>>>
>>> This is similar to a previous commit:
>>>
>>>   29da93fea3ea ("mm/uaccess: Use 'unsigned long' to placate UBSAN warnings on older GCC versions")
>>
>> Maybe it's time we make UBSAN builds depend on GCC-8+ ?
> 
> I would be totally fine with that. The only thing I can think of that
> might care is syzbot. Dmitry, does syzbot use anything older than gcc 8?

I use UBSAN successfully with GCC 7.5.0.
However, I can revert whatever future patch someone adds for this...

-- 
~Randy

