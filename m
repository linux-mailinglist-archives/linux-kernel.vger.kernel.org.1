Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231922ADDCE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbgKJSIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:08:23 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44729 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgKJSIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:08:23 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 72B5A4C8;
        Tue, 10 Nov 2020 13:08:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 10 Nov 2020 13:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9457oUm/XwqLd+xICXzQKpwpzVt
        0qdLN8gjUGCAdAQA=; b=OMUtlD3uUhFgbKhEmuPIwoHK6zecOpMBRgAMsfb06Ik
        NSeFJQNHgzycd5qGLN1ECXP++ruqe2NttqZiV9GcAbBFCx3aXIEx94aGIVW6NRWN
        x3exGPj8LsN8YoJETEB4GQI1/T7JyCWuqHji70dSrfyRUJBfYxsybnhC2ASli1qX
        5rsOqzWWa2+fkosEhAJESlxM8vLHvMN4inazcCt3jDZ9jbjmxhYPBRhrvtkIDrzm
        fIML3iSsdDxbCqDq7C28vs74LPwPvmdI/rvVYyORp6VpMinJc+nEdGRbK6dBTQmt
        emiyQi+E62Fzxc1OVdy+zuNOtAjpikf0YhQFxtw2lSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9457oU
        m/XwqLd+xICXzQKpwpzVt0qdLN8gjUGCAdAQA=; b=RmTdhs1Vm90RlkgqxFEiCr
        MlhU/V9AOreuj7eyXp1erQLG0dt0eoj8CrL/bjq8dIZrNhRvtTSYervwa0n/xX9Q
        XNnqWNuLgPLwksR7a2pSCawAzLyckDtnecXzPaH3mEyUAWrOzAB8zbjG1qUVqK+1
        D1TSRHfl/3a7yelpA9OrhB6W9f5PTa8OBOEfllhsYmxAq+grJ77koC2bDyZgdM7T
        LcqqTyOhij19ZlneGWb8UDbpfsx6cC3X2l70YZE8lekmps2jw2p4Pq3f52vG3MT1
        nmi/lZbnh4RwXCcciTRWqnrVmt45fqZ7HxkEuQrxUdBG/V/+uxAJ10QKb0bkrE9Q
        ==
X-ME-Sender: <xms:FdeqXxcZwqGWfSg2HDG8dhPgvzTJnxMixsSsFm-rIos9bzOTmtDQXQ>
    <xme:FdeqX_N0WZ3dnCMqRY_lX_zVi-7-EoicfcdqhIafOwKRyZvgobGQ1w8V0E_NbvLuI
    3KlvbeHvCkgMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuleeltdehkeeltefhleduuddvhfffuedvffduveeghe
    ekgeeiffevheegfeetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:FdeqX6h1jd8sCbovTYlfIbxNVI4hkZEmrWNGhnjGKskrHhzU6xouDg>
    <xmx:FdeqX690s7LGDHSItftK1LA3JdAP_N9K1JqsaYA3sJ92t5qlj5jCRA>
    <xmx:FdeqX9us1eDg_HWThp1nHe4tzI0GJ4eTA818N1pUy49_aSumPGAnOQ>
    <xmx:FteqX72f5C6B7UwUqe0-gXmhiILo9NS4bDDgaHd7J-meo3gEq1Siew>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 87D323280059;
        Tue, 10 Nov 2020 13:08:21 -0500 (EST)
Date:   Tue, 10 Nov 2020 19:09:25 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     snitzer@redhat.com, stable-commits@vger.kernel.org
Subject: Re: Patch "dm raid: fix discard limits for raid1 and raid10" has
 been added to the 5.9-stable tree
Message-ID: <X6rXVTC9lOoRM9IH@kroah.com>
References: <20201110150632.BEE662076E@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110150632.BEE662076E@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:06:31AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     dm raid: fix discard limits for raid1 and raid10
> 
> to the 5.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      dm-raid-fix-discard-limits-for-raid1-and-raid10.patch
> and it can be found in the queue-5.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Was backported with odd build warnings, so now dropping it from
everywhere.

thanks,

greg k-h
