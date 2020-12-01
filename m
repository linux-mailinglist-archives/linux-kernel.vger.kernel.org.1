Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9B72CAD2C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390824AbgLAUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:20:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388214AbgLAUUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:20:34 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2E92151B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606853993;
        bh=6cgQhA+9Fe1MapUiUOn3Uf4foo+0SJKMoMWA/pfA3Is=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kLepZq9jHFg4qycJMv8hPp8WOz4Ewm+cWjoNXhYyRQKezYkaQuW/sh0DUMzJIJR2c
         pY1fSvWumlADVr7ciTqMNY4Cyqf/cW6L5Ilbh5PKyJSddBuENIkXvt17kRQ4p1ywMu
         XJfPPtAM/MRE4oa5j9tclRQcAN5G97b74a50pCr4=
Received: by mail-oi1-f179.google.com with SMTP id l4so562221oii.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:19:53 -0800 (PST)
X-Gm-Message-State: AOAM530mQ/b3Qe0u06DFzIRQfuKeViopRLo4x2MLbyCq9VPsZZsk9+x3
        HLyLjJlAnPicfZjvnWCMnm4Ao3W/DL+mbwUDIbA=
X-Google-Smtp-Source: ABdhPJx3dUBp8fSD53Rf8bQvhGB0ZDRrlR6xTov+kRkzskWZIooEtpZNoOXeBp3TJzuTDnieg4EURE7JMYP79fAn7ts=
X-Received: by 2002:aca:fd42:: with SMTP id b63mr2814725oii.11.1606853992678;
 Tue, 01 Dec 2020 12:19:52 -0800 (PST)
MIME-Version: 1.0
References: <trinity-56749cfc-536b-45e2-8e6f-621754c07824-1606165260518@3c-app-gmx-bs09>
In-Reply-To: <trinity-56749cfc-536b-45e2-8e6f-621754c07824-1606165260518@3c-app-gmx-bs09>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 1 Dec 2020 21:19:36 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2dq8VtYARPS9r9aeJipA3hD9M01wmEJ8LuZT1_Taav3w@mail.gmail.com>
Message-ID: <CAK8P3a2dq8VtYARPS9r9aeJipA3hD9M01wmEJ8LuZT1_Taav3w@mail.gmail.com>
Subject: Re: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue allocation
To:     Norbert Slusarek <nslusarek@gmx.net>
Cc:     gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:01 PM Norbert Slusarek <nslusarek@gmx.net> wrote:
>
> From: Norbert Slusarek <nslusarek@gmx.net>
> Date: Mon, 23 Nov 2020 21:53:41 +0100
> Subject: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue allocation
>
> For the allocation of a queue pair in qp_host_alloc_queue() an arbitrary value
> can be passed for produce_size, which can lead to miscalculation of memory we'd
> like to allocate in one take. A warning is triggered at __alloc_pages_nodemask()
> in mm/page_alloc.c:4737 which aborts the false allocation, but it results in a
> VMware machine freezing for an infinite time.
>
> Signed-off-by: Norbert Slusarek <nslusarek@gmx.net>

Thank you for sending a patch with such a detailed analysis and even
including a test case!

> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index c49065887e8f..997ff32475b2 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -526,6 +526,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
>         struct vmci_queue *queue;
>         size_t queue_page_size;
>         u64 num_pages;
> +       unsigned int order;
>         const size_t queue_size = sizeof(*queue) + sizeof(*(queue->kernel_if));
>
>         if (size > SIZE_MAX - PAGE_SIZE)
> @@ -537,6 +538,10 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
>
>         queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
>
> +       order = get_order(queue_size + queue_page_size);
> +       if (order >= MAX_ORDER)
> +               return NULL;
> +
>         queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);

Calling kzalloc() with that user-provided size may still not be a great
idea, and MAX_ORDER is probably more than anyone ever needs here
(I don't know what the interface is needed for, but usually it is).

If there is a reasonable upper bound smaller than MAX_ORDER, I
would suggest using that. It might also be helpful to use kvzalloc()/kvfree()
in this case, which can return an arbitrary number of pages
and suffers less from fragmentation.

Note that both kzalloc() and kvzalloc() will fail for much smaller
sizes if the kernel is low on memory, so that might have the same
problem.

       Arnd
