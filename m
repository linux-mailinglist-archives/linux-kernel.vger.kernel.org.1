Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A930288172
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgJIEpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:45:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59431 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgJIEpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:45:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D97495C0182;
        Fri,  9 Oct 2020 00:45:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Oct 2020 00:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=S4/5eZfqaYaOzO/YeHgD2mGbpT3
        lW2T47+2f0JWAWZI=; b=pRhEWcT7KllZzKtVHmHyl+gJPE/br0RSkYako5P6vqV
        xObmNDyeJYriFvPBMmERo6eCwluPvHvEDtllve8wx65XAXVnD1mYsTqZdYTZCDAV
        j6S3XqMdslU+53E6G8E3D/zz8xekZSBRGFAjPnUJ0z8irrwD9LmXcf4hLmCeo12p
        0KDK98bSXfohW2ntyfCLVrCbTw4C1xpGYHwCvOeQA4Cl/XW3tY6d6pHOse1VNH8l
        wnKN+oaWAGAqlaZxJcufmq/ej7eN4DRZfOQ+Js5MikQlmXB7w/Yh+878UAB3FIf6
        J+mrWXzL4j+bOwa7ZJNlJmDqcD4FEO6d/rBUsvFnt7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=S4/5eZ
        fqaYaOzO/YeHgD2mGbpT3lW2T47+2f0JWAWZI=; b=Qw9W9492QtF0bYh8C/s/4R
        XyOuGclsmyzEnJfbOxA+1NBMfRf26XIqFVoA7j/Bj4SJ4Swm7GLmulUase3UWIWq
        zU7snfPVp66TwSIO41hgqKz3vJP4piCL+XEgB7oM3050qxg/HJxed9yyiFValNRw
        SE1CDy7YQVyioODCN7ju0BgbRtcBA3Bs/LkNkK78IAZXN7MWbsMOeauBhKIoEwVB
        SnzIZANjw1ejztlDZYr4qEPO8QBgx5lmvfZiEx+E4Lr2zHzuKtfZ7l3SbUzi5DAW
        BWuqs5Uw4MlobSvpire6taRLJH9TBYTiBHlGYUkwiTq7iNvMEg2xI4pNH+zj53YA
        ==
X-ME-Sender: <xms:0-p_X2H4WQXCAv1Lar7i5G07Yme-8xzRZXn9G3fGPR1R5MniSflyXA>
    <xme:0-p_X3UD2HsnPoTMI3qqDa-2JUX1eaJAocU8EERIoHp-M3JJNL1c67U0h1xd_hnYH
    RnJVKSFD8gR4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrhedtgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:0-p_XwLvUGtMH6SsBrNZuRCQ4l5KiyZwI9wutGi--2V3ERzsFkUpiA>
    <xmx:0-p_XwH87L6RJf--u-suOApyPDtrz29jpM2ZbQmNZ2YQqJgJbhkRcA>
    <xmx:0-p_X8X2f6DBPG46MS6ZREr_tFiMUtD9sFTJaheFgkpFX9rAubb70A>
    <xmx:1Op_X-I3Kqd4GhCOq__lCtogIVOhXuZGJB-ccQoOLkWhq0P9-0vSCg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58B903280060;
        Fri,  9 Oct 2020 00:45:07 -0400 (EDT)
Date:   Fri, 9 Oct 2020 06:45:05 +0200
From:   Greg KH <greg@kroah.com>
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, bmc-sw@aspeedtech.com,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 2/3] usb: host: add uhci compatible support for
 ast2600-uhci
Message-ID: <20201009044505.GA111063@kroah.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-3-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009024937.11246-3-ryan_chen@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 10:49:36AM +0800, Ryan Chen wrote:
> v2:
>  - Fix continuation lines, align with "of_device"
> v1:
>  - Add support for AST2600 SOC UHCI driver.

These all go below the --- line, as the kernel documentation asks for.

> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

You have no changelog text here at all, and I can't take that, sorry.
Please fix this up and resend with a proper changelog text.

thanks,

greg k-h
