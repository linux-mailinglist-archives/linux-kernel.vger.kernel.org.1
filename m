Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F302F6941
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbhANSSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhANSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:18:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93CC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:17:41 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o17so9388263lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIhd1uC2z/B49SFr+5F6fuw8ur1PxMBEOpX9JeU0Qpc=;
        b=AoB8ftutsiFSPCw0cLKCQs0z3iibi8buOE+leA0p6M8n8cLzFROGUPZBIn7ctD38k3
         P8PjCxgmmEPwmAxrvDK/44szweqhYTqRRhQ7ABljYS6nvUa+dFzpzyrpyeJb+Zevv9Ut
         Kqv0YJ+aqmNv1B67+g6LHOBYTHPMx/XbaQCkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIhd1uC2z/B49SFr+5F6fuw8ur1PxMBEOpX9JeU0Qpc=;
        b=DKrOH5mmwWGQkks4Vt0iuxrbcAkEn1/mn4ZaNGR1FzoX7JhLyzgZSlMjdj6+oyF4l/
         Tst5JMm5Ap45qcgX/5N67Ebq77uqeEvUjtF2AqIr3iI43tK+38mMjuWx+gYlizT5VsXS
         dfSkqt+Dc7XsRFhnxl5Lm675P98Xrbvp9GTvHlWaxjqxXgodLZRWyq6hwDXmVr88ar9A
         IUvXTp/mAGtfX9z1DGgw91O4Sr6jZTHfsm6P0Qyv1TeN5nf0YFL8Zt6MtyZEblQY7B/f
         PhLkU+Bqm8cXcAviWQawS9uUf95+IF+T+/h7iUluhCPmoXIqsoKH7BcRZ7KgHdj9qAij
         rBAA==
X-Gm-Message-State: AOAM533bGVi5IHT/33XcXxRosfWPhHL/bmdnj2cTcJ2hr6xMy9K3No/o
        wEW7ZzOGAkdQPPnHra41vKcKHqdVFvWb0g==
X-Google-Smtp-Source: ABdhPJyAaZ0KpCbmoQ9oPOKkpTl/x1cDmxtIkoXoFZyrwaKG63HzPNRUEZA+XVgkc6frN4TCf7w7ZA==
X-Received: by 2002:a19:844b:: with SMTP id g72mr3614742lfd.7.1610648259587;
        Thu, 14 Jan 2021 10:17:39 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id h28sm617378lfk.159.2021.01.14.10.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 10:17:38 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id m25so9332416lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:17:38 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr3584520lfl.41.1610648258222;
 Thu, 14 Jan 2021 10:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20210114175934.13070-1-will@kernel.org> <20210114175934.13070-6-will@kernel.org>
In-Reply-To: <20210114175934.13070-6-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 10:17:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whA1yCmrARFQ88Af2fh+z1ufS=62eLdXgETBzfMX2bGUw@mail.gmail.com>
Message-ID: <CAHk-=whA1yCmrARFQ88Af2fh+z1ufS=62eLdXgETBzfMX2bGUw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/8] mm: Pass 'address' to map to do_set_pte() and
 drop FAULT_FLAG_PREFAULT
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:01 AM Will Deacon <will@kernel.org> wrote:
>
> Rather than modifying the 'address' field of the 'struct vm_fault_info'
> passed to do_set_pte(), leave that to identify the real faulting address
> and pass in the virtual address to be mapped by the new pte as a
> separate argument.

Ack.

In fact - apart from the question I had about the 'info' sub-structure
- ack on the whole series. But this one struck me particularly as
"that's simpler and clearer" even if that finish_fault() case is now
not as pretty (but with an unnamed structure it would be slightly
simpler, at least).

             Linus
