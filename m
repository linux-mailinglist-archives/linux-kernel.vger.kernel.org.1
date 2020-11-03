Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C302A4870
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgKCOld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728072AbgKCOlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:41:31 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F1A2054F;
        Tue,  3 Nov 2020 14:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604414490;
        bh=08cuWeirHWRvjZCSTIQ57wvVDcL2egfmvBLTZ0vGBBM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=aSW1sCiQnhM5NTjlu9OUrXZ7nBHjUGjJls8kcfNUmW/1zhsZn6HoWBL6hyMsaVkvZ
         R3kyXvwvIPw/5EDhxsE7Drp88jD5k4NHVtQ+rVSnq2tDVr9nm1ESJBa8x44Pf9Y7Bj
         XtB1uabq6jbJNwECF/ZJg3qKnlpRhk1f0j1Sq/hQ=
Date:   Tue, 3 Nov 2020 15:41:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [PATCH] speakup: Fix var_id_t values and thus keymap
Message-ID: <20201103144119.GA3110335@kroah.com>
References: <20201012160646.qmdo4eqtj24hpch4@function>
 <20201103143142.c3juf3lqj4wz5nge@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103143142.c3juf3lqj4wz5nge@function>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 03:31:42PM +0100, Samuel Thibault wrote:
> Ping?
> 
> This is a change that should got into 5.10, in the meanwhile the bug
> (appeared in 5.8) is very inconvenient for users.

It's in my to-apply queue, sorry, it's really long at the moment.  Don't
worry, it's not lost...

thanks,

greg k-h
