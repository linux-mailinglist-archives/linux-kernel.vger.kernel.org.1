Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268B2284D1C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgJFOF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbgJFOFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601993123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=guYki50KQJdFnn1PZrjvoH399zUlc+hngMckBoejkYs=;
        b=QmXtxQIxyxopG4uSQH3A8GyEmUgtPnVmljWVzIi+GRslfKbA2iquCTaPiKw3D4HJJR3veU
        TqG0SFKNaX41Y7UoGxsfPlu5MKxXmxZc1Sz2qctvnF+NFA6QNhDb9RnhMKqb0X5VAGy/S0
        PgE8Ha9UxjEWJHTXZ4m4+J7/zRBfH58=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-K63kNEgUNW-DDnFs0cKWTA-1; Tue, 06 Oct 2020 10:05:20 -0400
X-MC-Unique: K63kNEgUNW-DDnFs0cKWTA-1
Received: by mail-wm1-f69.google.com with SMTP id u82so1161004wmu.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 07:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=guYki50KQJdFnn1PZrjvoH399zUlc+hngMckBoejkYs=;
        b=r+CjZ7+Lt5eV8VJipgCutM7+ncHqbs38a/8DQ789zezkjvoVteu6P9EJgSsYenVolE
         G05aGUFVwlXOBH1gc8IBno0GJPk8bFXwpL2Ain0XOCJswUREQkcVWpuwxrDKTJMpk05/
         3K58JJm3rmnyUeVTN4pT/EIVhaU/fmUhGrFJUKJbQGhUsib6JlvztH9DZZIpwj3pKv7v
         Fi0HGwLtIcQgP+zSL40UbtHjWIVjn25WWI8QcZrWsfOpynk2bYZTOcAwjeLC5DRVBxNp
         afLrmC3nIn4m0fFD/c5lr67uOoUd1AYUQ7qG0daUZN7yDkTbkXy6ZvgCdjjPT+EWhArS
         nsKg==
X-Gm-Message-State: AOAM532nI0QM6nazYnAgm8DSi4MhU8T/hT+C4MwVWllE45ND+2Wf5lBl
        hXtmnEk/vpLaaJS5ZxEMW1XaARtBvq++3fiYF3wYGG4EZyCYHcQXGl4atQyRX7F8FTCKxoKfGG6
        7l2hwlkEYuRW30+4fCD4aHllH
X-Received: by 2002:a1c:417:: with SMTP id 23mr4967684wme.1.1601993118923;
        Tue, 06 Oct 2020 07:05:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOa4DTQCDzLceiEFkj8shvvubVqqzvW5y8izKrSxstNeZxCY/TaDjcROYTZ8pPRTzplS32LQ==
X-Received: by 2002:a1c:417:: with SMTP id 23mr4967661wme.1.1601993118732;
        Tue, 06 Oct 2020 07:05:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q20sm3953461wmc.39.2020.10.06.07.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 07:05:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>, pbonzini@redhat.com
Subject: Re: [PATCH v4] kvm,x86: Exit to user space in case page fault error
In-Reply-To: <20201006134629.GB5306@redhat.com>
References: <20201001215508.GD3522@redhat.com> <20201001223320.GI7474@linux.intel.com> <20201002153854.GC3119@redhat.com> <20201002183036.GB24460@linux.intel.com> <20201002192734.GD3119@redhat.com> <20201002194517.GD24460@linux.intel.com> <20201002200214.GB10232@redhat.com> <20201002211314.GE24460@linux.intel.com> <20201005153318.GA4302@redhat.com> <20201005161620.GC11938@linux.intel.com> <20201006134629.GB5306@redhat.com>
Date:   Tue, 06 Oct 2020 16:05:16 +0200
Message-ID: <877ds38n6r.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> A. Just exit to user space with -EFAULT (using kvm request) and don't
>    wait for the accessing task to run on vcpu again. 

What if we also save the required information (RIP, GFN, ...) in the
guest along with the APF token so in case of -EFAULT we can just 'crash'
the guest and the required information can easily be obtained from
kdump? This will solve the debugging problem even for TDX/SEV-ES (if
kdump is possible there).

-- 
Vitaly

