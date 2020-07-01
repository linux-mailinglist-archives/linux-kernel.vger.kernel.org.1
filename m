Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C00B210A83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 13:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgGALqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgGALqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:46:36 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF8C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 04:46:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so21781662qkn.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 04:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYqF4GJWJhiq0zr8OJJzrOWqCriyzTSLkTobBVYc5/s=;
        b=aYbnmJqIMQKblPHiJRycAGb04R3B72H7jsqO/6ylS2mppwKkBIpk9UoHyuSrey4Jvy
         6BTgKhlaLOmMMEkE4nS9kML7tlq7mQndDNYznC+xFMZAGwM0g4dEEOWnMJhfTnmyeqf6
         /0VPnqwBNsXnkbmL6cJyjYO1SnqrCOj5N3RSVkj8b6xd6DIj62VvqyS3RUzY2ITAfNkV
         rje1wpA18rBWsCRXuPbD/rikd6/O9Wc7eMLEw4X7l+NLoGY8RtpvOKgbKfHA4qvxaiky
         ZslzS9cEDmKfKm4YWS+xc1cgzD2dX7sqoitreAdvsynJGA0jlDiXviF0lCBODxmGfxju
         e+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYqF4GJWJhiq0zr8OJJzrOWqCriyzTSLkTobBVYc5/s=;
        b=g9k17MTRuhZOm970sZjZ+gTqvEWuBfSZVhcIIyfqlafdOnrV83u5JIjJ8ldUzVkRVc
         ag48ZndeEwFMfLoKUltGNXxN1L+o6zrRckScljBUJaybBcPuV/63CYMSsSJPIbhxwed6
         bMhoCNNtKjqY6b0x+EgA+S4z/qjSrJ39Sz52TaUEbktzp1ez8B6KRJV9d/HOfvhEifc1
         qRlp1d09eVEdVjbxoOt2Zd2mvpvz8yT3OmPVSy8janGXbIfAuvPwijrew0FK5ZN2uB1F
         rwGxnz63ESGGgnYPEYJozPHCc9inUyzPQ/rPSyk7gUxPGVsr8D99/NgKPA06rFfxnnwY
         +Rtg==
X-Gm-Message-State: AOAM531RGay5jdvpzDzsfisu1KnY97II30ns78B5stBPE855Ov00re3A
        g/IzzOaW8Gtx1KzsYooT4TZ1sODjH6WmgpR+E47vpYi9uSE=
X-Google-Smtp-Source: ABdhPJwqu1fXRrwg0M7novYpBkm8DNW5TDfTOFJuqqC9PKaa+vMtnobtum6nx6izu14USV4vL6yPP+gCUj1N4kPnoVo=
X-Received: by 2002:ae9:f803:: with SMTP id x3mr23680182qkh.488.1593603995183;
 Wed, 01 Jul 2020 04:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200626223130.199227-1-peterx@redhat.com> <20200626223625.199813-1-peterx@redhat.com>
In-Reply-To: <20200626223625.199813-1-peterx@redhat.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Wed, 1 Jul 2020 14:46:24 +0300
Message-ID: <CAOJsxLEYHzjgMtXgbkoWYvU+Lf_08GPkMAFqibnEwARNzxJZxQ@mail.gmail.com>
Subject: Re: [PATCH 17/26] mm/riscv: Use general page fault accounting
To:     Peter Xu <peterx@redhat.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sat, Jun 27, 2020 at 1:36 AM Peter Xu <peterx@redhat.com> wrote:
> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.

I sent a patch to fix up riscv page fault accounting some days ago:

http://lists.infradead.org/pipermail/linux-riscv/2020-June/000775.html

However, your fix is obviously even better. For the generic and riscv parts:

Reviewed-by: Pekka Enberg <penberg@kernel.org>

- Pekka
