Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC52829EE8B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgJ2Omk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgJ2Omg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:42:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84CC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:42:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b8so3090346wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPw6NFmb8fLcJVP5lqOvf3z1qT6u6At9MFl+1mVTcr4=;
        b=PffPZFVsq5+Fxw6YFoSN+arrFKwsL3ZCw8i5ZB+fCUjccFIOjKssTOMKVBje4ALAxX
         TjHHoI9i2Wlb1JWSZ/aIofIzf5qJ7w8n9sw4QhGhNaMmxnbzfc1fUnTGTut6T1wI3QXp
         zaF/tzviyATa64rHxMoRA+TpDr/OdNrc6jZpJR6Ozio5v0fG1nVzbleMNhJaO+wFuNnU
         Ilxjk3/qznBbOBSb/GF8UeCPzIuu9w0SBEwXzW2OTxo/5iZGog1iXl/f8ImdzslhYmds
         39xEKLJOI5Iz4bphpeGeWeD+EDOw8hEHLaZuw9oxbpNpG/9NqlT2FcwulV8zlTbSbU+H
         PlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPw6NFmb8fLcJVP5lqOvf3z1qT6u6At9MFl+1mVTcr4=;
        b=jwuTR2YM06D+i/Y9ECLM8ipuX2SiJ7WpBNwaT+jDLP/UUL0EHbOscn5VQIrpBI4Lru
         EMVfMwvu+CMhuQT6+opO8W/oNOaUnbvbtpaX2XEDlaomieGjVAf3b0zgkvtUxK+PzVq7
         Jptb5IlqVUT8cbYsG3SUH/+Rc4vmSugfX9HCeN+kn5guU2a872zu52LHmUgV3ZSJZclj
         44T7X3inpW6OYxJDcFW6Zd0RI4AIL20kXGskrM4sSZIOaVVsTyPDpcGcBqhEblenchBu
         ew+odOGLighMmUdBRY6/t8m/lCRqlCuUdqofmMJef3m5nZG9nN/IkiXYWj0+OYc06hIt
         hsfw==
X-Gm-Message-State: AOAM532DrhP1mefX6B0Wbdamcq78UFzBBWpcLhJbH2RoOfVJxIX61W9Y
        EfJKC8XKrIEJBrglaRtdVZzECt3m2l4T1Trc+TQ9/Q==
X-Google-Smtp-Source: ABdhPJyx8OoVeVQA4V+c9XkOJaWG9rrSEmwjo721QTz3nJlHCfOnITXG0VX1t5Z/c6d365xIhg3LwA6ZSsdzQURjL6c=
X-Received: by 2002:adf:ff86:: with SMTP id j6mr6013437wrr.184.1603982526911;
 Thu, 29 Oct 2020 07:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201029142915.131752-1-ubizjak@gmail.com>
In-Reply-To: <20201029142915.131752-1-ubizjak@gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 29 Oct 2020 07:41:55 -0700
Message-ID: <CALCETrU_zdfTwOyymq+N9t99BJJyQJaUtCJ4wPxxvBC53zBabQ@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: Use TEST %reg,%reg instead of CMP $0,%reg
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 7:29 AM Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Use TEST %reg,%reg which sets the zero flag in the same way
> as CMP $0,%reg, but the encoding uses one byte less.

This will make a Linux distro fit on an embedded device that
previously had four bytes too little flash :)

Reviewed-by: Andy Lutomirski <luto@kernel.org>
