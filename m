Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CA82922CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 09:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgJSHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 03:07:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45931 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgJSHHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 03:07:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id j7so11346720oie.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 00:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+vdqjMSZj52aMc57EWgyBmxbziFgHH2zS7JDhtiRqQ=;
        b=sHljkpciaA3R65eN9tMTPZCILOY4mUbO07/8azlCrgp1vAm+sKosG217yIW45a6uho
         a1JXsTsdPKALnEoz/8kghpW9+fBGfijtC7gWnwA1IcvcSGcvAASNAmRyy8+jFx/ddU6x
         n+bJXYuQ4OiicgcEO8uTvmYHXusHB1i0A/BEtKmGOyGSe2Tw5hZZHxi70yRTbQxEFXXv
         GTBn/ujjkakUKbxO0zotDWgzPRuky+q7OvQ9OT5qu69z9fts+P6WnaUiEN8z1sYz+N6x
         zC6tIZfBKANQHSyxhf4taYjD8xm9eI95FAZZChVIVpssuoOMhpHaCydcvL6llBZyR+yb
         LxUw==
X-Gm-Message-State: AOAM532Sb1AXPSGBn1VKrwHSD+SUWCtNfOFOCsNi/leM2UapY+gdFcMP
        XrW42hj0Vjkplfh/7ZDV35D+OagD57j7Td6YJYot5hQM
X-Google-Smtp-Source: ABdhPJwdtwJCsUSWVnHL9Jsg0Pl8vmRd4uAolsZ9MtbZxGxCkleaMtJmbdUygZF4xFzc4nKSZYSk0LspsGKYX9vmQDQ=
X-Received: by 2002:a05:6808:8f5:: with SMTP id d21mr6917318oic.153.1603091232857;
 Mon, 19 Oct 2020 00:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <c5e23b45562373d632fccb8bc04e563abba4dd1d.camel@perches.com>
In-Reply-To: <c5e23b45562373d632fccb8bc04e563abba4dd1d.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Oct 2020 09:07:00 +0200
Message-ID: <CAMuHMdVVm+1_n9D40bcLB__8Bt7pDbwj014-Q3BJrC2WRuz96Q@mail.gmail.com>
Subject: Re: [PATCH V2] checkpatch: Enable GIT_DIR environment use to set git
 repository location
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 8:45 PM Joe Perches <joe@perches.com> wrote:
> If set, use the environment variable GIT_DIR to change the
> default .git location of the kernel git tree.
>
> If GIT_DIR is unset, keep using the current ".git" default.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
