Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C80D2BB902
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 23:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgKTW3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 17:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbgKTW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 17:29:54 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4B5C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:29:54 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id l11so15703754lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 14:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rN2oDMLkDXvF2d0qSHyE1KGJoI0coYurxX8BvFhI+bY=;
        b=G5VJUQuazvZ46rb86s40Pn6WkJ8vF48RjwI203WsXZ9Dd/97U9zAuv02njfWIOciBV
         QuSh0dRcRHb6kNB5R91cqfNYC3Nx6BskGC8Id4k04GJmqF+iTSL0z/vx19itSZMS+dny
         GX6UFvM4nLEOfv88ofsMR/2MQJp/CTfeCiBq4RMzNChRcKghzB+b2vhazIrHXFWol38n
         pfrMAxiWdO7fXF7LhFiySxUhhlwuVHmMt2IU2HAhlY57qt8oywDFoatbjiKMM0J1tI0a
         F2+QJ/feDTYc37U0EswhVkKC6ECmTYbgvZ1lbayAJ7xC0KxdUPr0mf9Jsvw5GLqRUrhv
         ttbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rN2oDMLkDXvF2d0qSHyE1KGJoI0coYurxX8BvFhI+bY=;
        b=ki1ginUSbqJxrVrwfeJaIwCzYcuzn1tWYwb002LLMndAV5tilbLr9krkPVKRtTb8mn
         DlbcKzFKdsr2TQilgwVEseMT+GFfHpaJkIMPT2G//hxo43ja7LWs9JN/p6g3C+O4X23d
         kdGcCdq0s+xG3+FOFtwL88oZ1Fc42ODIhdZVY8RlRvNqD10BEX9sQo4h9yDj7vZTDLct
         1+DuXj1TS04mqKlzleFOGNaf47EjQ/jp9PIOFNbPzAWE8xvL0Qw6LNZ8fwjKrzory5Ui
         tV4YI2VwdQobHg4SFS2t7QMFR/6kYGvTQxKZX+9Dpk40nCo5NIPfpvS7PaM5hxi+mGGr
         KWew==
X-Gm-Message-State: AOAM5307ZntU5KRbTKLE4fdRPHzbog3avtWn2cIgrLaTiVqQtxZNr9qX
        dwuXWF2x8Kdc1mPU67F4hQe+EhBhJ4pnbyr+w0Tv8A==
X-Google-Smtp-Source: ABdhPJz7KhY3kkkWmPWTE7oEp1RrYqakWRzVBA4phAIJXfRGBYOb72PMtSpg2EcEFuNfIDhSB+mhcRErvgpdubnMvSw=
X-Received: by 2002:a19:686:: with SMTP id 128mr8504175lfg.198.1605911392397;
 Fri, 20 Nov 2020 14:29:52 -0800 (PST)
MIME-Version: 1.0
References: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
In-Reply-To: <3E05451B-A9CD-4719-99D0-72750A304044@amazon.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 20 Nov 2020 23:29:25 +0100
Message-ID: <CAG48ez2VAu6oARGVZ+muDK9_6_38KVUTJf7utz5Nn=AsmN17nA@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/virt: vmgenid: add vm generation id driver
To:     "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc:     "Graf (AWS), Alexander" <graf@amazon.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Willy Tarreau <w@1wt.eu>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "oridgar@gmail.com" <oridgar@gmail.com>,
        "ghammer@redhat.com" <ghammer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Qemu Developers <qemu-devel@nongnu.org>,
        KVM list <kvm@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linux API <linux-api@vger.kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "areber@redhat.com" <areber@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Andrey Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        "gil@azul.com" <gil@azul.com>,
        "asmehra@redhat.com" <asmehra@redhat.com>,
        "dgunigun@redhat.com" <dgunigun@redhat.com>,
        "vijaysun@ca.ibm.com" <vijaysun@ca.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 4:35 PM Catangiu, Adrian Costin
<acatan@amazon.com> wrote:
> This patch is a driver that exposes a monotonic incremental Virtual
> Machine Generation u32 counter via a char-dev FS interface that
> provides sync and async VmGen counter updates notifications. It also
> provides VmGen counter retrieval and confirmation mechanisms.
>
> The hw provided UUID is not exposed to userspace, it is internally
> used by the driver to keep accounting for the exposed VmGen counter.
> The counter starts from zero when the driver is initialized and
> monotonically increments every time the hw UUID changes (the VM
> generation changes).
>
> On each hw UUID change, the new hypervisor-provided UUID is also fed
> to the kernel RNG.

As for v1:

Is there a reasonable usecase for the "confirmation" mechanism? It
doesn't seem very useful to me.

How do you envision integrating this with libraries that have to work
in restrictive seccomp sandboxes? If this was in the vDSO, that would
be much easier.
