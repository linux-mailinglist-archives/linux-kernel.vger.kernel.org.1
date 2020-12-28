Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE3A2E3368
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 02:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgL1BAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 20:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgL1BAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 20:00:18 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E48C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 16:59:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h205so20678629lfd.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 16:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDSu4XiZkV5gMDS1Vs4PuARPMnz7fqtwxfLIjwQCyCo=;
        b=pcKgIrQxu7UxjxzewMy3ISbe2VVkkRYf2zXO/968JrWoCLQw4nt42HaoVbCjM7qSV1
         gu0ttuRdR1QAvTWjF4QpLtMFuQbH0qVKxPAmXvcVCWvDI6Tm9C9VU3VCJqy5Bz4hQP5q
         pC5C11cSS7sq6SXbYSAqI4wi9l7M5ZAyRboR0m4bMq5p60bjtuH0FaphUpWrdNeDbUnu
         fUEjrfnkDLYOCbrHyCi3OrLRrSSLyy/JtJkRh1kCA85UpxRN2IBIK02OTR7qfgRCLYV1
         jctFI62OkUMBViwwPi90SbQ272eWhCi0tQrGZlBqtO2/kfUxstcrt60VsELuBckD6RSY
         du2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDSu4XiZkV5gMDS1Vs4PuARPMnz7fqtwxfLIjwQCyCo=;
        b=EFptJtdQhz3HMiY0iTgg2Z1JVuAyz1yMcVLI75dGKUN4MO55qfrl79NOnDNzc/PfCX
         uHW4qyrdsP65f94htJfuIBSeuO8zvrJlHxIRedTgqavefS94X2O5c+c1N2+Qf4jul3Gx
         3ywIf9AtMCPMYq0UUjKTuthFKTzG1iNv79SiTZR7TbANTzKbeOIRUxgm2fJPkQ+UbRz5
         ctMSwPqal9yEZ0RosLwP+4HjTOAZOn3YrF7b3OO7oUSn5LAIpjPCKg2prdP83vk1YlrT
         mIeEulru7emmjtwklY9Go6AEgbRVsa/Ku6plMObEMKYwuyCKN7dxyaoFuI/gNNttKbsW
         3ZKQ==
X-Gm-Message-State: AOAM531AzB+7awPSkaZMWWcyowma/tu2Owyia9QEOIHo9MAlXXRpQwPB
        fdwoLtmCFXlgcOzUss8RDloznODyLeFdiaByH7k=
X-Google-Smtp-Source: ABdhPJxnMfJxwsQx9ZSg/2PiO93a8sjwBWOBiRgIB7xtZ/vYMPFXsbSeRZ44g4I9BAeBH+RyDSFvmc6Zxjz7bFCXfLY=
X-Received: by 2002:ac2:43c1:: with SMTP id u1mr18693298lfl.38.1609117175998;
 Sun, 27 Dec 2020 16:59:35 -0800 (PST)
MIME-Version: 1.0
References: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
 <20201222204000.GN874@casper.infradead.org> <20201222155345.e7086ad37967c9b7feae29e4@linux-foundation.org>
 <20201223083126.GA27049@infradead.org> <20201223121136.GP874@casper.infradead.org>
 <20201223155254.GA6138@infradead.org>
In-Reply-To: <20201223155254.GA6138@infradead.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 27 Dec 2020 16:59:24 -0800
Message-ID: <CAADnVQ+DStjXJPUbUL7ggXyFj_iJuNDB56jdhzsq=D=QxgQQXg@mail.gmail.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 7:54 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Dec 23, 2020 at 12:11:36PM +0000, Matthew Wilcox wrote:
> > On Wed, Dec 23, 2020 at 08:31:26AM +0000, Christoph Hellwig wrote:
> > > Can we please make the eBPF code stop referencing this function instead
> > > of papering over this crap?  It has no business poking into page cache
> > > internals.
> >
> > The reference from the BPF code is simply "you can inject errors here".
> > And I think we want to be able to inject errors to test the error paths,
> > no?
>
> Something that expects a symbol to be global is just pretty broken.
> I think it need to change so that whatever instrumentation is done can
> coexist with a static function.

Pls read commit description that made it global.
It has nothing to do with bpf.
