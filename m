Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F33E2E19B5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgLWILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:11:48 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41605 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgLWILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:11:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AE8FC5C013C;
        Wed, 23 Dec 2020 03:10:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 23 Dec 2020 03:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=JLMW/D+ECKxiFyolA2zYLf4S7Yi
        Cp4T5fFM4pjEOdX4=; b=f34H+NPrkQKiXR5MI2HH+EAgaeNGhntrItL+tKYF4HB
        iQeEC3bjH/cxNWNL3bkIeYWDoIUmdnY+j/JDbcN3mk/A+E7ht3iU1MgPkeLRFOJT
        2gdzqnkkhBhUGxC3FjdElXiLkYWH2kxRj1d+5IrgWLr03lZXDH5y+ecvGPmULe3Y
        Dp+PZa4lDC2FtE5evEcHKOg5yVZ1Tk3dD6rjqaqaPOMyuyBHKfxw/CL19zP1SZno
        xhsgGIcl5z6sZ3ZXaJ5N5+Htqeq03J16Cu/irNrrtAtqEg//ZF04gAeSbJblKzvS
        NMkUanXSHE0QFn8BnyinYSqW7CrBcvkzfG+2HOzaeRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JLMW/D
        +ECKxiFyolA2zYLf4S7YiCp4T5fFM4pjEOdX4=; b=iFt5NUptiZ7imZfhUQxsYy
        aWJCOHdMSjhG84tB7kCoq5H/ZwcJAgX8VpjMywrfl65hLFM7rCsVHbnCxHgGJb9s
        vrqYAZ/C2LSLpR/NCY9DZXxp3OAGjW4AaUrk+HVOAZGlpD98QfJR40pcLj60EdMc
        5HERDeeLFcUluh77yfvjL7z5XqTM0XmkUBIlTO7ECLZWDMbe4/eEJNZAML1k76f6
        PDGQd9FC04f5acR+6kKDcRvZTzbUfKMMxrGodhqMKHCRnZ9zQ22XDulCV3P7X2sD
        JPkz29XD8FiEe/fe/YiyZHnAqcxZ1YV6EuyzAAjdIqOUaHSY4Ylx0LhCcV5nwELA
        ==
X-ME-Sender: <xms:gPviXy21pn-IFzS6LmsaidGTJ_NDcVNHX2ggCztNdzdWkOJNDTkhVw>
    <xme:gPviX2qORPXUFXOadtY8T1Qb7r6Dp-ceNOgkzPH-ZZ8DDk1QqrsQXmeJaWhKu6yIP
    HGzB7JuAAlnNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtiedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepveeuheejgfffgfeivddukedvkedtleelleeghfeljeeiue
    eggeevueduudekvdetnecukfhppeekfedrkeeirdejgedrieegnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:gPviXxPGp7PeQJNHVHgn7lVTjx8aZGYwxgLh8cWRv9LzkgZfRCH1_A>
    <xmx:gPviX_qgjsGZqzya1l-ZDVDycbEDkqPPbVVoRpbDCAECytOdolB5aA>
    <xmx:gPviX8snSPG3ZeuU4Hf3yitsKL8cHQAMjLS-Q_oX23DjarmdcD2sJQ>
    <xmx:gfviX6UbIaKAbjep1yODn90-Aoc4FjKqiPYMIQPQ0VKBcaj1ZnqkOQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0FA87240062;
        Wed, 23 Dec 2020 03:10:39 -0500 (EST)
Date:   Wed, 23 Dec 2020 09:10:38 +0100
From:   Greg KH <greg@kroah.com>
To:     chensong <chensong_2000@189.cn>
Cc:     linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com, chensong@tj.kylinos.cn
Subject: Re: [PATCH] staging: comedi: clean up debugging code in #if 0 or 1
Message-ID: <X+L7fjlFKWHEwwJh@kroah.com>
References: <1608690044-26710-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608690044-26710-1-git-send-email-chensong_2000@189.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:20:44AM +0800, chensong wrote:
> There are a log of "#if 0" or "#if 1" in comedi driver which
> cause warning when running checkpatch.pl, they are supposed to
> be cleaned up before release.
> 
> Signed-off-by: chensong <chensong_2000@189.cn>


Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file, Documentation/SubmittingPatches
  for how to do this correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
