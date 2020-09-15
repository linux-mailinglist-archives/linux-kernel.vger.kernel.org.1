Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A3C269DC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgIOFTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOFTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:19:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3364A20738;
        Tue, 15 Sep 2020 05:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600147149;
        bh=CA2Dl08uqAcZG/fMLIsvFYuOmef0QJmiUrJXYeTwhUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yXWFXSMtcPe4ErpGURe67VoWhUlsUimOxobUBuu7Z6xoxbyZDtldCMP6DiIbybJuD
         m1nyBb/ylXhd+dG77w2uZ6bBPBmKuVq7u4SSn3wFZykfb7WvT83jq+4WjUSXvF0dm8
         StMNILKJH8BoUgt4KFuqCNtv5gf02SURLNjNdZ6E=
Date:   Tue, 15 Sep 2020 07:19:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] docs : fb : vesafb.rst : Removed scrollback related lines
Message-ID: <20200915051907.GA12074@kroah.com>
References: <20200915051219.19479-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915051219.19479-1-unixbhaskar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:42:19AM +0530, Bhaskar Chowdhury wrote:
> This patch removed the scrollback related lines from this file : vesafb.rst
> 
> In the effect of this commit hashes : 50145474f6ef4a9c19205b173da6264a644c7489
> and 973c096f6a85e5b5f2a295126ba6928d9a6afd45

When referencing git commits, please follow the documented way of doing
this:
	50145474f6ef ("fbcon: remove soft scrollback code")

Can you fix this up and resend?

And you have a few too many ' ' in your subject :)

thanks,

greg k-h
