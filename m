Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64662FE0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbhAUEaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbhAUE3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:29:20 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D442DC061757;
        Wed, 20 Jan 2021 20:28:37 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id f6so435450ots.9;
        Wed, 20 Jan 2021 20:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEz/iLIdTw9v5WxUC29+q1wZ0vu+7s3YddxeSahPgM0=;
        b=DFUJkNHbazeR7OGjGEldoAx3hJrrb/8aMvXHpvsX6zSPYjQo1YvkfVAlhUjhA2+1i+
         Yw99LWlssvLnZ7JoK3YWdByLBl679kA9ALPU3U4MDc1M8dodj1Hm06fiATQrHQjuGeE1
         pbGNXX21WBBq2kh3/XW7c8FAA+NYf0jhk+oSGQxYY7tS1PZrT2PstR7GXq+a/8pyfjo/
         PF7sPxZwSQ2POTncI3sb0Ef3Bwt9Y1vo3WdTnxDIMzumkWb51r3mjastToBJnl3EF37w
         yP1eRVdaUprqvG4h5IQzoF5pI8IunB3tKA/Q5YLHHsl5yXGl9ybC7ZzMs/MgxBAbSm03
         Bdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEz/iLIdTw9v5WxUC29+q1wZ0vu+7s3YddxeSahPgM0=;
        b=gMEm6zf4M8pvEF8A9y+0v3bh0v4AC4i27wkRcFRzF7CVnWw6/LtRQENTKQiOYDMrwj
         XOt4AVZAv33kQXFNksI0Qqg/W9TB6LZsplGKj4c1w76fIh9gaF4piS2fMmAA4BhcJGy+
         TSGH8MQWpSCqPL/uuP1PdLIu2hjv7psNdmbiLirDVLPGt2oHenV/xnlb3xz01HlaHeA9
         F0cZHGVBVt8cuaAVEaOzoEetNe4760NI2ID3Xw4E+HufR9vRNrVkqfpleJLLdhna7cQL
         Phvt5M1MjRsR7ekFgymMueIaCbrgZDIfSIFLWhOe8tv0W5NaOtdXf8tBJ/2rwsZJxLUK
         ChyA==
X-Gm-Message-State: AOAM5314bokxz5UcoygFfxnfQkaZ0kBtKebM+2E2FppP9s7Nmjx/3+VQ
        Nis63JMKVNHrXhVM07oDGiK8FyEYGk+2BTkU328=
X-Google-Smtp-Source: ABdhPJyxCiEV+f+RiJbu5bYWFH5Mi6vlzsXNdJt9JvjH/4TG73sO4Nd/q0sC6TuVsDRpFmrME1l/M8WE36ThKzrww9A=
X-Received: by 2002:a9d:6f14:: with SMTP id n20mr2136998otq.285.1611203317361;
 Wed, 20 Jan 2021 20:28:37 -0800 (PST)
MIME-Version: 1.0
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
 <CAEr9=gsH2UhjMO_55FKmGKS0DYrT_-XKf0iwCKCNc93epbiXNw@mail.gmail.com> <87ft5ly5nh.fsf@kernel.org>
In-Reply-To: <87ft5ly5nh.fsf@kernel.org>
From:   Lindsey Stanpoor <lindsey.stanpoor@gmail.com>
Date:   Wed, 20 Jan 2021 20:28:26 -0800
Message-ID: <CAEr9=gsc0L=rn5YDLrArqbOMSt25HhHF7cwhp7sxdPa6-PQGpg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: usb: add rk3328 dwc3 docs
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, heiko@sntech.de, cnemo@tutanota.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 11:42 PM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Lindsey Stanpoor <lindsey.stanpoor@gmail.com> writes:
> > On Wed, Sep 2, 2020 at 11:12 AM <lindsey.stanpoor@gmail.com> wrote:
> >>
> >> From: Cameron Nemo <cnemo@tutanota.com>
> >>
> >> Document compatible for dwc3 on the Rockchip rk3328 platform.
> >
> > Hi all,
> >
> > Wanted to give this patch submission a gentle ping.
> >
> > Rob Herring acked the documentation changes, but I have not heard
> > anything
> > from the USB or Rockchip maintainers. This patchset would facilitate USB3
> > support for Rockchip rk3328 devices like the Pine Rock64.
> >
> > If there is anything I can do to help move this along, please let me know.
>
> Sorry, it had fallen through the cracks. It's now in my testing/next.

Following up on this. Will this move out of your testing/next?
--
Cameron
