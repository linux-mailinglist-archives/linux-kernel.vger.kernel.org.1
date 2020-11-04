Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25D92A5CF3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgKDDK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbgKDDK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:10:58 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E4C061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 19:10:57 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id a12so16738360ybg.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 19:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VuSQyNdXyckv6X3cT+S/PiFw418RH9fxe4aXmrLulpk=;
        b=nImedaiMkhSwuxmkSp8ow20eT3GTfbn/pA0MtDsaLUWUVKS5LJ4Xq+I2ODpa8DpJlt
         6fSXZ7s7poF1QNcunXYMgIqb/96jlSIDBBKflxrytLMOfGmehGRTsvndjOg2waP3Yv9A
         dUw2VZ9NaCxalcMkb2C1JqOAFw8XxV5RdyAZspl2rkkM+k3pDtzH6Zm2bQALvQa8Y58Y
         w7/o4Wa6Ob2gVeL1WYqeCVC9dNofFJiHufVQrrJYnCnv750irMPE8g+YX5OejYVpTtc6
         fx27PfBYxub7RuFLYNUj1GVYXQIpnlmhe86Iofta0mmUHVxS6DPcvRRpZpr6H5orxN4k
         c/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VuSQyNdXyckv6X3cT+S/PiFw418RH9fxe4aXmrLulpk=;
        b=ZNBM5ilxAOHywVRnwJgPW3Zn/awY2Ty4/n/JoFZbIFTKY7NDmLTTQ6+OvMQX/nVf9Q
         mN0+Ov8kb1TvGKpoCSxNKFdeJTLobnpY80uf4Rs0fYYaAize7TC7eF/Zlf1zBbQZrbO6
         kSDQZHSDgqLvM7kV5fO/9T+sRlpjDS6UwIPYbrfxgYjx6YNFzz4u9T08yLSitYjLYvQY
         BmIupI7pJShsFM22Acr2qIZzJmjLZaR7pe5C/DiYirEVgA00YOISPMq/0z8ZP7z1IJ9f
         QgucqRFE2RebBb3Su0jjlHmrpYrGVMtpps0RdW/tAyNovzEUctLRzunO/X/QEFpyb39r
         0WsA==
X-Gm-Message-State: AOAM533n5OnIHrHk48LHJokwhLalX0mM/W4AUKts4Rgj8XqiRVPzOzaB
        6n7lyW+5deh0arfLNQI0II6olgWmINEtcZpnBxY=
X-Google-Smtp-Source: ABdhPJwIFeY6xwlA90zAY0ilS7odPaDK7Lt+uAU0Em37wkgZy+Hn1lxGMaks62s7xIaFCDZyepoQHJ7gQR99GXfThB0=
X-Received: by 2002:a25:491:: with SMTP id 139mr34396718ybe.22.1604459456999;
 Tue, 03 Nov 2020 19:10:56 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
 <CANiq72=r6oieZ-Nj-e6e+HriW8kADB75z2pj6W-gg7Cff3nqGw@mail.gmail.com> <f474396f8f47c303e3a3ac90a582c116e38e50e4.camel@perches.com>
In-Reply-To: <f474396f8f47c303e3a3ac90a582c116e38e50e4.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 4 Nov 2020 04:10:46 +0100
Message-ID: <CANiq72nnpdPSngjoOf=imLxZ2g0A7ZXe5nRjF0qf5AG1UCfXyw@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Joe Perches <joe@perches.com>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 1:56 AM Joe Perches <joe@perches.com> wrote:
>
> Do remember that this patch is for the current kernel and
> not any old version that someone might be compiling.
>
> The current kernel _requires_ clang 10.0+ and that would
> obviously provide clang-format 10+ as well.

You can use clang-format without having ever built a kernel with Clang.

Cheers,
Miguel
