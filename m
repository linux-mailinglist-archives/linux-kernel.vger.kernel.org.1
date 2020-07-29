Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C53C2324CF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgG2SnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 14:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2SnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:43:11 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8C7C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:43:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t23so2644421ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQrDOEGzsiONMvvyToZ6AXQOHof7I1W0ObrG53hfoy4=;
        b=FF/FzVgGKEtoa6ZNMRJwrintVq5jh2Bq6c0fZ3NnY4HlUx2b3qO1S5u/W72THPB/D2
         5kFWiGbok3mN4nIPfy2Ths4v0XwyP960SYtD0HijzSgeyLgDiA8+6SPRdmS8iBxiNCPG
         mcfWzb1qVPadPo10hFFnqwskw1y2R0YA/EUtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQrDOEGzsiONMvvyToZ6AXQOHof7I1W0ObrG53hfoy4=;
        b=H3DQN8wYwU27dMdvuO68ymzUxxt+OfW1JT+RC0244MExauVyUlMkpapVYkfTjLOmjj
         /A133edvy1FpXec7MKJ9EjpA6OCX5I2k1U3ru0X7nrs6ZNxRreeDkMV51Opav6iyJfqk
         JLslEBlRh0AhFNDPwxVGK7giykB0YvmBPDzoovn3+bYfQzxLdo5nJIPtV77FcRunv3Xl
         I1n2mzlIzx6hFwcEZJSihSvhgJrjq2H/Cy3m5l2clTqpDA0mV5uxdbjdN0kHCrVppFiM
         mn9qYe/rHuJZYUFLkwiZ8B9ThDhv34GxY+Q2Bzo8GC1p8uIYACyGwOvuXPCrxFCgVuGv
         BJKA==
X-Gm-Message-State: AOAM531KPXFIcr475yrTkqmliynqn3MI1zoSVmlGagTs5F71a1HXyU5p
        XXlOwg5mIxLpVXLDbOryh4RTfTiuk0g=
X-Google-Smtp-Source: ABdhPJz2lrhyjyK9k9lriJPFSzjz9nPNd6G9rw4hLI6EcfRypaKo7iuRyYxUuIynsmumB0GRfIZBEw==
X-Received: by 2002:a2e:8990:: with SMTP id c16mr14635415lji.305.1596048189035;
        Wed, 29 Jul 2020 11:43:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id l3sm537511lji.115.2020.07.29.11.43.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:43:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s16so10938996ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:43:07 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr14882866ljj.102.1596048187597;
 Wed, 29 Jul 2020 11:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzCWbg3CUSeywiHxQ-fCE1FAGGdOt5Qm+sjsLQLBSExyw@mail.gmail.com>
In-Reply-To: <CAPM=9tzCWbg3CUSeywiHxQ-fCE1FAGGdOt5Qm+sjsLQLBSExyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jul 2020 11:42:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8Oeg66=eOoR7XPxxPcOXBD+9QqFf=BtABsVudZObjKA@mail.gmail.com>
Message-ID: <CAHk-=wi8Oeg66=eOoR7XPxxPcOXBD+9QqFf=BtABsVudZObjKA@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.8-rc8
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 9:44 PM Dave Airlie <airlied@gmail.com> wrote:
>
> If you feel this is too much I'm happy to respin with the
> core/drm_fb_helper and nouveau fixes. we have one outstanding nouveau
> regression fix, that I'll follow this up with in the next day or so
> once Ben and James get it reviewed.

This looks fine to me, I've pulled it. I'll be looking forward to (not
really ;) another pull for the remaining issue.

Thanks,

                   Linus
