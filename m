Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E782E3241
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 18:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgL0RnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 12:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL0RnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 12:43:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB2C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:42:25 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o19so19429728lfo.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9PMQ/TAeRGjobkyaAFCUk6MKMTfvyJDIgZG9GbnId0=;
        b=gOMY+9UCPB4zZdpNxZuOhbzFUQzGl7lDS9CszpT+SwhotLpEvlsNbHQXlu8d/gErJR
         nc8Gc7OyxMPE+7aPZEI5iV7aVfkk4oqC2irAkQyHF7mozUzqIRKCWb748i4R0jGsh1NC
         MlzaZIk+zpGh7WYrtSu4BnfX/iYb1ooa+Q7+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9PMQ/TAeRGjobkyaAFCUk6MKMTfvyJDIgZG9GbnId0=;
        b=Y5pvBFi6gCRKFh4+ZNYeoFI1SErWn+F+bYizg2HIzOdcoxTeelHSR7jByrTad8lG5W
         nvNDQbe9ywDzdr3PolfQ7YmNXit5gnAJZxkRdgb+jONLrbArXomoOtf3VZj1nKGG9nw+
         XYitJQ3IFFPUL3FVIwBnre0MFxz+MTcXgzqvVIzF+e7R3m8nPWEbfbRJf6rC+O+zUC/4
         BtWeCTObdQgQFDPPcegqbUXeG3QkISZ0c/I//3B7i6KgIYqzpblo49zgORn1ce2Y3hEs
         0PmSU+36/SE6wRp5Lkn7umQiCcGDn4FYhUGGXFnbeqkWMHn/muZGtIMV8A8vYMOl0ZHc
         D+MQ==
X-Gm-Message-State: AOAM530YrC6o+S2h8pNV5qzIT+GtiH4eSIsr7M8RoY7FxuUVOUh38WJU
        PDOK3qtsElkOwcRUz2+95IjUACsXWZi/ZA==
X-Google-Smtp-Source: ABdhPJyy7KRI2+wWDcpP2Yhn6IIsVGm/caVCIXIaTbKBP32OxL7HUaxUGOQzl5EulPCkI/3cyF+Kig==
X-Received: by 2002:a2e:6c0f:: with SMTP id h15mr21481493ljc.305.1609090943285;
        Sun, 27 Dec 2020 09:42:23 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id f25sm5085155lfk.291.2020.12.27.09.42.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 09:42:22 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id m12so19354105lfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 09:42:22 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr18449847lfc.253.1609090942043;
 Sun, 27 Dec 2020 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20201227141638.GA11393@athena.kudzu.us> <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
In-Reply-To: <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Dec 2020 09:42:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgdcA-gADjaqp5KZChRjwKGStOo_MVEu3MSi7HiRDGS9g@mail.gmail.com>
Message-ID: <CAHk-=wgdcA-gADjaqp5KZChRjwKGStOo_MVEu3MSi7HiRDGS9g@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
To:     Jon Mason <jdmason@kudzu.us>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 9:38 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The thing is, "PTR_ERR()" works just fine on a IS_ERR_OR_NULL pointer.
> It doesn't work on a _regular_ non-NULL and non-ERR pointer, and will
> return random garbage for those. But if you've tested for
> IS_ERR_OR_NULL(), then a regular PTR_ERR() is already fine.

Side note: no, standard C does not guarantee that a NULL pointer would
cast to the integer 0 (despite a cast of the constant 0 turning into
NULL), but the kernel very much does. And our ERR_PTR() games in
particular already violate all the standard C rules, and we very much
depend on the pointer bit patterns to begin with.

             Linus
