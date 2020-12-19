Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF2A2DF06A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgLSQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 11:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52008 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgLSQVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 11:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608394795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KbugKKrasuGedAjovAH1wi9O5DNDUKogVJv7kX6aCak=;
        b=Sz/Q2MP+6Wk4r21MBRSwQZZZRuEv+EfWQJ51/Mcf9e5BVZ1mv7yVSkNeSnPNFXZMGNUTJi
        iJDYg9auqHvJGu7qjxLH/efwSpxm5wIm11LEDOJupKSHBh4yIYgRx8HO/UmGAv0QEN7hZ9
        MKcsxuQxPMeMitNLEKybyvjEVGOcBvE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-B3KnRHqLP5-lMp6DkKIMYw-1; Sat, 19 Dec 2020 11:19:52 -0500
X-MC-Unique: B3KnRHqLP5-lMp6DkKIMYw-1
Received: by mail-wr1-f70.google.com with SMTP id g16so3375606wrv.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Dec 2020 08:19:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KbugKKrasuGedAjovAH1wi9O5DNDUKogVJv7kX6aCak=;
        b=hONF3yoBLyjwoiEnvMGW1uKFxi9t9CR2WxCW70ZasitITJooqlvgrh0cm0X14WqS4T
         9fVqj4EWIUs79ifNMV2rem9urLCidP7lAo9qM4wXNDmzc8ul3RPEd8ayn7sY7tKw8Nfb
         Mpd+SSNDAXPeRUwJ386V8ZAs11Imdcn7Meg1+iY4Wls7+s2OKht4vcFaLhnAUFaer71P
         zO4kF0PYvjGFuJSBLJ+LBavIQ/QeAhILJ2tqzIPLG3XUXDQdkE8Pqb0wGyDNzKU42B8u
         5TO0qOSJY3BiE8YB58HbPWpl6WpBL540tHA8TVhTr8AIwFns/XQPcJum2nvT+RAqJ/FO
         XVDw==
X-Gm-Message-State: AOAM533XdWQ/UqqKeH+NGpA3CrIH+GZVESzxUhKggfHz1wJmwETBciph
        YCTR/2I1EHdL1k6PEvrn3uhi/3UkvgiMvlBUb1z4Z/gMqInBr2kAj8BR2i1ETkw38GYIqj8n7zA
        kv4esH9lYusFkEX32DD6bOzleF3LcTehSSTWYOHG5K7R/HytYNjxAv7GedUS9WZXqMR+KrwWxHg
        ==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr8853312wma.175.1608394790428;
        Sat, 19 Dec 2020 08:19:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDoFtPKJFk+dmEFPvt/bjm9gtgE66UYP/MfbL/0VfC6d5hJoBaYApgKBKCvWHod8b+k2m62A==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr8853293wma.175.1608394790222;
        Sat, 19 Dec 2020 08:19:50 -0800 (PST)
Received: from ?IPv6:2001:8a0:f91f:e900:1d90:d745:3c32:c159? ([2001:8a0:f91f:e900:1d90:d745:3c32:c159])
        by smtp.gmail.com with ESMTPSA id b73sm22150875wmb.0.2020.12.19.08.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 08:19:49 -0800 (PST)
Subject: Re: [RFC PATCH] ptrace: make ptrace() fail if the tracee changed its
 pid unexpectedly
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel@vger.kernel.org
References: <20201217142931.GA8865@redhat.com>
 <875z50roia.fsf@x220.int.ebiederm.org>
From:   Pedro Alves <palves@redhat.com>
Message-ID: <fc796624-2660-8c2b-0956-2c9ba8281952@redhat.com>
Date:   Sat, 19 Dec 2020 16:19:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <875z50roia.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/20 11:39 PM, Eric W. Biederman wrote:

>> resume the old leader L, it resumes the post-exec thread T which was
>> actually now stopped in PTHREAD_EVENT_EXEC. In this case the
>> PTHREAD_EVENT_EXEC event is lost, and the tracer can't know that the
>> tracee changed its pid.
> 
> The change seems sensible.  I don't expect this is common but it looks
> painful to deal with if it happens.

Yeah, the debug session becomes completely messed up, as the ptracer has no
idea the process is running a new image, breakpoints were wiped out, and
the post-exec process is resumed without the ptracer having had a chance
to install new breakpoints.  I don't see any way to deal with it without
kernel help.

> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> I am wondering if this should be expanded to all ptrace types for
> consistency.  Or maybe we should set a flag to make this happen for
> all ptrace events.
> 
> It just seems really odd to only worry about missing this event.
> I admit this a threaded PTRACE_EVENT_EXEC is the only event we are
> likely to miss but still.

It's more about the tid stealing than the event itself.  I mean,
we lose the event because the tid changes magically without warning.
An exec is the only scenario where this happens.

> 
> Do you by any chance have any debugger/strace test cases?
> 
> I would think that would be the way to test to see if this breaks
> anything.  I think I remember strace having a good test suite.

I ran the GDB testsuite against this, no regressions showed up.

BTW, the problem was discovered by Simon Marchi when he tried to write
a GDB testcase for a multi-threaded exec scenario:

 https://sourceware.org/bugzilla/show_bug.cgi?id=26754

I've went through GDB's code looking for potential issues with the change and whether
it would affect GDBs already in the wild.  Tricky corner cases abound, but I think
we're good.  Feel free to add my ack:

Acked-by: Pedro Alves <palves@redhat.com>

Thanks,
Pedro Alves

