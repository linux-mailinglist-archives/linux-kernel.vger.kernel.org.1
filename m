Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CB22DA862
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgLOHIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgLOHIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:08:01 -0500
Date:   Tue, 15 Dec 2020 08:07:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608016040;
        bh=4sNwhyq700uV/hgN/Mm/DJbg/c2ltZpwXps4VviC3xI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=noFGv+k78orhqOwcdZr+aBNIDgLABBLIvfsC2YuzKj51sXF+B4t/eJZDBjAqVx25x
         yQhckNGkxCdSuspxcKLU4yMSs3aVDX+zPMEs9fYK5/hDo0kDwW36aKIFtcAzqHevy+
         LHjz+S+HRqVCIPGZuzX7edOHiLabjoiyuNupRmAs=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     Gaoyan <gao.yanB@h3c.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [v2] tty: Protect disc_data in n_tty_close and
 n_tty_flush_buffer
Message-ID: <X9hgpOaBSnf+fS/V@kroah.com>
References: <20201210022507.30729-1-gao.yanB@h3c.com>
 <X9G+bJSGQc6QIxLR@kroah.com>
 <b47fb47ba70d42978c73436370ae44bb@h3c.com>
 <fcbcb889dad8487897a7b77a8b6ac160@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbcb889dad8487897a7b77a8b6ac160@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top


On Tue, Dec 15, 2020 at 02:45:01AM +0000, Tianxianting wrote:
> Hi Greg KH
> Could we get your comments for the updates?  Thanks 

Sorry, it is the middle of the merge window, I'll get to this after
5.11-rc1 is released.

thanks,

greg k-h
