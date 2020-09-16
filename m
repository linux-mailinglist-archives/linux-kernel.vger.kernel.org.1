Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61DA26C432
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIPPaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 11:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgIPP2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:28:51 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D80C0F26C7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:11:51 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id w12so8499556qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmSwwgRApuWjFHGB7W+jFZmuTijCnKbWhEp+HqBlplQ=;
        b=nPBXzU3bKbavHdKlSad7zOyn+joU/xOqRWpXOJL/FubEQVL0KeamtOd4Kg4Sy5oxx+
         bNdcJrVvxQRU7K0J6deAUElu5adUQYFaFldpz+gULHRE9AC320fusZrLm0ym92r5HNNc
         s0klAZ0aE+BorsWPbOJgZqENuGQ5PdbGAOUD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmSwwgRApuWjFHGB7W+jFZmuTijCnKbWhEp+HqBlplQ=;
        b=GsIU5BUuKSC9sgsM1qOXPhkZuOfIsaYi851s5AKtP5y5vQPWyR4yz81lehGm5+weBA
         kLYA88WgXzzCKlPpyMUnSXi5euckf+UfxeL7DP3MtIY6AZJwD7JQ36ZP9e9EiXdQ+tIc
         a0PLv8OU4GvsU0+PP35kXUfzQpz4FdgqS90V/wc/CHYib9d9XJ50qNfWNRsxdtvhXqLb
         bxsX3B0wyaj5WAjfQMPZbbiQ7nNn1N2o96N/0ZHkLKkXn/oD7mYK2bp/sKW/HoRezKcl
         Ohs2QMpFUPiP5jDN4Y+1g4dBV8JABQwk8MmJeK5RMDRw2oJ68+m8pN1WcaBwHzdqX+8A
         jktw==
X-Gm-Message-State: AOAM530rVGVItRLj7CSVr5qs9oDnJS5jZIW22canzCfp6ABa4VrjXuCc
        NQeFY2B2C5z3/V1OR7PluQHsY24NuSzzM0M63djMVg==
X-Google-Smtp-Source: ABdhPJxfF2KFeaaq9Lix3rS59F8pG78SIw8GTEov1W5DC2Yz9cQeIqa6eXdUFyJdroEixPWd8Tn2gY3VY0AjXXRlzbk=
X-Received: by 2002:a37:a311:: with SMTP id m17mr23363623qke.442.1600269109841;
 Wed, 16 Sep 2020 08:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200909040400.908217-1-swboyd@chromium.org> <720fcfbb-3f3a-9679-bd33-56d7f65651a5@collabora.com>
 <CACeCKacudCkMoT40UJaf8PKUQu9G0csBmhih8cBO2Y3TAhV-0Q@mail.gmail.com> <7b391f5e-8200-ddc5-eb56-164c6006a134@collabora.com>
In-Reply-To: <7b391f5e-8200-ddc5-eb56-164c6006a134@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 16 Sep 2020 08:11:37 -0700
Message-ID: <CACeCKadnTdtwS99GbpkpQorfU_Uv067qJCbSjDnb09qyo5ExsQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_debugfs: Support pd_info v2 format
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Sep 16, 2020 at 2:39 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
>
> If I am not mistaken pdinfo is used by your userspace, so, assuming we don't
> break (or we have a plan to not break) things I'm fine with it. In general,
> delegating things to userspace and get rid of kernel code is good for everyone.

Sounds good, thanks! I will look into this and if it isn't breaking
anything I'll send a patch which does away with pdinfo.

Best regards,
