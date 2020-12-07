Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202332D0B62
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgLGH4u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 02:56:50 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51079 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgLGH4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:56:49 -0500
Received: from xps13 (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B2731240006;
        Mon,  7 Dec 2020 07:56:05 +0000 (UTC)
Date:   Mon, 7 Dec 2020 08:56:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guohua Zhong <zhongguohua1@huawei.com>
Cc:     <richard.weinberger@gmail.com>, <joern@lazybastard.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <nixiaoming@huawei.com>, <patrick@baymotion.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <wangle6@huawei.com>, <young.liuyang@huawei.com>
Subject: Re: [PATCH v2] phram: Allow the user to set the erase page size.
Message-ID: <20201207085604.57a37f69@xps13>
In-Reply-To: <20201207070715.15016-1-zhongguohua1@huawei.com>
References: <CAFLxGvxSycd=6WE4=XnrXxuF2Bc6A6ULA8GfkT8QvgcX=2Gk8g@mail.gmail.com>
        <20201207070715.15016-1-zhongguohua1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guohua,

Guohua Zhong <zhongguohua1@huawei.com> wrote on Mon, 7 Dec 2020
15:07:15 +0800:

> On Mon, Dec 7, 2020 at 14:56 AM Guohua Zhong <zhongguohua1@huawei.com> wrote:
> >  
> >> Permit the user to specify the erase page size as a parameter.
> >> This solves two problems:  
> >  
> >> - phram can access images made by mkfs.jffs2.  mkfs.jffs2 won't
> >> create images with erase sizes less than 8KiB; many architectures
> >> define PAGE_SIZE as 4KiB.  
> >  
> >> - Allows more effective use of small capacity devices.  JFFS2
> >> needs somewhere between 2 and 5 empty pages for garbage collection;
> >> and for an NVRAM part with only 32KiB of space, a smaller erase page
> >> allows much better utilization in applications where garbage collection
> >> is important.  
> >  
> >> Signed-off-by: Patrick O'Grady <patrick@baymotion.com>
> >> Reviewed-by: Joern Engel <joern@logfs.org>
> >> Link: https://lore.kernel.org/lkml/CAJ7m5OqYv_=JB9NhHsqBsa8YU0DFRoP7C+W10PY22wonAGJK=A@mail.gmail.com/
> >> [Guohua Zhong: fix token array index out of bounds and update patch for kernel master branch]
> >> Signed-off-by: Guohua Zhong <zhongguohua1@huawei.com>
> >> Reported-by: kernel test robot <lkp@intel.com>  
> >
> > Looks good to me, except the authorship.
> > If I understand correctly, you took this old patch and resend it.
> > Please make sure that the "From:"-Line contains the original author.
> > You can fix this up using git commit --amend --author=.
> > The git format-patch will create a correct patch.  
> 
> Sorry, I am not clear this rule before. But I found the same issue independently. It looks good 
> after changging the erase size for phram driver. Then when I try to send the patch, I found that 
> Patrick O'Grady has already send a patch which has not been merged as the link below
> https://lore.kernel.org/lkml/CAJ7m5OqYv_=JB9NhHsqBsa8YU0DFRoP7C+W10PY22wonAGJK=A@mail.gmail.com/
> 
> So I resend a patch with some change and fix for mainline kernel with the old patch link of Patrick O'Grady.
> 
> If I need to change the authorship, I will resend this patch for V3 with authorship of Patrick O'Grady.

Yes please. Also please drop the reference to kernel test robot as you
are not fixing an issue in the kernel that the robot reported (perhaps
you had a warning from the robot about the patch itself, this is
called a review and we usually don't get credited for that, at least
not with a misleading reported-by tag).

Thanks,
Miquèl
