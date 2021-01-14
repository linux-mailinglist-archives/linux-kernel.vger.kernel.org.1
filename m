Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE362F5F83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhANLKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:10:42 -0500
Received: from relay.sw.ru ([185.231.240.75]:57388 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbhANLKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:10:41 -0500
Received: from [192.168.15.122]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1l00UX-00GZr9-GL; Thu, 14 Jan 2021 14:08:37 +0300
Subject: Re: [PATCH] ubsan: Require GCC-8+ or Clang to use UBSAN
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        dvyukov@google.com, keescook@chromium.org
References: <590998aa9cc50f431343f76cae72b2abf8ac1fdd.1608699683.git.jpoimboe@redhat.com>
 <20210104151317.GR3021@hirez.programming.kicks-ass.net>
 <YAAj9aAcPsV9I6UL@hirez.programming.kicks-ass.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e291008b-6b4d-9da4-1353-0762bc68e8ea@virtuozzo.com>
Date:   Thu, 14 Jan 2021 14:09:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAAj9aAcPsV9I6UL@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/21 1:59 PM, Peter Zijlstra wrote:
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
> ---
> Subject: ubsan: Require GCC-8+ or Clang to use UBSAN
> 
> Just like how we require GCC-8.2 for KASAN due to compiler bugs, require
> a sane version of GCC for UBSAN.
> 
> Specifically, before GCC-8 UBSAN doesn't respect -fwrapv and thinks
> signed arithmetic is buggered.
> 

Actually removing CONFIG_UBSAN_SIGNED_OVERFLOW would give us the same effect without restricting GCC versions.

