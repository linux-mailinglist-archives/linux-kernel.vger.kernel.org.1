Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501F5269EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgIOGxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgIOGxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:53:15 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C89A20829;
        Tue, 15 Sep 2020 06:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600152794;
        bh=ATCOdWIHi3OO6opOWs3eQftzSjqLITuPWWAagm6qmzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IfasCXhTnqrCw5a6EixwAuj438ELvPqPMjHKW+HGmeHjU7bArrYjRW19u5LvBKwlW
         cWPfuIHwn/V20IkZe2Mz9xZ4aC4K7Nr4qLOD/ljYDAbTikx0Gm5Huar+xYT5ls3st9
         2ptJRiR3pz4VyRSiSgGE5bb+lYoeZMAX3sY4H9sY=
Date:   Tue, 15 Sep 2020 08:53:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2] docs: fb: Remove the stale boot option for
 framebuffer i.e scrollback
Message-ID: <20200915065312.GB3622460@kroah.com>
References: <20200915063721.30065-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915063721.30065-1-unixbhaskar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:07:21PM +0530, Bhaskar Chowdhury wrote:
> And adjusted the numbering for boot options too.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> This version corrected the previous version's mistake,subject line fix,more
> changelog information.
>  Documentation/fb/fbcon.rst | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)

You sent 2 v2 patches with different changelog texts :(
