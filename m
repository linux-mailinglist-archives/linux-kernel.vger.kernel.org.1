Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123E8293482
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391859AbgJTGCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:02:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391803AbgJTGCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:02:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5E6C2225F;
        Tue, 20 Oct 2020 06:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603173741;
        bh=JNP6a7auUSQFkVTghiv41qtMzt+jLfZdbM/n0v1EWh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yr7jdYfY2x9Sc0ZYUeYPHpTpL1KeoxMQglirmYr2xnsSR74INaZGRPsbTCEurZXxO
         q5qgaYmAySf6QHKK0OuBS53QcWKCZiGgRU5nJB7SV/XkZ6ma+/OpgPeYPymMu3KmgO
         SNzw/+5Bzp2aZPSOCjMWkslTxD6h0Yt1pFIrp8hU=
Date:   Tue, 20 Oct 2020 08:03:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     trix@redhat.com, jens.taprogge@taprogge.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        industrypack-devel@lists.sourceforge.net
Subject: Re: [Industrypack-devel] [PATCH] ipack: iopctal: remove unneeded
 break
Message-ID: <20201020060304.GA3794112@kroah.com>
References: <20201019193227.12738-1-trix@redhat.com>
 <82a6b8eee085b0e6df7c89d64721c3fb6719ba89.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82a6b8eee085b0e6df7c89d64721c3fb6719ba89.camel@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 07:50:39AM +0200, Samuel Iglesias Gonsálvez wrote:
> Hi Tom,
> 
> Thanks for the patch!
> 
> Patch is,
> 
> Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 
> Greg, Would you mind picking this patch through your char-misc
> tree?

Will do after -rc1 is out.

thanks,

greg k-h
