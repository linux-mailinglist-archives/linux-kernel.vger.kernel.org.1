Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA762C26B9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387821AbgKXNC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:02:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387663AbgKXNC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:02:27 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBE620857
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606222946;
        bh=mRyFh67kJfy8ZITfHjrOgCZZLf01NwP2u0w2OlFgRgg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sz5yMIkUhhtWCOgnTOr5d0bv8kSWhD3qN0uSJ43dioTwPSv0d9TuB5GEqDbC9qkdx
         l/igfcndpP0AI6ItVUWKeXoLPryk7PO33BV3QUErLEuMwflWwd6gTzfUeJyHounyqB
         HPdA5dFCj3LRBEFxtOEicfcHfJ+4YxMWJJOzJbTc=
Received: by mail-oi1-f176.google.com with SMTP id s18so22527311oih.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:02:26 -0800 (PST)
X-Gm-Message-State: AOAM533LyT+w/74RiNkuZDs4Y8f6RYW5pkLnLomQjH2pdRi8ML9oWJli
        MEMoEKVtSpfLrjvYNf+2O+t3ylyLkDmGsucyGQE=
X-Google-Smtp-Source: ABdhPJwd4HlK8aErAo0yZOEzAhlqNo8LDzc3+z00A1haMLZdh7R8bcKiStZxVrkCerFt2PktDuPW2+m1X4yfqNMJ5p0=
X-Received: by 2002:aca:3c54:: with SMTP id j81mr2648803oia.11.1606222945358;
 Tue, 24 Nov 2020 05:02:25 -0800 (PST)
MIME-Version: 1.0
References: <1606197161-25976-1-git-send-email-rajan.vaja@xilinx.com> <d63804a2-1880-70c3-841d-e824ec7942f7@xilinx.com>
In-Reply-To: <d63804a2-1880-70c3-841d-e824ec7942f7@xilinx.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 24 Nov 2020 14:02:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a37YhCPmzJMi2iw=XQwx2_7r1ueCF6AA_j7qkCJV05Uuw@mail.gmail.com>
Message-ID: <CAK8P3a37YhCPmzJMi2iw=XQwx2_7r1ueCF6AA_j7qkCJV05Uuw@mail.gmail.com>
Subject: Re: [PATCH] firmware: xilinx: Use hash-table for api feature check
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Rajan Vaja <rajan.vaja@xilinx.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        TEJASP@xilinx.com,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Ravi Patel <ravi.patel@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 1:54 PM Michal Simek <michal.simek@xilinx.com> wrote:
> On 24. 11. 20 6:52, Rajan Vaja wrote:
>
> Some lines should be added.
>
> Cc: stable <stable@vger.kernel.org>
> Fixes: f3217d6f2f7a ("firmware: xilinx: fix out-of-bounds access")
>
> Tested-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> Arnd: do you see any issue with this?
> I found that your origin patch was taken by Greg and pushed to any
> 5.10-rc version which caused panic on Xilinx Versal. That's why I would
> like to get this patch to v5.10 if possible.

Looks ok to me. If you'd like me to pick it up through the soc fixes
branch, please forward with the above tags to soc@kernel.org

      Arnd
