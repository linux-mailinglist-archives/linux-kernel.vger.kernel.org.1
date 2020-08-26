Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292A4252C76
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgHZLbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 07:31:10 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:45867 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgHZL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:29:22 -0400
Received: by mail-oo1-f65.google.com with SMTP id u28so354641ooe.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:28:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjVGS0HGbRfs0Re2eYmvuj93KRF7GbcoDgHD74CvDp8=;
        b=SJYyrYUaehmYrQ0sSWh1e3BB9KXMKf4ik8vbGsu9A94tJ5c+X7H3RBwaUQ840+W32+
         NGznR7Uae64hwP3vWoVj27eco2k06hgb3dQ3j3NoQO2QhmDCJWCoQJGeeDAyGIXB/p5+
         CoYF3x4A0C8RP7jWSeWpFgUnTAMtKp7prh3uUFwQmQZ13smfj4mGIINHqGcnxCPbcVtg
         DsKXM4UnY5Aq30znxl8G0OUwJT5myj7vor/Ud5JQuVJ8UvS8YuCRL2cHlXAMfv/XEOYM
         lsA+sGEUNMNg0Xeleo9T/86t6CpO0OdbMSvVzU5e91pKELuGz1XP3B03zo0yGI35vW/b
         Ysag==
X-Gm-Message-State: AOAM530/JNvdM8pH4gLLN0U/X1Mlohp3B2bkyXLMXsDRwh0c+nHndOuQ
        9m19+m0Rkw5Bc8WLZihG1bhE0sPVPQAqIZVG/rBhWmX9
X-Google-Smtp-Source: ABdhPJxmbNmsTV+R1Umjsvz30EeXTsekhqFvAQXgtdz2jvKrQiOSnzIYQdzEZQRT4NEV7snJoFtg+IW4pNVW9ZE5vdQ=
X-Received: by 2002:a4a:6c13:: with SMTP id q19mr10489990ooc.11.1598441328710;
 Wed, 26 Aug 2020 04:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200112171705.22600-1-geert@linux-m68k.org>
In-Reply-To: <20200112171705.22600-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Aug 2020 13:28:37 +0200
Message-ID: <CAMuHMdVZRnO7r-ihx4LiW2Jt+aG5jWnkjQJxCZ=JurtM_-ayXA@mail.gmail.com>
Subject: Re: [PATCH] m68k: amiga: Fix Denise detection on OCS
To:     linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 6:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> The "default" statement for detecting an original Denise chip seems to
> be misplaced, causing original Denise chips not being detected.
>
> Fix this by moving it from the outer to the inner "switch" statement.
>
> Fortunately no code relies on this, but the detected version is printed
> during boot, and available through /proc/hardware.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, and queued in the m68k for-v5.10 branch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
