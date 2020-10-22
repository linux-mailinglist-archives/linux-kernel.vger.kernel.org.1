Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCB72959B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509052AbgJVHzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440530AbgJVHzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603353305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dB+TM53F+j8wSOxNsUY6W0vGPFUWPodpwEVY3R8KKXE=;
        b=gBwKfHc0sHLXLKEeYOj52LcQWdfCbIsVfkSCQxW2daPSeeEZuG4NtIRfoE4IUTDEENmwE1
        fcOqtPThKUvcb5HICGu1TguK/cUbOh4tuExbzP7ng2N6KbHDXRmnyq4RKK7E13tUFJsnt3
        bd2NiPTfjB50oGpWVBfYOipuaaZEFiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-r9hdCvaaN9-l1Ial5DNDIw-1; Thu, 22 Oct 2020 03:54:58 -0400
X-MC-Unique: r9hdCvaaN9-l1Ial5DNDIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E65918BE160;
        Thu, 22 Oct 2020 07:54:57 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-100.ams2.redhat.com [10.36.112.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 645216EF61;
        Thu, 22 Oct 2020 07:54:54 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
        <20201022071812.GA324655@gardel-login>
Date:   Thu, 22 Oct 2020 09:54:52 +0200
In-Reply-To: <20201022071812.GA324655@gardel-login> (Lennart Poettering's
        message of "Thu, 22 Oct 2020 09:18:12 +0200")
Message-ID: <87sga6snjn.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lennart Poettering:

> On Mi, 21.10.20 22:44, Jeremy Linton (jeremy.linton@arm.com) wrote:
>
>> Hi,
>>
>> There is a problem with glibc+systemd on BTI enabled systems. Systemd
>> has a service flag "MemoryDenyWriteExecute" which uses seccomp to deny
>> PROT_EXEC changes. Glibc enables BTI only on segments which are marked as
>> being BTI compatible by calling mprotect PROT_EXEC|PROT_BTI. That call is
>> caught by the seccomp filter, resulting in service failures.
>>
>> So, at the moment one has to pick either denying PROT_EXEC changes, or BTI.
>> This is obviously not desirable.
>>
>> Various changes have been suggested, replacing the mprotect with mmap calls
>> having PROT_BTI set on the original mapping, re-mmapping the segments,
>> implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
>> and various modification to seccomp to allow particular mprotect cases to
>> bypass the filters. In each case there seems to be an undesirable attribute
>> to the solution.
>>
>> So, whats the best solution?
>
> Did you see Topi's comments on the systemd issue?
>
> https://github.com/systemd/systemd/issues/17368#issuecomment-710485532
>
> I think I agree with this: it's a bit weird to alter the bits after
> the fact. Can't glibc set up everything right from the begining? That
> would keep both concepts working.

The dynamic loader has to process the LOAD segments to get to the ELF
note that says to enable BTI.  Maybe we could do a first pass and load
only the segments that cover notes.  But that requires lots of changes
to generic code in the loader.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

