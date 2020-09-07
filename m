Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB0B25FA86
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgIGMbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 08:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbgIGMYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:24:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93FBB2137B;
        Mon,  7 Sep 2020 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599481445;
        bh=bdonkDzkbL50PhcUvl8MR/m3J5LP13sgCsKeaOyI06I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yuJPji+mRKsU7eqW0OeCgvQgj/Dkjss9IeGwaMOI/th/JBbZP5C6U6az5xushEADW
         S7GZJpVkp2LdRT9Tx3BX+hA4c9esoEM2NHRnX1zeMhu0gbGLyFk1AsntkSbH3oBadi
         P8mOw49bwHLgFcTOasi7NcKWFoSh1KTUSkTv+3fY=
Date:   Mon, 7 Sep 2020 14:24:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v8] binder: transaction latency tracking for user build
Message-ID: <20200907122419.GB2029056@kroah.com>
References: <20200907070045.GA605692@kroah.com>
 <1599480055-25781-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599480055-25781-1-git-send-email-Frankie.Chang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 08:00:52PM +0800, Frankie Chang wrote:
> Change from v8:
>   - change rtc_time_to_tm to rtc_time64_to_tm.
>   - change timeval to __kernel_old_timeval due to 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c766d1472c70d25ad475cf56042af1652e792b23

That feels wrong, why can't you use the "new" structure instead?

thanks,

greg k-h
