Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8A2EA6D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbhAEJAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbhAEJAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:00:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC98C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:00:00 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m12so70865017lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxfXiWmXKjcXG7MiAZTrs2FCKGpxYiIgWMEbJGIs1oU=;
        b=bkywPztvzYitrJ+9cLUSF5xNfyzCrl3laky8babFYbiP9F302vAG2D4vJKb8Bu+ATk
         gw6O3vh2xmZDi1tttnT9qlzaIMRNlK99yS0y3Zgd9eM9YDx4htSuHYeFHOFTtxR915BU
         V1IqJ39uzNdPKE+7lWDtGZ1iGnoPXMt8u8MG970iuB71aSjr6WoF1ms5RifpA7714SrT
         Y/ARlYkS0+IRLxG4j1NvKGMzGLa08pEjBeA90fMJ9szWSOR4LussPSo7H1D2cZNlgx/E
         0aL/f8zmdD1dXNnaHcJkMeFREne/qB0K23FxKfzUx7by7WPpg/Tio/Kuv2bsZG9I/Y3c
         cQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxfXiWmXKjcXG7MiAZTrs2FCKGpxYiIgWMEbJGIs1oU=;
        b=OjWaa7lMN2MCVgb8MAAkbRnTmNsfWjyvZ4QW31UX2Qxxo0NPo+LzKHuAVTSrGIsgXr
         oR2y9rIPIUUjhsLmlEA3TaYsiIn8UCM9jTENjbYtHAyg2TdtF8RWw9tC+yvArl4iHsXN
         h8BvjmvW6OeLVzo9a5Ca0guVp/zaEL8/UayDb5rCwacNdm8tN6yBePAax8FVMdyly4D3
         JUMMQcP54BF5vF2zeuVycu3gxHgVRG/T3kd5xkanGWywnZwiWjjKcYWseTHZB8819/xx
         U9qlBiyDiSaBEvwMocIa9z15filAjQkIBeeQ2j7BEjEFzyJ11FwGEB8/rliug8umHBPs
         BXBw==
X-Gm-Message-State: AOAM530wdR3vcQArfWnJqLYRpDMKH0XJC2YANVO+8FFeezrdrTzMCfOC
        K32Z1AqnQJ9zxGDGYcQREgiRXC2KoO66KUb7j2M=
X-Google-Smtp-Source: ABdhPJzQxOLGksuAu1JGN5vDpr0EChMuotkNvYE/OJIEEJCLnVrn9F31pKW5KwltZMWoPZfDXWljJYSsh88h4gErtgg=
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr32214831lfp.117.1609837199235;
 Tue, 05 Jan 2021 00:59:59 -0800 (PST)
MIME-Version: 1.0
References: <20210105082303.15310-1-dwaipayanray1@gmail.com> <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
In-Reply-To: <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Tue, 5 Jan 2021 14:29:46 +0530
Message-ID: <CABJPP5DQ0Y42z9ej_j06+KaQevT3ztWcwGMkismj4qv5EHvnxA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add a new check for strcpy/strlcpy uses
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 2:14 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2021-01-05 at 13:53 +0530, Dwaipayan Ray wrote:
> > strcpy() performs no bounds checking on the destination buffer.
> > This could result in linear overflows beyond the end of the buffer.
> >
> > strlcpy() reads the entire source buffer first. This read
> > may exceed the destination size limit. This can be both inefficient
> > and lead to linear read overflows.
> >
> > The safe replacement to both of these is to use strscpy() instead.
> > Add a new checkpatch warning which alerts the user on finding usage of
> > strcpy() or strlcpy().
>
> I do not believe that strscpy is preferred over strcpy.
>
> When the size of the output buffer is known to be larger
> than the input, strcpy is faster.
>
> There are about 2k uses of strcpy.
> Is there a use where strcpy use actually matters?
> I don't know offhand...
>
> But I believe compilers do not optimize away the uses of strscpy
> to a simple memcpy like they do for strcpy with a const from
>
>         strcpy(foo, "bar");
>

Yes the optimization here definitely helps. So in case the programmer
knows that the destination buffer is always larger, then strcpy() should be
preferred? I think the documentation might have been too strict about
strcpy() uses here:

Documentation/process/deprecated.rst:
"strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading to
all kinds of misbehaviors. While `CONFIG_FORTIFY_SOURCE=y` and various
compiler flags help reduce the risk of using this function, there is
no good reason to add new uses of this function. The safe replacement
is strscpy(),..."


> And lastly there is a existing strlcpy test in checkpatch.
>
> commit 5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")
>
I will drop this patch. Thanks for your view.

Thank you,
Dwaipayan.
