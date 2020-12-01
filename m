Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7972CB075
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgLAWwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLAWwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:52:25 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C049C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 14:51:39 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so7990453lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 14:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuGYiAw93uDx+xaKnW4QcfmpD+bqUd6sOz1Gxw+OYkc=;
        b=s9gA9NnbuZMwhgs/0p6cuZz+VMVRS/lamlHAPdz2exim393gyZGCxk0CcZuEMpbwMK
         fH4JQSsH2YEr+kYUFYUp/uwTAlwU5sxCbQX1ZDduTY/XnJI2xorGm6wM3wgzQ7/IwPhb
         wrvDk2d53Cspe2zNLTQ/CLOrKVbBTf17PkvLDXyZyaekiwXK9TVnkAEznuYn0mFsCRDR
         o0zp4TiQARV3hIwxo4oQeN2OLsQcJMZl7ZvddVqXGUcXQjRgKcuQZcDQJYBN7JbGNaOt
         jWGYQvUnPxsuaPo9VC355ztSRSIou2SoEjE1GeajgWebXStPebq3VS56R5Vqh53LeTJz
         fKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuGYiAw93uDx+xaKnW4QcfmpD+bqUd6sOz1Gxw+OYkc=;
        b=M7i4zJeyJbNXIRIDZbHcQGfErutHGw4x3ZOstEFCmul5VWAetEVxE3D7g8xI9AhdRT
         4nPTugeoxwlLNFXt3PNgsVKOpH53iOvjV2t9pSlAmK/g90NQs2g7C1E4M9tJ54MTxiV6
         rueb9dVKT0ThKkfoUA7YZfB5WI0ebfzSrNl0AjqqRIj/HwG1JoJJAQA21QpyOLNByQde
         zrQo7+/+y+wgETfojyyBXZvppRlchRN71ZtHWbNAnJprYF38VNrCrX7NgK45A1vNh+8L
         nwc5NHItLFYvx9FtxGG5QB4yWVqnBNAJEWfr3XOUIogoPZ2T6E3i18lSBn+07YJTfJxl
         i7nA==
X-Gm-Message-State: AOAM531MU9cW6LUkniJwRPMoDzJRzqqTZ7+8bJA8jpn73l0J6VoA+6cT
        jKBScnH8xU9NO44Q3aApVo/fTJWr+B0kH0OerYOFWg==
X-Google-Smtp-Source: ABdhPJyMHXSo0CkA53KWmGGRnV17KWYucQiKdb4Cvj5CJ08lhkLxW78peAVGTVWbJO/2UnueSxN2YjPI1XiO2T7etmU=
X-Received: by 2002:a19:8686:: with SMTP id i128mr2242469lfd.333.1606863097604;
 Tue, 01 Dec 2020 14:51:37 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
 <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com>
In-Reply-To: <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 1 Dec 2020 23:51:26 +0100
Message-ID: <CACRpkdYNL=PbWgf9wdKpiC2y1iZFG-ZD47O8u2a22zzGus9P2Q@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 6:13 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> I am not sure if DT maintainers accept that we revert a DT change just to
> handle some change in a driver. Usually they insist on fixing a driver and
> live with the DT. DT is carved in stone or could be ROM...

I usually use this rough consensus: is the DTB flashed into millions of
devices and supplied to the kernel using some bootloader, and
is the kernel upgraded on the device without also upgrading the
DTB?

And I mean in practice, not in theory.

So whether the DTB ABI can be changed or not is a practical
deployment question, not a religious sacrament. It came from systems
such as Sun machines where the DTB was, indeed, in a PROM,
and indeed intended for SunOS so Linux had no control over
it. We had to just treat it as static ABI.

If the actual situation is different, sucn as kernel and DTB are
always updated together, or those are a few custom systems in
a factory floor (not millions of mobile phones or laptops) then
it is fine to change it occasionally even if it is seen as "bad".

Yours,
Linus Walleij
