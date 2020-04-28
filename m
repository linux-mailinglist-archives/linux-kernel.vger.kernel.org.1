Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3A1BC447
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 17:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgD1P6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 11:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728172AbgD1P6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:58:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D74206C0;
        Tue, 28 Apr 2020 15:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588089527;
        bh=qXrJ1X738mDatImKsjVwSd8Q17d8jVla98VKaBYOuR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUfYbW3GbJdy2X49J3YY7Qd2zXiDhOXFr2vX+KqhyXFF/aB6tldFv6Ygm/uDWhMzR
         zHLTBYQClEk5AnwX8f3FtfDJHzxrQePDL73NQz17IbAOAHKvormV6KCwuGJBvvb5Ok
         uSWckYHOlHmUOJ/bR/ou+63j64apAeMiwfsvJB1E=
Date:   Tue, 28 Apr 2020 17:58:45 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>
Cc:     "hjk@linutronix.de" <hjk@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Message-ID: <20200428155845.GA1611284@kroah.com>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
 <20200416163830.30623-1-manuel.stahl@iis-extern.fraunhofer.de>
 <20200428135443.GA1437053@kroah.com>
 <6e93bbcb4ba85b4cc143aa8e3e7254071b3c8bdb.camel@iis-extern.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e93bbcb4ba85b4cc143aa8e3e7254071b3c8bdb.camel@iis-extern.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:47:42PM +0000, Stahl, Manuel wrote:
> > 
> > > +		return err;
> > > +	}
> > > +	pci_set_master(pdev);
> > > +
> > > +	dev_info(&pdev->dev, "Legacy IRQ: %i", pdev->irq);
> > 
> > Again, remove, be quiet :)
> 
> Use dev_dbg() or remove completely?

If it helps in debugging, dev_dbg() is fine to use.

thanks,

greg k-h
