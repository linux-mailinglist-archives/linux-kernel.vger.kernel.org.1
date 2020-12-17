Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3282DCA8D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgLQBar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQBar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:30:47 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E195AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 17:30:06 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z136so25953589iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 17:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6dQwp+n3JOcX+nLXSXjNOHWl3D3cLU9xBCqYgREOWb4=;
        b=ZX4EJ9/Ocdmd7IhRX8jQhFjf4hMjSTgDjilQnqsmpoL5ZCjlyMETnIPYGCPnXiwIRb
         s5VqKC6wxrGqjF1GCxt3JXOr7nraDXdOwD0OcslGBbELo8wseFfXvzzRDIKLgSJnjh9A
         NLole1g3xWlD7ufoyVvZvnzzv8kKPDVTLJOpADdT9m3NTzUlKX5lcyutlFFDB37/GZ83
         vudjC/fPf5pEo/tspUAIcB4nJ3uTYgjVswkiS30xDBDBhDPOCTLSolFVrJQ3ejZYbU2e
         h50z5l3GzomgjwVBOvrX/Gkcny7wDysKiIbNvmSqZdRWzp0eixWr+Dfouo5qGvTHW4kt
         kAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6dQwp+n3JOcX+nLXSXjNOHWl3D3cLU9xBCqYgREOWb4=;
        b=CgPNJ5Zpb2Nj/ixOMAo4ZB43md7yjY7I5dCVrf1o605SbxxmZfQqYYcbxhwn1rdPst
         ZvpWSWv3oGbUBgtrXD4olFvl5eFaxcdXe2A8JyNSOXwOw2SEoctVF1ikKP7Z7eeq4OQS
         kuJOA8lZ8STqHZ3kxXx16+pHrzozoNvH9Xjg9zfTZHAdmXSkS74cdhMRvix/5vHvriqF
         btLH9RsxAx0jxFkv+MIFec0B24lqxsMqxGJkRjl6RZNgS+No8sjvzBFT2pH2a9e189dX
         u8v++t1XRnB0s/6K+D2I53ywvBY+eg7FgAhuUKqnP7kSMAJBdrggqgmGU0t2SiLVZzXM
         bC7g==
X-Gm-Message-State: AOAM533GP0vChtCh4PdQkrNUpXhUZ63kn5NQfOTVoErTAESX02zuRlvN
        ETudJ27cxaT9C/45QVjMUl/4Ck8z2WW29fVyX6brszGVhd4oBQ==
X-Google-Smtp-Source: ABdhPJzVQzWUzfc0Rf4lX2ekHkcnePakR+RhiUkaJKWqtO6OXiI4idpxjZJSs+SNc93Bcn5nmLizaVIGCPugRqioAZo=
X-Received: by 2002:a5e:d70e:: with SMTP id v14mr44715814iom.75.1608168606099;
 Wed, 16 Dec 2020 17:30:06 -0800 (PST)
MIME-Version: 1.0
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Wed, 16 Dec 2020 20:29:30 -0500
Message-ID: <CABV8kRwoHAAdez8k60O+AJ9E3g5_PM0F6tpbpB9dC115_FD3Eg@mail.gmail.com>
Subject: brk checks in PR_SET_MM code
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     gorcunov@openvz.org, Andrew Morton <akpm@linux-foundation.org>,
        mkoutny@suse.com, ktkhai@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The code in prctl(PR_SET_MM, ...) performs a number of sanity checks,
among them

```
/*
 * @brk should be after @end_data in traditional maps.
 */
if (prctl_map->start_brk <= prctl_map->end_data ||
    prctl_map->brk <= prctl_map->end_data)
goto out;
```

The original commit that introduces this check
(f606b77f1a9e362451aca8f81d8f36a3a112139e) says:

```
4) As in regular Elf loading procedure we require that @start_brk and
   @brk be greater than @end_data.
```

However, it does not appear that this invariant is actually
enforced during regular ELF loading. In particular, at least on my
linux distribution, it does not appear to be satisfied when
invoking the dynamic linker directly.
For example, consider the following test application:

```
#include <sys/prctl.h>
#include <unistd.h>
#include <assert.h>

int main(void) {
    int err = prctl(PR_SET_MM, PR_SET_MM_BRK, sbrk(0), 0, 0);
    assert(err == 0);
    return 0;
}
```
```
$ su
# ./a.out
# /lib64/ld-linux-x86-64.so.2 ./a.out
a.out: test.c:7: main: Assertion `err == 0' failed.
Aborted
```

I don't understand this code well enough to know what the
intended behavior is, but unfortunately this causes some
processes to be non-restorable using the PR_SET_MM
mechanism, which defeats the whole purpose of that API.
Could somebody clarify whether this situation is indeed
supposed to be impossible and if not whether said checks
in PR_SET_MM are actually supposed to be there?
I suppose this is also technically a regression when the
old PR_SET_MM commands were refactored to use this
new validation. Previously only the commands that changed
the brk validated this invariant, but these days it tries
to validate the entire structure at once, so all the PR_SET_MM
calls will fail in a process whose layout violates the sanity
check.

Thanks,
Keno
