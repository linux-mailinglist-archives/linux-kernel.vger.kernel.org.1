Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19613233902
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 21:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgG3T2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 15:28:08 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16693 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgG3T2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:28:07 -0400
X-IronPort-AV: E=Sophos;i="5.75,415,1589234400"; 
   d="scan'208";a="461952951"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 21:27:32 +0200
Date:   Thu, 30 Jul 2020 21:27:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: api: add kvfree script
In-Reply-To: <75532a99-4498-c64a-de34-c9033782aa9e@web.de>
Message-ID: <alpine.DEB.2.22.394.2007302125580.2548@hadrien>
References: <75532a99-4498-c64a-de34-c9033782aa9e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +msg = "WARNING: kmalloc is used to allocate this memory at line %s" % (k[0].line)
> > +coccilib.org.print_todo(p[0], msg)
>
> * I find the diagnostic text insufficient.

I also find the message not very informative.

All of the other comments are not useful, and some are simply incorrect.

julia
