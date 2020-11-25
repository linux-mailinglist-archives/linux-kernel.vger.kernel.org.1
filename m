Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A222C40B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgKYM5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgKYM5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:57:39 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DFA620BED
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606309058;
        bh=lP2KN7ih368LyHmiCVh2BTzmfUDhaplk/c/TZ5vYPH4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NwWTGEICl6JUqvUOnu5GE87zkL/C7wKHoGTXTI58RDfsm3ey7jEoXbMCXOS365rQB
         kg/6N8WnSIeyJPBEftdmdib6YvCciT04eqG1YK8gtUr/WTmW76GKFM/7Icnxw87vlT
         bK5p2PdimrC3nRbkuJi9zCVs5p8bh631pUlfCP2c=
Received: by mail-ot1-f52.google.com with SMTP id o3so2110116ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:57:38 -0800 (PST)
X-Gm-Message-State: AOAM533Fa6j4wgRmcEe9tszL8UUSdUFKQwyGetiv4X8WbclO4h0RIOFg
        ufpO4TJhfRd8aNvhrok1GuBS6ZofA+tD13KCALA=
X-Google-Smtp-Source: ABdhPJwR4ShWjpI6tueFBwcsur5va/U/3OSkXo1gtnK+Rx3IDcR3eCddAPXeT9LZuVdO6WRSSyxbBNRmnBLrpLLVgOk=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr2647560otk.251.1606309057673;
 Wed, 25 Nov 2020 04:57:37 -0800 (PST)
MIME-Version: 1.0
References: <caa5c3cbe6253d67fed83c4351d85224f8cf226c.1606303816.git.michal.simek@xilinx.com>
 <20201125120739.GO8537@kernel.org> <7217421a-c4de-0bd1-3231-17563e51e3c9@xilinx.com>
In-Reply-To: <7217421a-c4de-0bd1-3231-17563e51e3c9@xilinx.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 25 Nov 2020 13:57:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3QkWTCDg+v9qtW0aG7ndhmSukuZG-znS_NzRHyoZLQhw@mail.gmail.com>
Message-ID: <CAK8P3a3QkWTCDg+v9qtW0aG7ndhmSukuZG-znS_NzRHyoZLQhw@mail.gmail.com>
Subject: Re: [PATCH] microblaze: Remove noMMU code
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Baoquan He <bhe@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 1:14 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> And second part. I know I removed that Kconfig macros for it but maybe
> good to talk about what needs to change to support different page size
> for systems with MMU.

I would recommend just leaving it hardwired to 4K. The benefits of larger
pages are rather questionable, especially on systems without tons of
RAM, and it's an endless source of problems.

The commit that added the option, ba9c4f88d747 ("microblaze: Allow
PAGE_SIZE configuration"), was rather nebulous with "can improve
performance on some workloads".

On PowerPC, the benefits of larger pages are mainly for the hashed
page table code, which I don't think exists anywhere else.

        Arnd
