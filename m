Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AC27E40F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgI3Irb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgI3Irb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:47:31 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72F6C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:47:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y17so1150695lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 01:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cr4F0zeDS/obqT3hxezbEXoAuNHnHKvlXLl42w4NaIs=;
        b=uvnIFiV7FZ+zzxcN3L+fCOcCWuTR9m5Qa6z3OabpBiheRDK7oh62P0AGiTJ6XmPIb/
         LbyEdCxFU83nObD/1diqJRWJlStu0Z5jC8YKKXrNm/btn67XGWCMhOkviYDGeFTih0lr
         tPMt6Whw+O1h3ZbA2rZ5mimAi8PWwVpQy4ek4HBScVoprn0iLZoVa0t7Netjtmmiil/V
         REimQjACKl1DgKtpQ4Yt7dPbJTE0au96lQDi/QUkdIMgVoR80ZwpE1cTIF8nKW0ss8ix
         AOKNfOOB7C9QqYFsUjoqnadPe2jn4unxwRkIBRv3NkTXHBsNHuJzF4m8hRO5E7+PmYO0
         svaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cr4F0zeDS/obqT3hxezbEXoAuNHnHKvlXLl42w4NaIs=;
        b=Vm/GQiCB8hxN1s1LxAbKijNyJjnT2+Wmi+Eu4ukx4mlj7+eDuFvxcrlLud8l1j+sOG
         4ZejypDWdwiiGSmvj+7mgMDIIDfqGVJ/tufoPrsQ3vI1ikNMgKLs9d93bCApEUlI94AN
         85s0RZt49t7LzWjF9F99o407XXAcEdZ44sOiR3GTsa+TzW5JpNPhblCFAoBxltS7ppqE
         ix5cTA9+99skmNQJLOtGTtzrPXhXVdW0e4N2cNQwz0a3uch+MeQQyXnzWw/LQQNTzt1z
         qWDFskz9bVtUiPcYqfqxpETICsGPNVFG8h2E++yoyW2Us7TEba4T1Oxtbj/gtW5JGvID
         F+cw==
X-Gm-Message-State: AOAM531Y++nwJykXIcpiXAdsd5HJAhq5MnGnEySc1rkmBfDJ8SfPn26e
        KVeoF/JO6lA+XOOtF5mKS7zvRDAFHYbCZKJxNEp+CA==
X-Google-Smtp-Source: ABdhPJxOpTPzyw1+Tet95je7SIFAGeXemd7JxYndbFKN8UuWccBXA0YLrbqMLAAR6lN3f0fEFaZho/Y4cHjNa8sCDj0=
X-Received: by 2002:a05:6512:20c3:: with SMTP id u3mr473893lfr.572.1601455649061;
 Wed, 30 Sep 2020 01:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200821075452.1543610-1-enric.balletbo@collabora.com>
 <99821f85-9a38-7591-f982-872603b6ce8a@collabora.com> <CAGp9Lzq-15xjvSVaEJ=2o18o-8ESGWsHf-LNAXXwKfxu4V-0NQ@mail.gmail.com>
In-Reply-To: <CAGp9Lzq-15xjvSVaEJ=2o18o-8ESGWsHf-LNAXXwKfxu4V-0NQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 30 Sep 2020 10:47:17 +0200
Message-ID: <CACRpkdYPoZX1+rfJb925_+H6YXiwO26cKLpZae=_j=RQKGA0Wg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: mediatek: Free eint data on failure
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>, hsinyi@chromium.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 7:57 PM Sean Wang <sean.wang@kernel.org> wrote:

> v2 seems the same with v1 or I was missing something.
>
> I just thought we call devm_ioremap_release to explicitly to free
> resource when a certain failure occurs after
> devm_ioremap_resource?

What is the semantics around mtk_build_eint()?

If it is called on the probe path no explicit free:ing is
necessary: anytime probe() exits with an error code,
any devm* resources will be free:ed.

Yours,
Linus Walleij
