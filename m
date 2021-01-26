Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF37303FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405618AbhAZOE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405691AbhAZODp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:03:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8BD522B2C;
        Tue, 26 Jan 2021 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611669785;
        bh=eF6dJSCc6mkS+0xckEBeYUobYicK7sB6jxfX2nw+RIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjzY0ebImxN0ogQadgQ0ZVMP9ZGrlkwpZMWN5FhnlrWycYAHUMLDcGW4HSX6XWKUk
         wPCBFy+XEsmCmHDs+rwmOCxI4Y6UeLDXySffIu9gnYwTiqhXh9s9X8Sj31h/R/K6OG
         HYHbmUaiVOQW1Yi8A2yXIuZYglIVsWncMOWb5EzM=
Date:   Tue, 26 Jan 2021 15:03:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     corbet@lwn.net, vegard.nossum@oracle.com, viro@zeniv.linux.org.uk,
        rdunlap@infradead.org, grandmaster@al2klimov.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] docs: path-lookup: update follow_managed() part
Message-ID: <YBAhFryculK1PmIJ@kroah.com>
References: <20210126072443.33066-1-foxhlchen@gmail.com>
 <20210126072443.33066-2-foxhlchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126072443.33066-2-foxhlchen@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 03:24:32PM +0800, Fox Chen wrote:
> No follow_managed() anymore, handle_mounts(),
> traverse_mounts(), will do the job.
> see commit: 9deed3ebca244663530782631834e706a86a8c8f

When referencing commits in changelogs, please use the documented way,
which for this one would be 9deed3ebca24 ("new helper:
traverse_mounts()").  That enables us to read and understand them
better.

thanks,

greg k-h
