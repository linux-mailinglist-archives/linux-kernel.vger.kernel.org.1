Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357B028F8CD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389403AbgJOSmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389126AbgJOSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:42:43 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A4CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:42:43 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m16so4188986ljo.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dw0XxsAm0N+xBFL5kuzzzttiWu26H5L6VPpZZ+p1K+Q=;
        b=WUzSrl2W1MAsVn/qZ/fS9Hm0TAB8UoUns4rO41D2Ev/4lY06qhyR4V/dfGjo49/3F9
         qF6QqX5XqRKgc2ZEoxerJCUvujPk9UZ4YbWpbs4OPfKOqXkcrp/7xo3biMGolLKVV5EU
         uPwB97ePNYaE3YFEMLJFzu5dYVx4ce1tOZOJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dw0XxsAm0N+xBFL5kuzzzttiWu26H5L6VPpZZ+p1K+Q=;
        b=W9wqm9icX1Fn/kUOTZW7sY083+IuUetW+cG6OhOBo7MwAFvcAJomURaFTbVbYf7giA
         8KovHSZMAf/JdFBdQrvT0WbI9Z7ZmjYLncaY2arr6Z7KbIpmPOaVMtITpe3m0q09xxq1
         KgxRXb/J1HlHDSqlfBMCfwg7GR2a7IaK6l+fMcf/5PUxlL39PqsnbHIaNZPVJwxgH1RH
         /Riy5GbP3qVri5+hjpGvIJXoZVdHHdAnL+N26E4asgmtOhYSA/aF6C9SEb8mtqBZFdgo
         kwwk5sUCMDX03oUdDIP38m9eueLahyRw5bjytguU4Kg9nz0V/PvbEZxLQBShdrcpHhPT
         sEnQ==
X-Gm-Message-State: AOAM532V6j9FIOCKeA9kNSYyk1N5/mjSilHrPzH3pHh1SUD009EJ30YN
        NBXx+sUHQ3BWa11diVM+8yd/jajgr+gOCg==
X-Google-Smtp-Source: ABdhPJzycXZ4Ktm6Hd2otwitfaHhDzKe7SXk5ICa8o1cQv2xWEzKfBsZ+BJavUMQGle6UALRA7d2og==
X-Received: by 2002:a05:651c:1202:: with SMTP id i2mr35138lja.289.1602787361281;
        Thu, 15 Oct 2020 11:42:41 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id o206sm1284001lff.204.2020.10.15.11.42.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 11:42:39 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h20so4174354lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:42:39 -0700 (PDT)
X-Received: by 2002:a2e:8815:: with SMTP id x21mr51353ljh.312.1602787358993;
 Thu, 15 Oct 2020 11:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <CAHk-=wiP+S4K3yU+FqgGmF+EgcSgk04Eerf3gE-6qObicy346w@mail.gmail.com>
In-Reply-To: <CAHk-=wiP+S4K3yU+FqgGmF+EgcSgk04Eerf3gE-6qObicy346w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Oct 2020 11:42:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYNzhoYuUBsBcFq1TFA5C+Bie-2uzZkF2McO9joXxW0A@mail.gmail.com>
Message-ID: <CAHk-=wgYNzhoYuUBsBcFq1TFA5C+Bie-2uzZkF2McO9joXxW0A@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     Dave Airlie <airlied@gmail.com>, Eryk Brol <eryk.brol@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Thanks, looks good to me [..]

Uhhuh. I already pushed things out, but my clang build (which I don't
do between each merge) shows a problem:

  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_types.c:650:8:
  warning: logical not is only applied to the left hand side of this
comparison [-Wlogical-not-parentheses]
                && !params[i].clock_force_enable == DSC_CLK_FORCE_DEFAULT) {
                   ^                             ~~

and I think clang is entirely right to complain about that code.

Yes, the code may be correct, but even if it's correct, that's a
really odd way to write things.

Anyway, what it does is:

   !params[i].clock_force_enable

turns 0 into 1, and anything that isn't 0 into 0.

And DSC_CLK_FORCE_DEFAULT has a value of 0, so what that line actually means is

  (params[i].clock_force_enable == 0) == 0

which obviously is

  params[i].clock_force_enable != 0

which in this case is the same as

  params[i].clock_force_enable != DSC_CLK_FORCE_DEFAULT

which may be what the code actually meant to do.

So I suspect it does what it meant to do, but only because
DSC_CLK_FORCE_DEFAULT also happens to be 0, which also acts as a
boolean 'false'.

But it's also possible that the '!' is a left-over, and the code
actually _meant_ to do the exact reverse of that. I have no idea.

This odd code was introduced by commit 0749ddeb7d6c ("drm/amd/display:
Add DSC force disable to dsc_clock_en debugfs entry"), and can we
please agree to not write this kind of obfuscated C code?

               Linus
