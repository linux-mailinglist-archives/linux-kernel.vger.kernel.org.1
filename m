Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4B012E3EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392139AbgL1OeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:34:14 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56929 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505121AbgL1OeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:34:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6589D5C00F5;
        Mon, 28 Dec 2020 09:33:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Dec 2020 09:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=sJoC7/Ia5+/htiaRt2Q8tV5e8MA
        bHQsr4knpVzsRSFs=; b=jdGHQ5PQjk1eA1NrLLcz3AVUzt7eyCR+vkphTKiVziC
        loeXEgUHVEEFeoDPT0lIGg2YJtUGtqK3NNKw+7HBMGdKwD4kFInNPa92CtF1CCp/
        zNHyHcOKiJ6hNs4xa3hr/xw7zxH6n+mw3dW6+MVUZiE11iNRf79NmMKHQchusNQG
        ktzbTKd0yVD78WR/y7cBNp+2w0U6YdHyepTIqbOAveavuwEGCjI39/bCWOPkedq7
        oVw3/MZu5Jzuyf4cDrHhbJpTGN6OZJ+OE5gK07ZOz5uWN49KbH2pq104UFrDMl2K
        FS/45GI2/gzjtJRIB0M3aa0NTcF4uqnI414BbKLgjiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sJoC7/
        Ia5+/htiaRt2Q8tV5e8MAbHQsr4knpVzsRSFs=; b=ATrJwwC0SJOPs8L/bfQK9C
        6ZHEh/oKXKhIunP4ig7mvSXomCQ6cSgnquVgftoljS/fY/x2M1ZnAoRf6bQnibZQ
        /sqVgQd7MSwHMUI/Xg+OdAPm8SyzlcfsjcRAL2GZon9jun9CJ9P2rVVG74d3bBg5
        SSaIjHMtSuPQ1TdO1WBA3HaI9NBkIUMg4KLkNpLdw0QaV6m78pI0lWdyrLUzdUum
        /T9RGlWA1a93H5Gxu5usXIJymD5U8XijN+1cOAlyyudgJPYMhU5IOOrzWlV53hn5
        uI/tsFZ+b8Zp89E9KGiqVdMILV2kjUOnALVXqtK621xMbu0eX2OWVwZRi0KWTTIg
        ==
X-ME-Sender: <xms:ruzpX8-xhRWgKYdoIqU4jas7PZw0brX5fXihoueW97Nc780xMuTASA>
    <xme:ruzpX6tOFI2EM6F61ox7BunSshUbEIPrccGbM9XR-ZYr2bSbKlPBrqfGkDTD6jFTW
    tA4Eu0TTbQivQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdduledgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:ruzpX_oWQFRyGirMfpB1SIWscKRx5ihTgUfi25_QiIoiOc_wMCzlrA>
    <xmx:ruzpX3mtQJaSOhzP7J1mOo7RZvcuJ0JbL2fy3cmeD4Ff5l_DpJz2Ag>
    <xmx:ruzpXzwQt9h_lEcC1Phk5YVximHV0_pvfCilioHY-yvsntdq8uOcOw>
    <xmx:r-zpX1JrhPFnwW7L0Pk0o_snFJlYkLz2rbsTgh1v-7FBhOoIn19PIA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 544E0108005F;
        Mon, 28 Dec 2020 09:33:18 -0500 (EST)
Date:   Mon, 28 Dec 2020 15:04:47 +0100
From:   Greg KH <greg@kroah.com>
To:     Song Chen <chensong_2000@189.cn>
Cc:     linux-kernel@vger.kernel.org, abbotti@mev.co.uk,
        hsweeten@visionengravers.com
Subject: Re: [PATCH] staging: comedi: remove warnings of comedi_lrange
Message-ID: <X+nl/xjHSBwpqWjF@kroah.com>
References: <1608771498-13335-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608771498-13335-1-git-send-email-chensong_2000@189.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 08:58:18AM +0800, Song Chen wrote:
> Checkpatch.pl reports "warning: struct comedi_lrange should
> normally be const" in some places, which are supposed to
> be removed.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> ---
>  drivers/staging/comedi/drivers/das16.c   | 4 ++--
>  drivers/staging/comedi/drivers/jr3_pci.c | 4 ++--
>  drivers/staging/comedi/drivers/ni_670x.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Never send out patches that you do not test-build yourself.  Breaking
the build is a quick way to make a maintainer grumpy :(

greg k-h
