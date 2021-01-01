Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE38D2E8598
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 21:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAAUnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 15:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbhAAUnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 15:43:13 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC3C061573;
        Fri,  1 Jan 2021 12:42:33 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id x2so20290872ybt.11;
        Fri, 01 Jan 2021 12:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rONuYMnxPvmop9iDMOO+viRpaWkuUd6c67qG1oEdArc=;
        b=NYVo5gkfExNgfI6X++LgshnTbmcN5N1v9f9tz1IcnMiFNR8eQHsbLzSGdnwuiGIZW/
         7ojuVoVhFKAqmr2I3aDe7H/BS+Fl7zHEZggpo1nxBUTRRurFYZdDAcDIuGkWAjNBr6io
         LqhNZtp4uAgqz/4beh7VyTmNA4X6P9ZLiZaX8/C5wMETOjOwH9AT1VVK22vHMwCJuhsi
         nCGzrvLED/EbEMKe+m1Eh99Oag7wvyKRf6HRzdD+Zs+rvYWz287aE3f2lHwA1z+cpeEZ
         G9oVmrLdfxOfNTXch24fKjvtcLjsc+VchC6kepNT16P5KhSnPe+A0fWvbUvZzIVTOVYm
         ywnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rONuYMnxPvmop9iDMOO+viRpaWkuUd6c67qG1oEdArc=;
        b=i29LiV0yKvRiirRxc/URH/sW/pNwHLfn99MlzxoCex2mDx3/7ZXjULvLXH+JR0Vr7D
         Mp8dHhXVfCrF5FCmy07lKxemv72717FQowkNoKSfFW2CGn738lXATuVBbgaBF99F65LZ
         Z/dNn7dWPesLRsUVDNVA8hCYSEnq8+3Sb6jXd/3XDZ1SyfdS92RhpXa2PNFylh51BZta
         FvkJ098WwlgdEbIu9yQm8vGiNtwavao+Q0Fcy84vjg0HK+Io00V3F3WjWo+0IHfc1V8P
         jyavGvnE9RorlFti5Fx09Z7DK/x5sg9KduYfGqhzPo6S+mdTE9uYomm/fJHyNJC9xru0
         bgXg==
X-Gm-Message-State: AOAM531eI6rwktvbldHiGFnqBbPdY09r/gWLG/m9+BJfLC/3V+Tusg+X
        VaTB3ed7u9bM6f2SuXzcFBP+1a3946tquX/N+IU=
X-Google-Smtp-Source: ABdhPJz/kd138obaeY0KngKE5R0epQssHlPC805op1U7n0XUra7Shpfzo8ENsggv/3pspyypea3Wy6H5Mci43fxKTrw=
X-Received: by 2002:a5b:949:: with SMTP id x9mr92124869ybq.33.1609533752446;
 Fri, 01 Jan 2021 12:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20201212161831.GA28098@roeck-us.net> <20201222205402.2269377-1-ndesaulniers@google.com>
 <fe77cdc9-7ef1-a300-259b-65b451b2551a@physik.fu-berlin.de>
In-Reply-To: <fe77cdc9-7ef1-a300-259b-65b451b2551a@physik.fu-berlin.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 1 Jan 2021 21:42:21 +0100
Message-ID: <CANiq72nXe_BAyxb+VVf0CSCm749FLsQ5c6wCQQNc97ef_Z8YwA@mail.gmail.com>
Subject: Re: [PATCH] sh: check return code of request_irq
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Paul Mundt <lethal@linux-sh.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 1, 2021 at 2:50 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Verified on my SH-7785LCR board. Boots fine.
>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for testing, John!

I think Masahiro was concerned about the error case (I assume you
tested the happy path).

In any case, if no maintainer suggests something else, looks good to
me (and it is no worse than the status quo unless the `pr_err()` can
somehow kill it), so:

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
