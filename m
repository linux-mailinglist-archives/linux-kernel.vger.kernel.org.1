Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B432C6CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 22:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgK0VSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 16:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbgK0VQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 16:16:15 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8A9C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:16:05 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so7278689ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bcq5nvyQqo6mh3u7DswmsrnqFs0sPScZXFNxYa3vNA4=;
        b=c6828afhOnkbjpth7Yk1WdawsTrP15Loc77tsWPGeki6JdT3pIdKiz1Rm7UQtJREb1
         FKJcxLizt0aPl/2jHtrHwf6U2yEVf9RbnFXpCojlP0i1Cjf1J+/uRsfzfOpmXvTbfqQJ
         T8Qh2BDNl3PSX+NtQ2pRuNIPHu3qPdPnszA7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bcq5nvyQqo6mh3u7DswmsrnqFs0sPScZXFNxYa3vNA4=;
        b=b84B4M9geiPpxlnfT7aiolAkzrIq8AciXjHlhTuiKHXjJ8c1Rz1leaAJgvmXPeIiDY
         cWgOaKZHqFdGbzMBFakiLP61Us5N2sZjbWTTk6rzn74gtCvP7dXQ7YHzkuWqusdjYjcW
         VGD56vSx0cDbnz8BI5TWX9ircadfW6MwzlPmNqw6lllORl1YiA1JF/yg2bJnfZtKDJQl
         IMFbPZzpKrjVTx6GCEFtOJqcLrzLQ/dvvqWUY/9IeIMsMVpG157wzl9QJotOQfVu2aUE
         pc6yyQDsAlmpunCYsh6dJT6R4BR2EnQx5JxAIcoRgO3OY4Gmpwbp1nDH2/tD+cymc3QI
         pkIw==
X-Gm-Message-State: AOAM533E/0kB6BT9A+llp4lIRbV6B57wdezgI9Nb1/wjUJin6gCZ/Ar3
        f7JnQTgGNtcM/dib9+pjz7wJ0SikREMWrg==
X-Google-Smtp-Source: ABdhPJxyx0gcRNV/pBMZiJw4rnj5nm0kWsGlwMaP7GqR8SFyxmGY/GH9Y1o6vUmZXtYKmFNQvLXcrw==
X-Received: by 2002:a2e:b164:: with SMTP id a4mr335255ljm.271.1606511763654;
        Fri, 27 Nov 2020 13:16:03 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m7sm828200lfj.113.2020.11.27.13.16.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 13:16:02 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id t6so8751860lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:16:02 -0800 (PST)
X-Received: by 2002:ac2:4199:: with SMTP id z25mr4440339lfh.148.1606511762473;
 Fri, 27 Nov 2020 13:16:02 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNASn4Si3=YhAPtc06wEqajpU0uBh46-4T10f=cHy=LY2iA@mail.gmail.com>
 <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
In-Reply-To: <CAHk-=wihYvkKOcXWPjY7wN13DXbh3k2YX_6JxK_1cQ=krbi9kg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Nov 2020 13:15:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com>
Message-ID: <CAHk-=wi86Eu8Whu66CVu+GVTxbuJG+QNvDuk-hXnWu+5q90Zeg@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] Kconfig updates for v5.10-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 1:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>        make --trace allmodconfig
>
> shows a series of
>
>     scripts/Makefile.host:112: target 'scripts/kconfig/....o' does not exist
>
> lines, which is silly and wrong

Oh, this is a red herring. It's "make" output being misleading, and it
just comes from the FORCE keyword.

And no, those don't actually change the end result for me.

        Linus
