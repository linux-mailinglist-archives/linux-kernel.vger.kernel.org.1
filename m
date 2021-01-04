Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0602E95A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbhADNN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADNN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:13:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D766C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 05:13:16 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i24so27256956edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 05:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmTnOyvAWkf1ZR5nEt8hocUqB4bK0OOI3ZU75pn4B8g=;
        b=rQ1aySv/Ai2QMmIOvi3obyVdHo4qx0sf1fjaXAS5KBnNL2y69Q3kw6Kt8L7cQLa39N
         OsTifxBviupCByOdGhSZm6kp9sLkZCz0Y2yuBf8cM8XeC7qHdJt3WaDkxzQ8qA6KKUkZ
         cf2ryOyKyRJluXcauzU6T3611yURcHWfKPyDwfg2zolvntSmEHLQOcD+tBFg9YUnXiRy
         01RsItPbMhQ2wg7nMK9JaxWukpnOa5e09tKuSHB+JKN+jgT3nZfZK0dEswu4kXTwUAmt
         p8f+miY70CWe2jdq/Rtwmg+d337ldJbMc4sJpOWYyUFBMbsZ3oCIdEk/AkbuXwUGX5K5
         FVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmTnOyvAWkf1ZR5nEt8hocUqB4bK0OOI3ZU75pn4B8g=;
        b=dyC8EofcmAz8vaDL7QhymFD27itPY9rXeMR9eWYi9c9WHbPW+Nn+enQUw5lV0FLLuu
         BaeDEnTaEO9zSL742fEzAsQ/0BPga2TlMi4vCq3OvNennxa+CdNmwo0RSkEGwH7BEAM6
         QlG5I4eB2vBgk0P8fb3OMfDRxeI63ySEcn8e9gZP9hnIDN2/kiCOkZZrNxOo4XiZucXu
         9ackaFXYdGawW4OkgbBNfiYzzRI+nCVVSkaDl8xFj8v1K+DBxCmKv4U0mvBz7ftvhsQK
         qkioWJgoF8RDofxjmD7gRJ7C3tyQVUm0jV5Jiizk3KmPccPPtxMk0NArZnUCxQ7uYF64
         Wlbg==
X-Gm-Message-State: AOAM533ByR4H1p6f9betLJEDsn2SBOxDCOxHDntAt1HX9jo3p4ZfC7en
        4qwwebE6cvzjSCtFo5bMJ5TuT+6SNIuYMFUMlCz9xD3Jifc=
X-Google-Smtp-Source: ABdhPJxCoesfWKWLGjDwujsOjYo8s+cdaJyZBKOpfJin4/auU3QNcr4Oqie33FxznE6OTDFJ6wuoJMoZXdFb1At8on4=
X-Received: by 2002:aa7:de0f:: with SMTP id h15mr71508029edv.110.1609765995234;
 Mon, 04 Jan 2021 05:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20201217221148.2877318-1-martin.blumenstingl@googlemail.com> <20210104094849.1850c993@xps13>
In-Reply-To: <20210104094849.1850c993@xps13>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 4 Jan 2021 14:13:04 +0100
Message-ID: <CAFBinCDw_Zwwww88Vd2yU5sMZxYg-NQWHhLiuV7A5rhApeNroA@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: intel: remove broken code
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

thank you for looking into this

On Mon, Jan 4, 2021 at 9:48 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
[...]
> >       nand_set_flash_node(&ebu_host->chip, dev->of_node);
> > -     if (!mtd->name) {
> > -             dev_err(ebu_host->dev, "NAND label property is mandatory\n");
> > -             return -EINVAL;
> > -     }
>
> This is valid code, it's best to use a label = "my-storage"; property
> in your NAND DT node. Then mtd->name will be updated by
> nand_set_flash_node().
so you suggest moving the check instead?
the original code flow was:
  mtd = NULL;
  if (!mtd->name)
     return -EINVAL;
  mtd = nand_to_mtd(&ebu_host->chip);
  ...

by saying that the code itself is valid you're asking me to update the
flow to the following:
  mtd = nand_to_mtd(&ebu_host->chip);
  if (!mtd->name)
     return -EINVAL;


Best regards,
Martin
