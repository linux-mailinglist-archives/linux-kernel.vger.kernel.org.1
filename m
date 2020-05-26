Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E443B1B5CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgDWNo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 09:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgDWNo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:44:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D668E20728;
        Thu, 23 Apr 2020 13:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587649497;
        bh=yN7Uwml3MaUXo3MsDP/rNPn+9X8ZEznkNegUs+mvS3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cU7mDlKHJ51Bgk22hEmKsJcAly1OUqd1XdCjq2N3bIx7b/sXFEDUrYetIJAchULql
         O3c6wNrcKehWVwh2FX5dWHcuSFAslhDgJJlg1omRdMAh1H/9j/eEcMes4mBsvUVtM7
         LqS1cYje7KH3c+fj45g7whaFN1jRARZLZ0PAYH/I=
Date:   Thu, 23 Apr 2020 15:44:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Adam Borowski <kilobyte@angband.pl>,
        Chen Wandun <chenwandun@huawei.com>, jslaby@suse.com,
        daniel.vetter@ffwll.ch, b.zolnierkie@samsung.com, lukas@wunner.de,
        ghalat@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: don't hardcode the mem allocation upper bound
Message-ID: <20200423134455.GA4073139@kroah.com>
References: <nycvar.YSQ.7.76.2003281702410.2671@knanqh.ubzr>
 <20200417144915.GA25595@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417144915.GA25595@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:49:15PM +0200, Sam Ravnborg wrote:
> Hi Greg.
> 
> I assume you will take this patch.
> Not really drm-misc material.

Yes, will do, thanks.

greg k-h
