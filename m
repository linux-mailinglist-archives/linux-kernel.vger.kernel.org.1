Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B842C573F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390834AbgKZOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389991AbgKZOlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:41:04 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF29221F9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606401663;
        bh=kDKRaFwSyrQzI/5KqIOMDNUjvyh0rFbVZ0h/er1Jx1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CoMGVWppG7tUtVl9oMi4Qpz87k1/ZRliLF72IDjgB/TIW9T6Z4vKDimaS5DGd0Q2l
         G7zr35Xtyevb/Sh/mQ2T3gTl2JPfh4yCdsF1R3bE+qvG/rZPvKHIGOSQz2ZurNI4aG
         rjXikd4fVXCTTKXvtvApqWMdES9EUfl8ajQ0jP60=
Received: by mail-ot1-f50.google.com with SMTP id 11so2031685oty.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:41:03 -0800 (PST)
X-Gm-Message-State: AOAM532jWioiiTnHjMV0W1u+L0W2nD5sZ47BtxRGM9m7ejGsA4X7OOat
        l0BCBqpTWkl1CAA0HbUbpgZNsdHklx+lZtH4dgE=
X-Google-Smtp-Source: ABdhPJwb8V1WMLDcmr3+lGiQPHZARsGS3/JdagxpjPuVMuYRdrt1TcHjveIjIea19JypNV/jr3GIes0ZNNZuAKkYJVQ=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr2544828otk.251.1606401662959;
 Thu, 26 Nov 2020 06:41:02 -0800 (PST)
MIME-Version: 1.0
References: <43486cab370e0c0a79860120b71e0caac75a7e44.1606397528.git.michal.simek@xilinx.com>
In-Reply-To: <43486cab370e0c0a79860120b71e0caac75a7e44.1606397528.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 26 Nov 2020 15:40:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0zj90cMS922L9jhEtimatzp0cjEr1T-e=tHWSuzZqy8Q@mail.gmail.com>
Message-ID: <CAK8P3a0zj90cMS922L9jhEtimatzp0cjEr1T-e=tHWSuzZqy8Q@mail.gmail.com>
Subject: Re: [PATCH v2] microblaze: Remove noMMU code
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Baoquan He <bhe@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Joe Perches <joe@perches.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 2:32 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> This configuration is obsolete and likely none is really using it. That's
> why remove it to simplify code.
>
> Note about CONFIG_MMU in hw_exception_handler.S is left intentionally
> for better comment understanding.
>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
