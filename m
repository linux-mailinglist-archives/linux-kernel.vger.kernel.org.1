Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7997426CFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 01:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIPXw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 19:52:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgIPXwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:52:55 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F12D22209
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600300375;
        bh=nF2wOkIEMuGCFK4dksaS+0Wz0X+Zn9VQD2tY5C3RqhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lGHJXh97ET5irFpcyLAup5LHRVsyKJJK18zjIBbbuKMwWlO5OfFc+YAo1M7J1yyQG
         1yEluEpuoPvF0Yd68cosRS9vfFuY5vHAK9Y2lden8Q8auuVrKctbZO2t/bxR5YLuN8
         RFswmk7iLQWrB+QvKqQkCrgOQ+kMP58jOWG2N0eQ=
Received: by mail-qv1-f44.google.com with SMTP id cr8so97915qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 16:52:55 -0700 (PDT)
X-Gm-Message-State: AOAM533i9LbSKpFpO1xWCcq4sd6AWn5pbp8yiBWoYDAqxDxQtP3VkOBP
        LD7jp2tDDDraZFJmCywOzkSp64R/JpcVkkKSKa8=
X-Google-Smtp-Source: ABdhPJxk/2WJdUbiQ98vW/TRcidfXBjP+pxcd5+FCIEZ+6phIVfswzfHflXrKfZpcjeIo9SMIIiMIJF2qa7F5uCDFt4=
X-Received: by 2002:a0c:bec4:: with SMTP id f4mr26619568qvj.14.1600300374647;
 Wed, 16 Sep 2020 16:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <1946561.0luHp2vXsY@rfietze>
In-Reply-To: <1946561.0luHp2vXsY@rfietze>
From:   Timur Tabi <timur@kernel.org>
Date:   Wed, 16 Sep 2020 18:52:21 -0500
X-Gmail-Original-Message-ID: <CAOZdJXVbWm2LBjmZbY4FmDAi4fKThwF_=wnUvSt9sTts_fb0Kw@mail.gmail.com>
Message-ID: <CAOZdJXVbWm2LBjmZbY4FmDAi4fKThwF_=wnUvSt9sTts_fb0Kw@mail.gmail.com>
Subject: Re: [PATCH] print_hex_dump: use %px when using DUMP_PREFIX_ADDRESS
To:     Roman Fietze <roman.fietze@magna.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 7:23 AM Roman Fietze <roman.fietze@magna.com> wrote:
>
> This function is mainly used for debugging. But for that purpose the
> hashed memory address of the dumped data provides no useful
> information at all.
>
> Note: There are only very few locations in the kernel, where
> print_hex_dump is not used with KERN_DEBUG and DUMP_PREFIX_ADDRESS.
>
> Signed-off-by: Roman Fietze <roman.fietze@magna.com>

Is this patch going to get picked up?  I was hoping it would be in 5.9.
