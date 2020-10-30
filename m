Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB5C2A0C01
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgJ3RBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgJ3RBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604077258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxfqukHcbkTD7X3ox1ou1pebvrWuXAmJeGcia/vnGj8=;
        b=RGlaks7H2PzhiDrlPNU+jCoXSUoP+nynqWq/5BIouPHMBsDWWacjV794PL29OrhO92t9ec
        LPvRmG9cqL/zFy7JX8Y0bNnPDWWySACHY5hi/kVJJZ5C9Y8c5fexivLZPYzmNtS1C1/tHT
        3PWX9SYZ1FsjU9b+EP1LzLNOkLSuGok=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-iqN5WoOGPL6FclNIrAkFGw-1; Fri, 30 Oct 2020 12:58:54 -0400
X-MC-Unique: iqN5WoOGPL6FclNIrAkFGw-1
Received: by mail-qt1-f198.google.com with SMTP id p2so4322897qtw.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 09:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gxfqukHcbkTD7X3ox1ou1pebvrWuXAmJeGcia/vnGj8=;
        b=tlPWyYr9c8nvaKbidzL0DPNMQzOZsO97eoAUXMNbtVEsYY/B8lYl7a1zUb0CuKkTYr
         pvx6fmOoTjbiKs9XtGiR58+MZ30i/GgeEU8nj4wML7OXdLsiPzB4Aw6e3Parx8A9ovBl
         Gk89Lo/yO8nP04cKH08ZDLKhKtm+fZSzbWjodmxl+fcATISj78sgtMqvUY8h++izp4HW
         OOqwhrjLClPDlUTTiR7bsro/dPLefusUgdm2kqZSXGCQZmzibPo31SDHKQYtJ9ew6WLy
         tVDAN5wwuizUdbWJ//uabxYEBQv6QLlqhpMshUzb86PNyVXtXegb9m31GWkCLmCys8/d
         qsPA==
X-Gm-Message-State: AOAM533kvY1cIPxyQnkbqi8QPWb+TL2NY3WRMggjPRXvz5F0Jo8PFT8C
        +ArYlIyV5pLNgp0RULp1PcvIQQOCf9r0zv9vgi1pKfcxAX3MASJpqYliJ8WM2pX79X6QCm+M61O
        U2BLxT5eGQ+dq/qsvu7Cf3x54
X-Received: by 2002:ad4:4841:: with SMTP id t1mr9144561qvy.34.1604077133292;
        Fri, 30 Oct 2020 09:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYy+y4KegMcHE38+ry6q9jqqq9aaJ0lz4oZAPJv96jST8zKUGewygF8ZOWBX+WQqa+NZzz+Q==
X-Received: by 2002:ad4:4841:: with SMTP id t1mr9144540qvy.34.1604077133087;
        Fri, 30 Oct 2020 09:58:53 -0700 (PDT)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id x5sm2896788qkf.44.2020.10.30.09.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 09:58:52 -0700 (PDT)
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan>
 <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
 <87sg9vn40t.fsf@nanos.tec.linutronix.de>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
Date:   Fri, 30 Oct 2020 12:58:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87sg9vn40t.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 11:10 AM, Thomas Gleixner via Libc-alpha wrote:
> On Fri, Oct 30 2020 at 10:02, Zack Weinberg wrote:
>> On Fri, Oct 30, 2020 at 9:57 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>>>> According to patch description [1] and time_namespaces documentation
>>>> [2] the CLOCK_REALTIME is not supported (for now?) to avoid complexity
>>>> and overhead in the kernel.
>> ...
>>>> To be more specific - [if this were supported] it would be possible to modify time after time_t
>>>> 32 bit overflow (i.e. Y2038 bug) on the process running Y2038
>>>> regression tests on the host system (64 bit one). By using Linux time
>>>> namespaces the system time will not be affected in any way.
>>>
>>> And what's exactly wrong with moving the system time forward for a
>>> duration of the test?
>>
>> Interference with other processes on the same computer?  Some of us
>> *do* like to run the glibc test suite on computers not entirely
>> devoted to glibc CI.
> 
> That's what virtual machines are for.

Certainly, that is always an option, just like real hardware.

However, every requirement we add to testing reduces the number of
times that developer will run the test on their system and potentially
catch a problem during development. Yes, CI helps, but "make check"
gives more coverage. More kernel variants tested in all downstream rpm
%check builds or developer systems. Just like kernel self tests help
today.

glibc uses namespaces in "make check" to increase the number of userspace
and kernel features we can test immediately and easily on developer
*or* distribution build systems.

So the natural extension is to further isolate the testing namespace
using the time namespace to test and verify y2038. If we can't use
namespaces then we'll have to move the tests out to the less
frequently run scripts we use for cross-target toolchain testing,
and so we'll see a 100x drop in coverage.

I expect that more requests for further time isolation will happen
given the utility of this in containers.

If we have to use qemu today then that's where we're at, but again
I expect our use case is representative of more than just glibc.

Does checkpointing work robustly when userspace APIS use 
CLOCK_REALTIME (directly or indirectly) in the container?

-- 
Cheers,
Carlos.

