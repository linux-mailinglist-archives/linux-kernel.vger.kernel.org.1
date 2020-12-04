Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C829C2CEA47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgLDIxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLDIxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:53:44 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619CCC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 00:53:04 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id o1so3425948qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 00:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ie25EXYGJygVSq1WCc3nxTESm5cgyIfQIT3ckwHo9Es=;
        b=nI0FiqTRD2Uc7pujsoo8JHuFJYFma9yUkqVRq8LWwnqTcUo5rxCgfAx05yc+PWUiJH
         OzP5V3COQ/H1HwDb5aa1TZvyTdFXUAVnGqDDZOIrG2cHX/zOvQaqPhabHoPphkzXiUQ2
         BIPWES+dlWXWdWzC4ZY69aTC041wbemwIxCL38PdrzphqzarVGYtlbhWJcZDiDzjldVc
         lFi47XJ1O7T/jSVoQ+rirQn+Tfqg4BiW3kyppNwiZ6OMVr0E0XSAAXpVvrme92mwrZi8
         wYBvpMGukkROYPtVUUUJy4BMDeMsbaUyfGvW59Y6AzaccMh2ZqcgCKLHOQo7OGn6/C0v
         HSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ie25EXYGJygVSq1WCc3nxTESm5cgyIfQIT3ckwHo9Es=;
        b=HgpqhEiDKDMoRbxHU11tI6U5kIfmQxqdAR++vHJpEerXkiqtyjU/+gcdovR0gzviqn
         amSaukFbanA3dalb9BsOUq/z0o1NXCx9IkzYUSM1Rm4LIfbgprmo9W8heALdMYwsuqsG
         mUg22SH+B9eGirY/2KohVajTAj1vei91322aStyqOvtxdaSRfUvCBPL19hYgOUc+yB0W
         I2d7Z/KINq8R/gd77SWqB7k6LF51x/PhUxzKTkEef+PVkbLhuglpR0QX0/oPHqRahoBy
         NxndVCie8LixwFK/7TAxsyM20Hj3CxL2/1LqMhefnTmFCffW/h4lFNZlbd+48CaGH8mF
         QZiw==
X-Gm-Message-State: AOAM531xZCfVWrLQFuY9ov6zExJH8/JLkXbV5JXhA32j6sl2PdBdgBrB
        tN8N8NfuulKYp/jq/Im7m7OlQfN97b3o+CJRPFQ=
X-Google-Smtp-Source: ABdhPJzeojDScSBtppSAW7yMarKnc8Aa6DXfy/aKs60aX6n3wPYeQQQQ/xQJh3Yz18uPiJFsmwumDDZhj0hRntXMRPI=
X-Received: by 2002:a05:622a:24b:: with SMTP id c11mr7237941qtx.166.1607071983687;
 Fri, 04 Dec 2020 00:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20201125071132.39988-1-zhongguohua1@huawei.com>
In-Reply-To: <20201125071132.39988-1-zhongguohua1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 4 Dec 2020 09:52:52 +0100
Message-ID: <CAFLxGvxSycd=6WE4=XnrXxuF2Bc6A6ULA8GfkT8QvgcX=2Gk8g@mail.gmail.com>
Subject: Re: [PATCH v2] phram: Allow the user to set the erase page size.
To:     Guohua Zhong <zhongguohua1@huawei.com>
Cc:     patrick@baymotion.com, Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>, wangle6@huawei.com,
        young.liuyang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 8:14 AM Guohua Zhong <zhongguohua1@huawei.com> wrote:
>
> Permit the user to specify the erase page size as a parameter.
> This solves two problems:
>
> - phram can access images made by mkfs.jffs2.  mkfs.jffs2 won't
> create images with erase sizes less than 8KiB; many architectures
> define PAGE_SIZE as 4KiB.
>
> - Allows more effective use of small capacity devices.  JFFS2
> needs somewhere between 2 and 5 empty pages for garbage collection;
> and for an NVRAM part with only 32KiB of space, a smaller erase page
> allows much better utilization in applications where garbage collection
> is important.
>
> Signed-off-by: Patrick O'Grady <patrick@baymotion.com>
> Reviewed-by: Joern Engel <joern@logfs.org>
> Link: https://lore.kernel.org/lkml/CAJ7m5OqYv_=JB9NhHsqBsa8YU0DFRoP7C+W10PY22wonAGJK=A@mail.gmail.com/
> [Guohua Zhong: fix token array index out of bounds and update patch for kernel master branch]
> Signed-off-by: Guohua Zhong <zhongguohua1@huawei.com>
> Reported-by: kernel test robot <lkp@intel.com>

Looks good to me, except the authorship.
If I understand correctly, you took this old patch and resend it.
Please make sure that the "From:"-Line contains the original author.
You can fix this up using git commit --amend --author=.
The git format-patch will create a correct patch.

-- 
Thanks,
//richard
