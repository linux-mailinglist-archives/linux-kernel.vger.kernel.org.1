Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07AA26E312
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgIQR7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgIQR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:59:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EA5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:59:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b19so2791720lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/ee+MYUELRkezGa0AUSkRTrQNoSLc8QIm1BNLJSq/s=;
        b=RLSV25HCpGRUhd6y3DrJ4YHZmVRNWzpLTarogx3oqWBFjt71dM5nd9UPnIIknkEPJD
         dz5BQOhcGH+uQVxjuEJL1U9KU+Tt7MI90t6YY5Mu9bW3+PKDrfkGMHhB8Rv695yYhFwx
         VEQdE5iC2UtXW5a2pIMCOMRcWByCtfO32odtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/ee+MYUELRkezGa0AUSkRTrQNoSLc8QIm1BNLJSq/s=;
        b=kFxgGNUhcSa6xM8/i8dP8RW6Nt6jC0un4l6k666cFUuSOq7Ii8T+Oxltas9C90ZnmK
         6FwW/qpWy+M0cV0/x/CPGdzjwhtJjvO2GaBhICEd7/pXVrza+pCNs1i+awgNyXMwRT9d
         TuS57psQDMLa2N99I1zUld3pDmDEJxbl639ifibz5SXTZF0wvR7WBCm8iYz5NWOte7eh
         5aA1eXFmyDDDQKP/UK8LEImxshoyVgrZ3A2M3A/cshaWuXSvqzq0TQNHIK4ej6gRjcZ2
         eubgFZQAZibjriPbY9m+hAx2yXAZz29zS/4e+NUcFpjfNgmUERKoRPkM6mB+pbkNvb8O
         F2hQ==
X-Gm-Message-State: AOAM533KXNryOq2n/DMEHXRoYH7MaBJy9zfC87mxCRxOPCttrTMMqpHW
        LalifMy4/xql8ZGVeuugSods70rr+enbCA==
X-Google-Smtp-Source: ABdhPJyuRtE8JkBZpy/lbIZjTu0ZWNPWB7cvKAnfnpNkSehBaRHAYz6Vs4heEZgpq3ScDr0gbXaiyw==
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr9790235ljj.227.1600365561673;
        Thu, 17 Sep 2020 10:59:21 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z28sm56420ljn.46.2020.09.17.10.59.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 10:59:17 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id y4so2805297ljk.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:59:16 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr11283202ljp.312.1600365556555;
 Thu, 17 Sep 2020 10:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200917131644.25838-1-john.ogness@linutronix.de> <20200917131644.25838-4-john.ogness@linutronix.de>
In-Reply-To: <20200917131644.25838-4-john.ogness@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 10:59:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUp2=szOdVP8A7+iG8iguNvHo4gnU6f9QBuj1hh3DBvA@mail.gmail.com>
Message-ID: <CAHk-=wiUp2=szOdVP8A7+iG8iguNvHo4gnU6f9QBuj1hh3DBvA@mail.gmail.com>
Subject: Re: [PATCH printk 3/3] printk: remove dict ring
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 6:16 AM John Ogness <john.ogness@linutronix.de> wrote:
>
> Since there is no code that will ever store anything into the dict
> ring, remove it. If any future dictionary properties are to be
> added, these should be added to the struct printk_info.

Ack. I'm very happy to see the dictionary stuff go. It was one of
those over-designed things in the printk rewrite years and years ago.

              Linus
