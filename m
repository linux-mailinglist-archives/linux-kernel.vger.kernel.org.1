Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDBD2936DA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbgJTId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388914AbgJTId1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:33:27 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D15C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:33:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l24so942935edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58AkHmn0/n9F+uToLQON7ODblLUEHphsnb6OZwgBwss=;
        b=tYc7DjVBH2EgcctKtLtBSnPZZGESEibnXrZkC7yGNR4uCgXcG7ZHbwbbT3i6apQXcL
         quGBGdSdWQqE9HTaPLdlXXBIO0bJkUWB/aCjEUFIbhUDrgh4fNpi8hXkE8EqTufO9zrG
         Qqj85OBfYtUy57Wj2mdUeSCl4xIq4wRCaMfCOnhbOcOYzq3wkcEGFvZa7jbs7o9rsWec
         HzyRjFo8h8ymqQxF8Q8d2ZkTs83pna8jKlozJFoWEkPUHj3y83vAbMczi8yPz58jqRKZ
         ntvkbtcEzo35IC1eahNfu/nmqIm5iUlmJ3IykJ1YwjUmXZohGpUUYxqgb6/O08FtG3Nw
         NKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58AkHmn0/n9F+uToLQON7ODblLUEHphsnb6OZwgBwss=;
        b=tYnhFZV/RddqlJXxS6anT+fGPcMESZPQ/fWikqX7yhXn1m63uT60s6Fe9dxOi4C54J
         8tqddzH/XlIXiHUsvbFpHSuHsoHzlAaWQ6FSH+78hme8f7CjrP9xSFf+I8aSQYHyNSHK
         g4D1UEWWWDdQwHQ3wW6US9s+/qtcJoco+Q6hmqjcMz2ZFr69PQT+DFgte2QQ7bjbIpNt
         CxMdfBGbyYkPU3WGJqFUx9O7CNoLqRLsBWHZ/kOrA4HTBDFOAwkOmc9rz7pPt59I/6cN
         OPdwpw/1iInf8iqHz1eOM/4dsjWZkEQ90jTbG+NSI4CJJyWXLmoq49wTMc/BBeRdLrmB
         Hl8A==
X-Gm-Message-State: AOAM533hthIFOb4WBEYMJIDEcMFV9uNVmJolNgU6K9iu0XEaq97dsBWR
        rG5d/GZTZvOpj+a4dQXOs1qdPbxlqvBc3xUkBOI=
X-Google-Smtp-Source: ABdhPJzzwqovonklQjOOxf+6YT09ESPFNqFNlNvZdgBlBIvHmmrfhE4K4PblcmfS2wP8S8tBy+jGXf6ijq4eMcCZ6zs=
X-Received: by 2002:a05:6402:a42:: with SMTP id bt2mr1562670edb.193.1603182805562;
 Tue, 20 Oct 2020 01:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <1603133171-87982-1-git-send-email-Sanju.Mehta@amd.com>
In-Reply-To: <1603133171-87982-1-git-send-email-Sanju.Mehta@amd.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Tue, 20 Oct 2020 16:33:14 +0800
Message-ID: <CAKF3qh0GUgnyxx4P7M8jtwPdPT0xTPBjBQU3j8sqwsYANJrLag@mail.gmail.com>
Subject: Re: [PATCH v2] pciehp: Add check for DL_ACTIVE bit in pciehp_check_link_status()
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 2:33 PM Sanjay R Mehta <Sanju.Mehta@amd.com> wrote:
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> if DL_ACTIVE bit is set it means that there is no need to check
> PCI_EXP_LNKSTA_LT bit, as DL_ACTIVE would have set only if the link
> is already trained. Hence adding a check which takes care of this
> scenario.
Sorry, I couldn't understand the logic here. if DL_ACTIVE was set,
PCI_EXP_LNKSTA_LT is to be cleared, vice versa.  why need

(lnk_status & PCI_EXP_LNKSTA_LT) &&
 !(lnk_status & PCI_EXP_LNKSTA_DLLLA)

Double safe ?

Thanks,
Ethan

>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 53433b37e181..8ab2f6a2f388 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -309,7 +309,8 @@ int pciehp_check_link_status(struct controller *ctrl)
>
>         pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
>         ctrl_dbg(ctrl, "%s: lnk_status = %x\n", __func__, lnk_status);
> -       if ((lnk_status & PCI_EXP_LNKSTA_LT) ||
> +       if (((lnk_status & PCI_EXP_LNKSTA_LT) &&
> +            !(lnk_status & PCI_EXP_LNKSTA_DLLLA)) ||
>             !(lnk_status & PCI_EXP_LNKSTA_NLW)) {
>                 ctrl_err(ctrl, "link training error: status %#06x\n",
>                          lnk_status);
> --
> 2.25.1
>
