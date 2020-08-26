Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264262524A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 02:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHZAR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 20:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHZAR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:17:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3283920738;
        Wed, 26 Aug 2020 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598401077;
        bh=xXaAEJ0AEr+5jikBS0er1PNhtLBu2gg0MrzTQd1zC6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GziKgOjQuNTLiyQzSE8/pAtRGOGqyQr6ck2qKh0HhXFhtXBYiRHAXd/C/O1AcGrlv
         Yok3Cajmqe878dcLJAkRzbvcd5F0Orqy0K0cO7c7kSRL8utpGhM2Im4QDCwrO2N9SO
         NCqN28JRSjdqUDGa5u5y54AS+w2grsvS59zcpE2A=
Date:   Tue, 25 Aug 2020 17:17:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        John Ogness <john.ogness@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
Message-Id: <20200825171756.830d5895eb40d2dded2803ae@linux-foundation.org>
In-Reply-To: <20200825123542.GU4353@alley>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
        <20200821080813.GM4353@alley>
        <d81e8b0d-fa7f-1da1-671f-0541b94ad349@siemens.com>
        <a5f4c178-9b3c-6ccd-9ea1-24d8fdc13273@kernel.org>
        <20200825123542.GU4353@alley>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 14:35:42 +0200 Petr Mladek <pmladek@suse.com> wrote:

> Andrew, would you mind when I take the three gdb/lockless-printk
> related changes via printk tree to avoid synchronization problems?

No probs.  If such patches turn up in linux-next I just drop my copy.
After checking that the patches fully match...

