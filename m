Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F81D09AB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgEMHOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 03:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgEMHOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:14:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99B9206D6;
        Wed, 13 May 2020 07:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589354055;
        bh=DLr2UF6e0IHfcW2xoKKLz/KEhDxSLoxOz8Ehzzq0pOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgtWzUv5Pg1zRmc16W7qpkqqRqludZO1T7kog9p3eecl7JMcb5IxeW5U9A2y3pi07
         l9WRB5Dpp95/qBln3UUKhkMmykr7W2pl5z1cpYtBIxmIlUbleEBZMkPa8aXmEOi43d
         7O4k8NtL6nwaZ0pHpd5u4Cf5pXxpfhKeZ+BwelpA=
Date:   Wed, 13 May 2020 09:14:13 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Idgar, Or" <Or.Idgar@dell.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Ravich, Leonid" <Leonid.Ravich@dell.com>
Subject: Re: CMA enhancement - non-default areas in x86
Message-ID: <20200513071413.GB766804@kroah.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513064755.GA763968@kroah.com>
 <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:00:12AM +0000, Idgar, Or wrote:
> > For what type of device?
> NTB (Non-Transparent Bridge).


Very odd quoting style...

Anyway, what exactly is a non-transparent bridge, and why doesn't your
bios/uefi implementation properly reserve the memory for it so that the
OS does not use it?

thanks,

greg k-h
