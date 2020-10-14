Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC2528EA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388121AbgJOBei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbgJOBeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:34:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6FEC051127
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:05:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d24so1306569lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlFvy8eyL04DCdB/CZCNzYgQ2J2bwqnrawGVF61K2Q4=;
        b=T4nkPbcrfWVzlUXPa2RR1CJimGsiGY65KGzNi9VNP62ZmKbMbTcQk0jIvKba4mQWTj
         Ql2R8WvQdFrPo1ebURmmR+z4SRbFVplsZde363RW7Z/ZsuQgnaSQ9O2JbS+GUN+LzQRD
         3lLLweu8MvSfGCWs26YQ2AN9k47D9sYkCWPjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlFvy8eyL04DCdB/CZCNzYgQ2J2bwqnrawGVF61K2Q4=;
        b=nh4LGJr7OT0e26kYF0KHX35N9OxnvRKp8Nvj2r1x9/q+67Jnv4qMEypDcmJkj1cYcx
         w0XyxmqVPAohHAbEZHcQyCFd5ENiN0Q5img0JRAbPbDuQhCoOfqvHRA8pLXFUoZEAqJ9
         BO4KyjYC4v1gjPdiOYJtqKVUXIncpSStkIOAM5FzEaAfonkNhQ/8sjneC6HmJ1MaKd8H
         4rD5GHeLe/tqeb875+ngG5i7d6Vw7UiUwE9I9gnwRYG2RFJ48pWlIc+Au7EY997HjoMu
         rmHbndRgkrhm4nQEKWd1EZaOsrL+qWBfAkaCsh9Id49smnZVHl109AI0RNhPU71i8REc
         xneQ==
X-Gm-Message-State: AOAM533YsaSLN/2GoBXS9UK/rjl0V1PkkWvGpQK0D3VoWHnsvne02oRj
        BHNWEjpfYB8FVpPzuoYaGH+tfRGgCP2glg==
X-Google-Smtp-Source: ABdhPJxZLHhRzxsNHqNFNkfgtygHbjVqpPFyxfgnUk4C1F2fGA2QN6BrB0VniTCvL9Y5c1nrEW4JMQ==
X-Received: by 2002:ac2:41cc:: with SMTP id d12mr124235lfi.178.1602716743056;
        Wed, 14 Oct 2020 16:05:43 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i63sm270917lfi.53.2020.10.14.16.05.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 16:05:42 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id m20so1166946ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 16:05:42 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr173561ljh.312.1602716741597;
 Wed, 14 Oct 2020 16:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201014222650.GA390346@zx2c4.com> <20201014230209.427011-1-Jason@zx2c4.com>
In-Reply-To: <20201014230209.427011-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 14 Oct 2020 16:05:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgDWFJiioE+C=_JOQvEtcw3CVXPq7wDGHDhV8hFrFCnw@mail.gmail.com>
Message-ID: <CAHk-=whgDWFJiioE+C=_JOQvEtcw3CVXPq7wDGHDhV8hFrFCnw@mail.gmail.com>
Subject: Re: [PATCH] powerpc32: don't adjust unmoved stack pointer in
 csum_partial_copy_generic() epilogue
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks - applied and pushed out.

             Linus
