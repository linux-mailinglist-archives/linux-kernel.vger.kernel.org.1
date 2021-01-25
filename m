Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9E302D80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732678AbhAYVXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732612AbhAYVW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:22:27 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D878C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:21:47 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id k132so14749470ybf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/UAxJz9Ju6jh7ahXkaUefROLXtTs6Fgq1e4ruhMD38=;
        b=ZtwEiSRvlSkDBLBF/yBVBFHtUNKeRRCdMADF9JugdMyTTZ9Y8AH47/zN2z8EuPZcD0
         jK63Ba2Kw9k/ctbBH7Aunj2ScIMVOpmwnwuiNC9e7Aqv4otj8U+jY0l0l48440jqhLsi
         GOpNu9TJiExAQHSJuzANk71ap9VdO80/87VVj1VdcJDFk2+ysU/4ie3Q9CZGiY+oxy2Y
         yJjjzONA2a5hQioagFpzyGkMEf4+hAxpS9SvSrI8o3ldsd2iiIrQQpGUprHMCOcRpwiM
         fd1BfT5skxCwrEupALCgSp7SO8aokwiMdfBlAciQpIwkDLKBSnPhTKBJel/ydq5slHj4
         Ta7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/UAxJz9Ju6jh7ahXkaUefROLXtTs6Fgq1e4ruhMD38=;
        b=HgF8knoCvI116OIeDI6DTd7ackhyRfapxYpXfTV/5AQ+XfNEaiDVETLOSCFbwB0/Zs
         fLfbzof569EoPoVbOIocn6p+l5vav63UPNqpi+FcgAn6iZvQtkN5dJWWbq31RB2CG+Be
         +A36+26vy1HPcHp4IwrQC9x4XB52YSa/jmYtgKKPFN4mTjESCywEqxWvbbvdi7XFrMUB
         32IwlI5OgYHqA+lWKCIeO+mLqVXdpe4On04nXGcF2n3rrQLYUd63EyXwlmTUGWBsTF35
         kjRVxjz68XDI52kcMHob0Eb7S+0sBYbFzs6ZKHt0s/A5Bay1O381hvX6fkpGfigLB7It
         z9ag==
X-Gm-Message-State: AOAM530K/vPef6gg/cJhz+XXUcuJ8xWLvra0nZDLZhasxUIWtlV34S1c
        k5la3uvV9XjZSXs5uJ36uuyZ+1FpltAe3PKtXhoj7/AQ0bjTfA==
X-Google-Smtp-Source: ABdhPJyuW5R6czEROrtHKrzzMECCabOawOV6cmyYUueIKygbrOTWt57+bH7dblJyfYfPi+AQUryVhlR4nVnAwhdt8/A=
X-Received: by 2002:a25:d6c4:: with SMTP id n187mr3689559ybg.115.1611609706769;
 Mon, 25 Jan 2021 13:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20210122160102.2877424-1-geert@linux-m68k.org>
In-Reply-To: <20210122160102.2877424-1-geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 25 Jan 2021 22:21:36 +0100
Message-ID: <CANiq72mWqnNpH+MJSB-ZGX44kWzXgj=M4qMYF1HYBrWAD2FC5Q@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Fix duplicate CHARLCD config symbol
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 5:01 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> A second CHARLCD config symbol was added instead of moving the existing
> one.  Fix this by removing the old one.

Applied to -next, thanks!

Cheers,
Miguel
