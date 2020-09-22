Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E167273BA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgIVHVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbgIVHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:21:02 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D928C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:21:02 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so16843575lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YDJN3EXMJU3d3rFlGH/rbr1Jkw5/Z+5EHDzOysJfBeA=;
        b=op90nJ/Xilj6wj8zFYKVPWih3L7bMN2b/pmbPyxdblp9CDe7tU531EzGIZf2FK5fWJ
         U9zpnkChjQf1ULa+aXwAebSAB+WAL0W4tu1rwnDM54HFhNmuVxKOR+/K90NtyyWMxTe5
         lYD02J1xdeKO+3jm1a2zUBdcb0KD3Z1k/avJBxGfyg1wSQc4Vk67TxiIG7nxEwme2qrq
         svO+YCFq8aXLUVATCM/O3Z5r2GQSu1XE93bbbFTunI3Z+T5bBPAfLSRs6vkEUltRnOJ/
         8MX0LZavN3NmdDjGsQKlvrPocR/xMwp4p+St+jzyiEu5fiGx52l+DhBRXcL6l7XYpdRn
         wJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDJN3EXMJU3d3rFlGH/rbr1Jkw5/Z+5EHDzOysJfBeA=;
        b=WolaupC4ZmWKIn7VHoYd6E2mZs7q1p8p7UD6J7dcufDb3TAsVFQFtrugxQK1+uazJG
         HvYtoV0eR1gew79yU+9k1TgiTtPEcfdpRi+8xXYvy914PgMr2dPXg/kJQ69n4DU6mjvl
         YZFAoGsBrQl3p3UXtg5Yl6MRA/7hwn01fT+pn6NBCsvtumsUpDXg4PR/0Vb/aX7fJECl
         jEbAKZAm9qmQGUy6y9n9bO5KpnzriRyUnteYRMXmfeWVZ/VZIJ3C/SXqEB7hgoyDV2SB
         BtQ7dgZ39bgdwM225U1niLqudyBfunSVfWyBmXxZp9J0kTxbMaawILQpb5vkazpssYom
         Ja4A==
X-Gm-Message-State: AOAM531KjiuvTCbM8IsR/9/TJa1Ag9PmtaBhgK2BFHF4gm8jC88Ynw0l
        9wf0XkxOuMypa4EuhfIIPbDs+59QfNvwo71YTzBhNg==
X-Google-Smtp-Source: ABdhPJwh3O18KE6fGKtQXUrgxn8PXxjeImqE7D3w3MW4Mz4e1jPndLWojCXgXFlL+dyvzth3ePoQxBdjtoxLMc5pb48=
X-Received: by 2002:ac2:4a81:: with SMTP id l1mr1089424lfp.388.1600759260572;
 Tue, 22 Sep 2020 00:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200902064407.30712-1-sumit.semwal@linaro.org>
In-Reply-To: <20200902064407.30712-1-sumit.semwal@linaro.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 22 Sep 2020 12:50:49 +0530
Message-ID: <CAO_48GHiAB1VOxd=bJWAqAh5paWAVRqLRDESiEXY_=c=uQ1jvg@mail.gmail.com>
Subject: Re: [PATCH v7 0/2]dd support for Tianma nt36672a video mode panel
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam / Theirry,

On Wed, 2 Sep 2020 at 12:14, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> Some Poco F1 phones from Xiaomi have a FHD+ video mode panel based on the
> Novatek NT36672A display controller; Add support for the same.

This latest version (v7) had all the outstanding comments fixed, and
Bjorn has also given his r-b, so could you please get this set of
patches merged?

>

<snip>

Best,
Sumit.
