Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361932A37A2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgKCAS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCAS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:18:28 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06A9C061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 16:18:28 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id y1so4485979uac.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5EWBdWu8UMzj2fy/b6+R99bCZwb5PgoyCKlY/KWrK8=;
        b=GyELAh8UJAQ9j8T5R7lfyyPpYgOuleQHhkDVSzcdBjfMkVX+fb93Ww39Y+F7Z50iJa
         U99tzTx9J/3Wnk9U9gYevwzBjmRn0nn2Ld//0+WnA2lH8Em3PHSYtzIn15UUwpvgIF6T
         L0IdmplbDcEThNJBDqHEr97EUeUQ6iCkzk4cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5EWBdWu8UMzj2fy/b6+R99bCZwb5PgoyCKlY/KWrK8=;
        b=MK2v8ySotFU8358RlgWjKji57t1Ptm+HwRLyo3OCfqHMQbRdcGxOSB2eQIaTzzElMm
         SiKzCRk2dN1JWoBMJMbmciOuTlKft/vtwhMfF14zZtzpsRwc725F7JvfXMKYWnpUWznY
         CChbEoWAj9ho4wLS855H6memazsextDkxgvAohs+93XsF1xkHt2w5ckIJLd0rc1qrWr0
         fsekzk/Mhoxt2wsgwhqmdUFpUqykmKau9DDeFU8eIPWyxiCeetcUpk4BaetpJvPt8OLl
         tCshGWoFCo6CDZiuQ6T3SltAHzXA5Ubyu+u+tpyhsa9WPcgaqO0OYX8Psv53FWB2uagv
         90cg==
X-Gm-Message-State: AOAM531zuLSkMeP9s6Umuk/0YIgwGR2f6E7PIvrZ7tYvGIKq07h1xJnz
        UjPWjU2d49AMnWiMke5ohLwHXRaEgdLdpw==
X-Google-Smtp-Source: ABdhPJwNnNHfqKpjsky1YxwOZt4/sg5tDAU4V2zmJZdXpzcRkESboCHIQrIe+ZWXRvS5Rj88m1SWiQ==
X-Received: by 2002:ab0:48ab:: with SMTP id x40mr9257028uac.68.1604362707511;
        Mon, 02 Nov 2020 16:18:27 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id d137sm658609vkf.53.2020.11.02.16.18.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 16:18:25 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id z123so3793885vsb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 16:18:25 -0800 (PST)
X-Received: by 2002:a67:ef98:: with SMTP id r24mr2212207vsp.37.1604362704803;
 Mon, 02 Nov 2020 16:18:24 -0800 (PST)
MIME-Version: 1.0
References: <20201023162220.v2.1.I45b53fe84e2215946f900f5b28bab1aa9d029ac7@changeid>
 <CAO-hwJLn5XKV+cp+fCRY395uBWuX=JrxgiGSHUnJXFpTzFWu4w@mail.gmail.com>
 <20201030180042.GB3967106@bogus> <CAO-hwJK8c+BrH3u5PMCndv6Jjj6K2z=4nyKMAojD09EcHjBROA@mail.gmail.com>
In-Reply-To: <CAO-hwJK8c+BrH3u5PMCndv6Jjj6K2z=4nyKMAojD09EcHjBROA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Nov 2020 16:18:13 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XbXGRD8mkg6H57X=EVo8=0ptMz9s+YA0UR3Vwv-DLTDg@mail.gmail.com>
Message-ID: <CAD=FV=XbXGRD8mkg6H57X=EVo8=0ptMz9s+YA0UR3Vwv-DLTDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: HID: i2c-hid: Label this binding as deprecated
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Rob Herring <robh@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Borgia <andrea@borgia.bo.it>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Hans De Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 30, 2020 at 12:12 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> I honestly wish we could have this as a separate module that would be
> in charge of the DT folks, but already having it as a separate file
> would be a win.

I've made my best effort at splitting it into a fully separate module
in my v3.  I'm sure there will be bikeshed-type issues, but maybe it
looks OK-ish now?

-Doug
