Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947A0215134
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 04:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgGFCmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 22:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgGFCmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:42:25 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778B320771;
        Mon,  6 Jul 2020 02:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594003344;
        bh=CrR+Ru1vIzVxb/frbja2kDuVOq5rjlaAGt224uq0yAU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fl9CdV4dcESwGpstxHYpUOY55lRqxa4UjOu1awhEV9wC4YxkzSvqbz5uDDY7S8ete
         HgJOZqrihBYN2wojiukP3+PUSQ06axqmUyQrE3qK8BZQ/5Vc6PFhAAs7BcKyeugNsX
         t0SdORRsf+VonJvcbYQ8vHsUaIukvTnWoWX2nxJ0=
Received: by mail-lf1-f43.google.com with SMTP id u25so21746730lfm.1;
        Sun, 05 Jul 2020 19:42:24 -0700 (PDT)
X-Gm-Message-State: AOAM5307stqFu5SxhvGwoGW48fvI+K9TKk/iFReDaH9D1IMzB4EF8HOg
        Oph4ho2YE3jPZsPKWjNUqIrySOe9Tm2u8cAZhN8=
X-Google-Smtp-Source: ABdhPJwDZYsA/gr9T0oE6LiNRx4sZr0rPI8qgTnwq0KpGS9PhHzhuLp5VyzNULOhkK89kDCcITnySqynDS/YBCoNrjo=
X-Received: by 2002:a19:4a4e:: with SMTP id x75mr28674931lfa.70.1594003342600;
 Sun, 05 Jul 2020 19:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <1593958397-62466-1-git-send-email-guoren@kernel.org>
 <202007051336.C9EA0ECF65@keescook> <CAJF2gTR5Fc1wpjr1ZYZikS=hCP9rbjJVsH9b-z2nBxbBcfBoCA@mail.gmail.com>
 <202007051820.DABE7F87D7@keescook>
In-Reply-To: <202007051820.DABE7F87D7@keescook>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 6 Jul 2020 10:42:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTr_ENhGRmjqNbGBhEc8y4D3YSqAResvwHuB1ykemKTUw@mail.gmail.com>
Message-ID: <CAJF2gTTr_ENhGRmjqNbGBhEc8y4D3YSqAResvwHuB1ykemKTUw@mail.gmail.com>
Subject: Re: [RFC PATCH] riscv: enable per-task stack canaries
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 9:21 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jul 06, 2020 at 09:01:51AM +0800, Guo Ren wrote:
> > Yeah! :) I just want to show you, how about the format: use tp in gpr
> > to do that. The format is similar to arm64.
> >
> > tp is the task_struct point in riscv.
>
> Sounds good to me, yes. Thanks! Is there anyone looking at the GCC and
> Clang sides of this?
My colleague is working on gcc's.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
