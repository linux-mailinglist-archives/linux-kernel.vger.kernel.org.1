Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061BF2E09D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 12:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgLVLkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 06:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgLVLkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 06:40:02 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101A4C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 03:39:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b26so21720186lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vEOdxOf3Oi31x+Ioc56RXk7qAlmQxla1l+5+ovO2vxQ=;
        b=bWXT6Eowm2Rd2vMNa/4HwGzq4okGY37rz4xe5Zovs/UpaMZS2IisYgX5layS+oUKXj
         eDmwWYSI6zdRbOq5+iy1gclbPIKNZq0Pni9kaKBiAzDx+J9KSzRGcO7nAMIn2VOfjweL
         29X+xUF8R0hprT20Hwa6VaFJdCaKMUy/VRKrYu2Cbg6VAwaM05YvfiXMhVW5mD3ZnLq4
         hx0JPPSzCcBl2WshQF85DQcrW8U+NDduyWp2FZWCZRzmBUE9cjEbZhCwS7z0jrfwVEiH
         5wvx5RhalETDrCmr5gZCCXovpfEifjAC9/0hH2xTAyPc4H7IFPy2ORxvz3aZfGTqJn8C
         ALFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vEOdxOf3Oi31x+Ioc56RXk7qAlmQxla1l+5+ovO2vxQ=;
        b=G3dTgVaUHk9YvNOoeguXrLiZUnjFp7KGtk3LGdsZSrqH5RLGwJic+R1ucrqQjyiDtx
         M6XwGI6OzxFCmoQ+efaBxrigrTXoU3drdfVVX2R2btBzdZOBr6Ow7f3BAojP/zjT9pM8
         3Le7Klby8oFIVqy6x54kJXBcvH7K1+/pVJnP2m7V4kpg0wtL9X1si7EeOumzvvNNlWKF
         50Fp+CtW9zUCovzh2qW0dsikmhFJdqvVxjWRaIwlEWtOo5s09cQ7WmELZbSe4CJwCbbJ
         21oYu1LCF59eFJzD9tg8L+EnXeg9J6/zO00GD6sHXmrzFy43p3wxRRiKu8t6nlDFaKHW
         eM4g==
X-Gm-Message-State: AOAM532F5Y3upcZHZwdOPVhwQA+AVmgOSko383vq6CIBOb7WWYLsC2XE
        Px+HIJbjH7jbsg1DbUptd3qfWrE+qdtWukWnVQE=
X-Google-Smtp-Source: ABdhPJxSOZZIFlE5itNqeegulycWEXMG8OkTpwJdnQNoxDMyk02F92V9oTmtGtnX+ufOiSJWRkHopx1vTFvmDN4XfzM=
X-Received: by 2002:a19:814c:: with SMTP id c73mr8138048lfd.638.1608637160635;
 Tue, 22 Dec 2020 03:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20201222074810.GA30047@open-light-1.localdomain> <6846ff7a-b302-a0fd-1cd9-af0f2ee733ea@redhat.com>
In-Reply-To: <6846ff7a-b302-a0fd-1cd9-af0f2ee733ea@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 22 Dec 2020 19:39:08 +0800
Message-ID: <CA+2MQi-qXS4BHwDuxJXN52GyA67+kv9iCoasg2knRg5ytxp1vA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] virtio-balloon: add support for providing free
 huge page reports to host
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.12.20 08:48, Liang Li wrote:
> > Free page reporting only supports buddy pages, it can't report the
> > free pages reserved for hugetlbfs case. On the other hand, hugetlbfs
>
> The virtio-balloon free page reporting interface accepts a generic sg,
> so it isn't glue to buddy pages. There is no need for a new interface.

OK, then there will be two workers accessing the same vq, we can add a
lock for concurrent access.

Thanks!

Liang
