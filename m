Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C202E9256
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbhADJGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:06:46 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56497 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbhADJGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:06:45 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E6B575C0053;
        Mon,  4 Jan 2021 04:05:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 04 Jan 2021 04:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=W/tjyQHZg/eDqynJBaRQjpcaU17
        zR9G/rdfy1VBuGYE=; b=GRIOaGj1/CGmcVQaGRBnri83ncEJuW/CQ9RZ9BTlcYr
        CGjx5waepgDhoZ620dutTAWPdvKktSKjQswWg8OdYdfqM6m+gSWfA3gJH2Z8p6R2
        BiOGlCDLLV2MvdcKVjSXeWLyV+VCWVMX3SPBeW3YE3umVS3oYocMtQGLJCQkLp0v
        IekWwLrcZuMQavzY4pGpgGoPJ9nDAbKapXjbKDbBLOQT+zMuYkfwjy9c2iYeF+AO
        JaVyKgz6Uphb9WU41Wh0wmnd5mopZALADzWMzfy6nOHur1uc1Hx8P2kGv6mXBKKM
        jPstKPNzT2Xdc/qnZZhCQ+UWKPfQhG0SDcPr6ZJOzXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=W/tjyQ
        HZg/eDqynJBaRQjpcaU17zR9G/rdfy1VBuGYE=; b=K1uwnrslsBk3qI2p2RBa90
        niF583DbmhQQZm2XnuoONy+bT8DU9f0LydTzvXCKcaHx+N8L2xWwVG/cegYQs8T3
        C+kJiB4dlgOu7rKBfCC+Moc+8nNOckxkwJR9G4j0hw40LIsv/GCM/U9IJkK7ls2D
        czxKemNIj21w3YUUl5656lCh1+oBDaFVHFnhMWRqFHoY0ta0DZzh3rMrvbx3Rmld
        3fiGMw88/ho1gXQO6UNx7QCqonJbSbKDLS9V+dKN4t67tZ3XMZ7qwCAoOg0GBNP2
        MJwiWuYGUBwjqiz+2K0ZXDrykHKB38SdHyMhOEGUjDj1LUD/McD08n6GgnW9UjfA
        ==
X-ME-Sender: <xms:YNryX8ZqR5wQJFc5J6DxSuxycUGVSp-scoELK1WY6B3E8tLgYI43qA>
    <xme:YNryX3Z21B4pZJSYoip2TC7_Ui0K2MZJbI74MwDHrhOfgkL5WVe5EV9mQvQnb8N7c
    rgjomkTWtVLuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeffecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgfffgf
    eivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedrkeei
    rdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:YNryX2_MDINKnRxw5u5Nny6P8KTmekCqtEtEsdTYY4UZuf6Naw0sCg>
    <xmx:YNryX2oxVkk8aCjtT7tWbG0drAPG6Dv040QdpG4lbfakHmTUBUH3Fw>
    <xmx:YNryX3oKFGA6WP7jw85x4iTADkUeIgZkXc_pOSrqEL8O6xauuyp7hw>
    <xmx:YtryX2UYHzcf984c5k11DfP2LcXs_aHZ_-fevnAaABF3FetApWWyuA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9D0F31080059;
        Mon,  4 Jan 2021 04:05:36 -0500 (EST)
Date:   Mon, 4 Jan 2021 10:07:04 +0100
From:   Greg KH <greg@kroah.com>
To:     Song Chen <chensong_2000@189.cn>
Cc:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        sfr@canb.auug.org.au, abbotti@mev.co.uk,
        hsweeten@visionengravers.com
Subject: Re: [PATCH v2] staging: board: Remove macro board_staging
Message-ID: <X/LauHVX4EPvuzU4@kroah.com>
References: <1609750546-17118-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609750546-17118-1-git-send-email-chensong_2000@189.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:55:46PM +0800, Song Chen wrote:
> Macro is not supposed to have flow control in it's
> statement, remove.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> 
> ---
> Changes in v2:
> 1, kzm9d_init and armadillo800eva_init are not compatible
> with the definition of device_initcall, fixed.

I already applied v1, so what am I supposed to do here?

thanks,

greg k-h
