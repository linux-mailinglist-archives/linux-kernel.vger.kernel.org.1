Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026DC2F7F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbhAOP1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbhAOP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:27:14 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618EDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 07:26:34 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id a1so4092455qvd.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 07:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXa0cKHLVR9Tqw/zGTSb/zrOKdjPP+sDBHyXkAcY+V4=;
        b=Z5dIwm1tiQpDlio11nv3Wu0JOvwrkHcZBdkcpoDOgzMx8p6oxmUUnO5hDlzZFdwMaK
         F7qEBx6v4zKIEsI6Ygg38RQVXdyiTP6kBqhVxWlW5NCy5Hs7j1FlEyOh9LF/RiTFkYEB
         i4o3a32NPakRQ9+Vf/axEnED/LC619QBNBprODGEKzLuC8vdAzge2tB3lhNRVAgxSTiA
         LUOTRuW695jFnjeEw7dyu5YjVb2Jw4Wlf0HTBWkcV5Hm0RL1g2ZHS9LT6GTp3a32z/F4
         wDfFGWe1IGcfg9n7znu3tPZho1WTHx/YD86hW8atWN7IKdMNknO/l9LV0iiAp1IXxGrY
         /tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXa0cKHLVR9Tqw/zGTSb/zrOKdjPP+sDBHyXkAcY+V4=;
        b=ukPBKpAiH7JoMmyTFuMkljTWtWwAlBW7BWfHb//ErHXt2yjD9e0mS2YT1s3hEcvvVl
         9vqb9HsKNT19PGPFqr6hqhSIfJ9lKmf3cXot6/MtYBEt1u2xjq1+SElnvm92/cCb6EkR
         5Bl+p72vD/5AgtIfO6KZRoK+nGJNTX9NM3yBkyskAuxTJxD3uWve0HfBZd5eQsMW6Szi
         DINLLXEQtBEewVl42Kbs49p8Njf8KoCY2sKyLuUdccVZ+x8Wep24fW/IavMaomHIIDMy
         BwD/iI2rV55fpJp4Equijab6MkEKhKffibmb1USwqixe8zbQBXzmR48+0Wb+P+TnebS/
         yxwA==
X-Gm-Message-State: AOAM533vXlZ6BDQYqRdbEwt0GEOJCBkPYoOSU3YaKMbxA/HB7JDhw4i6
        HIyECXraoUTKZkyirqMTWauqYq00/JdZ0AkHNutXkw==
X-Google-Smtp-Source: ABdhPJyQr7uo9F3Xok26dWWKni/afho7+kX9trhxSvQzAZ6gyv9nrPMpYXAemIyqSyINcFaCdWe9igDRtPA5KH4ZL6g=
X-Received: by 2002:ad4:47c4:: with SMTP id p4mr12699275qvw.23.1610724392534;
 Fri, 15 Jan 2021 07:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20210115130336.2520663-1-glider@google.com> <20210115130336.2520663-4-glider@google.com>
 <YAGckOeJxqCcHKa+@kroah.com>
In-Reply-To: <YAGckOeJxqCcHKa+@kroah.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 16:26:21 +0100
Message-ID: <CAG_fn=Xen6Nd9qJnW6F4r5vgj7WAUo40BHeN_FXKpJ2jrpT6-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] docs: ABI: add /sys/kernel/error_report/ documentation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> sysfs is "one value per file"
What about existing interfaces that even export binary blobs through
sysfs (e.g. /sys/firmware, /sys/boot_params)?
What qualifies as a "value" in that case?

> please put something like this in
> tracefs, as there is no such rules there.  Or debugfs, but please, not
> sysfs.
Does tracefs have anything similar to sysfs_notify() or any other way
to implement a poll() handler?
Our main goal is to let users wait on poll(), so that they don't have
to check the file for new contents every now and then. Is it possible
with tracefs or debugfs?

Also, for our goal debugfs isn't a particularly good fit, as Android
kernels do not enable debugfs.
Not sure about tracefs, they seem to have it, need to check.

Do you think it is viable to keep
/sys/kernel/error_report/report_count in sysfs and use it for
notifications, but move last_report somewhere else?
(I'd probably prefer procfs, but it could be tracefs as well, if you
find that better).
This way it will still be possible to easily notify userspace about
new reports, but the report itself won't have any atomicity
guarantees. Users will have to check the report count to ensure it
didn't change under their feet.

> Also, any reason you didn't cc: the sysfs maintainers?
Only my lack of common sense :)
I'll add them should the following patches rely on sysfs, thank you!

Alex




--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
