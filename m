Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39282AF32C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKKNfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKKNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:48 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2741DC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:34:48 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id v143so1621773qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcK0lBgrxsMXLlLrogxS0dLfs0KKEis5xHufU2EfuSg=;
        b=UMQZhwSpg6RfDxD9TLt1RxB4DutSWx+EGxr81T/wQSAYx12YfCpsrSVaxgg4PqNdnp
         aheCGVTNW539RBDiyzbNkGkxyBhSFP3uuRXihTEQgZtd/YWNiYfSbFxdnSpxehOA5JGY
         c7+wO56I26cyq4EAoj6mNnmMqXTZdgq6ThiwwAdyU1+cU2VJdBSh16NSJr1y99v0Sf4N
         OgDEi8Fjai5v5jRUqDlHomyKdqyLLSXYiq3tr84jVAXOmCINnJecl5jXn9XH3ihJDJfZ
         BYayVkCIp1emb8Ku5RDy3+8jt3bzwqF/clP1PLIoEny7QMzh9wUM7mnyYhqBBakcMFep
         8WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcK0lBgrxsMXLlLrogxS0dLfs0KKEis5xHufU2EfuSg=;
        b=nmL3iiUGvUKp+IsWAlzij2aiUJ3JoBvC95KOM+JBKl8QlGzJX8R98Dv6/ObBdPOCyr
         JCDawGzZ5Gkuef2VGsbtIJVN+gk3+SF3O9e9IjR06tsr/Y08D8WT79kTeY2dutVRvVHf
         KgoaM6iYO7VIczGDbUQRFvHlCcX18Xkax6ZQVVgELSHIf7ii6JPMdHYxnceU1G+qBQK6
         //r0mmU4pyoowa7Ow/skvzfmn3Nns+9RQucn+krDQVCupw0crVFCk0Xj9TVxILkvvs6z
         PFzOzwCmDoREXhwCQoBEX+orYFPIC127o8jkHna7MUF0+ieoFChJ45194f9BVSarEOm2
         wpmA==
X-Gm-Message-State: AOAM532FMTlmJkIdxDq8W//2wR7X+iQyxyz1VL0xJBwP8Qo6DkVYPRKI
        N0dQF6X1TQworI4FyS09VIQZ4i1zBO1dR7Mnj8k3ryr3A3MMLVzJ
X-Google-Smtp-Source: ABdhPJzRHIW1FWHC4Jc2zUU1Ni8snHWwQ2soJfjrsiBYp7ZSUB/UsO2vep2oShG9dQ77+Czh8p0c5ohQXkZVsHeEUOk=
X-Received: by 2002:a37:6b07:: with SMTP id g7mr25402721qkc.265.1605101687164;
 Wed, 11 Nov 2020 05:34:47 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a6f2030598bbe38c@google.com> <0000000000004162e805a190c456@google.com>
In-Reply-To: <0000000000004162e805a190c456@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Nov 2020 14:34:36 +0100
Message-ID: <CACT4Y+aH=eGwrJba6bbRPeZ5CfEwu0Ex2b6V2VkuM-58h8F9bw@mail.gmail.com>
Subject: Re: WARNING in wp_page_copy
To:     syzbot <syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 3:47 AM syzbot
<syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this bug was fixed by commit:
>
> commit c3e5ea6ee574ae5e845a40ac8198de1fb63bb3ab
> Author: Kirill A. Shutemov <kirill@shutemov.name>
> Date:   Fri Mar 6 06:28:32 2020 +0000
>
>     mm: avoid data corruption on CoW fault into PFN-mapped VMA
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1170c813e00000
> start commit:   e31736d9 Merge tag 'nios2-v5.5-rc2' of git://git.kernel.or..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
> dashboard link: https://syzkaller.appspot.com/bug?extid=9301f2f33873407d5b33
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fd9fb1e00000
>
> If the result looks correct, please mark the bug fixed by replying with:
>
> #syz fix: mm: avoid data corruption on CoW fault into PFN-mapped VMA
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: mm: avoid data corruption on CoW fault into PFN-mapped VMA
