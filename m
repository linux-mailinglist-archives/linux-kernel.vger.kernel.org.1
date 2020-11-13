Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1242B231C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgKMR6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKMR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:58:15 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042F8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:58:15 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id v20so11748283ljk.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30TzI7YDsCmN8GL0MEWAM7NbBmlMBsWjVdad+EUVtl0=;
        b=QxEd0Ez4KTMwpbR85OZahXBn1xU7+K+yaP6O54k7seEijrvfl0s7H1wm6TowhV1eek
         qmNWYGNHk8lXC1rS9kiQSyIdB/6qFXPr07KLxpAimCBLdTGCciYR+if2QNLyO7G2P2uF
         75pFq4edOUq9gIVs15aIa73B8cFFjiS7s5qfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30TzI7YDsCmN8GL0MEWAM7NbBmlMBsWjVdad+EUVtl0=;
        b=aUlrTZ8qqgGMp0M1jOVT8gmairlAe6wyt5MdgGcjjl53cNkvepjv1TceHSeHwc1l55
         jdjnEbqC5Flkx0eT+S+zPyuP6l1+wzzl7ph/IQ/96vXxfX+/PXAlrUc+d70JcqX4gRSp
         xBJGYj+HLPFCWmcATlGzvrqG+V/1eBOM0s/omuGsETNn2pshY9INgFKS2F5ZYQd4FA6P
         W0OFYp7MQx8B8aulNdCO4ZVajN7VXo8zapNMN11dmm8WkewQ5Ji7V+3zxo0xvSceSgZS
         KiDuSGvjrUGgsev1mItxZEwZ4501XstTehWnGof0qCVK9qKkKPqEgCyrc6TyBt2YqQJ/
         a7qQ==
X-Gm-Message-State: AOAM533aGo9tdL4PoSDEl56njE0QziF4pET5EnlYNG8PZEzJ884gYALm
        X70Q860v+IduxYGyxUdcqvj3Aw8HwfFczQ==
X-Google-Smtp-Source: ABdhPJwelzCRouudddL4A7ytIG6W4Y82654OPvJ6i+dUA0DRR+KK3StDEe0N2prO6ddi4hXhtMzNnA==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr1485582ljm.204.1605290291903;
        Fri, 13 Nov 2020 09:58:11 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n26sm1637072lfi.303.2020.11.13.09.58.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:58:11 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id r17so11754174ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:58:11 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr1438802ljo.371.1605290290132;
 Fri, 13 Nov 2020 09:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20201113082930.27da4612@oasis.local.home> <CAHk-=whO3bt9wCFX-v54RYewdAuovVEDx9DHJ0SbhrzCwY3aEA@mail.gmail.com>
 <20201113125419.3656d001@oasis.local.home>
In-Reply-To: <20201113125419.3656d001@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 09:57:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdQ8YFtxsgLx8XCqeiL-2AOoNAx2RwDFcq-C+uowbp9g@mail.gmail.com>
Message-ID: <CAHk-=wjdQ8YFtxsgLx8XCqeiL-2AOoNAx2RwDFcq-C+uowbp9g@mail.gmail.com>
Subject: Re: [GIT PULL] bootconfig: Extend the magic check range to the
 preceding 3 bytes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 9:54 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The issue is that grub padded the end of the ramdisk after loading it
> into memory. I'm not sure how the bootconfig tool can fix this. Perhaps
> make sure the ram disk size is 4 bytes aligned?

Exactly. Since - as far as I can tell - the _only_ thing that actually
generates that BOOTCONFIG_MAGIC marker is the bootconfig tool, you
control the vertical and the horizontal. No need for some "heuristic"
and searching for things.

And then that thing needs to be documented, so that if somebody else
starts generating BOOTCONFIG_MAGIC markers, we have a hard rule in
place that "look, the bootconfig is always aligned".

Might as well align it more than 4 bytes while at it and make it even stricter.

               Linus
