Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296BB22C89B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 16:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGXO7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 10:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgGXO7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:59:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04F52206D8;
        Fri, 24 Jul 2020 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595602740;
        bh=u80k3o+yMsUhRhDlI5TDV+bP/sT0UHxg6hWT8vGxnUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byM5bE+qq0+e4DX1qLnAPg5gQqxDsg//AT4pubsYTtBg1PF7LZpTTu1rOQK66ZtWS
         uFwPKjaNvGO8QKNCn/TEJE3EW5XRh1xeFTewkzqPSCQYsUKM7WMLkRDp1UUd+m98AZ
         3PsLL2mhcCf6wOGL1yj6dUvFoZns1ek5VkrOi+8I=
Date:   Fri, 24 Jul 2020 16:59:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH v5 00/18] dynamic_debug fixes, cleanups, features, export
Message-ID: <20200724145900.GA330332@kroah.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
 <4d7244b1-fa4d-f1bd-42e4-7123116e708f@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7244b1-fa4d-f1bd-42e4-7123116e708f@akamai.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:48:54AM -0400, Jason Baron wrote:
> 
> 
> On 7/19/20 7:10 PM, Jim Cromie wrote:
> > this is v5, changes from previous:
> >  - moved a chunk from patch 13 to 12, per Jason
> >  - shorten logging prefix to "dyndbg", drop __func__
> >  - now with more commit-log advocacy
> >  - shuffle EXPORT_GPL(ddebug_exec_queries) last.
> >  - v4+ series Acked-by: jbaron@akamai.com
> 
> Yes, series looks good to me:
> Acked-by: <jbaron@akamai.com>
> 
> Greg, what do you think about pulling in this series?

Me?  Am I the one who takes these patches?

Ok, will do, give me a few hours...

thanks,

greg k-h
