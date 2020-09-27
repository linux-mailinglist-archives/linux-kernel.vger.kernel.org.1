Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D160D27A0E5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI0MZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 08:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI0MZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:25:08 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317A723718;
        Sun, 27 Sep 2020 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601209507;
        bh=IY/N4/ki8QJZ9vdRwB7Eus2b1ptin2/9EGBJa2l8EbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wKm0mWRV+6ARVxIfY4vm2CJU32hbHecxSvUSR81Yh9pkW7vpX4+FoF5b/3lUa/qwO
         YeB/uIfp1P5Uj8s2h2OOFB/DM+ciqibvsE52+Bh20TQXuXQWfepFotLOV1Px8lALdR
         DbKRxNKrZu4+wp4mrgnawtfkO67W+FKhN7H1kMM4=
Date:   Sun, 27 Sep 2020 14:25:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nvmem: core: fix possibly memleak when use
 nvmem_cell_info_to_nvmem_cell()
Message-ID: <20200927122516.GB179084@kroah.com>
References: <20200923204456.14032-1-vadym.kochan@plvision.eu>
 <12edae35-a927-11bf-f80a-037011c4f07a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12edae35-a927-11bf-f80a-037011c4f07a@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:32:42AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 23/09/2020 21:44, Vadym Kochan wrote:
> > Fix missing 'kfree_const(cell->name)' when call to
> > nvmem_cell_info_to_nvmem_cell() in several places:
> > 
> >       * after nvmem_cell_info_to_nvmem_cell() failed during
> >         nvmem_add_cells()
> > 
> >       * during nvmem_device_cell_{read,write} when cell->name is
> >         kstrdup'ed() without calling kfree_const() at the end, but
> >         really there is no reason to do that 'dup, because the cell
> >         instance is allocated on the stack for some short period to be
> >         read/write without exposing it to the caller.
> > 
> > So the new nvmem_cell_info_to_nvmem_cell_nodup() helper is introduced
> > which is used to convert cell_info -> cell without name duplication as
> > a lighweight version of nvmem_cell_info_to_nvmem_cell().
> > 
> > Fixes: e2a5402ec7c6 ("nvmem: Add nvmem_device based consumer apis.")
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> 
> Looks good to me! Thanks for the patch.
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Greg,
> 
> Can you please pick this one? As don't have any nvmem pending patches to
> send it together.

Will do, thanks.

greg k-h
