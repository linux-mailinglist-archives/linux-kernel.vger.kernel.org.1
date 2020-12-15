Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173BE2DA509
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 01:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgLOArN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLOAqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:46:50 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A3EC061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:46:10 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s26so296664lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTQhcSzd6Xfpbh6Xm5AYq/PzIAT0fAP7iahagCVunzs=;
        b=DcSrpvwoVwQqedh9fPdP6HCEN9kjxXw3qmBiXXvO5ep3GFV9kL6LYvs9LFdmgdv6jg
         gV3t2spwq2++HibZ7yGrsZjWOFHV5scU3+kX2MbiH6gT/7DQy2jZv81jSFmwRtlTcnIY
         Q6U2mQRFsJEAkkfy4Tg6261+COOOzEBgL/5Xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTQhcSzd6Xfpbh6Xm5AYq/PzIAT0fAP7iahagCVunzs=;
        b=O2VJy1G8kX46bG/yaXXbmPNTfULQf7syOxFZIRlywmInbl7WMumwqSUFFHW3egyVDH
         ORYls4yF31l2yRJjm4foCEI8FQ2/GaG0InnfAr/H//ML/Oya9JsMQSuZuQ5Gwwex8uem
         dq6Iy+M2a2ozFGKJNAvJcpC6cOy4FGTY2B/raKVz+wyRwAQ8z97ZZjGs+wcPRtjijdWV
         oODA8NSyZcvviJEBYowN1pBI/i8sm2GE0DgH8Bt35md8coR6954w6cCIEjPc4VyTf6Op
         Up//l9D2cy6EssDjRbjEOngmeBQOvV3yrPE+UjabcbQXpDA3XmhCXffJExvyMohiOA5w
         1fMw==
X-Gm-Message-State: AOAM533/cXkDucGaXLO0bF2b46RKm9aaHE1bEYxCSXs/4KrTWEBg47/D
        44idNJodNAquRKKU+jKSlvfwsUWXwZ1ZQA==
X-Google-Smtp-Source: ABdhPJxeahT462iIHvbyjV72Ac3K/8wsDmpvPY60fELlom9x7tXufROTi5BF/4OEt4chRu1EimvPqQ==
X-Received: by 2002:a2e:b5d8:: with SMTP id g24mr4210757ljn.50.1607993168300;
        Mon, 14 Dec 2020 16:46:08 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u14sm16271lfc.96.2020.12.14.16.46.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 16:46:07 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 23so34960619lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 16:46:07 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr11121445lji.48.1607993166785;
 Mon, 14 Dec 2020 16:46:06 -0800 (PST)
MIME-Version: 1.0
References: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
In-Reply-To: <20201214132745.3323776-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 16:45:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wic8QjSuwjwpk8oLvtgWWCGfAC72ojuAU3PwYr7CWHqHg@mail.gmail.com>
Message-ID: <CAHk-=wic8QjSuwjwpk8oLvtgWWCGfAC72ojuAU3PwYr7CWHqHg@mail.gmail.com>
Subject: Re: [GIT PULL] Some fixes for v5.11
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 5:27 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> /* Conflicts */
> At the time of creating this PR no merge conflicts were reported from
> linux-next and no merge conflict with 2c85ebc57b3e ("Linux 5.10") when
> pulling the tag.

Really? It conflicted with your own time namespace fixes.. Was one or
the other not in linux-next?

Not that the conflicts were big or bad (free_time_ns() prototype
changed right next to timens_on_fork() prototype), I'm just surprised
you saw no conflicts..

It may be that Stephen didn't even bother reporting them as trivial.

               Linus
