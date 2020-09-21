Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D0D272321
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIULwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgIULwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:52:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493CD20EDD;
        Mon, 21 Sep 2020 11:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600689122;
        bh=NQPRQz+/iXSNe/+tUadlxBAYfUGBh67MQofu9hUBUTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPP0h1Fj1Zxs8Z6/zNYzmrhuwfKB4AUNmvHGDOZBvtSOTwTVB1pshajIcnVjzuPTf
         FxcTYmWjx2NvgWR88Fm0N4iEovvT5pCil6Mw3WZwndBm1jXFHNpJoF97z1Rt3kuuNZ
         4RxSLc5sQTGLrvKOIloeRy0IyRe8q/pKfK4q2gSg=
Date:   Mon, 21 Sep 2020 13:52:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     stern@rowland.harvard.edu, kai.heng.feng@canonical.com,
        johan@kernel.org, tomasz@meresinski.eu, jonathan@jdcox.net,
        kerneldev@karsmulder.nl, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: simplify quirk handling.
Message-ID: <20200921115226.GA275283@kroah.com>
References: <20200921113039.GA19862@duo.ucw.cz>
 <20200921113800.GA26212@kroah.com>
 <20200921114729.GA21368@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921114729.GA21368@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 01:47:29PM +0200, Pavel Machek wrote:
> On Mon 2020-09-21 13:38:00, Greg KH wrote:
> > On Mon, Sep 21, 2020 at 01:30:39PM +0200, Pavel Machek wrote:
> > > Simplify quirk handling.
> > 
> > In what way?
> > 
> > Please be more descriptive in your changelog and resend.
> 
> Have you looked at the patch below? Please apply the patch. You are
> free to edit the changelog if you feel the need.

I am also free to ignore patches with changelogs that do not say
anything of consequence, which I will do here.

greg k-h
