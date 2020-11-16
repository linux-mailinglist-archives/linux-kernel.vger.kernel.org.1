Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C439D2B4D88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgKPRib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387499AbgKPRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:55 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF403C061A04
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:54 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so21101520ljh.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=HKbDpA8RbHc7R9WeYnYhMYC3gxw9weFs3lMu3SDaX0XkAID5B1sf9E42rWBynbT+Sx
         yT3uEIqvHZJzSY1G2ko5rQ9hLa877Siaz6/opPHEMxfi0DtcEJEuWQQNCPcD356BV5kx
         d7ODwPPcAS09cbveKqn/VdCocdxDt/vjlquyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=W8FbOdUNmjqh8cMfQPOvEoNzVGBdQpuFfODTEU7lDPvagmC1z452yLQpZkOwIC7zT1
         5YVKcb5PXZc6qEmYcI+ym6HJQRznNhOl2TH//2ADjoN/dSnhrvVIXUPUPwm4qCKLey4C
         68xF2vjDT48jr7KU3txqffeJcIrqcTkwKgR0FDtvLMHWBrxK8QUVx7MRWGLe79W/r+Wo
         jzi+0pWvtD9bW4GmrV1368a9P8SLnpCdrO2+W4iFc1eJWw7gk48+zELDQLfkth0Uk9+t
         nxWuUihPsUi0C9EvhTD6W696K6D47LwgXinfzPkCZQr8m4KGTTAKnnuSXwfZeUv3bQyy
         oSyg==
X-Gm-Message-State: AOAM532/MPIruLlSZKOmssVi6G36PUQj6eqzKDjjr6ficlLn6quv4qH0
        vQTcKjz4hnUgCobUQ8XaSPTiDDiRyDFEeA==
X-Google-Smtp-Source: ABdhPJyU7WZDteo9+BYJ3jtktAuy0e8KeMEOz51N3YLjFwiolole5i+PTvIbuIx7ANoYgvN5R5lwCg==
X-Received: by 2002:a2e:8792:: with SMTP id n18mr187534lji.57.1605548272276;
        Mon, 16 Nov 2020 09:37:52 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id r27sm676565lfn.290.2020.11.16.09.37.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:37:49 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id l10so21084960lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:48 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr153620ljo.371.1605548268341;
 Mon, 16 Nov 2020 09:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
In-Reply-To: <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 09:37:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:47 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> This discussion seems to be going down the path of requiring an IMA
> filesystem hook for reading the file, again.  That solution was
> rejected, not by me.  What is new this time?

You can't read a non-read-opened file. Not even IMA can.

So don't do that then.

IMA is doing something wrong. Why would you ever read a file that can't be read?

Fix whatever "open" function instead of trying to work around the fact
that you opened it wrong.

             Linus
