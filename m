Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ECC1BC427
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgD1Pxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 11:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728083AbgD1Pxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:53:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F23C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:53:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so22017103lje.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q096cfWzKfhRoQY6yVeooYdgz5eJpNiXcAOLwCb6KyU=;
        b=Yzx06nnuUmM+GAk8GeeXeouPCL1sKYw7yWl0m9ix8MeW/DAQk5QAxJcrFdPYvhNNJk
         JP7NUXrtNV4ES4rhsEUYPBzKTwX+0hr+GlHPsvLa2HdpK8y6zH60c8lB+yzg5Pjyv9uq
         /bQD3sV6hCA4ZIyegnMj/vADCwCM3KxYGReYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q096cfWzKfhRoQY6yVeooYdgz5eJpNiXcAOLwCb6KyU=;
        b=dCcobLf7/GsSETNtlcbOY8RdgB3gk8mKKtBciuZXKHA8Vd/FJKydgdx73Du/LMgEGJ
         fT0VWNkExvsXLITOMJVnJEaA2rtWsdezCdWGAMnnrWxYZUED0O9AS5TsgDdtjNbRKxwi
         /B6cr2VToEdhkZPpguKb8UaKEcvyVYiQp30TPkxxzOwalebF7uaxRfkAWJBqqrPgkEIh
         N1+emmmR2uIJJVGZfkaSaVEcSeLbCfZ7+h598TVESs4ZuEGcKjjauyYcXg11Qe2i859Z
         Swig0k3MR6xKaw351m34SRIytb0MCF2ej2G3W5lw2CKcFCzU5ZuAXKca6hP4CML2TKrt
         X+CQ==
X-Gm-Message-State: AGi0Pubg3wPHmlNEB7gu6r1uoZa7PR+zlsl44HCdhxetEu5k9/2Tk96r
        7S5rZdLcXN+qCXSzO9aXWrmC8TDZJ94=
X-Google-Smtp-Source: APiQypKMZIT//HFJnd2AQAuzNcj89rwpvg6NACqanGK3BGH8tFmfnph20qwVrMoYmbwDGAffeFL5+g==
X-Received: by 2002:a2e:7e0b:: with SMTP id z11mr17500836ljc.284.1588089232692;
        Tue, 28 Apr 2020 08:53:52 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id y8sm12889728ljh.83.2020.04.28.08.53.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 08:53:51 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id g4so22049681ljl.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:53:51 -0700 (PDT)
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr18195660ljl.3.1588089230946;
 Tue, 28 Apr 2020 08:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200427145537.1.Ic8f898e0147beeee2c005ee7b20f1aebdef1e7eb@changeid>
 <20200428011134.GV125362@dtor-ws>
In-Reply-To: <20200428011134.GV125362@dtor-ws>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 28 Apr 2020 08:53:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft7k4Ps=UXONw=usOmN8anfcvNgpkNmeKwVc1Uh6bDR-YQ@mail.gmail.com>
Message-ID: <CAE=gft7k4Ps=UXONw=usOmN8anfcvNgpkNmeKwVc1Uh6bDR-YQ@mail.gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4 - Really fix attn_data use-after-free
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     stable@vger.kernel.org,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Duggan <aduggan@synaptics.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 6:11 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Mon, Apr 27, 2020 at 02:55:48PM -0700, Evan Green wrote:
> > Fix a use-after-free noticed by running with KASAN enabled. If
> > rmi_irq_fn() is run twice in a row, then rmi_f11_attention() (among
> > others) will end up reading from drvdata->attn_data.data, which was
> > freed and left dangling in rmi_irq_fn().
> >
> > Commit 55edde9fff1a ("Input: synaptics-rmi4 - prevent UAF reported by
> > KASAN") correctly identified and analyzed this bug. However the attempted
> > fix only NULLed out a local variable, missing the fact that
> > drvdata->attn_data is a struct, not a pointer.
> >
> > NULL out the correct pointer in the driver data to prevent the attention
> > functions from copying from it.
> >
> > Fixes: 55edde9fff1a ("Input: synaptics-rmi4 - prevent UAF reported by KASAN")
> > Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> >
> > Cc: stable@vger.kernel.org
> > Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
>
> Ugh, this is all kind of ugly, but I guess that's what we have now.
> Applied, thank you.

Thanks Dmitry. There are other bits that sketch me out in here as
well, but I didn't get a chance to really figure out if they're a
problem. We call rmi_process_interrupt_requests(), which results in
reads from that same attn_data.data pointer, in a few different
places. Some of those calls are outside the irq handling path, like
the in rmi_enable_irq() and rmi_enable_sensor(). Can they race with
the irq handling path? (Meaning they'd be doing those attn_data.data
reads as rmi_irq_fn() is kfreeing the data?) There are a smattering of
mutexes around, but I'm not sure if they're trying to protect this.

If I can find some time I'll try to submit a patch. Anyone is welcome
to beat me to it though.
-Evan
