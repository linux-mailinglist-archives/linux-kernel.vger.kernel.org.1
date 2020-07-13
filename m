Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7543219AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 10:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGIISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 04:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgGIISN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:18:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F982070E;
        Thu,  9 Jul 2020 08:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594282692;
        bh=0JSt5HvV2eJPEfaljzdwUdysEFavnpCkZsURiwFWrZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FagGrbt0bIqI8UXV3HAu/r6cSIsmYZ2goUoFkmp4JgKDgmYTW6whMfrC9RpBeFmN0
         ibAJtNtr/rpPmT3yRt/wvtteKjitMJdoquPrjwKlLV8EBoTdSPg3woAW8/Tm+Ckmya
         TWWVUBjCdVNJ3b9ZIJFwtPP18NRLUcwx/TLtO9Vs=
Date:   Thu, 9 Jul 2020 10:18:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hridya@google.com, tkjos@google.com, christian@brauner.io,
        arve@android.com, maco@android.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: add Hridya and myself into Android
 driver maintainers list
Message-ID: <20200709081820.GB13487@kroah.com>
References: <20200708231253.3831497-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708231253.3831497-1-surenb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 04:12:53PM -0700, Suren Baghdasaryan wrote:
> Add new maintainers for ashmem driver to handle related issues.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Can I get an ack/reviewed-by/something by the existing maintainers to
verify this?  :)

And I thought we were deleting ashmem soon?

thanks,

greg k-h
