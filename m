Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A172AE702
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKKDXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKKDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:23:30 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F73C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:23:30 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id m13so824924ioq.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MtCTLPr/nLLPjkd638N9S+CTPL+nfBQ/x6OWapsdMSc=;
        b=TL0wdX7NjDApkOvujstE3i4F3uawHe37ZQIrUQ5qhGv0zg7FThLK65TVKp91AjchZv
         XrKLn3g1Fj3ahN2tmbzTiZmUfL+19TYvGenISURXld2/StkpYsSrBz/Y2Wil19SWN4Jz
         QMs5R/maEnYYDBUr9W3+r1cXuAGzT9XeMorGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MtCTLPr/nLLPjkd638N9S+CTPL+nfBQ/x6OWapsdMSc=;
        b=jJisN3vYQwcIa9/Q/34EfOMdlXPPms+MZz3NzdRbvfgWVVICheYEb+ScF4YShEzm8r
         /g8Ke3zB2ZohNu/rggcPh7wxUKd2wpEW98rEWaKe2W1l0r1Z/McvVQyx2R5jtaqDbAzo
         a84XQ7WqhMtWVpvfuhoDLdJvUuwhXNIdD7yUUYEnh3fCrGv3FnY8mXNYSdaHr2yi3Yyk
         dFpML696TvUobXKZ2nNhbC6uJOBQ7X1IVUb7jqdhsQplIx7oMYBvpZrOfief7r0GxoAz
         cdrQba+O2cad2nHy3AGx0fbGf15Icd7ACEGsAvqN6R1gF5jrPgN9iDK+l7APc62YhTQw
         dT5Q==
X-Gm-Message-State: AOAM532otMr15mQaikqv9Y6+qW97xAsH08cN9CsnmS/Cxh2VN0zRX+Xu
        ZyFiHCwyxoviQGY5rV1tz31SwCNhjF2G1w==
X-Google-Smtp-Source: ABdhPJzIB0pqxWt6FZZATvsWLOEOrI8jiu3mYi/FQJclNgkymZLoXty+HIOX3JuLYF0VAC/1LKE1uA==
X-Received: by 2002:a6b:c047:: with SMTP id q68mr12621158iof.189.1605065009548;
        Tue, 10 Nov 2020 19:23:29 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id d14sm330192ila.42.2020.11.10.19.23.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2020 19:23:28 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id m9so817299iox.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 19:23:28 -0800 (PST)
X-Received: by 2002:a5d:89c6:: with SMTP id a6mr10292848iot.69.1605065008201;
 Tue, 10 Nov 2020 19:23:28 -0800 (PST)
MIME-Version: 1.0
References: <20201110084908.219088-1-tientzu@chromium.org> <3b851462d9bfd914aeb9f5b432e4c076f6c330f3.camel@sipsolutions.net>
In-Reply-To: <3b851462d9bfd914aeb9f5b432e4c076f6c330f3.camel@sipsolutions.net>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 11 Nov 2020 11:23:17 +0800
X-Gmail-Original-Message-ID: <CALiNf29ku1aBiaBEg9ZTe7USSZZiOwnZWW3NKZgSGZ6M+GAX7w@mail.gmail.com>
Message-ID: <CALiNf29ku1aBiaBEg9ZTe7USSZZiOwnZWW3NKZgSGZ6M+GAX7w@mail.gmail.com>
Subject: Re: [PATCH] rfkill: Fix use-after-free in rfkill_resume()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     davem@davemloft.net, kuba@kernel.org, hdegoede@redhat.com,
        marcel@holtmann.org,
        "open list:NETWORKING DRIVERS (WIRELESS)" 
        <linux-wireless@vger.kernel.org>, netdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 1:35 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-11-10 at 16:49 +0800, Claire Chang wrote:
> > If a device is getting removed or reprobed during resume, use-after-free
> > might happen. For example, h5_btrtl_resume()[drivers/bluetooth/hci_h5.c]
> > schedules a work queue for device reprobing. During the reprobing, if
> > rfkill_set_block() in rfkill_resume() is called after the corresponding
> > *_unregister() and kfree() are called, there will be an use-after-free
> > in hci_rfkill_set_block()[net/bluetooth/hci_core.c].
>
>
> Not sure I understand. So you're saying
>
>  * something (h5_btrtl_resume) schedules a worker
>  * said worker run, when it runs, calls rfkill_unregister()
>  * somehow rfkill_resume() still gets called after this
>
> But that can't really be right, device_del() removes it from the PM
> lists?

If device_del() is called right before the device_lock() in device_resume()[1],
it's possible the rfkill device is unregistered, but rfkill_resume is
still called.
We actually hit this during the suspend/resume stress test, although it's rare.

I also have a patch with multiple msleep that can 100% reproduce this
use-after-free. Happy to share here if needed.

[1] https://elixir.bootlin.com/linux/v5.10-rc3/source/drivers/base/power/main.c#L919

Thanks,
Claire

>
>
> johannes
>
>
