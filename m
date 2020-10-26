Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195042992BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786329AbgJZQqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55454 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1780212AbgJZQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603730753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EtQ7ATZf42jwj5zA9pcp/oVxiJsLAJssQKkbBhG+zyg=;
        b=WhU8hFXq6r60r7p6nPa0werS3FQw2gn8ny1eL5ecfRnW2dV/Q35dyUgG5SLu4pMwg9yVza
        /TOtR2bzd6zTZWIzDJeExl50eDnFwiAbctyzZI7c4Z4vamjfOvdEjhmbj3HQ/WxB29+/YT
        rgQrCmbIhLPoLe3IX0N0bOrVEiSpJQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-N3pw_MRnMBKF2Of_PM6O7A-1; Mon, 26 Oct 2020 12:45:49 -0400
X-MC-Unique: N3pw_MRnMBKF2Of_PM6O7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC861879526;
        Mon, 26 Oct 2020 16:45:46 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 495D65C1BB;
        Mon, 26 Oct 2020 16:45:44 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Martin via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, toiwoton@gmail.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
        <20201026162410.GB27285@arm.com>
Date:   Mon, 26 Oct 2020 17:45:42 +0100
In-Reply-To: <20201026162410.GB27285@arm.com> (Dave Martin via Libc-alpha's
        message of "Mon, 26 Oct 2020 16:24:11 +0000")
Message-ID: <87r1pl9brd.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Martin via Libc-alpha:

> Would it now help to add something like:
>
> int mchangeprot(void *addr, size_t len, int old_flags, int new_flags)
> {
> 	int ret = -EINVAL;
> 	mmap_write_lock(current->mm);
> 	if (all vmas in [addr .. addr + len) have
> 			their mprotect flags set to old_flags) {
>
> 		ret = mprotect(addr, len, new_flags);
> 	}
> 	
> 	mmap_write_unlock(current->mm);
> 	return ret;
> }

I suggested something similar as well.  Ideally, the interface would
subsume pkey_mprotect, though, and have a separate flags argument from
the protection flags.  But then we run into argument list length limits.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

