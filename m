Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 694E527F28F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbgI3T0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3T0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:26:46 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC68C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:26:44 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id v20so2976299oiv.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Z2lLSWgDbgK7BNqLC+QsU5QXGUOAVtMT/PZbpA1UHxw=;
        b=iIOe9I5pNZP8meeUXNKAoUKsEM46L9A61BGhluC0nLPrinz84am2mCS1nJyDND6tpN
         YV3piRTSnPw9ZCuPmD4me9UBdd/RiiLZA7KTZGq+bkZbob4bJKhVdrfSSiXpzYvJkGjv
         rVG7Kc6ZOwftO+6sZpAviDhRjqqGKRaxJLFCK++XaVhmqMWIhk96RwGAVDvvqx0dj8Df
         hh0u8UwVwH5prtgeEzosT0wfxf3yfOjik1BkQ4xhURP/3HHl5GXCGiUnN5gxoxAlFgj4
         nxkEcZRHcWEo+fUamu10vjMg6rSrGK1yI3IGEwLzUkTCuo4pWdeq9c+0WRADM1LO0osc
         Bgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Z2lLSWgDbgK7BNqLC+QsU5QXGUOAVtMT/PZbpA1UHxw=;
        b=CdYRdFjxApj5mA5ujPVxLfmuiv12QkN8azZIRJ1V68eQuLpeoDJh6+4ZDZiRbW6J4H
         XI6mIrsDXqDJKRB8Qjq7y59ta0JTLml5BXy0zzXCb86HFxkMNkLikREv+YLXFRtVswgp
         kyK9+JdEw4eebDbGFq6aXCKhU+z0HOMz7+WjIECeg34clEAcj6yMsJ1RXfK82qvAsyoA
         4c5BRMWgB235wcc+Zqu99HL+yc2bUFY0WTlM4956D8TSg87867xZ7+zvPlppHbPFUduF
         otoqtvZnSfhDynZV60KXGkXYnuVmIjHjQDgCnRxazCUTR/FQSK/nj56RZU1a6IiPygEJ
         2lVg==
X-Gm-Message-State: AOAM533xwcimyMDftFoC+h/l4CPo+U/3MNOs4POT2K462iqGlEnJogkP
        YJBzVmLTsEielTckFbpOxDbW+AC/4XtF+Rz9Mcs=
X-Google-Smtp-Source: ABdhPJxwk9Y4Gq9riJNLzoaZvWfU8vfbadHDK8LBdytKQc3PZaNrKl+7h1DCy0KN295zcsYKq2cV77dttlNcvkhQvSA=
X-Received: by 2002:aca:f302:: with SMTP id r2mr2145767oih.151.1601494004188;
 Wed, 30 Sep 2020 12:26:44 -0700 (PDT)
MIME-Version: 1.0
From:   Sebastiaan Meijer <meijersebastiaan@gmail.com>
Date:   Wed, 30 Sep 2020 21:27:12 +0200
Message-ID: <CANuy=C+JH7sZbMToWNNyWcKANbwSx5KLaiRBLHXBz6EU=JCABA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] vmscan: Support multiple kswapd threads per node
To:     mhocko@kernel.org
Cc:     akpm@linux-foundation.org, buddy.lumpkin@oracle.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, riel@surriel.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> yes it shows the bottleneck but it is quite artificial. Read data is
> usually processed and/or written back and that changes the picture a
> lot.
Apologies for reviving an ancient thread (and apologies in advance for my lack
of knowledge on how mailing lists work), but I'd like to offer up another
reason why merging this might be a good idea.

From what I understand, zswap runs its compression on the same kswapd thread,
limiting it to a single thread for compression. Given enough processing power,
zswap can get great throughput using heavier compression algorithms like zstd,
but this is currently greatly limited by the lack of threading.
People on other sites have claimed applying this patchset greatly improved
zswap performance on their systems even for lighter compression algorithms.

For me personally I currently have a swap-heavy zswap-enabled server with
a single-threaded kswapd0 consuming 100% CPU constantly, and performance
is suffering because of it.
The server has 32 cores sitting mostly idle that I'd love to put to zswap work.

This setup could be considered a corner case, but it's definitely a
production workload that would greatly benefit from this change.
--
Sebastiaan Meijer
