Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5422B9962
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgKSRhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgKSRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:37:08 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2025CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:37:08 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so7166671ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWEVN098FpZJFcAmKY11I26ZadR0uReqN/JRZh6yv1g=;
        b=KqRYM6qvFzlj4whHg0wPUzefb/Tt/+dAVF70kktIo+tJZZh5X1F/kXlctUDU74ROhm
         ydrBhKXfT+AawsD7xzm48LfuqXJ0cGbrdZu7ibL6Rh/C60eTsOVtdcLOGlTSlgNECPSW
         DbXXj1j+AT2dxH3MRfRYkWW13fPRd1hqoxEsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWEVN098FpZJFcAmKY11I26ZadR0uReqN/JRZh6yv1g=;
        b=cTcVj62HA24eIt2QMLWg7oDDoDIpWMvSfUYvshZ2bM53TyKd3h0SRvF1BvGMlVlZFR
         KHJYTlYUKqo6n2CwKQ+BKlrWpcvMXr0EA7B4sxzmXwfEKwQKF/d0JBXvZOhzgLmt79/A
         QFSUD52vyJlH+l7emioMQcNt8UqQ5QjUJgTbGmzIkKH8Hlj1hVvSKWrvgP9zXHPNw9d9
         qFOGaijQ0kQh3W5e/L9wa/hFW94vv2uBsP/I2JNlIglPkQerx2Mv3nsyzzZmdIHGLBzu
         lqviBHwBlZ0Y86LdRzysajg+wZEhjYlnuXbrPcGyG1AfJ44LGj98WiIiUfUQwAwgPolJ
         MfmA==
X-Gm-Message-State: AOAM531XbTaNkxO90wp03nGOzTrU4a8vi5M+D0nW8D/S+kNvMfQlm5Hk
        LS3XzFuI8Es9yw4VtMo4r6J/bP5fK4F57Q==
X-Google-Smtp-Source: ABdhPJyF7KiNgB7OVli6Z0Jf1Ygip6aJxmLlh5VIUQl9WR6rI12S/BuHkSMkQ80HtdO0Y5eO6MkQyA==
X-Received: by 2002:a2e:7a0d:: with SMTP id v13mr6674026ljc.348.1605807426291;
        Thu, 19 Nov 2020 09:37:06 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id j22sm21564ljb.5.2020.11.19.09.37.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:37:03 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id v144so9391370lfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:37:03 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr7079601lfd.603.1605807422828;
 Thu, 19 Nov 2020 09:37:02 -0800 (PST)
MIME-Version: 1.0
References: <160579629161.503380.9118263439060046721.stgit@devnote2>
In-Reply-To: <160579629161.503380.9118263439060046721.stgit@devnote2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Nov 2020 09:36:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com>
Message-ID: <CAHk-=wi9RedSQoGF06dVs2mp7tBp4QoiW8+XZzNcDFJr3Zo5gg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] bootconfig: Use hexadecimal ASCII string for size
 and checksum
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 6:31 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Here is a seires of patches to change the bootconfig footer format
> to use 8-bytes hexadecimal ASCII string for size and checksum instead
> of u32.

Ugh.,

Just make it little-endian only.

The _worst_ thing to do is to make it some kind of "native-endian",
because then you have to deal with cross building issues etc.

But using a __le32 type and just doing "le32_to_cpu()" is trivial and
optimal - not just because everybody relevant is LE anyway, but simply
because even if you _aren't_ LE, an unconditional byte swap is better
than a conditional native access.

           Linus
