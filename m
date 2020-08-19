Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966C124A650
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHSSwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 14:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHSSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:52:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34332C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:52:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y6so207452plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyYpI1eTNYdHfR0G2Gw+QKYgydAMFbim5qzbpHh6tkk=;
        b=QUGdMAQCv2M76+xBa+GQ4k3SZJrORZYHLCCkIjlZQ6h6BuPiFrBf8ntRTn7pJ7ESLX
         NYfyLE4eWMQQbrkEaO4gdrdZGhVtdFz7Qs/ib6J7P26b6WRVMcUEIfHOy43P5MugHuuX
         P+PkU2F1tqZii+G/WNiLWnEjqIDyNG4b5SBNMI1xVb80e0mHHRsHwaFdzg0yhWEx8knh
         32dUu1hlBEd8aoRPrLgWyax7nhv+hIwUUMjngchHb4DqvAwr4qVedog+2wzGltISDkgS
         44Dunb7gYpI8+bkYDHZXw3XlxbdfaJ53i6lFlezKGwAXnTA5LPs0gTrfkaOBsg4+g3su
         aLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyYpI1eTNYdHfR0G2Gw+QKYgydAMFbim5qzbpHh6tkk=;
        b=ZrXEy5mfFlZQjlYHpoQHQA29soc0XijjUjN0Ux34SJRjv3cCEjCJR1Z9MJFT5ZmhMo
         YzI1Rg4Rm6oqzIhEWdrhnLFE5VD8FjXH79oNUD1mCqhOA8ytYvrYQFNwTduc9DsqR1Hj
         hsOnPqHBIAOqhuCg+Pxo4AQsbYEpoxcmmgyKpvzZNNHto1O6EnDRXTet17jq5ehJdkFu
         yKkxyK/UthPmkFMShSpw4FugPUhzttxsuFBbPESjEk09WqsiGQptBt3T6loSvgi7ice6
         soF9dSWxWBOMq13XKmNUUQUZbV6ezMEEm70j67fwnkpnqoGfsXiTyC+Z659y2KAHrqja
         Q2XA==
X-Gm-Message-State: AOAM5313C0l+c8h9X8o9uhAmJBdcp6DEZs9YgoKptJEZGL3U+ueQkjce
        rqYWcbSXiK5aLDy+9902x/prw0ZP2jevL6Dkg/RALg==
X-Google-Smtp-Source: ABdhPJxKaH/KH85qKcrDnnxPhxKHsYCEW4OLxljbbjCOZt7Mzu97zAqCPy4Kf8PFve9OS/InPqY8ntjOIBiOaMnYRvQ=
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr19798331plo.244.1597863130537;
 Wed, 19 Aug 2020 11:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200819161907.1155110-1-enric.balletbo@collabora.com> <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de>
In-Reply-To: <C9E59107-CE83-4554-9447-5DE5BEE09A3B@fw-web.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 19 Aug 2020 11:51:34 -0700
Message-ID: <CAGETcx9_A-E5b-JxT2G142mGxqoo8xqFNEgT+CNWt=oOv0Z5+w@mail.gmail.com>
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
To:     Frank Wunderlich <wichtig@fw-web.de>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 9:52 AM Frank Wunderlich <wichtig@fw-web.de> wrote:
>
> hi,
>
> does the fix you've linked to my revert [1] not work in your case?
>
> [1] https://patchwork.kernel.org/patch/11718481/

Thanks for pointing it out Frank. Also, might want to avoid top
posting in the future.

Enric, Can you please try that other fix and see if that solves your issue?

Thanks,
Saravana
