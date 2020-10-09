Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C76028818F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgJIE5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:57:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJIE5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:57:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A5022255;
        Fri,  9 Oct 2020 04:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602219456;
        bh=WFJP1Mok4IZ5GN84tpRCCLl/M+wEBHhHKC0WU60CrRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w/w5TzbRBptY088zgyLUc2BaVKPAMOwDEcmSd1Cnc3bvfB3gp5OFsmuOHU+evJhAv
         2VZudsSJ3rXc5WvTME6vSn9gYIXW1R9Arv9hm3FpyIyZbnO0TgVV4LmcEe0Ww+dkVL
         rsXP9iXq+8aE2VpkTYAZfekMJDtyEWth6tFRH/mM=
Date:   Fri, 9 Oct 2020 06:57:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Harshal Chaudhari <harshalchau04@gmail.com>
Cc:     arnd@arndb.de, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
Message-ID: <20201009045734.GA112189@kroah.com>
References: <20201008182713.2764-1-harshalchau04@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008182713.2764-1-harshalchau04@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:57:13PM +0530, Harshal Chaudhari wrote:
> Checking the argument passed to the ioctl is valid
> or not. if not then return -EINVAL.

Along the the comments that Arnd made, this is not the correct value to
be returning from an ioctl when you don't pass in the correct command.

And it doesn't match what your patch says, please be consistent.

And do you have this device to be able to test your changes?

thanks,

greg k-h
