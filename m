Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD8224F37
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 06:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgGSEiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 00:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGSEiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 00:38:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA87CC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:38:50 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 6so10696468qtt.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 21:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yAx2E6TAzpz5oRPn5T0P4uA7F5EuVFuWjvlUrLLvtHo=;
        b=vU5NLvRtPUVE3+b3+aPEUHZklwwd0heHUOdCDjZO6wbac7sHSWaWd7UcW31CxoE44U
         XeT9tYvehGKaEzy9oCjGJz1Uuq2w+r5pMhCq+E13VBp8mREAv5mdu3bSF59RHnMmyMNi
         H0JdwD2FI7Tyql0GXZFAdfqGbxnV3wgLgYWS93qrnYFMfwj0bi1BmU+NvHrFgnGm6wLU
         f/KD3kW7gEMbNNNpU62U0T8VroTnivWr5zFZ0K1JGXSYQTg85CBC7PyS78p0DjhmOfDw
         lp5AlKKU8yWEv0FlfhJYbOsEOgOXx8WBYUq0KQES5rl+Ic6hwFbAJNlfV0KIcR2JZnwh
         bJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yAx2E6TAzpz5oRPn5T0P4uA7F5EuVFuWjvlUrLLvtHo=;
        b=FK3Aatiix0dgoXMnY8K+DTZIOrP9iou4IpfGGwYHGOQBavk1bwJhZiSKg4cklBnPMU
         vuo5vqgxvvnDZuKL2PXvn5Q9TOl8Ah7Aibdwofk4xTVTLJV2sFetiaKtBoh+8XgNS/sr
         eb/PLuLjfCLTaOBbG5sa1XkKizQbq/HCXeKa2B/1CaIv/Qm9KSM1GWZ6GL55cnY2zpiR
         hXV0uM0pxk76KHgZ/yz+fhuYNsHv9olLmbU6dnK00kwAxFWxIw1bitOVCCvGZ1mwW34U
         aOBcc7xPXtsRbVWdtnePAwIxfPBHl+2gXs3LW1tr/zYvc+1tOkx4hk56bg2vaO/gmUWy
         YB0A==
X-Gm-Message-State: AOAM5319LyLgdN3YpBRi64WAMyH3KSmPDkkN7nYDSgmqOwaW6YoWDuze
        NtCeCm6eSUici3MttNXmmod8wbzOrOkbF98UwayBRpw8hNc=
X-Google-Smtp-Source: ABdhPJxhqTv063uzYwPJiyg2CRE5CjQd12Z6JPwG9w2xpqQ586uYpaJ+ybIzEklIj8m6KLE/iO1rr4ebc0hl6rqIDv8=
X-Received: by 2002:aed:2e07:: with SMTP id j7mr18568391qtd.338.1595133529773;
 Sat, 18 Jul 2020 21:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6bGBbN=EiJxO9Fq9HqLz6F=hSQqjKms_G6qPHzbZ6G3zg@mail.gmail.com>
 <20200701105824.GB2098169@kroah.com>
In-Reply-To: <20200701105824.GB2098169@kroah.com>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Sun, 19 Jul 2020 12:38:38 +0800
Message-ID: <CAAvDm6a_7YutbOjkx55dWacH7TRpumZL5ZB_rzXc5d8nSus28A@mail.gmail.com>
Subject: Re: Are there some potentially serious problems that I should be
 aware of if I totally disable the CONFIG_ACPI option on the X86_64 platform?
To:     Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>
Cc:     kernelnewbies <Kernelnewbies@kernelnewbies.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg KH
>Yes, your ACPI-based system will not boot.
Do you mean the OS will not boot or some of the Linux subsystems(i.e.
USB PCI etc) will not boot?

Thank you for your attention to this matter.
On Wed, Jul 1, 2020 at 6:58 PM Greg KH <greg@kroah.com> wrote:
>
> On Wed, Jul 01, 2020 at 05:15:52PM +0800, =E5=AD=99=E4=B8=96=E9=BE=99 sun=
shilong wrote:
> > Hi, list
> >
> > Are there some potentially serious problems that I should be aware of
> > if I totally disable the CONFIG_ACPI option on the X86_64 platform?
>
> Yes, your ACPI-based system will not boot.
>
> > Would it do harm to the hardware?
>
> It might, try it and see :)
>
> good luck!!!
>
> greg k-h
