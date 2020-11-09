Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B5F2AB409
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgKIJxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:53:44 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95175C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 01:53:44 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id n142so7630354ybf.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 01:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhnmelEoKg7v8GwmZUSzzOCG7t2GTTQBk/QkznsOk3s=;
        b=ubFlDbuTR7Vk81ZmeLZX/vBI+YdTquk8SYHVG+OY8vPOVGLsMWLv+AC+Sov+xFb3OS
         a2U1urW6VqNH5x9K592T2zkx4ZhULKOfysz7wyZybTMsD4NI8xIJrRt7xB98H4GgIm9W
         xhhK3F6o4PxjkBGdWMpbFN0aGZOy6k51OnVbeBr0YCKuy4wO4WmtaDfJvT/BeWifUH+l
         wff3VBSeRwi5c6VnUnybkIUtDY5/itwHlMYgklK4AKuNRXyj2xY7h8CY9hQx9z93A2a+
         g6RVyU5x0zveQ0F20Xs29449WWYfQMBx0ZVRuTmg2OICG3EzOdonP8V1enLAemrIDwJr
         Bsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhnmelEoKg7v8GwmZUSzzOCG7t2GTTQBk/QkznsOk3s=;
        b=QgkfH4mXWhlZuHFaepXJDrcsXHyRXpR83Xk0xIuJTvh+7EhmLGyPxTsssLhNyChiVA
         pgOUe1kNQzXNp01TyFlSO6IQ8ge4myYMrvPqrhQflrmAHnxJ78/qNO1uHjIian5Si3i1
         sGcROtDZzSCo5MHUyJW22BTJhL+H1yUNoyEYTcOMF/I0w/l3i15CBLP8qwypDoKQ3I1V
         e8vTMx6C7G6jp2NO0itVEdPEn+VzOMg5ILZtPaXD/1TG9avraxMsRqq5qkK9+1C7PBK3
         FNp/KmOqYDcpKcRQUP4WCFvANZV7geQb73QdPQLZbpe35id0QRsIa3d0yfgqJ2N9ss4p
         tT0w==
X-Gm-Message-State: AOAM532LFVrJJSzUD7totGxbfFCD7r5qgIX8Zhc5CtUfi0MCKBXIGqpo
        9G12OSow+fgFulBf35panRcF0EjvO91pqzGV5QsqnQDT
X-Google-Smtp-Source: ABdhPJwCg/Ag0PL8RlKz4sDSLXrhsVnm284LPJU2wirGri76drVdYCwaPRMOe/MFCDvgOLg4KZsEeLzWqvGdJL51AUA=
X-Received: by 2002:a25:384c:: with SMTP id f73mr17017482yba.135.1604915622705;
 Mon, 09 Nov 2020 01:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20201103095828.515831-1-poeschel@lemonage.de> <CANiq72mDG8YJLcpKuE+noUQY5B9K6Cc71ado_dyLFVVf_xzKwA@mail.gmail.com>
 <20201106101135.xesjdqg2z3hgpqnv@lem-wkst-02.lemonage> <CANiq72niN_gB7Nq_+Vnf9CrBhFZF0_cew-kdj=rAURJ0DWJxnQ@mail.gmail.com>
 <76f9cd1b-3ace-e8a8-aaee-8d64e0900603@infradead.org>
In-Reply-To: <76f9cd1b-3ace-e8a8-aaee-8d64e0900603@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Nov 2020 10:53:31 +0100
Message-ID: <CANiq72nrXMoab=c0KvcA6fgn=sRuVsR6Kgx6iCW=XEFx=gnkVw@mail.gmail.com>
Subject: Re: [PATCH v6 00/25] Make charlcd device independent
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, Nov 6, 2020 at 5:35 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I'm not sure that I understand the question...
>
> Include
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> if possible. If not, then don't. It's not a big deal.
>
> Integrate the fix from Lars in whatever way works for you.

Thanks Randy -- I asked Stephen Rothwell and he told me even for -next
patches on top are preferred, unless the bug is bad enough. In which
case, the [] notation can still be used to give credit.

Cheers,
Miguel
