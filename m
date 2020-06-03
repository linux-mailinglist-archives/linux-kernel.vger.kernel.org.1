Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543BF1EC950
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 08:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgFCGOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 02:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgFCGOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:14:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB5A22068D;
        Wed,  3 Jun 2020 06:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591164885;
        bh=S2g2RpDgji3qUmc3Z++eaclycufz5rb3P87OS+u0RYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTwbpgCeR3lnlgzpQTl0OccK3xWL9/GCGkqiEaj7wiyWdmtnMpRdeWYU31ZVYwuV5
         Mf0zMuug1fzNsA7yhsNmRIL7aoC5dM/ECE4dcROExtT+gWr8OcDl8oUxz4ZUNiYDGp
         Da0cCStH2QmJSG/fTNAMmE2pt96EDWjXbdD5kmlk=
Date:   Wed, 3 Jun 2020 08:14:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Ian Munsie <imunsie@au1.ibm.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix kobject memory leak in cxl_sysfs_afu_new_cr()
Message-ID: <20200603061443.GB531505@kroah.com>
References: <b9791ff3-8397-f6e9-ca88-59c9bbe8c78f@web.de>
 <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 09:42:41AM +0800, wanghai (M) wrote:
> 
> 在 2020/6/3 1:20, Markus Elfring 写道:
> > > Fix it by adding a call to kobject_put() in the error path of
> > > kobject_init_and_add().
> > Thanks for another completion of the exception handling.
> > 
> > Would an other patch subject be a bit nicer?
> Thanks for the guidance, I will perfect this description and send a v2

Please note that you are responding to someone that a lot of kernel
developers and maintainers have blacklisted as being very annoying and
not helpful at all.

Please do not feel that you need to respond to, or change any patch in
response to their emails at all.

I strongly recommend you just add them to your filters to not have to
see their messages.  That's what I have done.

thanks,

greg k-h
