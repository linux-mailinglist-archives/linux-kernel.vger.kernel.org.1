Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43912E02D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 00:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgLUXOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 18:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLUXOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 18:14:16 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E7C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:13:35 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so27577813lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f06zvCtNpwfTL+4Itq4rCpQRN53L0BPN7ECqHQNOVpQ=;
        b=YPEH2Xb2Ow8JmzRAuCKa272elvNzGdaJcJVbXOAswsyaU1vW/qvS3mZEvPQgkSsF4g
         3oN6qkAJWfGl+PmPsyxxPFKtVeKvVltnzERL2UIJN2ckt8Aovs/Zb9VTbJx3IX+lOwGm
         SPwiI22Arin2BcxLEmElXrQkTZ3/UHRfgC5iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f06zvCtNpwfTL+4Itq4rCpQRN53L0BPN7ECqHQNOVpQ=;
        b=FEH6XEFCTdmeRhFz3on7xfhVGr1363pCRBbrpQRUsaYmV7DQ9jrkQlL6nLGlr+ZY84
         fYLo72xv2SNoGbRzQk3OmO+4s4qOKcfhI2W8Z5bfDGirTALK4G0yHuLlMDEVdPYkef4O
         dfMN8sEd6WYjlNQePIs27jEM77tcHGbXGk+PR41jrlUUE3Lkn6iUIjVr+7//1vEoFq7V
         Pn2qE3NMRjCqp0qvYgbubuUF46dCwJEqgl357vh/MsgjTdCyiKcFMlepT95E73Pq4WzF
         CZS04Ek2uhbBb7SxZF/z0wi+nJdXE23leJ672/ZrCm4Z2EMD71cqtK4zaEGO2Bk8kckb
         bHIw==
X-Gm-Message-State: AOAM533MzoTAqxHNgbim/imuG0DajBeyXbNpt0n1WYsjfWb0rkGywkZQ
        c58c7v2uzmyzy7ymuG63J0LVSCuY4am9ug==
X-Google-Smtp-Source: ABdhPJyzKMtpe/bPsWcpBqmuqJDmhXcwUQtr5+x7ggqq6kwxxvrVIfxdj6EECVIlmoLgRfMfF3axNA==
X-Received: by 2002:a19:4191:: with SMTP id o139mr7569047lfa.224.1608592413128;
        Mon, 21 Dec 2020 15:13:33 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id f3sm2467003ljn.129.2020.12.21.15.13.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 15:13:31 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id m12so27626576lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:13:31 -0800 (PST)
X-Received: by 2002:a2e:3211:: with SMTP id y17mr8114725ljy.61.1608592410631;
 Mon, 21 Dec 2020 15:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20201219043006.2206347-1-namit@vmware.com> <X95RRZ3hkebEmmaj@redhat.com>
 <EDC00345-B46E-4396-8379-98E943723809@gmail.com> <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com> <20201221172711.GE6640@xz-x1>
 <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com> <X+D0hTZCrWS3P5Pi@google.com>
 <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com> <20201221215526.GK6640@xz-x1>
In-Reply-To: <20201221215526.GK6640@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 15:13:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSeNSeT44BZpZoQu+nFjDHVCy2t0kKMjkXnBfLOaPGLg@mail.gmail.com>
Message-ID: <CAHk-=wjSeNSeT44BZpZoQu+nFjDHVCy2t0kKMjkXnBfLOaPGLg@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Yu Zhao <yuzhao@google.com>,
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

On Mon, Dec 21, 2020 at 1:55 PM Peter Xu <peterx@redhat.com> wrote:
>
> Frankly speaking I don't know why it's always safe to do data copy without the
> pgtable lock in wp_page_copy(), since I don't know what guaranteed us from data
> changing on the original page due to any reason.

So the reason it should be safe is that

 (a) the pte is write-protected

 (b) we're clearly not a shared mapping, so that if anybody else
writes to the page in another mapping, that's irrelevant (think of it
as "page copy happened earlier")

 (c) before we install the copied page, we check that nothing changed
our initial assumption in (a).

And the problem is that userfaultfd basically can cause that (c) phase to fail.

                Linus
