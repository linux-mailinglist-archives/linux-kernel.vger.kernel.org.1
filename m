Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB05302D82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbhAYVWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbhAYVVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:21:11 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C52C061574;
        Mon, 25 Jan 2021 13:20:29 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p185so14703995ybg.8;
        Mon, 25 Jan 2021 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmbpmkuKqVUt6T2Juf0lH0dcNnGW/+3z9Jk28Ukw+eU=;
        b=Z9q/0Vmi4LnXBk3oksLy2aM/rGON7xYLeJ0E3axLJbogGxvGo1paFkehivHwvjR4+G
         hccQ0X1xW3TryQfWmlg+uGxs7QkJICVVH8YktRpFzW5MYAu8jaOltgDRDnYG1P/6b2yW
         FotW/KvvwaXaG1Up/Fh7GhsgXGPGaCq9Si+5eVjbLtDoAlgLms31s3mt6tqrrSr/nCS/
         f+MnLkipRsXGG8gHQ+JPFL64y78TYFtsNq3WwGFP05uw9GQWYbzY1No6ZBfod8dPCOYT
         JINBQVGFJc0xFHY1O0EFo/xIkO7W9G62Fvjj1rwwh2Sb2Mg4ICNTlHHeQXxS8OmZxDUQ
         8jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmbpmkuKqVUt6T2Juf0lH0dcNnGW/+3z9Jk28Ukw+eU=;
        b=AxZKPgwS2CsucElUJECDcPgX+SGhv7T7dMRpATjJKU8Fe4Wxq3Gw1X13lXmraUicJF
         iu7hCDruw4RMXsRWg7NhU0M7o+yoKd+bl2iHPdBJ9xdl2Km6IumxvlXyWv2YUi+6+mIn
         jm5xiwAbnIMI/ZY3jTnQSHGzDPv58+aqOhaomFv9uR2xD9Y1YGZEbnmfha/a7MNG7dGY
         yHQLiRVvuudcfFKLrgfG2ad2XfXfNkL5ntcDdFOalTWP/46nD+bXLLGAWnzGlZmb4a0H
         Vqao16oNiJp0am0s+us/Mg/jJJPKxJlXXkXcnsh4ZzJrLBcXokKRpM2rRB7b2G4jecyz
         wWLg==
X-Gm-Message-State: AOAM530I9DXCHiTLcbzKsLd8sbbPX6p8TTawsN37Xz08IU+hxVhDu+HW
        S4NDxjq1GKvBTcxsmm1HlfXk7tbv/JXlvQvTZqc=
X-Google-Smtp-Source: ABdhPJz2uZNCT7vksZRoEVcjH5caeYpzB601zzmcONQcy7xjG88fmjCi+01TaERvIUZlmGW2ixY8TcQ6PuindGFdjEg=
X-Received: by 2002:a25:ce4c:: with SMTP id x73mr3716456ybe.93.1611609629371;
 Mon, 25 Jan 2021 13:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20210118123538.564597-1-geert@linux-m68k.org> <20210118123538.564597-3-geert@linux-m68k.org>
In-Reply-To: <20210118123538.564597-3-geert@linux-m68k.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 25 Jan 2021 22:20:18 +0100
Message-ID: <CANiq72kv_oSsOOP4uKLakMA7BWUqBN4Qt8cJvdJcKSOh=gM9xA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: auxdisplay: ht16k33: Fix
 default-brightness-level range
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 1:35 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> V4 changed the range from 0..15 to 1..16 in the driver, to match the
> dimming set hardware register, but forgot to update the DT binding
> documentation.

Applied to -next, thanks!

Cheers,
Miguel
