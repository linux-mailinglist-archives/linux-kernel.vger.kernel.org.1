Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7AD26BF26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIPIZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgIPIZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:25:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F56206C9;
        Wed, 16 Sep 2020 08:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600244750;
        bh=F4qC2LqBNHnT9rL+Oh8sOHMcIkhubIhoOZ4zPLIEpTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebR1Dq6e5Wm7kRDlJ3s+WAKFwx15+GxNftP5bLBmzE3DFGv/ON8xSMngZYYLb22Lw
         tqH8Dz9D9f0TQ1WgIfWWauuAxuJaug6L34rx49i9ksujCZqE80WW1nEtxE8Thby37a
         8HzLgysMa57u+A5Pj5u8mmMINy4XLB1XPYJTAXRc=
Date:   Wed, 16 Sep 2020 10:26:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>,
        george.kennedy@oracle.com, jirislaby@kernel.org,
        syzkaller-bugs@googlegroups.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com
Subject: Re: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
Message-ID: <20200916082624.GC509119@kroah.com>
References: <00000000000024be1505ad487cbb@google.com>
 <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
 <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:01:06AM +0900, Tetsuo Handa wrote:
> Greg, will you pick up this patch?
> 
> It seems that finding the real cause of [3] and actually fixing [3] will be difficult.
> Since I can't reproduce [3] locally, I will have to try flood of "#syz test" requests
> for debug printk() patches.

I agree with Daniel here, can you retest these against Linus's latest
tree please?

thanks,

greg k-h
