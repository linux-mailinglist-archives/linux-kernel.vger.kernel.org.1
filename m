Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA772F9D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389282AbhARKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390056AbhARKXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:23:20 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0403EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:22:40 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id p5so7235734qvs.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E7b4WeOHgdYLNAFctjfJGeS6VNWY7pPBdbCgdjKDlQE=;
        b=BvQ146S7SGydtHihAba7WPhV8kde08dutF5V3Og4H1Hux8g8ukOdUgJM/tAB8hBYP5
         j/xHzYxgB7yeAJnSrPpZqIxdnX5v6jUtW1XzN+rrz42qYHBJdxc8f3aockmd2VbKXfvX
         iWtvFTHG8Q/fG0zElt3X2vzC31DMxoOH4+mUyI6ZiEQI8QcAvIXkxiLM/Pfsf5TCyCHc
         JedNhQM7phW6U0lug3Sv0kgcymER/CsfhACysE+EicDU5O7ITc9cRGx0pVCsfLUs/8DS
         0HrGko+Osm4qKpbcDUoiuGrsk6yCe2RcK/pTBUFi46G7r9D0GrjKwm5VUkDmTnfWo7+5
         LNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E7b4WeOHgdYLNAFctjfJGeS6VNWY7pPBdbCgdjKDlQE=;
        b=CCp+uyvTeJQfXEjzIsHZymiJlQsNMLjgiw+tVpbg6mhEWLa5W0ARZgsxQiqQ8Mh1XP
         FFUvCfB5uQDZQbYbtF8I5QuLwjK+xRloRJzGjlX+tR0N5IYRZE3pEHTXftQkl2xKXpPQ
         nlE5OX4EZfj9iCz4xWTfMsA7WslbPLzv2x9his1PH8IYb18LQKgVkji0Tx0jGZz/vmXt
         uwaP4eKGYzXo3atwRkxhZ84T6OdUoIy/bcyKGiw9a872cz5XcQAv3Oj4NYdevbeMX4Bz
         9bGdR9RG7on8ztC1kC+hLqUnWdMJhVHUl7AjS9IOIl8yr+KtuVM452qhGnzh7wSnoy65
         4t9Q==
X-Gm-Message-State: AOAM530fy4+wR+X1IUtpCy1niJbSJqSkZS5xCNEr5IrM1dTunWT86GtX
        XnSvLGW240LhgnbQvg1bWTeUs2nxSFBMceeaUEIO9g==
X-Google-Smtp-Source: ABdhPJzP4uRKQpGNsBPbV5cTd6x4Rw3Er5hnqwT7R5LyA1UDx04O9mEoFfnYa6c84TKooghfAteR2xPpcxJCqHA1TiY=
X-Received: by 2002:a0c:e90a:: with SMTP id a10mr23809113qvo.38.1610965359033;
 Mon, 18 Jan 2021 02:22:39 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <20210115130336.2520663-4-glider@google.com>
 <YAGckOeJxqCcHKa+@kroah.com> <CAG_fn=Xen6Nd9qJnW6F4r5vgj7WAUo40BHeN_FXKpJ2jrpT6-g@mail.gmail.com>
 <20210115115239.1f3693ac@gandalf.local.home>
In-Reply-To: <20210115115239.1f3693ac@gandalf.local.home>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jan 2021 11:22:27 +0100
Message-ID: <CAG_fn=UnMhW4y6y5Tef9xnbB2S8gKozY7SXyk9STFh53rPfW-Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] docs: ABI: add /sys/kernel/error_report/ documentation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If you do use tracefs, add it to the top level tracing directory (no need
> to have instances of it), and rename it to "kernel_warnings", as
> "error_report" is too close to the existing "error_log" which holds error
> messages of syntactic errors done by users entering in commands to some o=
f
> the special files.

Will do. Is it conventional to add a new dentry* to struct trace_array for =
that?
If not, maybe it's better to create this dir in
error_report_notify_setup(), like this is done e.g. for
/sys/kernel/tracing/trace_stat - just to loosen the coupling?

> That is, /sys/kernel/tracing/kernel_warnings/ would be your error_report/
> directory you have now.

WDYT about "kernel_errors" or "kernel_error_reports"?
"warnings" suggest we'll be notifying about any occurrence of WARN(),
which is not what we are planning to do.
Also, shall I rename the library/config/etc. accordingly (to e.g.
CONFIG_KERNEL_WARN_NOTIFY)?

> Use the function in kernel/trace/trace.c: tracer_init_tracefs() to add th=
at
> directory. That's for files in the tracefs directory that will not be
> duplicated by instances.
>
> -- Steve



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
