Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298E92AC2A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbgKIRkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:40:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731963AbgKIRkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:40:39 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0948720578;
        Mon,  9 Nov 2020 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604943638;
        bh=vmW6+ivQOVSBlimhpgmEgEYrtUFst48LRIcDkWWt8Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1yvtbsnB/qLmPJWEFiKa9zwwf3/8eOZLp6MZrve7p2zmjIKVLWoNVFSonk9XKh7r
         4NHkT5KcwDqaUVT2SHNWfwuLHgmErn6FNfid7HQ5SEjtbxnENlaaXdurhTufqdBz78
         McgsmS0ZfwvxN/oHgLrhqlzqrlqYQ9pHeBxsyDV8=
Date:   Mon, 9 Nov 2020 18:41:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        qiangqing.zhang@nxp.com, sherry.sun@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mic: vop: remove unneeded semicolon
Message-ID: <20201109174137.GA2413477@kroah.com>
References: <20201031152258.2145680-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031152258.2145680-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 08:22:58AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/misc/mic/vop/vop_vringh.c | 2 +-

This file is no longer in the kernel tree at all :)
