Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88401302CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbhAYUli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732275AbhAYUlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:41:15 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D72C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:40:34 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id g13so4883056uaw.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xse+NZ32YaEhEnQrOuzogTMX54wkPpLl67Kc1k3a2Wc=;
        b=dBcFDGO3VqYDkBnAvIrI3b93EK5ovoKlwwkmbQHXQ88XM4hYFDw2Kr56UVAJX3Sslb
         p7JFad2Y+fQ5+fEjFqqN+RI/NB8tVXj4AcG9UxpsKvceY0M7xdEmOkM7QyXYn9jhEQc8
         CjMgfvxl6QgHR1IqWOWbDSlEzMnK9IUsXKuObMEfG35OIZxiuDnMYER3K4cXEC+qBgK3
         h5rIqaseaTygDVMsjwFdUcdfI/F+SU8HIeRHyW96Q70Ph4O1c33dE5oT1kVJVEbEK6HV
         rhGkTl+oMx6Eyt+cmH0/UnUKJmE2donhmI8ppnJeuMlEp2hhOLPKunvlUkhxINx88ST0
         mCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xse+NZ32YaEhEnQrOuzogTMX54wkPpLl67Kc1k3a2Wc=;
        b=b/icBQak1sM2rtIHgjFp/iBnELSS9OZTOIv/IGiEe1OcPtVyNs9KrE106HTefugwQB
         BnTOTkHxqmHirQ0fEQgnChRbdeJmoi/zhCp9VaNd53pJGscxgbu+7PkOxYJirtuweLfQ
         uV/MGVgMnysGv7LhryOu1XwoLkk74ocxEjmlRCwYUzkZuGYGymIqz0sAzyU3vvkV7pxi
         13iD1kzACExOHkXne0YqaFdqQ9Z4Sse6ZJTHVcTDyeag+SkpKyM234tDgC71g3R36/AS
         g0mJ/vv+Sh6NaIXZ2QbEa0ZfZNDUuBu69rKZy7fYTJndv/UUkiLl99oi6Gb71Cd6kKbK
         lOBA==
X-Gm-Message-State: AOAM531Q1b7eI3UBsnDSAILn1kONkq4sbF12Dqch1HPln+kCJ6WEJ6FH
        NFoZyR5910ejwzNd7djBoytrXZzXY3klHeU58bggtGJZpXhzsA==
X-Google-Smtp-Source: ABdhPJw9rNVI0EK7MuC0JDDg6P914QfFFzK4+VuLeahLbU0Bll7xtRA5VwvDsE2mUR5ETK/rvk/cYqSVOU6FmyeM0kY=
X-Received: by 2002:a9f:2286:: with SMTP id 6mr2051559uan.66.1611607233640;
 Mon, 25 Jan 2021 12:40:33 -0800 (PST)
MIME-Version: 1.0
References: <20210125190925.3655829-1-samitolvanen@google.com>
 <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
 <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com>
 <CABCJKucWV3V10KRiHN+Oph-nffrBmo6Sc6+jAKJasQ8wFekRJw@mail.gmail.com> <CAHk-=wiScU+tS8ZSL2-gpuKB5Z-XKLOGkF8WW=bL-8t_KSqxFg@mail.gmail.com>
In-Reply-To: <CAHk-=wiScU+tS8ZSL2-gpuKB5Z-XKLOGkF8WW=bL-8t_KSqxFg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 25 Jan 2021 12:40:22 -0800
Message-ID: <CABCJKucu1_Z1K7iFvo0_pratvVrG6SBDRnJuYZh-hVTYtukvFw@mail.gmail.com>
Subject: Re: [PATCH] n_tty: fix redirected_tty_write checks after write_iter conversion
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Jan 25, 2021 at 12:03 PM Sami Tolvanen <samitolvanen@google.com> =
wrote:
> >
> > Neither, I noticed this because the conflicting function declarations
> > broke Clang's Control Flow Integrity checking.
>
> Ahh, interesting. Is that automated somewhere, or are you running your
> own special checks? It sounds like a useful thing.

I=E2=80=99m running a continuous integration script locally, which tests a =
few
basic kernel configurations with CFI to ensure they compile and boot.
We=E2=80=99re using CFI in Android kernels, so this helps catch issues befo=
re
they reach stable kernels.

> I was thinking that maybe I should make some sparse-based cross-file
> checker, but it sounds like -fsanitize=3Dcfi (or whatever it is you do)
> catches it.

That might still be useful, because CFI only adds runtime checking.
It=E2=80=99s primarily a mitigation against code reuse attacks, but it does
find these types of issues occasionally.

Sami
