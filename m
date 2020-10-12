Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75FE28B22E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbgJLKZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJLKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:25:46 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540B5C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:25:46 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id d18so5312141uae.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GNvkFgdLXDpcfWvKEkv73QYFM9xMPNMDp+xRNimMAgE=;
        b=LpeAaQE650BQqklbSHLv2Z6xJrQs0Qovh8tsFCu9b9qA7JkCMs22nZlLnXA3K7N40i
         M97wedrLVMvuepRTbOMUXWtAVci+cldAdywwLor67r47xJKs5ua7al0YSAPvVPjdy3JI
         wPLP0a8f7OQfD8L5oOy4FjFUVvzbW+2btpdHtsSEWLs8AQQL1HTQmFyKFb4aFEOjcqSJ
         saSU/UwhPg3kCbzVxyKhqTI0EeGDg60cgwR3qxI5kD2zBdpOj35UD+8J+DSg7GqLHgSp
         O39rGncW4S4sMudb8bYPyt4aOyALFo6o5wKguelMIM3taqkp2xtauVOlu/JdPRldZKSI
         uuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GNvkFgdLXDpcfWvKEkv73QYFM9xMPNMDp+xRNimMAgE=;
        b=Srhnf0nYt+n4/K/pfso2J/eC0wK0PVS/qFFWIySckbn8B0SOtXg1J7bfGtA+Ko1LqT
         Kesm581SJQm7wPiNgw8OZWPsDMnQFD12cSGeJjp7CXixrErohBA/akUZgSph5d2SQsgu
         ax7Q7+HLagh/c9RGkuq53318ATqdVjcwJzcB3eIvnxFy7zpCVgR0bN+ZJbrSxOAQDR8f
         G8kc7/9Kbq491ZXm3GLnDuZnqkIrnwxG+6UjphTYIqkH7Z6URpLFiKn2PxYQFB0A5JOb
         zeiFA+04RqwSFhdhXq0PPKIPm7egVNkOswanTbqzw1CLx+Ov/1nmmVE/M6AP56rqbVHr
         oztA==
X-Gm-Message-State: AOAM5308sc54KpSnFkKgTGfFaVEKLFOI/XAl757taRVQitACes8XYTWd
        NlgdKj4cg/JsmJsynlLYV1Pbmwz2yBVgzdAZwXq32g==
X-Google-Smtp-Source: ABdhPJwHw/rPM9GbZKUkpgzjrld/wPjs3AcYKe2gy0ttqFI2wKiBif4+nXfNA2ziyPOYvCzyaXZ6O9srMtMfWGs/SmY=
X-Received: by 2002:ab0:4425:: with SMTP id m34mr11902243uam.19.1602498345316;
 Mon, 12 Oct 2020 03:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200717033350.13006-1-benchuanggli@gmail.com>
 <CAPDyKFpp54tNRiQ+or-3o9dUJ=CB+PpsRc=fkxc10dAUY-x_SQ@mail.gmail.com> <CACT4zj-Z0yiuYF9KVyvTM+0nvk__YnBh=c7MHuB1XOFVpTtmHw@mail.gmail.com>
In-Reply-To: <CACT4zj-Z0yiuYF9KVyvTM+0nvk__YnBh=c7MHuB1XOFVpTtmHw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Oct 2020 12:25:09 +0200
Message-ID: <CAPDyKFrWO_x2wBjKRaoS9ypEszuQ+RWMr5Vej0uBOVV3=AAD-w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and
 enable SSC for GL975x
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 at 10:41, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Ulf,
>
> Regarding this patch, we also want to fix the EMI of one hardware
> using the old version(such as v5.4).
> Is there a chance to append a Fixes tag on this patch ?

Unfortunately no. $subject patch is a part of the pull request with
mmc updates for v5.10, that I just sent to Linus.

> Or what should I do ?

If you think that $subject patch should be included into an LTS
kernel, please send a manual backport to stable@vger.kernel.org. For
more information about the process, please have a look at
Documentation/process/stable-kernel-rules.rst

[...]

Kind regards
Uffe
