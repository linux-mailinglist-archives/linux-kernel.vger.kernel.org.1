Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0BA2A378E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKCAQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKCAQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:16:26 -0500
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F190FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:16:25 -0800 (PST)
Received: by mail-ua1-x941.google.com with SMTP id p12so2024024uam.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p7j2MkqbzfmNDffUUJc2UA/rAd92pXTAvHkKX+n2Ey0=;
        b=kSydRRrNnUb20Ij+6fkK3MbRCz5KLiSa0VZqCZtc+WNLyQf/+BUD3QYq9V0bXFh7l2
         sQemKcpvArm+0zAmqI9hD1Z0ZJsZIdh2WO6Weucj/evPtWOjZNAhJjpHg29trekQqWXN
         vIzoI/n6ew5YlKlM68cPh+TdcsN3T/lelf++I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p7j2MkqbzfmNDffUUJc2UA/rAd92pXTAvHkKX+n2Ey0=;
        b=eiWdYLBsOJAqJ+ZxGwdjMI8ec2g6m61pQG6iUWThns1MTKvxgR9oWx3Z7MFsDFNLKL
         JCGMALT74O/dPgKEFPVU+N+7ozF8+gSLDWSk3pjEKbdLV170Yq0K7wACmx4q5G4by+Lm
         ZjRpdqzYYVCw8rpqBUfJd5/ads/tZSrnGM1D8+wAr2ka9rAyNwzEohCF4UACAV17DAev
         8DzDSPO+lkvA/LFZL6v+vIzKw7vQeUbvYII7ghOWo5ETMvn/Iwv40mt1xtQ8VMdHm34K
         l1gbNAzEJND6ru4q7TthT7j8Uz2TS3/gOAk+kVhoH76clMNmcnE+eNW8GKxmw+EJLK9g
         HWGA==
X-Gm-Message-State: AOAM533NLv0+BANXhB5ritHkDKbHVtB4vbPB7o9AKWZ5A0kRCpPDcZoV
        MK+lYCvaCvpFnWjxprxgXM53JMMqthRdJg==
X-Google-Smtp-Source: ABdhPJyS3zaZaMxmkG18zQnEeoKZt+Dt8VD+hN2KPjd+gcMsXYNby/6DhAn855YcDA3Mwtv556l+6w==
X-Received: by 2002:ab0:31:: with SMTP id 46mr8820920uai.131.1604362584385;
        Mon, 02 Nov 2020 16:16:24 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id u203sm1999829vkb.34.2020.11.02.16.16.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 16:16:22 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id f15so4496421uaq.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:16:22 -0800 (PST)
X-Received: by 2002:a9f:2f15:: with SMTP id x21mr9142861uaj.104.1604362582272;
 Mon, 02 Nov 2020 16:16:22 -0800 (PST)
MIME-Version: 1.0
References: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
 <20201030164743.GA3967106@bogus>
In-Reply-To: <20201030164743.GA3967106@bogus>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Nov 2020 16:16:04 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UoDUVyUakJGL=Pmedjj7DFexbi=WHeEkkD9XNhay64JQ@mail.gmail.com>
Message-ID: <CAD=FV=UoDUVyUakJGL=Pmedjj7DFexbi=WHeEkkD9XNhay64JQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: HID: i2c-hid: Label this binding as deprecated
To:     Rob Herring <robh@kernel.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-input@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 30, 2020 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 23, 2020 at 04:22:52PM -0700, Douglas Anderson wrote:
> > As pointed out by Rob Herring [1], we should have a device-specific
> > compatible string.  This means people shouldn't be using the
> > "i2c-over-hid" compatible string anymore, or at least not without a
> > more specific compatible string before it.  Specifically:
> >
> > 1. For newly added devices we should just have the device-specific
> >    device string (no "hid-over-i2c" fallback) and infer the timings
> >    and hid-descr-addr from there.
>
> I wouldn't go that far. Having a fallback is perfectly acceptible. And
> hopefully there are at least some devices where that's good enough for
> drivers to use.
>
> If we have cases of only 'i2c-over-hid' being used (in DT), then the
> solution is making this a schema so we can enforce that as not valid.

OK, fair enough.  I think in the case of the Goodix touchscreen I'm
trying to support, though, it's not useful to have the fallback since
it really doesn't seem to work without all the delays.  :(  I sent my
v3 without touching anything about "i2c-over-hid" as far as bindings
goes.

For my edification, though, when do you believe "i2c-over-hid" should
be the fallback?  Presumably you would advocate for
"post-power-on-delay-ms" being marked as deprecated, right?  That
should have been inferred by the compatible string, right?  So, in
theory, anyone who needed this delay couldn't have ever taken
advantage of the fallback, right?  They wouldn't have worked without
the delay?

-Doug
