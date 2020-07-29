Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6C231ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 14:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgG2MxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 08:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG2MxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC2AA206D4;
        Wed, 29 Jul 2020 12:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596027201;
        bh=iojlClZWVh0dh0Rl11AjHfrnNEiiNUT82pdn+efYjxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0O/Ko7N1kTAjJJpl5QFrAO4uwdCTKZtEBxfZE6qdc9d5G1bAGHfRQJA3v+MWKXbm
         Yo7RjNnw3nDN01VKNhVRgXxx0j3GwJy3a1QY447c22amen6+k7fRePEjxYiVj1wDH0
         Qlwg+M7hT3094fhR8f8EauHkUKqMJFm9TzF4Qt5Y=
Date:   Wed, 29 Jul 2020 14:53:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     jslaby@suse.com, ebiggers@google.com, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, dhaval.giani@oracle.com
Subject: Re: [PATCH 1/1] vt_ioctl: prevent VT_RESIZEX font height change from
 causing potential out-of-bounds access
Message-ID: <20200729125311.GA2912372@kroah.com>
References: <1596026381-5013-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596026381-5013-1-git-send-email-george.kennedy@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:39:41AM -0400, George Kennedy wrote:
> Add a VT_RESIZEX check to ensure that changing the font height will not
> cause a potential out-of-bounds access. The candidate font height contained
> in "v_clin", though below the max, could still result in accesses beyond
> the allocated font data size.
> 
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> Reported-by: syzbot+38a3699c7eaf165b97a6@syzkaller.appspotmail.com

Did syzbot also test this that it fixes the reported issue?

What commit does this fix?  Should it go back farther to stable releases
too?

thanks,

greg k-h
