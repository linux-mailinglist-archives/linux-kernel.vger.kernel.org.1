Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111D31F662F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jun 2020 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFKLD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 07:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgFKLD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:03:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFC55207C3;
        Thu, 11 Jun 2020 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591873436;
        bh=mU4heyURLmbtomghT4H3Nqm49/LX2wthsm0zFZtXfYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d2qqUn7qRLb2nD/eqaJAff6iErpSyrt1meK+mYgcKFjD8bDff4z8Jd+ckFKricYpz
         jvbNgV8mfQ6Qw/ioB2Gva04W2e4qFS/tyenhQ4fsUpo/Ttd1/jlurbhhQP3x43bpLy
         rXVaYfYyVaHhh4q+zXhY+rAXl6M0M73Gty4MQSwY=
Date:   Thu, 11 Jun 2020 13:03:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Su Kang Yin <cantona@cantona.net>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: talitos - fix ECB and CBC algs ivsize
Message-ID: <20200611110350.GA3954279@kroah.com>
References: <cantona@cantona.net>
 <20200611100745.6513-1-cantona@cantona.net>
 <718354b4-d284-8e47-4085-f45101f9ca36@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <718354b4-d284-8e47-4085-f45101f9ca36@csgroup.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:50:24PM +0200, Christophe Leroy wrote:
> Hi,
> 
> Le 11/06/2020 � 12:07, Su Kang Yin a �crit�:
> > Patch for 4.9 upstream:
> > 
> > commit e1de42fdfc6a ("crypto: talitos - fix ECB algs ivsize")
> > wrongly modified CBC algs ivsize instead of ECB aggs ivsize.
> 
> To make it clear and avoid this problem to happen again, please generate
> your patch with option -U8

No need, this patch should be fine as-is.

thanks,

greg k-h
