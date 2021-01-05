Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9412EABBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbhAENSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbhAENSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:18:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 095ED2255F;
        Tue,  5 Jan 2021 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609852679;
        bh=L5vHanvorBgMxhq0DojAdOuvn1iR/NL4qzHRjPW9Rz0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B/lPjlRiB/OiiuDORF6tlLamB+abCzelpmqsPYdVNMBy/BhmrOfIB+37xbb5q3cu4
         P7LjsucH1m3yADaZokCX0U2YedpRH0selh3I0PilcGuXo/2jFoVf4+/Sz5gOrX3H7x
         h6kUMI1gaDUEl4yHvw1Lio4xYqYkiK3StVU3ytyJrUstKfa/pyyNm81sV6AL68xT7k
         5WUXZ76EyJoUX0CTSd5cO8CZ4eCqORnD8pOjaAZe+quzSOT936Vkgx7VzRuk7Q0p7J
         iUPQB8nSD74125Fmtm1fKCBZLXrJny08akKMx+bR6PCYd8ASPVcmxHU1vUrCps+E/J
         0dvAEaon6qIDg==
Received: by mail-oi1-f172.google.com with SMTP id q25so35927882oij.10;
        Tue, 05 Jan 2021 05:17:58 -0800 (PST)
X-Gm-Message-State: AOAM530HlQvCvJ6R2m4JntqafWCQwyk8Tm7Er80O4STwP8kwQB4Fik90
        leJfIH414SnEYr51NF+pHbUakLuCB+w6eLmV5wI=
X-Google-Smtp-Source: ABdhPJx+rCRx2J9DjkpBdhpIuUOPFKuhkgg+uls3dm0E7tLK6vQKddiiPx4bSJMfckXyViv8JSfbvJrScFJ3GGJSksY=
X-Received: by 2002:aca:fd91:: with SMTP id b139mr2427344oii.67.1609852678326;
 Tue, 05 Jan 2021 05:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20210104085806.4176886-1-arnd@kernel.org> <ad54481b-15da-e795-0c1a-bd54d3e8ab87@physik.fu-berlin.de>
 <CAK8P3a3zDB5wh-bdg+fq6nvg9gHrESFhhgss4f47VJ1JOvoE1Q@mail.gmail.com> <71274a7cdf7d48bf9c2fda873fa37727@intel.com>
In-Reply-To: <71274a7cdf7d48bf9c2fda873fa37727@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 14:17:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2KhaEZ-ErAXGi0wOr_z2YT-GUV7r5QMhUoV+e+tpc5zw@mail.gmail.com>
Message-ID: <CAK8P3a2KhaEZ-ErAXGi0wOr_z2YT-GUV7r5QMhUoV+e+tpc5zw@mail.gmail.com>
Subject: Re: [PATCH] ia64: fix xchg() warning
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 5:00 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > I have not received any reply from the ia64 maintainers, I assume they were
> > both out of office for Christmas.
>
> I'm back in the office ... but have no working ia64 machines, nor time to look at patches :-(
>
> Should drop me from the MAINTAINTERS file.

If you like, I can apply the patch below and take that through my
asm-generic tree along with the two bug fixes I sent:

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f2e55faaf7f..b74093803154 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8432,11 +8432,8 @@ F: drivers/i3c/
 F: include/linux/i3c/

 IA64 (Itanium) PLATFORM
-M: Tony Luck <tony.luck@intel.com>
-M: Fenghua Yu <fenghua.yu@intel.com>
 L: linux-ia64@vger.kernel.org
-S: Odd Fixes
-T: git git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
+S: Orphan
 F: Documentation/ia64/
 F: arch/ia64/

Is that what you had in mind? I see that Fenghua Yu has not been
actively involved for a long time. If you are both out, that would
make the port unmaintained, but that may actually help find someone
else to either volunteer as a maintainer or pay someone if they
have a commercial interest.

    Arnd
