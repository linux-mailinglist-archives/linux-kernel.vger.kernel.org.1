Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B55295CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896491AbgJVK1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21212 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896445AbgJVK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603362429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPIkebfSmahJxqWSXFZBWrl5c9NLCKt65PwRaZq/71M=;
        b=fkMmMsstK8OkxW7/0aVIaVae69+8pExz6T438VpqOuBsopPuoAXOHcbx+5b0eSlxNyWvIG
        nsNZE9FlrE4DGJ1pGCrhznfDS7DzmPvEW2C1kYxj1x8lQ685c+RMSA5qA8BHlPphotF1+d
        wpGjDYxCCY0k4ROQ0ZreMl6UYxLyw/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-6JlkKx4cMjmKDzYGgBVEKA-1; Thu, 22 Oct 2020 06:27:07 -0400
X-MC-Unique: 6JlkKx4cMjmKDzYGgBVEKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04DB0107AFB7;
        Thu, 22 Oct 2020 10:27:05 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-100.ams2.redhat.com [10.36.112.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20B315D9D5;
        Thu, 22 Oct 2020 10:27:01 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
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
        <87sga6snjn.fsf@oldenburg2.str.redhat.com>
        <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
        <20201022082912.GQ3819@arm.com> <20201022083823.GA324825@gardel-login>
        <20201022093104.GB1229@gaia>
        <4e82e730-4e71-35fe-e46e-f032766dedeb@gmail.com>
Date:   Thu, 22 Oct 2020 12:27:00 +0200
In-Reply-To: <4e82e730-4e71-35fe-e46e-f032766dedeb@gmail.com> (Topi
        Miettinen's message of "Thu, 22 Oct 2020 13:12:09 +0300")
Message-ID: <875z72r1xn.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Topi Miettinen:

> Allowing mprotect(PROT_EXEC|PROT_BTI) would mean that all you need to
> circumvent MDWX is to add PROT_BTI flag. I'd suggest getting the flags 
> right at mmap() time or failing that, reverting the PROT_BTI for
> legacy programs later.
>
> Could the kernel tell the loader of the BTI situation with auxiliary
> vectors? Then it would be easy for the loader to always use the best 
> mmap() flags without ever needing to mprotect().

I think what we want is a mprotect2 call with a flags argument (separate
from protection flags) that tells the kernel that the request *removes*
protection flags and should fail otherwise.  seccomp could easily filter
that then.

But like the other proposals, the migration story isn't great.  You
would need kernel and seccomp/systemd etc. updates before glibc starts
working, even if glibc has a fallback from mprotect2 to mprotect
(because the latter would be blocked).

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

