Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B03269EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgIOGwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbgIOGwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:52:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3393920756;
        Tue, 15 Sep 2020 06:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600152733;
        bh=74TxL+Ikz6wxuq0KAoaG3IXdmf89zEQbxk+AbUBW/Ac=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=k7J0NLWJIkZkxgYP1BpHqVrzoulv+mq4n385DbU2ezK8aMvY0YGA/n+NN71Rx1u1J
         RjM0VsUac1SaJTQztJyNZ8DYWuPHF8Td6P1P7npKFcxxZlZGbSOPt/pZgPZKUkQqog
         e9bvlXev4jw3LbHA2jQNYfwx6hMPhth5JfaHOK1A=
Date:   Tue, 15 Sep 2020 08:52:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2] docs: fb: Remove scrollback related lines
Message-ID: <20200915065208.GA3622460@kroah.com>
References: <20200915055712.968-1-unixbhaskar@gmail.com>
 <20200915060437.GA16383@kroah.com>
 <20200915061259.GB25365@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915061259.GB25365@Gentoo>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:42:59AM +0530, Bhaskar Chowdhury wrote:
> On 08:04 Tue 15 Sep 2020, Greg KH wrote:
> > On Tue, Sep 15, 2020 at 11:27:12AM +0530, Bhaskar Chowdhury wrote:
> > > This patch removed the framebuffer scrollback related lines.
> > > 
> > > This is the effect of this commmit  50145474f6ef ("fbcon: remove soft scrollback code")
> > 
> > Why the extra ' '?
> I hope you are pointing at subject line space, Greg?? I was looking at it on the
> docs:

No, look at the extra space in the changelog text above, you have two of
them after the word "commit".

thanks,

greg k-h
