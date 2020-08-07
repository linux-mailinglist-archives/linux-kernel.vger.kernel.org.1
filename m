Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6923F009
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 17:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHGPbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:31:39 -0400
X-Greylist: delayed 115149 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Aug 2020 08:31:38 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45292C061756;
        Fri,  7 Aug 2020 08:31:38 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 07D48E806C9;
        Fri,  7 Aug 2020 17:31:35 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 75A67160D5D; Fri,  7 Aug 2020 17:31:34 +0200 (CEST)
Date:   Fri, 7 Aug 2020 17:31:34 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Martijn Coenen <maco@android.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: Re: [PATCH] loop: unset GENHD_FL_NO_PART_SCAN on LOOP_CONFIGURE
Message-ID: <20200807153134.GA222272@gardel-login>
References: <20200806073221.GA219724@gardel-login>
 <CAB0TPYEsRPxiVLS7ieBLJprje_avAo49n7QWExpovuLBJHkOGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYEsRPxiVLS7ieBLJprje_avAo49n7QWExpovuLBJHkOGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fr, 07.08.20 10:53, Martijn Coenen (maco@android.com) wrote:

> Hi Lennart,
>
> Thanks again for the patch, I tested it and it looks good to me. I'll
> also add a test case to LTP for this. Two minor nits on the patch:
>
> On Thu, Aug 6, 2020 at 9:32 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
> > Let's correct that and propagate the flag in LOOP_SETSTATUS too.
>
> Think you meant LOOP_CONFIGURE.

True!

> Also, could you add a "Fixes" tag, like:
>
> Fixes: 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl")

Thanks for the review. I'll fix this up and send a v2. Are you OK with
me adding your Ack to the patch? And also should this geta cc for
stable?

Thanks,

Lennart

--
Lennart Poettering, Berlin
