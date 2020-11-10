Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4672ADDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgKJSHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:07:30 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:33553 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730504AbgKJSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:07:29 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D0C4F13A9;
        Tue, 10 Nov 2020 13:07:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 10 Nov 2020 13:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=l7QHak7ESVMStgQxNDwhr66Mk5j
        zNJZi9d5pVFXP3yQ=; b=XYxVrWxByKVxFVxzdide67LilgzkAZOBgE1lFna90e3
        nnFLvirP58aeNiXIhCMeE3gGkXhAEBueT5Jf4ksA00GFtWqyV1DeAHGWuaoOdeEl
        Yw3/NTtDUH6y3i3FdmUtjNssiqmhj3bVc0GwsuVBZ8gNJ2EFp+twac5co5AiCrvS
        lJpGrjk3prlq+xh31CkVpBRTJEHs8XhwIrdz6HfUnZHG0M1qlFaYwaJbSmkHIXAR
        0FqmHOaFKIK4LNH2hg4wwJebVVOUSC2lVtdm9ZDJ0iraeWJfa1xD3A3ISqp1+4v/
        sg6433Al0xo9IuwW/8bAgmU0NEf3arEHhhY16/SUChQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=l7QHak
        7ESVMStgQxNDwhr66Mk5jzNJZi9d5pVFXP3yQ=; b=iaFYyiT26OOCipAbPD4OPz
        36HHqSImnnPbCNzHU46wdznkzb7bgMsnPv/lDDm2JkcqSOGH0t7epiYMYb9STCBY
        qzGKtX1PWJa5dJciuCEeWG3CBYLZ1F9jBbNCrkgouI4gl2G6kne3furroFqQ/+nW
        2Xchn9GMTw2mbiZTPFp+XBTmV8V/lTg2R2K0M9p+0O3zs5LlXeqSoVT6A4jtOetI
        IZNZr5l/WfH2XY054ZUvgTVbF0Pou4Th9KVELzYOeGMz4lDMtjkUgamJaDcdJz5s
        /LUQxFhsv5Ma1h96/JQDogXqfKLjriWxOAKEYccwp1YwijeV1X0Azu90npnEtu1g
        ==
X-ME-Sender: <xms:39aqXxbu5xqfj0t-zGwjnHaV6nD77bs0e3m7Mnol2hUeZYN2OnYifA>
    <xme:39aqX4Y_5qx5n-kFkQp3zW4DA0IGIIi-CgjHjKbsAj799Yo1TaSgmxnLGfIHJgL4o
    mqOUsg-fVvRlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuleeltdehkeeltefhleduuddvhfffuedvffduveeghe
    ekgeeiffevheegfeetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:39aqXz_IAzb85mwTwms7_2Eu3iMo6PURp7WouAOyDxtRdmDq4NwDrg>
    <xmx:39aqX_pIfObU1Cg4RvEmCQdvMMzkgrZkabNKlFHMy-MctyDJS06pXw>
    <xmx:39aqX8pyNxsurzCEXxmY9kvXVelhuB4TkAarf4ryNjDW1W_gBQRGNg>
    <xmx:39aqXzQORIqm8riB7bC9lLU6UxzIsvk4KRDFiK3o33fhCVUYs8eSEg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id EEE13306307C;
        Tue, 10 Nov 2020 13:07:26 -0500 (EST)
Date:   Tue, 10 Nov 2020 19:08:29 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     jgg@nvidia.com, stable-commits@vger.kernel.org
Subject: Re: Patch "RDMA/ucma: Fix error cases around ucma_alloc_ctx()" has
 been added to the 5.9-stable tree
Message-ID: <X6rXHRXgoin0xa85@kroah.com>
References: <20201110150627.EAA1920781@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110150627.EAA1920781@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:06:26AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     RDMA/ucma: Fix error cases around ucma_alloc_ctx()
> 
> to the 5.9-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      rdma-ucma-fix-error-cases-around-ucma_alloc_ctx.patch
> and it can be found in the queue-5.9 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This breaks the build as well, dropping it.
