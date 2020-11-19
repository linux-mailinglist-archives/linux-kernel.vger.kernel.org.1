Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BF2B9DC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgKSWoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgKSWoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:44:00 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B7FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:44:00 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z21so10617734lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 14:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS2ziAVItkqEx2SqUODDHSlWmSIFo8HRkkEU7BX2L3o=;
        b=Zp0HLWq0Gd81klL3naebwMq47XHq3qGVLpz/+ELC34vtM+h0SCVRbwqOe8PNvnXotV
         bgGIVXy61qLL1g4h3GAgbZHvoFQcvDfpuVXWgjOJOYpeIz3GQKo7I95yshdAjUsNfu9E
         FUlXgfIxfXKrAO/bHsHrpP4C4Ls2ND4EDsq/BDOSOoDLOIriH/rnCcRA7JGm+2s6ocuk
         JHQ0MaINt6BdFKnhtprLPXfeCWxgTGR7ipIBBRAxtUCNVMgQUm8hMVD435CR0q2zswcv
         XN7NXR4cuQNN9S1883PSTQv0zFJ/WcDzBdluZXnogvlDe68DxwPCJNMgkeh2rrjPfgyD
         QFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS2ziAVItkqEx2SqUODDHSlWmSIFo8HRkkEU7BX2L3o=;
        b=IoaX/ZmisHjLofdVzdi1hOzB7+hQ3PToNGRXfP4BlMQ2q0YQTdcs2/bz7Fu4tZgiqs
         9qzafwHwf/1/8cFZkU/FN/aQWpVTELeOnvPk1ruwIZIJBj42PibhMlPsxUXnySxMIugH
         nF6cQtXVTCAlrRnpZkDhX335eTXP1am1zgj1DhCpsZYv6qjppsnfPYn7Bic9Xn4Us/3g
         X9dWrXJfeW3Q58McnjiptDrpYMzL7S3oht4Zsh36ohkAibFMo9zucNFnIygQRi0cfXbv
         SydvxSr+It//a3YJWQ6aalUKH+BH6v+4Cy7lElvMsSFHblRskDKoBayFNiF9abowe0ge
         trqQ==
X-Gm-Message-State: AOAM530Ey/0kEmv5WGl88qtRsfUIvbUiB+UpS8q/JB8LHzMMT6fahgl1
        wl5WxuDgPN4Sm35cw4lVnjikNk3eZ+YfnbVA5OOBYA==
X-Google-Smtp-Source: ABdhPJyOFxXPk10FgyOBdoONY7hsC26aNygRvmBzCcUSDQ6YoVn4/SWQJv32hHxm1JmcSFwvxAJq5LUT8sG05pYvK6c=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr7181693lfk.338.1605825838254;
 Thu, 19 Nov 2020 14:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20201117003135.1749391-1-rkir@google.com> <X7OUZmlRAuwWWHEn@kroah.com>
In-Reply-To: <X7OUZmlRAuwWWHEn@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Thu, 19 Nov 2020 14:43:47 -0800
Message-ID: <CAOGAQequ6hhzCjpf8V9vp=0xrAS3rs283goSFFfxVFw0ByjfPg@mail.gmail.com>
Subject: Re: [PATCH] Update MAINTAINERS for goldfish-rtc
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        =?UTF-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lingfeng Yang <lfy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +M:   Jiaxun Yang <jiaxun.yang@flygoat.com>
> > +M:   Huacai Chen <chenhc@lemote.com>
>
> It would be nice to get an ack from the people you are removing and
> adding to this entry :(

Hi Jiaxun and Huacai, could you please ack this change?
