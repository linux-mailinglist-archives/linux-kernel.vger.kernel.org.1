Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CB5269E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgIOGEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:04:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgIOGEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:04:41 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE31206B2;
        Tue, 15 Sep 2020 06:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600149879;
        bh=9weKiD10vvg7Ptzyv8NHpN5+UhBlvjS1k44medd5SuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5UhSBTeoy7+ByTDVVLaIb8OncVxpNtGvIB/hFKIH1RKLJClMFaeCG/lC6LZC5nfe
         eXh6uoaC2aiurbU+uagWfH18mIUYES5SicS+P8UFaZczJkPtDSOXQIyN45tKoBaLGf
         uh1MPEjCA/CXkKXmhPjqakzWLlaU17YeEpbVp/NA=
Date:   Tue, 15 Sep 2020 08:04:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v2] docs: fb: Remove scrollback related lines
Message-ID: <20200915060437.GA16383@kroah.com>
References: <20200915055712.968-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915055712.968-1-unixbhaskar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:27:12AM +0530, Bhaskar Chowdhury wrote:
> This patch removed the framebuffer scrollback related lines.
> 
> This is the effect of this commmit  50145474f6ef ("fbcon: remove soft scrollback code")

Why the extra ' '?

And you can line-wrap things here :)

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> Following Greg's suggestions,fix the subject line and include the commit Subject

Same thing for all of your patches you sent...

thanks,

greg k-h
