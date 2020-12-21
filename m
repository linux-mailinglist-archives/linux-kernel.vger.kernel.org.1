Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B02E0186
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgLUU1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgLUU1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:27:22 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ECBC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:26:42 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h22so17206434lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpofkkkZ7q2cLabxVdnoR1KpfpHXn/gunfXeSPC5btE=;
        b=efJi2L/jwYZG7lsZ3QUyQ+qJRPOSZJVBiQPV+KYdbYTDhEtiTiZJDpg0XZofJH/vr5
         mvNIAsdX5eAcIdvkl8jdEU5jTFWJ/AX+Txhwsgdbaf4PRt5Mq82tnOXK8TWv+g9m7y52
         H+k0THZ5Fa1365neNcweicdbjh0OKXdZEByM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpofkkkZ7q2cLabxVdnoR1KpfpHXn/gunfXeSPC5btE=;
        b=m05oYQ3CKRYVxACqUOZEankE98sPgu/33jcJOIeQLpcZAY4Pf2z86oWVucZMFtgzkc
         xDRAsTJq+ITA9+2r/8ufY/15REsPd6RPlMFl+jWGo1UYe5EjnqbdlW05+BNETKKFljZz
         RfTjXMqoQ/kZdA1TaywMaNNWsJtqY5RsSPkSE+903gZLvvXiePoK3j/AJBYp57RJ96r+
         Osq2BpFchAXcRpQ1R/cudFzgXh9bi0YZp53yt9Sr1Q/S1DILI3SXmNiUWK2+Femr64iN
         XKVHautXuDYyDtcSofU//Oyb4eJMC/NjJDpDRi70mZLONRJJG4gQc0vLhL9rHGXgvZzD
         9W6A==
X-Gm-Message-State: AOAM530xuDWEmWOMc+Xozosh8BhQbqaBNK6mEoAW5luPCvZOgiGr5HEl
        KaIwEF4hINGpfaPizyuFDsEl/QcQ1TuP5A==
X-Google-Smtp-Source: ABdhPJwW3IJgQByRWfI8RdVJS8yV+VyR8BF0Rjic6hIGRTt9nyOKRrEiXStxwVLP3iLm2siOzeS9aA==
X-Received: by 2002:a19:54c:: with SMTP id 73mr7830099lff.551.1608582400342;
        Mon, 21 Dec 2020 12:26:40 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c5sm2252077lfh.160.2020.12.21.12.26.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 12:26:39 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id m25so26656564lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:26:38 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr6960312lfr.487.1608582398544;
 Mon, 21 Dec 2020 12:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20201219043006.2206347-1-namit@vmware.com> <X95RRZ3hkebEmmaj@redhat.com>
 <EDC00345-B46E-4396-8379-98E943723809@gmail.com> <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com> <20201221172711.GE6640@xz-x1>
 <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com> <X+D0hTZCrWS3P5Pi@google.com>
 <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com> <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
In-Reply-To: <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 12:26:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
Message-ID: <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:23 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> Using mmap_write_lock() was my initial fix and there was a strong pushback
> on this approach due to its potential impact on performance.

From whom?

Somebody who doesn't understand that correctness is more important
than performance? And that userfaultfd is not the most important part
of the system?

The fact is, userfaultfd is CLEARLY BUGGY.

          Linus
