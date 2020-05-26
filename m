Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF481C84B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEGIXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 04:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgEGIXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:23:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 009E92073A;
        Thu,  7 May 2020 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588839818;
        bh=lO99hYKc327tJIds5lglufIkKhv7kNMeB7LuejbJZ3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDeTWn3l2J1cfzbkF+ah1A84Sx22VmW7ca5mL79RHkM+xbNdaur8OeBhRdwcVVnRx
         rTt2f4Ng+/Y5wzdve7MG6TZnr7inIu9KD/7M9gvuEKF8onAVODdLLyqOZE62mgRJ3r
         YQHyqd7qYiV4yp2rtUlwRm7x+sMMMjFSZ4s1tFHI=
Date:   Thu, 7 May 2020 10:23:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     security@kernel.org, syzkaller <syzkaller@googlegroups.com>,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Write in snd_rawmidi_kernel_write1
Message-ID: <20200507082336.GG1024567@kroah.com>
References: <CAFcO6XMWpUVK_yzzCpp8_XP7+=oUpQvuBeCbMffEDkpe8jWrfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XMWpUVK_yzzCpp8_XP7+=oUpQvuBeCbMffEDkpe8jWrfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:54:34PM +0800, butt3rflyh4ck wrote:
> I report a bug (in linux-5.7-rc1) found by syzkaller.
> 
> kernel config:
> https://github.com/butterflyhack/syzkaller-fuzz/blob/master/v5.7.0-rc1.config
> reproducer:
> https://github.com/butterflyhack/syzkaller-fuzz/blob/master/repro.cprog
> 
> I test the reproducer in linux-5.7-rc4 and crash too.

Same as the other email, patches are best, thansk!

greg k-h
