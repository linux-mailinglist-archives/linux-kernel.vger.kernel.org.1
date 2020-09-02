Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB86725AEFE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgIBPca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgIBPWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:22:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB09B20767;
        Wed,  2 Sep 2020 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599060142;
        bh=PafC4luDUVsLd0CvhpVv+0h3RiIUnGou8VQWTyXKaH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0vlvv5xkZfFzOch2k7oTHhJc577RFRmad/f4nIOgptOpLm4VyphiT4+lWXH9Ch9Mb
         f/q94ZLdLFwBvqo5pW9SGyvATymfNUxqK6GeqGoWJIfp5jQpSX0XTTcfwkMkUHfoji
         78aMyrwzA/VJvMJl5zab+f+IAe9ZuMdDJ/In0okI=
Date:   Wed, 2 Sep 2020 17:22:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        stern@rowland.harvard.ed, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 7/9] sound: line6: convert to use new usb control
 function...
Message-ID: <20200902152248.GB2032878@kroah.com>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-9-gregkh@linuxfoundation.org>
 <s5ha6y89r6u.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6y89r6u.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 04:41:29PM +0200, Takashi Iwai wrote:
> On Wed, 02 Sep 2020 13:01:10 +0200,
> Greg Kroah-Hartman wrote:
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> I guess this and a few others with (x/9) are stale patches, right?

Ugh, yes, those were still in my directory, my fault for using 'git
send-email *patch'

:(

greg k-h
