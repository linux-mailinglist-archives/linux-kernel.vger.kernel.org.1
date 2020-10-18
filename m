Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE62917E5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgJROjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 10:39:40 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38773 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgJROjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 10:39:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id i12so8011222ota.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhoQCn1JiZzZO+O1miFJ27iO/mX2XMIJR/r8umj5hJE=;
        b=KpLhA87ul/uuReiJ9vGC1u/sjlh3cpQJZR4Au9i2hE2rtDyB3Ycbf/YEIhwim8AmJb
         Mr4CwgKq6jj5Tc2Ie+TC5fz6pWwrm/cnTRES6ap1ATDjEhQ3/i7e9hWDlI4VFO9JwfXW
         nh4wyRxgnMljG4VpGmXWfTdUPYM6BG/H9iqJTbnmXaY0RzfgGWV9/7aCK+Zt1Vurf0Zv
         anTUy87q6FXF8hsJbvQ2tuMh42PFPXHs/jBTKFTL7JT2VO5jTPYzJ/BteTf/gnzGGqes
         iMPIu1n6yI6eZ3JVE70VabJCe+9eElbgn3z9m+GvazMphQSZfw/cUpjDEIRMs1DiG6oI
         EVZg==
X-Gm-Message-State: AOAM531BFl0DuYUcednNIY+3dzgaDrlRS6606cU3WHTxYbw9C5/kR3MW
        qZ7BxYs7Tkil4dDPpj+C+9yzrJa7vN9uv1aOOG4=
X-Google-Smtp-Source: ABdhPJyYtSylRs4YpN8Jpnr9M4d0jJYc50QXbtzghaCMbPhoACjsEVrwjsHXEKcKsFZXRWH9MqFQS0EUiUgrYY3/FE4=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr8589875oti.107.1603031979558;
 Sun, 18 Oct 2020 07:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201018140445.20972-1-geert@linux-m68k.org> <20201018142508.GJ20115@casper.infradead.org>
In-Reply-To: <20201018142508.GJ20115@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Oct 2020 16:39:27 +0200
Message-ID: <CAMuHMdVcTx0wVTSh-YaJxXqCMpCxGRe3QH36O5i+McinfdRwDg@mail.gmail.com>
Subject: Re: [PATCH] lib/test_free_pages: Add basic progress indicators
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Sun, Oct 18, 2020 at 4:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Sun, Oct 18, 2020 at 04:04:45PM +0200, Geert Uytterhoeven wrote:
> > The test module to check that free_pages() does not leak memory does not
> > provide any feedback whatsoever its state or progress, but may take some
> > time on slow machines.  Add the printing of messages upon starting each
> > phase of the test, and upon completion.
>
> It's not supposed to take a long time.  Can you crank down that 1000 *

It took 1m11s on ARAnyM, running on an i7-8700K.
Real hardware may even take longer.

> 1000 to something more appropriate?

What would be a suitable value? You do want to see it "leak gigabytes
of memory and probably OOM your system" if something's wrong,
so decreasing the value a lot may not be a good idea?

Regardless, if it OOMs, I think you do want to see this happens
while running this test.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
