Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBFE282B1C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 16:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgJDOKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgJDOKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:10:49 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23ECC0613CE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Oct 2020 07:10:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5EC4022EDE;
        Sun,  4 Oct 2020 16:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601820647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xVT1+uHV60x1aVCZ95DvmbILFkWAS7anVazJ1b7EIoQ=;
        b=bxjyZbK6MEBzL6yVKoDx8aHhT0lKMZgS8k28EDwu4jzwfjSz9EgVO8yaOQ9xd5pwL0MLXF
        SozTiDFIWc06BrLqCfdvkzaB7gPFuJJ5KlTAOaJbY07+8dGVGEP/DWriD4Sx7PJMCsrdXq
        H/7bdvJ4zxTVXy/g/w16ekHa98GQytQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 04 Oct 2020 16:10:46 +0200
From:   Michael Walle <michael@walle.cc>
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Subject: Re: [PATCH] mtd: spi-nor: Prefer asynchronous probe
In-Reply-To: <CAD=FV=VddVg=QLS32Jr-Mxh6nyiB2=1MybxGiYuuaKd+fQ4+Lw@mail.gmail.com>
References: <20200902160002.1.I658d1c0db9adfeb9a59bc55e96a19e192c959e55@changeid>
 <20201003150633.23416-1-michael@walle.cc>
 <CAD=FV=VB-ML0=kmN-yAH7sD-sMiX9Cq1_9B9QwVL=Ed5ZrGnbg@mail.gmail.com>
 <b376b3f2e41662237d50d589e3696b06@walle.cc>
 <CAD=FV=VddVg=QLS32Jr-Mxh6nyiB2=1MybxGiYuuaKd+fQ4+Lw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <23aa87ccb6ae4133a17885b809194161@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2020-10-03 19:00, schrieb Doug Anderson:
> On Sat, Oct 3, 2020 at 9:54 AM Michael Walle <michael@walle.cc> wrote:
>> While debugging another issue I also noticed that sometimes my
>> /dev/mtdN devices were reordered. Note that I have two SPI flashes.
>> Might this also be connected to the async probe?
> 
> It's likely.  My guess is that you shouldn't really be depending on
> the numbering.  If you need to depend on the numbering, there should
> be something that guarantees it like a device tree alias.  We have
> struggled with similar things on MMC for years and I guess Ulf finally
> decided that we weren't going to get a better solution than the device
> tree aliases.

But this has to be supported by spi-nor first, right? So that would also
be something which has to be added before we can make the probe async.
And as far as I know there is no such mechanism like /dev/disk/by-X for
/dev/mtdN.

-michael
