Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89FF2C4E88
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 06:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387851AbgKZFwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 00:52:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732436AbgKZFwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 00:52:51 -0500
Received: from localhost (82-217-20-185.cable.dynamic.v4.ziggo.nl [82.217.20.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A16520770;
        Thu, 26 Nov 2020 05:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606369969;
        bh=hnc18p/0F/IOKnfVsNwzQQR0GYqV1vVqSBLqJ6XV/ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugsbPmixCjpFAor9u06EmbptEwXeEybQZcmz/shikemhL+M5Ps5o0UQ8n7IGCXf3n
         KX32GAxzciUEjyTjUlXObWYz1PALlVIgHYUbNjbMKOmO4e71ndepBqdlW4RVFTRAui
         412ivPxZlsBAYH83dok87GrzFzyOEzLhUc+rDLNU=
Date:   Thu, 26 Nov 2020 06:52:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "J. Avila" <elavila@google.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: Potential Issue in Tracing Ring Buffer
Message-ID: <X79CrSX1rnpnbqPd@kroah.com>
References: <20201124223917.795844-1-elavila@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124223917.795844-1-elavila@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 10:39:17PM +0000, J. Avila wrote:
> Hello,
> 
> In the ftrace logs we've collected internally, we have found that there are
> situations where time seems to go backwards; this breaks userspace tools which
> expect time to always go forward in these logs. For example, in this snippet
> from a db845c running a 5.10-rc4 kernel[1] (thanks for getting us the trace,
> John!), we see:

Does the patch at:
	https://lore.kernel.org/r/20201125225654.1618966-1-minchan@kernel.org

resolve this issue for you?

thanks,

greg kh-
