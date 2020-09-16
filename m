Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF93826CA5E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgIPT5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgIPRfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 709BC2224A;
        Wed, 16 Sep 2020 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600259686;
        bh=cGNtWAo22LwCSwjqAlF0X3q0KPrk7PCvy8F/Khpgj0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p6F+Qdc4YH2FUK0R5O8EMOgm3+HLxnk/hnSC1fjpoXhVw3M77lVKwIiGLlwljOgt1
         MDvvlIRv8SrVlCxBOM9hdzO5DsUs+/dfQNPuCkskrBj3GhIsF1L0B1EN8IKzGMuUtK
         EzM4YvOTVhooc6tGVvOx+FC3SNW0l5DKudnkpj1g=
Date:   Wed, 16 Sep 2020 14:35:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>,
        george.kennedy@oracle.com, jirislaby@kernel.org,
        syzkaller-bugs@googlegroups.com, b.zolnierkie@samsung.com,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com
Subject: Re: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
Message-ID: <20200916123519.GB2808885@kroah.com>
References: <00000000000024be1505ad487cbb@google.com>
 <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
 <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
 <20200916082624.GC509119@kroah.com>
 <3233dcc2-31d5-42e7-3d9d-b36a65b660ea@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3233dcc2-31d5-42e7-3d9d-b36a65b660ea@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 07:06:31PM +0900, Tetsuo Handa wrote:
> On 2020/09/16 17:26, Greg KH wrote:
> > On Wed, Sep 16, 2020 at 09:01:06AM +0900, Tetsuo Handa wrote:
> >> Greg, will you pick up this patch?
> >>
> >> It seems that finding the real cause of [3] and actually fixing [3] will be difficult.
> >> Since I can't reproduce [3] locally, I will have to try flood of "#syz test" requests
> >> for debug printk() patches.
> > 
> > I agree with Daniel here, can you retest these against Linus's latest
> > tree please?
> > 
> 
> syzbot already reproduced these bugs using the latest commit. ;-)
> 
> You can find
> 
>   ci-upstream-kasan-gce-root 	2020/09/15 15:18 	upstream 	fc4f28bb 
> 
> record for "KASAN: global-out-of-bounds Read in bit_putcs" and
> 
>   ci-upstream-kasan-gce-root 	2020/09/16 09:54 	upstream 	fc4f28bb
> 
> record for "KASAN: global-out-of-bounds Read in fbcon_resize".

Ok, will pick it up now, thanks.

greg k-h
