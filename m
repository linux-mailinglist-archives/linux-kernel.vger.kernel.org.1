Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B49295A37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407888AbgJVIZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725980AbgJVIZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603355133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SnmBgwDYPdid0KKn11DGxkxXghl8eOjBqUMsY5IBsf0=;
        b=VRpV6lMzL4uZ9hGHaFURQCQMzj9vP4DvSGyw4bxHH4ABnO7//Jhv6GIoR59ILgHWFsMd+h
        TZHW+dBFEivxHkUX3Md/mwK/wTbfS705w9u2a6d/Y5v9yJcCi29r2+nNo4d77llBRi9StO
        Cf+Waxt+jXVTntfR/OWFX/qPPmsYHv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-XEJpBZlwP4WaXlKWW9MDSA-1; Thu, 22 Oct 2020 04:25:28 -0400
X-MC-Unique: XEJpBZlwP4WaXlKWW9MDSA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB711107ACF5;
        Thu, 22 Oct 2020 08:25:26 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-100.ams2.redhat.com [10.36.112.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE4535C1C7;
        Thu, 22 Oct 2020 08:25:23 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
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
        <87sga6snjn.fsf@oldenburg2.str.redhat.com>
        <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
Date:   Thu, 22 Oct 2020 10:25:22 +0200
In-Reply-To: <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com> (Topi
        Miettinen's message of "Thu, 22 Oct 2020 11:17:19 +0300")
Message-ID: <87d01asm4t.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Topi Miettinen:

>> The dynamic loader has to process the LOAD segments to get to the ELF
>> note that says to enable BTI.  Maybe we could do a first pass and
>> load only the segments that cover notes.  But that requires lots of
>> changes to generic code in the loader.
>
> What if the loader always enabled BTI for PROT_EXEC pages, but then
> when discovering that this was a mistake, mprotect() the pages without
> BTI?

Is that architecturally supported?  How costly is the mprotect change if
the pages have not been faulted in yet?

> Then both BTI and MDWX would work and the penalty of not getting
> MDWX would fall to non-BTI programs. What's the expected proportion of
> BTI enabled code vs. disabled in the future, is it perhaps expected
> that a distro would enable the flag globally so eventually only a few
> legacy programs might be unprotected?

Eventually, I expect that mainstream distributions build everything for
BTI, so yes, the PROT_BTI removal would only be needed for legacy
programs.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

