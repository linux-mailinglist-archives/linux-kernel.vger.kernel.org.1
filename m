Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B923A2A607C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 10:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgKDJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 04:29:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbgKDJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 04:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604482180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNIUH/NWHkFHY64VfaawTYBDidvMrnoULy11KAx4HxE=;
        b=Hm0dasHDJho2bdaEvbHeeA4fvJqotcGLTfhaz5pda27RyAM9jSl5mqDxmiTBOKTXv/xIek
        ih+3ptMrScXvhERZAnD66JwxJOqBjfi9GPgtypKYh39lHoDK3n7oDY7osOx7uh19vZwrh8
        lOG0b7cWm6PGUkuV5JV3sZ8rKs5r8RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-SFfYKSFfNCypDyaQQ8tYwQ-1; Wed, 04 Nov 2020 04:29:37 -0500
X-MC-Unique: SFfYKSFfNCypDyaQQ8tYwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 465421009E2F;
        Wed,  4 Nov 2020 09:29:35 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-12.ams2.redhat.com [10.36.113.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D02D65D9CC;
        Wed,  4 Nov 2020 09:29:31 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
        <20201103173438.GD5545@sirena.org.uk>
        <20201104092012.GA6439@willie-the-truck>
Date:   Wed, 04 Nov 2020 10:29:29 +0100
In-Reply-To: <20201104092012.GA6439@willie-the-truck> (Will Deacon's message
        of "Wed, 4 Nov 2020 09:20:12 +0000")
Message-ID: <87h7q54ghy.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Will Deacon:

> Is there real value in this seccomp filter if it only looks at mprotect(),
> or was it just implemented because it's easy to do and sounds like a good
> idea?

It seems bogus to me.  Everyone will just create alias mappings instead,
just like they did for the similar SELinux feature.  See =E2=80=9CExample c=
ode
to avoid execmem violations=E2=80=9D in:

  <https://www.akkadia.org/drepper/selinux-mem.html>

As you can see, this reference implementation creates a PROT_WRITE
mapping aliased to a PROT_EXEC mapping, so it actually reduces security
compared to something that generates the code in an anonymous mapping
and calls mprotect to make it executable.

Furthermore, it requires unusual cache flushing code on some AArch64
implementations (a requirement that is not shared by any Linux other
architecture to which libffi has been ported), resulting in
hard-to-track-down real-world bugs.

Thanks,
Florian
--=20
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'N=
eill

