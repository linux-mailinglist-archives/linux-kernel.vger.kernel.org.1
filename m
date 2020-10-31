Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4FB2A14A3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgJaJSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgJaJSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:18:42 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C6DC0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:18:41 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id z7so5376925ybg.10
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O98vctGJlMm54y7ZgkFRa5GNToqKQf+9E+2CGnC5b6k=;
        b=Y3/3bCaJNeg5r7RyY83l0gNBsB6eZfAKpe8LX6g8nWg7avzzZEw3rC3bCEDDsP4nsu
         Gyz9RkXt+fHZ5RLSbq9Sq6z8yvatN7ZKS6qWQ1Yv69t55553k7ljcErkmMI584sUr3U4
         uLqYt1lLVJJWVlz/0SG3wLJ1JWHCYF1P80GhsUpsh7Qfpb8823zp2UyTQHydRw/jt3xi
         TZHdhmaLoqS6bbTavQut44QMREnzbKml8keWciUDWdbXmHyHNy6dbGchfHLavbHedLGV
         OpViPqTmfJ3uL4tQ+tpY/S8He2Wbo4dIkifAZcdOJF/tofL6ijcIVbL06W4+yqRptuxz
         le/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O98vctGJlMm54y7ZgkFRa5GNToqKQf+9E+2CGnC5b6k=;
        b=SrmK73qnUCb+QtYTXGkN6hKxN7cTt9/Dg9r0908PU/Y1+xdG62NT8euquyRzh4Nnhq
         kBoXV3CgBhvuHNfAmQodk6YkRXDLVXsvwHArhAgsKhdYVoIjRzfU1jS4bHYHn0dkgfbB
         /PslhoofSIbE9j/ibfl9Y5D0OXkxU1atvRUWCE7JsDpWzOWp7tKAuOIk+oAF5teus9sG
         30tYlEW86RtSoiJxKnmjfbx5wwWeW4iz9TmqP05Nr7xAeO8BD1DlMIiHleL6nG5iUb5J
         lNvLC6M/eaXBJC/ODyyNfWi/5agwFG9vcJTKIeeqpiF+g+ViDhICRBvdlxdU2wMGr4VL
         ocHg==
X-Gm-Message-State: AOAM531qKjOvflY4uie/g9rp0qTDwI5o2IcKEykQy/hJYoeUpOWwsuQO
        zKSOriLe3j+ghyWmtSTmejUybCi0sXwc/RJGFy23saKt6Zw=
X-Google-Smtp-Source: ABdhPJwnn5lyLK5BSq7j/tEOGyhmr40uU6gynLa5ItouJy8sWwN7pURl01tJK4zjYkPy8Snzhkhp+eMDs/CrvYHBRU4=
X-Received: by 2002:a25:384c:: with SMTP id f73mr8429950yba.135.1604135920359;
 Sat, 31 Oct 2020 02:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201029095231.311083-1-poeschel@lemonage.de> <20201029095731.311528-1-poeschel@lemonage.de>
 <20201029095731.311528-22-poeschel@lemonage.de>
In-Reply-To: <20201029095731.311528-22-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Oct 2020 10:18:29 +0100
Message-ID: <CANiq72=R0FBG6Zx-_u8ZjYFLovUnAmnZS6HO4Qa0OYUyncPeVw@mail.gmail.com>
Subject: Re: [PATCH v5 23/25] auxdisplay: charlcd: Do not print chars at end
 of line
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     open list <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

A few extra typos in this commit message.

On Thu, Oct 29, 2020 at 10:58 AM <poeschel@lemonage.de> wrote:
>
> Skip printing characters at the end of a display line. This fits to the
> behaviour we already had, that the cursor is nailed to last position of

to last -> to the last

> a line.
> This might slightly change behaviour.
> On hd44780 displays with one or two lines the previous implementation
> did still write characters to the buffer of the display even if they are
> currently not visible. The shift_display command could be used so set

so -> to

> the "viewing window" to a new position in the buffer and then you could
> see the characters previously written.
> This described behaviour does not work for hd44780 displays with more
> than two display lines. There simply is not enough buffer.
> So the behaviour was a bit inconsistens across different displays.

inconsistent -> inconsistent

> The new behaviour is to stop writing character at the end of a visible

character -> characters

> line, even if there would be room in the buffer. This allows us to have
> an easy implementation, that should behave equal on all supported
> displays. This is not hd44780 hardware dependents anymore.

dependents -> dependent

Cheers,
Miguel
