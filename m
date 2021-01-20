Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283582FDA09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392531AbhATTuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392741AbhATTsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:48:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C1C061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YO65qeuBlA/Px+uGMMtu2IuI+NS6eKWvr/uQdksGWHk=; b=ZYDNsDliyOykuxcU6CwW9AORNj
        ZzPzRXjpZ4vAseB9D1pGl/v+qNQQTd9OgLgVGnHxs0IYXMTzdUFNoY/83XdgFLMYKqtwmYsmLC+3N
        T8ti0RrUuYHx2n6d4EuFca1Ny+AQ7fARvLk6EMdX6h4B8tNVxPDxZO9+2OkFRY1Lr8OpckAc1obUt
        GBEOaH+rkalJhuHqexjqMEZtLgE13JQawomCk9KlSJ219bLbR0L/jJ4R12Uc1Qvz3upn0DrXGT5xI
        XQXV9cwjphk57JfdCHXtQpPNSpTWWXpVO2R3u71K4dQ1ezoik1ozlEivZlaBKTR4VpOkyF2vfCCrE
        upz1ZNAA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2JQf-00G8fi-Js; Wed, 20 Jan 2021 19:46:15 +0000
Date:   Wed, 20 Jan 2021 19:46:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     gregkh@linuxfoundation.org, logang@deltatee.com,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
Message-ID: <20210120194609.GA3843758@infradead.org>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject doesn't make any sense to me.

But thn again queued sound really weird.  You just have a managed
API with a refcount and synchronization, right?

procfs and debugfs already support these kind of managed ops, kinda sad
to duplicate this concept yet another time.

> +static long cdev_queued_ioctl(struct file *file, unsigned int cmd, unsigned long arg)

Overly long line.

> +__must_check int __cdev_register_queued(struct cdev *cdev, struct module *owner,
> +					dev_t dev, unsigned count,
> +					const struct cdev_operations *qops)
> +{
> +	int rc;
> +
> +	if (!qops->ioctl || !owner)
> +		return -EINVAL;

Why is the ioctl method mandatory?
