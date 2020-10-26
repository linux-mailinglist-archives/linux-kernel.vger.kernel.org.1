Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C53A298EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781065AbgJZOOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1780363AbgJZOO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:14:29 -0400
Received: from coco.lan (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE24021655;
        Mon, 26 Oct 2020 14:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603721669;
        bh=2qLSIc7k4XMXAWyWMEK9MRLmkYAUIzU/1aq7uRh/K/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K3IKflmpxBRU6TXMyWrNEDYrZiZ1oNRms/Eio7YpPVPZaOwdl5rWt97pyF8z+9ps3
         XG1fXkbVdFO09ithiMvD56yHvQbdxY9RGmYGJJsRk/dAAj4giiNV3vZRVdXRUIbmPA
         l6sUeiBCrc8TRn5cbSA7Uy0WgzTiqGnVtQsdQ+Yo=
Date:   Mon, 26 Oct 2020 15:14:23 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, paulhsia <paulhsia@chromium.org>
Subject: Re: [PATCH v3 48/56] sound: fix kernel-doc markups
Message-ID: <20201026151423.622f847e@coco.lan>
In-Reply-To: <s5h5z6x5cdg.wl-tiwai@suse.de>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <535182d6f55d7a7de293dda9676df68f5f60afc6.1603469755.git.mchehab+huawei@kernel.org>
        <s5h5z6x5cdg.wl-tiwai@suse.de>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 26 Oct 2020 14:46:03 +0100
Takashi Iwai <tiwai@suse.de> escreveu:

> On Fri, 23 Oct 2020 18:33:35 +0200,
> Mauro Carvalho Chehab wrote:
> > 
> > Kernel-doc markups should use this format:
> >         identifier - description
> > 
> > There is a common comment marked, instead, with kernel-doc
> > notation.
> > 
> > Some identifiers have different names between their prototypes
> > and the kernel-doc markup.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Shall I merge this through sound git tree?
> 
> Or if this goes via doc tree, feel free to take my ack
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for reviewing it!

Feel free to merge it though sound tree.
 
Thanks,
Mauro
