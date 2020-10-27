Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC9129C921
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372187AbgJ0TlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:41:12 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44735 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408959AbgJ0TlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:41:12 -0400
Received: by mail-lf1-f65.google.com with SMTP id b1so3827233lfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQSBsKAoxAPc9BflYGP/pyyeNxQ7aw5FNmEKlmZscts=;
        b=MolhiKPyDtbqQKOC8QyzkdXBKBofzOGVG9CxfW55dTFgVcnq9X/BNDhY1ef43Izev0
         mt4N/FmaslYvGyD9Rcczc4nNfEaq1igv77eYUtR6zQZIS+Dnmtc7jeFdOe2q6po96qIU
         WXaScIEvflBXCn+kvNJ+XGAZRR3VB3gMT5l5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQSBsKAoxAPc9BflYGP/pyyeNxQ7aw5FNmEKlmZscts=;
        b=mRbDA/3Tk1mVQARcdVHi2JNe7MzRiPpAZJIwDcKBaORWNhOftgEU3WSaidCO+U6i+Q
         OPLR0qSG+PmXb0f/o8VXfZAeWDC7hCHuKC6FZhwux6wJRQykA9fxqHB0BGcGJibvDM5N
         JxJML8UEbQDgjLp9rzUQdubUwirSb4GwNWucUNj2TitZc4mYHUdWwRSLoeJ3vBUvO0z3
         l0/oqCnky6cndmASjhgdgE48a2u6fUDBBOCW8XIcYOwnU4f9R1dsz7hCH4Y13YVTiDug
         OarBrkaQzTazMk0yQkdwqPFTSF8eFB2eBbONc7f8DAi6KXhXILTB09Dt9HG18gq2+npL
         f0jQ==
X-Gm-Message-State: AOAM531vAYS1mjjK3fFG+SRHFJp8+HrRIZEvjFL9VuUFgvFb5aLDELb8
        vGM01uL444/XQlqBbp2n23YaPhBthM4Izw==
X-Google-Smtp-Source: ABdhPJwj7J2quHce1o3LX4ekMqYBqT8Dx4laBnjr0u+MdmxRDvNZ7OJwLQL8TPrtZ0Y5+kKfmuK5Nw==
X-Received: by 2002:ac2:5395:: with SMTP id g21mr1350698lfh.330.1603827669651;
        Tue, 27 Oct 2020 12:41:09 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id c7sm293367ljk.59.2020.10.27.12.41.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 12:41:08 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h20so3134426lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:41:08 -0700 (PDT)
X-Received: by 2002:a2e:a16b:: with SMTP id u11mr1577403ljl.421.1603827668344;
 Tue, 27 Oct 2020 12:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201027182246.651908-1-geert+renesas@glider.be> <9bfc1775-3cd3-8b5e-23b6-8d4b78536147@kernel.dk>
In-Reply-To: <9bfc1775-3cd3-8b5e-23b6-8d4b78536147@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Oct 2020 12:40:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWeeozKo_O_=wkvAnc-SXLw7ohkWBi9ew74QikB61A5A@mail.gmail.com>
Message-ID: <CAHk-=wgWeeozKo_O_=wkvAnc-SXLw7ohkWBi9ew74QikB61A5A@mail.gmail.com>
Subject: Re: [PATCH] mm/process_vm_access: Add missing #include <linux/compat.h>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:33 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> Oversight on my part, didn't fail on my configs. Linus, can you pick
> this one up?

Done.

            Linus
