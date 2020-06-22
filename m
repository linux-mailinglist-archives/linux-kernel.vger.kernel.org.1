Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849F6203F59
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgFVSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 14:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgFVSkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:40:52 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3D472073E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592851252;
        bh=ummMjX41XB0RRf8l8TTRWyYH8+hc44L6LHZf3H73YC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wSCsG5hIV6ZBfn+dFHGxUmYzBqbWn8+GKXzmKRWdH9+v86DGH4XaiVFU9X3X6p6dG
         xWGHaj01lg2D3ch/gfC9VSizFk7D7KKXPgHl08Q1u37VZkSBr++XDiqVYPRUEe7v+3
         wgPQWM8v9Y9SDwGM+qC7fPe1OdXb+5wBa9XNjsTA=
Received: by mail-wr1-f47.google.com with SMTP id q5so5346102wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:40:51 -0700 (PDT)
X-Gm-Message-State: AOAM533LuytW24aHInfPGRQaWPOR9jBX0BxZvnRBmDCFANNvJ7ZtoGyX
        IZSyu062YdcURa2nqJ3iFYVLntHW77hUUqszldxCnw==
X-Google-Smtp-Source: ABdhPJz5M3EsisMMo/x090Cfd0ALE75dfYWGHpWLEOo1QV5wAcPSmZiCEsS/+gxuCYK8WO72MQWuSswYv/WPuWAeYCk=
X-Received: by 2002:a5d:6acf:: with SMTP id u15mr19669170wrw.18.1592851250402;
 Mon, 22 Jun 2020 11:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200619174127.22304-1-bp@alien8.de> <20200619174127.22304-2-bp@alien8.de>
 <CALCETrXZhFJGJA2h4zP743KYTtni-rQSUME8mtSYUdk1-ZTauQ@mail.gmail.com>
 <20200622170908.GH32200@zn.tnic> <CALCETrU0C5yVwfAOj+v1RqNBZY+phXrdvCBZMKdOXOExBgMbVg@mail.gmail.com>
 <ef327682-7e9f-5652-1664-3e201ac38f60@intel.com>
In-Reply-To: <ef327682-7e9f-5652-1664-3e201ac38f60@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 22 Jun 2020 11:40:38 -0700
X-Gmail-Original-Message-ID: <CALCETrUT1_WVjMbPZhUcX9sjFvLBZKCc2fxeJJsD940k1Ajyrw@mail.gmail.com>
Message-ID: <CALCETrUT1_WVjMbPZhUcX9sjFvLBZKCc2fxeJJsD940k1Ajyrw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/fpu: Reset MXCSR to default in kernel_fpu_begin()
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:38 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 6/22/20 11:33 AM, Andy Lutomirski wrote:
> > Suppose you do:
> >
> > double x = 1.0;
> >
> > kernel_fpu_begin();
> >
> > x += 2.0;
> >
> > We want to make sure that GCC puts things in the right order.  I
> > suppose that even a memory clobber is insufficient here, though.
>
> Even with CONFIG_PREEMPT disabled, we still have:
>
>         #define preempt_disable()                       barrier()
>
> I don't see us supporting preemptible kernel_fpu regions any time soon,
> so shouldn't this be sufficient now and for a long time?

That's on the wrong end of the function.  It'sL

preempt_disable();
LDMXCSR;
<-- some kind of barrier here might be nice

--Andy
