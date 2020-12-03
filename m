Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7417D2CDA29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgLCPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgLCPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:34:48 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151E9C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:34:08 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id q5so1478582vsg.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6bUmmhNs5Vo0iuri/gifDqZRZWxy1kGAo1J9lB1K5k=;
        b=D0ie8/h3FBLr6GsJocONE1JbQgocKTLMtMzcvLZ4m0y7cnANQLWYb2PicTVkU3CHWU
         0xhY3CUtX4DW0z+8e0aqlOnA0qQynUINmANChrlAvRpPTKilDW7S8pl1Ya7o5kR9BFVg
         gJdorF74HsyAZkpPn12nGzaqdkO24ic6ate64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6bUmmhNs5Vo0iuri/gifDqZRZWxy1kGAo1J9lB1K5k=;
        b=q3eXSwzJiYx6F2Zw3laHQpLYys7BKCedPPXZgmzYUjaVQLtcbdduETIqTWm/SmmmZt
         Q68g8TS9fZhxZG4+oCsq9vh7/Fm4DtJYZlYDgQWDNtfsHWjKB+XX/H2PwqEK9wiEZPzp
         vy16AsrboaMxOH2UoFqwTS0T8uHJyBeSAYafcRdzv0pg4ZBmnx4xh/fTsjFhnFr5yfqp
         zdGHi3hRw5Hpe0DpknDvGkX56jFjRIpoy8kzkWqfq8g/qNjmy0RiAgAATZCsBEZrfM/H
         BDVs7XHjjhGKX3hEoDABhs8UiAEAfRZI9rHXo9PRiA7TaAN3w+XvvfTnmmB5yrIU9QL5
         EuzQ==
X-Gm-Message-State: AOAM530PaoJdOpa3YTwDf+dz8LSiNBTEufW9j2r6uTbbZ185qJFZwCG5
        tYEQ+XwmEuJaX9wPiWtKTJB7BbUkRlZMSQ==
X-Google-Smtp-Source: ABdhPJzgBKsWfIPmCCBFsCdHZ61X/jIIAAGmBQiO85tWkLPNwyUgP6I9SCn9Hk+kdKB4zAQgsa7Gsw==
X-Received: by 2002:a67:cd16:: with SMTP id u22mr2725795vsl.7.1607009646748;
        Thu, 03 Dec 2020 07:34:06 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id z24sm128434uar.5.2020.12.03.07.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 07:34:05 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id b23so1440648vsp.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:34:05 -0800 (PST)
X-Received: by 2002:a67:8c41:: with SMTP id o62mr2741810vsd.49.1607009645158;
 Thu, 03 Dec 2020 07:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20201112200906.991086-1-kuabhs@chromium.org> <20201112200856.v2.1.Ia526132a366886e3b5cf72433d0d58bb7bb1be0f@changeid>
 <CAD=FV=XKCLgL6Bt+3KfqKByyP5fpwXOh6TNHXAoXkaQJRzjKjQ@mail.gmail.com>
 <002401d6c242$d78f2140$86ad63c0$@codeaurora.org> <CAD=FV=UnecON-M9eZVQePuNpdygN_E9OtLN495Xe1GL_PA94DQ@mail.gmail.com>
 <002d01d6c2dd$4386d880$ca948980$@codeaurora.org> <CAD=FV=WQPMnor3oTefDHd6JP6UmpyBo7UsOJ1Sg4Ly1otxr6hw@mail.gmail.com>
 <004301d6c968$12ef1b10$38cd5130$@codeaurora.org>
In-Reply-To: <004301d6c968$12ef1b10$38cd5130$@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Dec 2020 07:33:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VCbjRUxUsmyk=64FLDGU=W41EXh5tdfQr1Lg83T8jiEA@mail.gmail.com>
Message-ID: <CAD=FV=VCbjRUxUsmyk=64FLDGU=W41EXh5tdfQr1Lg83T8jiEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ath10k: add option for chip-id based BDF selection
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     Abhishek Kumar <kuabhs@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 3, 2020 at 3:33 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
>
> > What I'm trying to say is this.  Imagine that:
> >
> > a) the device tree has the "variant" property.
> >
> > b) the BRD file has two entries, one for "board-id" (1) and one for
> > "board-id + chip-id" (2).  It doesn't have one for "board-id + chip-id
> > + variant" (3).
> >
> > With your suggestion we'll see the "variant" property in the device
> > tree.  That means we'll search for (1) and (3).  (3) isn't there, so
> > we'll pick (1).  ...but we really should have picked (2), right?
>
> Do we expect board-2.bin to not be populated with the bdf with variant field (if its necessary ?)

The whole fact that there is a fallback to begin with implies that
there can be a mismatch between the board-2.bin and the device tree
file.  Once we accept that there can be a mismatch, it seems good to
try all 3 fallbacks in order.


> Seems fine for me, if we have 2 fallback names if that is needed.

OK, sounds good.  So hopefully Abhishek can post a v3 based on what's
in <https://crrev.com/c/2556437> and you can confirm you're good with
it there?

-Doug
