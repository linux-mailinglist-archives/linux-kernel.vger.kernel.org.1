Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8DE273F88
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIVKX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVKX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:23:56 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE69C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:23:55 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id u8so17433942lff.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFsyWx5+F5ciEqS9MPpeKvxqjYLpGGKF1xhv4oNr2Bk=;
        b=tRTv1EYWaO1Kbjh0reygUy+9B34CYAO66hakY6V6zrGqMG5Gue0xe2HAH5QGk8Lc5Z
         7Qde0YpSp+9nmP+oruQr2hP8OgUceiMnMhAbpT6PX18my6LaXI8e6jjxvl/9fp/Dz7h3
         QFr53cYOtMGh4CVt52CXasnQyOAW6X7d/4SlwwwK2JLHHm4LroKUBU+iMDnzBpw4cLKk
         XBD8c8qEZVpl9ng2jnCWo2qrCqJuBP/5kJr6skWbEGw01KxI/XnxTz0HVVECKtPQ4HB2
         iPtzocFIyypgeRDUP6/ve/q04tGIWutWd27y6zEfOkWXb292ozbFHRuqGYtLD4M0GXq6
         vgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFsyWx5+F5ciEqS9MPpeKvxqjYLpGGKF1xhv4oNr2Bk=;
        b=L1RV8ykhBN97FtjpdhgAWsxk8+gDBXbigM/tDThhJ43ERt+p9/76oAgu6ksB3IjnoW
         1McTwpcBwYQp3Blsy3Rw4xvExi1a69yfUxXa/Bh3eFxJSgUZRg7FwT1G45t07FMV5sPI
         nda/OXdxdqobHkcGPdIkSjWvZUJovp9loSEu5tSeXRH1js9gpaJDmjR0cFJHhOpPPyIx
         gTFSImHcaIBT5+eXhyY3gJ8pq4F+DpwAmHU3BAnNWOMyFP5NcSS2d+PnmqkKsPjst8EH
         O+yJVMcEiMw00Ga1Ct5+/HkKU13+USJJcncXImsFP5Ba/c67olb9POo60/F+FYXUwbXU
         w1yw==
X-Gm-Message-State: AOAM532Lj9pO0YRWESburGxK0JzSRA09BSdI+8NJ7jo9VC2VDzqPqBQh
        /2W4YXmg+Xj5rsp5lhBMVZsE/BwyFv76kqIj5gc=
X-Google-Smtp-Source: ABdhPJw7CGbRjeQ83rDXtxYKKoDVQp5nfUL1VgAAiodHk/W0yyowjdENUdRQex2n/PGSdkWj9ZkPN2gGt2TQ2r7CvvI=
X-Received: by 2002:a19:7e8d:: with SMTP id z135mr1527752lfc.158.1600770234227;
 Tue, 22 Sep 2020 03:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191016082430.5955-1-poeschel@lemonage.de> <20200921144645.2061313-1-poeschel@lemonage.de>
In-Reply-To: <20200921144645.2061313-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Sep 2020 12:23:43 +0200
Message-ID: <CANiq72mzgWRkstnGKNt7qwGowK3qSLKQa0jUQLAACELFvTgSxA@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] Make charlcd device independent
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Mon, Sep 21, 2020 at 4:47 PM <poeschel@lemonage.de> wrote:
>
> This tries to make charlcd device independent.

Thanks a lot for the series!

> [1] https://marc.info/?l=linux-kernel&m=157121432124507

Nit: please use lore.kernel.org and the Link: tag instead.

Cheers,
Miguel
