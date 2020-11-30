Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E935A2C8DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgK3TR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgK3TRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:17:17 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846B4C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:16:37 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id x4so437699vsp.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIA2xSxWfK7qGlR97h+CAw+iLvktcG9rcuMRTWU8G3M=;
        b=RfZpv4GzuYmMmrmWQkvQMiqwCENZoVj/HZBhEzAB9B7fxWfwEkvBS2K5PMzqT2dgKu
         pyW00MjWd2I5uZikP1HdwC2rEbJxgLkNP1go2H5SfcP6mF/hwIVARwrxnfi4nTqFhifx
         U1gU2gH6wSwhq7l6FFGmz6VyvPpHRKMy3TXES3mIrAGrdWvdFpLD708BtUn2TVgHXvyh
         x20nOiGWARWN3g8n1EhiGMF4e/kIOMVMVOcmVuozzI5xFzUj4vYrfU4DxUquhiYF3u1u
         UJNNR1gpIraj+cN1YXMIT9PPh7DxdKSpeKeERKl07Xpg7USLvthedLQVJGrAv3oI0gb8
         /RPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIA2xSxWfK7qGlR97h+CAw+iLvktcG9rcuMRTWU8G3M=;
        b=nU0Qo/KCL+uepsJ3SoP7aXu/1OpCIt4FLcp5Q+gV/EwGbgjmNEyEVFD+6F0jAP8+VZ
         j+tCEVsmGTblvRc1Q6Dz9JpjAUgxcDR5yAx/Lx0tCOQGi4czEQUoRij+FUo3fXJRH8sL
         hOBglyqA4mTmuhtKa9ChJpdFvxxE2qnziIvgHSc4hVE4UJnH9a5KckydQznOk0Q6V2qY
         yRb9GmeHjZ6h7EiQAkw7BNmrqsjVxL458BC2Pofqbyvx80Q5GbHjDW6nubg++wGWLUij
         baVgZIeauLCE3J8/VDmYSC2MvWPfFrfTJKS3mqvCUUN8j7YVKQN0vmvjtl0039wiWfOy
         ku9Q==
X-Gm-Message-State: AOAM531LPBdJmd6DKOWBWT1ZKmN/ILtkXwcUKrLyhuJ0teWMV6wfDGqd
        nbKyjcqiilSElaem07949aB52fNfvALeTmSzJqibCQ==
X-Google-Smtp-Source: ABdhPJxLORQWtYwsk+RXtxwhyBODAfSUw8KimDXnghg0vdEjxdjJIhECa4FXBlgk9ZpxYydapDPZb45lqH60hHHN6IM=
X-Received: by 2002:a67:80c8:: with SMTP id b191mr8758903vsd.36.1606763796133;
 Mon, 30 Nov 2020 11:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20201113182654.967462-1-samitolvanen@google.com> <20201127121526.GC13163@zn.tnic>
In-Reply-To: <20201127121526.GC13163@zn.tnic>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 30 Nov 2020 11:16:24 -0800
Message-ID: <CABCJKucov9YMHn+QD8f-qk2=Oxh=j=DdZJcwHynTefY=zy03aw@mail.gmail.com>
Subject: Re: [PATCH] x86/e820: fix the function type for e820__mapped_all
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 4:15 AM Borislav Petkov <bp@alien8.de> wrote:
> I think the proper fix is to fix the typedef to:
>
>         typedef bool (*check_reserved_t)(u64 start, u64 end, enum e820_type type);
>
> because
>
> * is_mmconf_reserved() is passing in E820_TYPE_RESERVED which is enum e820_type
>
> * is_acpi_reserved() is the other check_reserved_t function ptr and the last arg
> type there is unused so it can just as well be enum e820_type.

Sure, sounds good. I'll send out v3 to change the type argument to
enum e820_type.

Sami
