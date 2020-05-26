Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756CB1C11BF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 13:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgEAL7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 07:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbgEAL7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 07:59:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F282A20836;
        Fri,  1 May 2020 11:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588334373;
        bh=0VQ7YPYlx9hfs/EB0jGjLy7lp7UfqP2NSb+PtmCf+ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dSpJVP7SAFq5uosWAWOJDU+nAgJMw7/QPb15FniUXreIe+Fj7WvLAuRjzPqJRAhrt
         0z955JM3M6fp1UxEnchSZwRiJUfqxTi1PGa8NxGlirqm4GgCXCrzMF+ifLyMwDp6Bt
         EGvv7YnQUU4WpGSNR7ziQJwDJPgN0JVbOcMZfCtE=
Date:   Fri, 1 May 2020 13:59:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Paul J Murphy <paul.j.murphy@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
Message-ID: <20200501115929.GA1609634@kroah.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
 <20200501081002.GA1055721@kroah.com>
 <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f60aece195cd0700728fc38b0398949a82b72fc3.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 12:50:36PM +0100, Daniele Alessandrelli wrote:
> Thanks for your feedback.
> 
> > 
> > First off, there is a "proper" way to send patches to the kernel
> > community that Intel has that I do not think you are
> > following.  Please
> > work with the Intel "Linux group" to do that first, as odds are they
> > would have caught all of these issues beforehand (hint, which is why
> > that process is in place...)
> > 
> 
> I actually followed that process and got the OK to try to upstream.

Then someone seriously steered you wrong as I know of one specific thing
you did incorrectly (hint, you needed to get them to sign off on the
patch...)

> I think the issues you identified went uncaught mainly due to the
> limited Linux ARM expertise within that group (and Intel in general).

No, they should know better, if not, there are bigger problems there :(

greg k-h
