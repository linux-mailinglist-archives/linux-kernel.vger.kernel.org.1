Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE1241CF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgHKPKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgHKPKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:10:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1085320782;
        Tue, 11 Aug 2020 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597158602;
        bh=/2rz7VAq8cyEk4SPG3pzOlwfbcdudd7aW9vaBSW0CHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRqylVWX6O5m7nica0yVumQWqSwjwlXcxChU2WnlUMO7N8vsKwmXz5drr1ec/XX13
         dNQkTHCHrJDYIYhYyb2zEs/+TUpyOYMyYuZ+UGBj3TTYFPCXkjRg+NqzWRzLDFrPMp
         sXLDb+lqtSeiZ9dCSUhtDSf/NWo8mAwEDz7V2dMc=
Date:   Tue, 11 Aug 2020 17:10:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot <syzbot+9116ecc1978ca3a12f43@syzkaller.appspotmail.com>
Subject: Re: [PATCH] vt: defer kfree() of vc_screenbuf in vc_do_resize()
Message-ID: <20200811151012.GA427920@kroah.com>
References: <1596034621-4714-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <0c9d8003-ba3f-8f2d-7c5a-56c5ca7db750@i-love.sakura.ne.jp>
 <20200804125831.GA221149@kroah.com>
 <6053bc22-0876-f503-c1b6-3181a70d97de@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6053bc22-0876-f503-c1b6-3181a70d97de@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:02:03AM +0900, Tetsuo Handa wrote:
> On 2020/08/04 21:58, Greg Kroah-Hartman wrote:
> > On Tue, Aug 04, 2020 at 08:15:43PM +0900, Tetsuo Handa wrote:
> >> Do you think this approach is acceptable? Or, do we need to modify set_origin() ?
> >>
> > I think what you have here is fine, as cleaning up set_orgin() might be
> > hard to do at this point in time.
> > 
> 
> Seems that there is no comment. Greg, will you pick up this patch?

Yes, will do after -rc1 is out.

thanks,

greg k-h
