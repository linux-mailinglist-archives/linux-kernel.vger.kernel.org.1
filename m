Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4332680EB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 21:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgIMTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMTIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 15:08:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A9C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 12:08:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so11857906qtv.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 12:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5h/UqJjCjlFG6zN+mmpXGeRd6XKS0E7CMl79QNY5+I=;
        b=Pf+0f9sD5zuwy2f/CbR8WRLXfQuOC7MkQsYuQ9EVjJp4tImhhFyMsxPKLO2N/hjmF4
         dLd4p0Dx6/TcsEN0C9gaeWFKbkvEdv8yIILBCM8e9AFAuF3ALtG1c2PpQnJtH4zAq1Vk
         XZabcjTYtDcbs8r8wu8YU80WJS2EYAgFS2tUWAIrhK+RZU0r5gXKC+5w30LCWCWnKpG8
         F82m7uISYK6Tk6K/DLGXCWGb0gI08oSjujFBbXBIdGFZc/lV0Lmwz7qutVcaS2aJVkBJ
         W/lTzD3qfyOjCTh+LW88zF58awXHeeW22EAvKUmI6jDZd6c+2GF+4x9dDf/rjGPhCIww
         0VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5h/UqJjCjlFG6zN+mmpXGeRd6XKS0E7CMl79QNY5+I=;
        b=HIWw6GcofxIy03hH6JQKcZnhTCGegf4Xlbjzp4MkZNKhJCANDnNd7rwH4vsyaVP0NI
         kg8tp0mFBBjOSRUEOEytq5UMkpVQgww8nDYvkHE6ro7yY8fd6lLtu7bth+pSHbQNkz2G
         Jli+SgmU4t9+NmlMaixdA2BjV8HbFB1PYl3e1USNRttboSZG/HGmBLnkpELOpEp9s7va
         SZRH0duDDVmT80dgyYRr4Cyix7Vmc7zaGC8CBicnk/YUsQlxg2jFn9QTkRYUXPRepRmT
         +15oNdO3Z4hRibQVYJ40r5YVGrLtEHPyaaH/hvKNQmAHVbVPZT23IrlwLGBFQUUn6O5e
         JC+g==
X-Gm-Message-State: AOAM531HGyvTvaqmAMJF1EngujWJB8q1tHBQhlnVBeNUWnWdrdbDb5s6
        NYkraCZDcaWdNvX4lhPQNTxfjMGNsu/qIYu4hTE=
X-Google-Smtp-Source: ABdhPJzMTauxCQUYokReYXoy/ykjdVeZEniEuEt1D5WE6euJ3kdIyTE80ICdIX4DKl2m7peR5X21kjm6iy6go1/qzsA=
X-Received: by 2002:aed:3b7a:: with SMTP id q55mr10320667qte.78.1600024093865;
 Sun, 13 Sep 2020 12:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091037.3794172-1-chengzhihao1@huawei.com>
In-Reply-To: <20200601091037.3794172-1-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 13 Sep 2020 21:08:02 +0200
Message-ID: <CAFLxGvxA9pw8D6Q8GbBD0SUP+EHhOsZmRMSPxrW4sq0gYi9N9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ubifs: xattr: Fix some potential memory leaks while
 iterating entries
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:11 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> Fix some potential memory leaks in error handling branches while
> iterating xattr entries. For example, function ubifs_tnc_remove_ino()
> forgets to free pxent if it exists. Similar problems also exist in
> ubifs_purge_xattrs(), ubifs_add_orphan() and ubifs_jnl_write_inode().
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Cc: <Stable@vger.kernel.org>
> Fixes: 1e51764a3c2ac05a2 ("UBIFS: add new flash file system")

I agree that this needs fixing. Did you also look into getting rid of pxent?
UBIFS uses the pxent pattern over and over and the same error got copy pasted
a lot. :-(

-- 
Thanks,
//richard
