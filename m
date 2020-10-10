Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C14289CA1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 02:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgJJAQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 20:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgJJAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 20:08:53 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100CC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 17:08:51 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id 67so8523131ybt.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 17:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUg3JbgQNsYOFU1vKd/KouziNbar+YKHV7L5J9gfUGc=;
        b=N3avCwbsWqbjK3ZU6ECcmPOJ8k2N2DR/11gWYRotupBwLINWkeUeuwOchOnpJq0p3u
         rwzlgu2TDrmht1ove2uqCBD6sZZvZUmPLRWjlG9r2QzgEaePMEBRD9VhoeAawmpWXWMG
         FBdb6l9jg7ulK8pV6aTQcz06H2y+6oLQEOcSNkUPPZIhBo5QI0plKlvWbYS3OycudbOg
         JBa06G4q23O4Kuv4eTvgFWnPt93YJulhCSUACAEVdrJnGdBvRyAh+lXqT0sreCFv/XCo
         ZkACuz4lP4MSE2+0oPeLNFeDc1nT/QynhDmyQiAPDuK7yYc2HpavIvs0CTKZPRiCt3dB
         hQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUg3JbgQNsYOFU1vKd/KouziNbar+YKHV7L5J9gfUGc=;
        b=gnCYihS0jgNytErrIgwTb4H01jyYBE3OheaqxrrMGDx/VD+89f809sgWoDFq9CD0/a
         SAejKGOzfIKtdDVkNiZE5daXQKR0H/8kwgobtdv9JTXII1sFg+/PHZ7C6nIhrkRpRJlk
         u1erk49SDR4HoS21U87+ER+W3JdBV58drJDDPYcblFzjrZkqll2JZisEzFyeB6Oo4i76
         jedCsJPLHnwljKztxVzXX5KvWceLbPtDEW+dhanaLS8guxeiVg81jujc2zXcgPbxVuww
         QwgMwt1LkS4Hg+d4oxTqIXu2wwGgsS3Cu6beikTYrymdBMaUMt571P0hWi0LarAlz+k1
         Qfig==
X-Gm-Message-State: AOAM530R6wDDG/i3wZzyt5OOq5mHNzP7keg1GLZUg8cba0ncyy0DHCbR
        dWy5LqrQuiBqHi/pYwy1s25HRxqJNFvsiHeg0H8=
X-Google-Smtp-Source: ABdhPJxy2qz4GgYkLrsGNQmcCzJiYnxxf5VaLF7EBiVVyalokVWpNDRinYJahQ+uuJwc3cGl0S5U88Otp/WF/opzm6M=
X-Received: by 2002:a25:b88d:: with SMTP id w13mr435792ybj.39.1602288530270;
 Fri, 09 Oct 2020 17:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201008182713.2764-1-harshalchau04@gmail.com> <20201009045734.GA112189@kroah.com>
In-Reply-To: <20201009045734.GA112189@kroah.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 10 Oct 2020 01:08:14 +0100
Message-ID: <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
To:     Greg KH <gregkh@linuxfoundation.org>,
        Harshal Chaudhari <harshalchau04@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 5:57 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 08, 2020 at 11:57:13PM +0530, Harshal Chaudhari wrote:
> > Checking the argument passed to the ioctl is valid
> > or not. if not then return -EINVAL.
>
> Along the the comments that Arnd made, this is not the correct value to
> be returning from an ioctl when you don't pass in the correct command.
>
> And it doesn't match what your patch says, please be consistent.
>
> And do you have this device to be able to test your changes?

I will test this tomorrow. But from an initial look, its going to
break ppdev. There are few ioctls which don't need any arguments.

-- 
Regards
Sudip
