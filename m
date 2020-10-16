Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9E628FC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgJPCe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404192AbgJPCez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:34:55 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:34:55 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a12so668013ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRFu4XyLJUaboKK9qG9+2IQ4xH96xQePNVeGubVhXBg=;
        b=FMO/F5M08gafWlZ0+ywzEwlzw1E3a/0ASULyHUbRxN63QYe0rOK4Tb+DOj/jkZ6YFU
         Hb0mjmP8tCe6oxknwN3muaP7zwzLUFMUalAce5R0KAEo8Wm/R9hawRL6duOMP0Ygkbbf
         k1rzwN2NBfAx26EsWHcL8m/W0jKW8tJzos0SHOKu4CM13NRnPK1r3JgU9F9Umg7BDvPl
         gEGkKcoU8BkPOd1Nw9S3mhHfQGGbG+lrSBDD/2xCvReV9BW5Wz3rkgUcfLO7EzLo9z/N
         LibcHy+eFoi5ut33rb1uQcLn8siG7Q7njS+HqlQ6LsH9Eb/H3RaqrLqEYsifm3b3BkBr
         ycyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRFu4XyLJUaboKK9qG9+2IQ4xH96xQePNVeGubVhXBg=;
        b=EM5mEgKSkP9SjyHgSzk4C1R5lWbdS24xX0Ra36pGm9eE3eDP+KyLJ+p75X9dIqq7nO
         DpCjWr/IOtaQZON8GTvWxvAHDRN+5wsyg3Bu7p9IHr9gcjt5x6EP/w2FHfpzg9mlU3oW
         cm7qNQovzDVhAx4yDh04WT7xhlFJsl1gVR0oWDHyYUPfzJMF8BWjV3Kk6rBPWMERmQoJ
         EoDG637jniOKyA3KnYW8oukX8WOiJOPZemJmmxFqKoJj8TSDKrJr5AHqbt5AAWXJiStK
         6UudIBemA4aBLvL5EqXz+0strVPkkBVL2T6rLIvupxb1HvHWpjPGKq5PzRM4ppmt1h5j
         TFCQ==
X-Gm-Message-State: AOAM5339+pLLfmlFYSwYTpxAZ12mKNUEok+bqHtrwKcoEtfLxsoYErYI
        ES52NblSS3EOJN2Jsx0Zf/MDLoCr03xoiuhRqhA=
X-Google-Smtp-Source: ABdhPJyL8ASo7baN7S0qMZDCztIU3HT/YOgyEtGIn1W2930NStB1xsCE8Hubd+NCXD1/4PEAL/DDaJ2PSf9z5NRNa1E=
X-Received: by 2002:a25:b792:: with SMTP id n18mr2143221ybh.93.1602815694777;
 Thu, 15 Oct 2020 19:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201005122732.3429347-1-poeschel@lemonage.de> <20201005122732.3429347-2-poeschel@lemonage.de>
In-Reply-To: <20201005122732.3429347-2-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 04:34:44 +0200
Message-ID: <CANiq72nGzHqY3t_DvPknnpDK3MOwWt45ZW2iLs4FRbvvGxw0mA@mail.gmail.com>
Subject: Re: [PATCH v4 01/32] auxdisplay: Use an enum for charlcd backlight
 on/off ops
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 2:27 PM <poeschel@lemonage.de> wrote:
>
> We use an enum for calling the functions in charlcd, that turn the
> backlight on or off. This enum is generic and can be used for other
> charlcd turn of / turn off operations as well.

Typo: of -> on

(Already corrected in my queue)

Cheers,
Miguel
