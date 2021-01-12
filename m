Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E82F3522
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392176AbhALQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391773AbhALQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:12:42 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DA2C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:12:02 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id u7so1701446vsg.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akwWoUl9d7eg87LqFZihgtmlwoPvByeIJJP6uKXwLdE=;
        b=meGhOUgJ2QqSMK2pL9aGgXg+Z65YQt2RX0AN1oTgq7pZADjXfCnoQN3J7xPX1uwHdD
         1/0poCwYaaAhY9bkzCf3chpMOXsdWkD3gTO6rmYm8+U0DCgraCp+bLYhovtLXHMv4Gx1
         3H0eXRBTd0tubEiGe/44jVCwAjFNklPFZW0dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akwWoUl9d7eg87LqFZihgtmlwoPvByeIJJP6uKXwLdE=;
        b=pzSUiIw5Zeiarinasez5IjcfrPnt+lAWveQZ5ScTIBb7B7yzUQuzeSuZ/ISt56TiuY
         onZGDClHv51qJExWHbstRfKAtaRiYMU1awMdiAtOBHQO0k4lq8T8XwWxkHYLcpxP/mGB
         Mp5V3tcHkch4rB9ilx6NcA2VCo5A+n8745Ykm28A3cspuM4QW708i3K0wogbGys7mzpp
         x0MsMs/fC7cQ6B+//LfSu9+AH6OTGSZCSKTHUE4/biW8NKHkOkiNVvVslBepq43xqTIV
         G/ozHEVQbAPBSpsIJ8glo0VcXOMgxZzTHWuhZSu+3+pDYkwgFv8M07y/z1eP9J22HaRz
         Jtjw==
X-Gm-Message-State: AOAM533MrVERCgBRV610EG8awbT0zCAnZBqwLzHFvAEnk0l3YTRw/2BW
        TYQLX8OWPqAl9DzTPIcbJlSYSb/Jl3Fk3Q==
X-Google-Smtp-Source: ABdhPJwXvZAwaLBls4KfBCvGdXXdnmnMzs6d6IZFS08pv0CF3lvX7fD45PKnBG6k5eTApdHNRdRYhQ==
X-Received: by 2002:a67:f9d5:: with SMTP id c21mr5000051vsq.32.1610467921260;
        Tue, 12 Jan 2021 08:12:01 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id t189sm496223vkt.12.2021.01.12.08.12.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 08:12:00 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id 73so978294uac.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:12:00 -0800 (PST)
X-Received: by 2002:ab0:49e4:: with SMTP id f33mr4246266uad.0.1610467920063;
 Tue, 12 Jan 2021 08:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20201216071926.3147108-1-swboyd@chromium.org> <CAD=FV=VZ7BPw0=_3mfLYmO+kUDLbOfxy=wzH5Vnff=MiGP5oVQ@mail.gmail.com>
 <161041705349.3661239.3305335724733202161@swboyd.mtv.corp.google.com>
In-Reply-To: <161041705349.3661239.3305335724733202161@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 12 Jan 2021 08:11:48 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XULGJMiyrfME7FDsNuZJRz=JhTbtrYKH9UGiTHSKn9Ow@mail.gmail.com>
Message-ID: <CAD=FV=XULGJMiyrfME7FDsNuZJRz=JhTbtrYKH9UGiTHSKn9Ow@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: socinfo: Open read access to all for debugfs
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 11, 2021 at 6:04 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2021-01-05 15:06:35)
> > Hi,
> >
> > On Tue, Dec 15, 2020 at 11:19 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > There doesn't seem to be any reason to limit this to only root user
> > > readable. Let's make it readable by all so that random programs can
> > > read the debugfs files in here instead of just root. The information is
> > > just that, informational, so this is fine.
> > >
> > > Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  drivers/soc/qcom/socinfo.c | 40 +++++++++++++++++++-------------------
> > >  1 file changed, 20 insertions(+), 20 deletions(-)
> >
> > One worry I'd have is whether there would ever be any PII (personally
> > identifiable information) here, like maybe a chip serial number.  If
> > so, is that something that is OK to provide to any random process?
> > ...maybe I'm just being paranoid though, since presumably there are
> > enough random HW characteristics that could be strung together and
> > hashed to make roughly a unique ID anyway and hiding every HW
> > characteristic would be a bit extreme...
> >
>
> I suppose if that's a problem then the process that mounts debugfs can
> change the access to restrict it. I'm not aware of this needing to be a
> kernel policy though, so I'd rather leave that up to userspace to decide
> if it should be restricted further.

OK, fair enough.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
