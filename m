Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DA22BAF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgKTPp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:41548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgKTPp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:45:26 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449BC22252;
        Fri, 20 Nov 2020 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1605887125;
        bh=t4FPdIp/srlG0I4RLF89pJGn9GvpCylyQzugK7V4+Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HdkU2jz7OREVIZbvId+gLMOwHXTw34eIztWCW4o+OWDJWTH5qRe3q3kpU2rlrG4fC
         O8v2pbTEyU96Lj5W4YRggenDsvRUWhkAk+LiI6M039qdhASUVwv0WxZqhF5wekbiab
         KU4FxYlN1e1EIRKU+LwKwxdsb0pek7ZSbZTwRQwE=
Date:   Fri, 20 Nov 2020 16:46:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uio/uio_pci_generic: remove unneeded pci_set_drvdata()
Message-ID: <X7fkv1m4CvCcCbzF@kroah.com>
References: <20201119145906.73727-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119145906.73727-1-alexandru.ardelean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:59:06PM +0200, Alexandru Ardelean wrote:
> The pci_get_drvdata() was moved during commit ef84928cff58
> ("uio/uio_pci_generic: use device-managed function equivalents").
> 
> I should have notice that the pci_set_drvdata() requires a
> pci_get_drvdata() for it to make sense.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Apologies for not noticing this sooner.
> If this can be squashed into commit ef84928cff58 , then it's also fine.
> I've started seeing that there actually more xxx_set_drvdata() leftovers
> in the entire kernel, and I pinged the checkpatch crew to add a check
> for this.
> 
> https://lore.kernel.org/lkml/CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com/T/#u

I can't squash existing public commits.  Can you resend this and add a
"Fixes:" tag to it to show what commit it fixes so we can track this
properly?

thanks,

greg k-h
