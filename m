Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA632EA6BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbhAEIxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbhAEIxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:53:31 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A0C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 00:52:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id h186so18006775pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 00:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EbrvcIwMoq++jgGTTRvYm5QFBxlGfKoxxIGECgFMJYs=;
        b=iGmg5LmhKiGSj2U64qF0fgcCB8bubcJN299bsUyCR6SQmZAkwMTvKYpHDzwZ6pE/GP
         2OvopbsxX9hahbZzHItuq8wMbo+SGz+fJP6Xkc5+FznmqPC292KTkUStSsIpVtbX117F
         4wBUmFVPebUPiaHHpYHUZK9APj2CcpiYdsKVHP2cQmKPz1vx7H8p86ViP1X5eiacEoc8
         ps0/OXGCJV4MCep03X9ZiCsVVYtLHer+51pVb7euxMoinLNClk1HbT0I4+ppvMwHAC3R
         uWQZOEq6Kq+4f2chP1fYjTFzKr4jpI/dZ3KFuKO4ZOHbLPULraJ9HIFeXfyr8UE49wNg
         kbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EbrvcIwMoq++jgGTTRvYm5QFBxlGfKoxxIGECgFMJYs=;
        b=lFFLcwHjAcAhi9E4u1pBcB8hiO8TFrN37dH1ICDMaAkVHM2Xs/THB9njQXJtz0B21s
         rGZLzogmBZLSn66W8/57KMQoMNQPFobxKzL820uFXQ2mmRJ7fXZarCIambSiFXQcZ2hM
         Gf8GaecuZWQXn/jELGLGDAAaVTqQJN/DN4rwSp4CKYmrHVqAep3/r/owZpMvfjhndXAy
         xRUtMBBpuc4pZeJrDBy1Ia9R447hM3WpWmyc6fYozPjCHU4zJxhC52uHwpzcx1Gb75hQ
         p6mX9klQUD2SF0V8j7NQrMTvz33KEWwqtIFnW2pPdfQFHF0QTocEAv9Vp9ws7puwlZsy
         d6hg==
X-Gm-Message-State: AOAM533Z44HHkpIAUylyZgRr0Y0lGBznIyWPEqlNYFzMSyO3LAYF8NWd
        P062dCkBlTTs0OrAc4g0uKmRnOjWioe0NA==
X-Google-Smtp-Source: ABdhPJxoQkfzGtKhM86tK/6Z4qK1vxD+A+V0mLOdiD4QgZVp1moAwHuhNpb/an9EgXzjaatpo4dlKA==
X-Received: by 2002:a63:5701:: with SMTP id l1mr40644023pgb.381.1609836770995;
        Tue, 05 Jan 2021 00:52:50 -0800 (PST)
Received: from [192.168.88.245] (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 197sm63832387pgg.43.2021.01.05.00.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jan 2021 00:52:50 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20210105081325.GD3040@hirez.programming.kicks-ass.net>
Date:   Tue, 5 Jan 2021 00:52:48 -0800
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Content-Transfer-Encoding: 7bit
Message-Id: <C255B66E-C418-4B30-B363-76441266A0DC@gmail.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <20210105081325.GD3040@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 5, 2021, at 12:13 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Jan 04, 2021 at 02:24:38PM -0500, Andrea Arcangeli wrote:
>> The problematic one not pictured is the one of the wrprotect that has
>> to be running in another CPU which is also isn't picture above. More
>> accurate traces are posted later in the thread.
> 
> What thread? I don't seem to have discovered it yet, and the cover
> letter from Nadav doesn't seem to have a msgid linking it either.

Sorry for that:

https://lore.kernel.org/lkml/X+K7JMrTEC9SpVIB@google.com/T/

