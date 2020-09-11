Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD958265F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgIKM3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 08:29:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgIKMXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:23:34 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7A622206;
        Fri, 11 Sep 2020 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599827013;
        bh=QaMhDuXaj06ZsADrwpgFJAjUIv92PDxxGzNdrTC+ceE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IxRVyVa7HNzPv2MYezbU9T6sYSz1wK7xQXVMP8SljQAI3/NSsNggk7fsgvY9hNvC9
         xWw64dQmMWU8VWuQauOl63oBaM1TrYBRUZCwrnPLWWqtK7PNBFQ/NoQIBOUf9yTcHB
         9VoU5yn2DSBlP0jSHXisaGCiUgnHcCZnqitejp4k=
Date:   Fri, 11 Sep 2020 14:23:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsi@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>
Subject: Re: [GIT PULL] FSI changes for 5.10
Message-ID: <20200911122307.GC3758477@kroah.com>
References: <CACPK8XdDHEcbdH2HXeFpL9U+SYmydSMw5jkti_0x+EjQy7RDHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XdDHEcbdH2HXeFpL9U+SYmydSMw5jkti_0x+EjQy7RDHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 05:14:05AM +0000, Joel Stanley wrote:
> Hi Greg,
> 
> Here are some FSI changes for the 5.10 merge window.
> 
> The following changes since commit 4a851d714eadeabd65c7e321a2e7830f77d945c4:
> 
>   fsi: aspeed: Support CFAM reset GPIO (2020-09-10 12:26:43 +0930)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-5.10

Pulled and pushed out, thanks!

greg k-h
