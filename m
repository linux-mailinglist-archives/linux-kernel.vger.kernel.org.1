Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC38245AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 04:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHQCSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 22:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHQCSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:18:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09731C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=nZCcwv0Wht/iKzqSZJvMvvq50B64/ROu+qMNB5S+xD8=; b=UyyqrFf6za4T8JtyGcq62iHHnI
        PsoHGMZPAQYPKmhe5s9FWD1LcmLlDYPjLTuVZ/+6QptE5jgYxwIX19/tbKH5NNWnwY/cxLHb+qDNe
        6uBaDFq3OE/EBDlFJ6dMJpkYNA4gc2Tt9mrwhAgRUw+0JdQp37QfJjAky03naAlYP7zUnminWOWRj
        4KTT/WGDmKhzsKhvOsIMTcqD5pLn+2jkcKPYGE2q867m51LnNv99LxPRPIUgfNENHV5UEaP7r4E6a
        C2INh8JuuIMDd3xx7sMBgUlVoHZlJlAovn9WSlhnmNg/snjxmYKSYnAE5GXIJ12r8pkkTsLBFaVKB
        35mBaEng==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7Uik-0000mz-TH; Mon, 17 Aug 2020 02:17:59 +0000
Subject: Re: Linux 5.9-rc1 (sparse? kernel/time/timekeeping.c)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>
References: <CAHk-=wiwfkKp93C+yLqKWAU0ChBdeBDUhgOk09_=UQ8gOKbV3w@mail.gmail.com>
 <83b35552-d1a2-e4ce-9a41-2b5cf688ccf0@infradead.org>
 <20200817021518.q3petwc277m3uqxz@ltop.local>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b52f9b10-a5de-d33e-7c69-1a28cdf9b833@infradead.org>
Date:   Sun, 16 Aug 2020 19:17:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817021518.q3petwc277m3uqxz@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 7:15 PM, Luc Van Oostenryck wrote:
> On Sun, Aug 16, 2020 at 06:35:26PM -0700, Randy Dunlap wrote:
>>
>> on x86_64, allmodconfig:
>>
>> $ gcc --version
>> gcc (SUSE Linux) 7.5.0
>>
>> $ sparse --version
>> 0.6.2
>>
>>
>> I seem to be having some problems with kernel/time/timekeeping.c,
>> including a segfault.
>>
>> a. Is it sparse that segfaults?
> 
> It's most probably the one fixed in:
>   eb6779f6f621 ("generic: fix missing inlining of generic expression")
> 
> On the main tree there is a branch with a few fixes since the last release:
>   git://git.kernel.org/pub/scm/devel/sparse/sparse.git maint-v0.6.2
>  
>> b. what prints this message?
>> make[3]: *** Deleting file 'kernel/time/timekeeping.o'
> 
> It seems like a typical message from make when a command fails.
>  
>> c. I would prefer to be able to tell the source of warning/error messages,
>> i.e., gcc or sparse. Especially when they are intermixed.
> 
> You can use the option -fdiagnostic-prefix[=PREFIX] for this. It will
> just prefix all messages from from sparse with the given PREFIX or
> 'sparse: ' if none is given. You can pass this option via 'make CF=...'.
> 
> It may be a good idea to directly add it to CHECKFLAGS.
> 
> Best regards,
> -- Luc

Thank you, Luc.  I'll get the latest and also use PREFIX.


-- 
~Randy

