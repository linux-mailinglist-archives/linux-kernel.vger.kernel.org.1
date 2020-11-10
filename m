Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75112ADDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 19:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgKJSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 13:02:22 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58081 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgKJSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:02:21 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7C0431408;
        Tue, 10 Nov 2020 13:02:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 10 Nov 2020 13:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=e+PgtdLdETzLArw3G0NnqKTOZtK
        0c/5+IbwCXV6Y/Gs=; b=yTrt0CRXI9Asv9Fese+xTkWX6G5Mf4VvpJCQQ+9Za18
        GnqXVkXzE6fCdS/SZL+M+H9EWtFu0oTaCrkpc9A7lysCWTq6N6uoxMeSKI3rGyv1
        QSmuHfKZXYkJHI0aOd10ClyC5751IZ9tYT8/xyw71V+0FNoct7Ze5rmb1weZSlEF
        NIloyXDmD65g0RhMueM8ARirbMKo1lZUFxMLNBAGHSNqMggyl95N0kpDRRjtsUTw
        7StTE2Y5laZJ+KHvzBMCZxKAMLU7DH7sZgbnDEwl84QRzFkdRwu9TiBbUQn46RZO
        HQ2cmOJJiaZELNI0u67SSSB3Pt64fG+0Y8ZQ8zgHnsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=e+Pgtd
        LdETzLArw3G0NnqKTOZtK0c/5+IbwCXV6Y/Gs=; b=XtZzZn+448NGwEZ/BQNS7S
        Znc0uPfSUWLEoaeS07mG+LE5JB5XTLxN2B+6r1kDeeXPOB/5Dq1kda2l+jV9W2QY
        t+2KGZFf5ORQljDtwmK2DDY7UWzStAf2VJBsTnSkxLv95A9NLfsJ/XdNFvvh/NmR
        4k5tOm89LQJkv5nj+X/D2n92hTzYLL1C+bDNJNB4JE/QtwgW0zr0cX6JC1BPFu3K
        W+YkTxRQn1SYXyGv1DabNTl9lRVsDSHkZfbulWfkT15hYIZgl7uJZ85Nnb1WJ6vq
        XMTkvaWpLa9moLJkIE+nQBsoyjEckK0LC7DAtIxhlcw5AcxZBPfKkizMbSwDYrpQ
        ==
X-ME-Sender: <xms:q9WqX1cMmyxunv9UBg_9itucVxMLAEHvNNEF6nZ6j8mXOVylG5xXqw>
    <xme:q9WqXzOHRGUL4MVvhy8--la--EG-ZpQLC0PCWAAls9age9NyhKjnwYAyXi9LCAdNR
    vYty58lRwlnzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeeuleeltdehkeeltefhleduuddvhfffuedvffduveeghe
    ekgeeiffevheegfeetgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:q9WqX-i6CYQnHR2Dhl40r8Eff_0luu013bL4NURggrln5NzV9zOQeQ>
    <xmx:q9WqX-9w1LjmoGQpEsSaD3ooxpQCJdA-LmdX6l-JGQ2kwnNKVjekIA>
    <xmx:q9WqXxuUgipH5R6pe2Qf_bjgwM1oA9uO3iXGetbwxmJsIU0NhWnSJQ>
    <xmx:rNWqX_1MLFSfFH4020i2LQjRIDw6J7u8yoEACYh7aOiebH054rpEBQ>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C4883063081;
        Tue, 10 Nov 2020 13:02:19 -0500 (EST)
Date:   Tue, 10 Nov 2020 19:03:22 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     josef@toxicpanda.com, stable-commits@vger.kernel.org
Subject: Re: Patch "btrfs: sysfs: init devices outside of the chunk_mutex"
 has been added to the 4.4-stable tree
Message-ID: <X6rV6keWW4bY3L5M@kroah.com>
References: <20201110151116.C2CBF20825@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110151116.C2CBF20825@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:11:15AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     btrfs: sysfs: init devices outside of the chunk_mutex
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      btrfs-sysfs-init-devices-outside-of-the-chunk_mutex.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This broke the build on 4.4.y and 4.9.y so I've dropped it from those
trees.

thanks,

greg k-h
