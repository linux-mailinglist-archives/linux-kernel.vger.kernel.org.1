Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3DC2B4A88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731786AbgKPQQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbgKPQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:16:55 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A328C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:16:55 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id o144so7259531ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYJuJTZQo8LxCE8SO48rV1CdcO9MdQ2NEOHmPiSubSg=;
        b=IByH22JJKroKWk567LXOTFtu/xKxibsm6oBhkvtOt+JbVLvPw7+8waLdDHc+fVL/Y/
         yQJpvNOFcgRo775YZdIPV6bZAJNpvSZWjXKWOWa3ir91iz1NicfGBdY/YqVhhO0tgslR
         0gW9AEQkvK/0LZbC5Tt0Xl3/7T4YIg/XfWKPLnyaT38pra7seIBbqEQPg0UNVSVHyEvL
         ZEHpEKdcG9gqMjF8JMKLDnVS8Ye5ieznUC4jh5SmTczxAJ0s4HDQ69ql0U/owbk/Zg1U
         wXwW7FhYqJG37+xtHF83Jrpg+a0yZmHQCue5g3/nVWcaurebgWAL82WZQP+ukDhXkFJD
         A2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYJuJTZQo8LxCE8SO48rV1CdcO9MdQ2NEOHmPiSubSg=;
        b=lI+a8p1yJtHlpN121LtxQFvhQK0BNsfOevOGyXUbiF0CQI0ABRQLbvbw/TdhKKEfjt
         pHdaUCtIa3ZVM4KdkfQI1/44DxhBCSD/DO1ABMUtjCPSIOh3DsXn7j7+Kwjym6zBRj9p
         7SzS8IZ5iHJUfXNOaS4Bj0pQsC8ZZ96nwzghD0X6Xup6alSP0dozGXtCuaAlBmz2Ly4M
         TdxHKjfS1tprYNyhMfhjRinhfHlOiJg5+kMlJfwtXzYdu4rJnLiYDXWW53mUizrvr1Xn
         /9Re4xkq6T+FygRduDXgqJ7r2864V7eoMY20JINGDY3WUocLwJrBzry7gmNg2GbzRUgi
         5ikQ==
X-Gm-Message-State: AOAM532md1brukEETkx9beQLEISbvFgJAW52rgvZO3ahJehYaF5DJ+jS
        +/DUynlLM7Xwd2ppbhGqgfTGcjnGgKTGhhVzKFE=
X-Google-Smtp-Source: ABdhPJx8nZTf3MZ6aPGfuBIEyeYS3HsR1M+PcEV+Ze5y1ts3IjLJ8rHzKHgNjLBegaGSGn1N5V/LJSxqvexKGxL7DTc=
X-Received: by 2002:a25:61c5:: with SMTP id v188mr25044552ybb.422.1605543414581;
 Mon, 16 Nov 2020 08:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20201116100504.tccqktcgxwn4pyqd@lem-wkst-02.lemonage> <20201116132155.555489-1-poeschel@lemonage.de>
In-Reply-To: <20201116132155.555489-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Nov 2020 17:16:43 +0100
Message-ID: <CANiq72nZp3SFODFadbxEYj0wh6_pA25jP24Ht+uM2xWV941hig@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: panel: Fix missing print function pointer
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 2:22 PM <poeschel@lemonage.de> wrote:
>
> From: Lars Poeschel <poeschel@lemonage.de>
>
> charlcd drivers need to provide some print function to charlcd. For
> hd44780 based panel driver this function was missing. We provide the
> generic hd44780_common_print function which should be suitable.
>
> Fixes: b26deabb1d915fe87d395081bbd3058b938dee89 ("auxdisplay: hd44780_common_print")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Thanks Lars, picking this up.

Cheers,
Miguel
