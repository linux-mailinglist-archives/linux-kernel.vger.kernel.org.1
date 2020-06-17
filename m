Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241A81FCC74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 13:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQLgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 07:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgFQLgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:36:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6CE207DD;
        Wed, 17 Jun 2020 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592393798;
        bh=i3CHHkWt7uTtcIUvnX49srUPMnVlFyiU7GS37fP3xcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Bwomn1DFCBh+zuPVslZbNNswQt+pREc3VF2v/kD14PWS24GC78Aoq88ele/98rNi
         7LTQjzh3AA8+JTORfKUlXbsrpF9NXaRtj8AzuWdRU9wvJXeZ9aKc7x9JT55SYh3EQ9
         SN/X1YBbT7DVIMEjP5N78S6fOEViA3S5sofqJilE=
Date:   Wed, 17 Jun 2020 13:36:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wade Mealing <wmealing@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "zram: convert remaining CLASS_ATTR() to
 CLASS_ATTR_RO()"
Message-ID: <20200617113631.GA2115184@kroah.com>
References: <20200617103412.GA2027053@kroah.com>
 <5cde1d94-275e-2555-b13d-0b04a7a70fc7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cde1d94-275e-2555-b13d-0b04a7a70fc7@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:05:54PM +0200, Steffen Maier wrote:
> On 6/17/20 12:34 PM, Greg Kroah-Hartman wrote:
> > From: Wade Mealing <wmealing@redhat.com>
> > 
> > Turns out that the permissions for 0400 really are what we want here,
> > otherwise any user can write to this file.
> 
> Minor confusion on my side:
> Did you mean "read from" instead of "write to"?
> I.e. only owner may read but not group nor others.
> Whereas using CLASS_ATTR_RO would resolve into 0444.

Sorry, you are correct, I'll fix the changelog text and send this out
again.

It's a "fun" file, reading from it causes something to happen, not the
normal way things work :(

greg k-h
