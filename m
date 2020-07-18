Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E16224B88
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgGRNaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 09:30:00 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:8426 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726569AbgGRNaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:30:00 -0400
X-IronPort-AV: E=Sophos;i="5.75,367,1589234400"; 
   d="scan'208";a="460306961"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 15:29:58 +0200
Date:   Sat, 18 Jul 2020 15:29:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Markus Elfring <Markus.Elfring@web.de>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org
Subject: Re: [v2 1/4] coccinelle: api: extend memdup_user transformation with
 GFP_USER
In-Reply-To: <cf2bd604-3094-f90a-52a8-ff5a44cf3850@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007181529460.2538@hadrien>
References: <0b9f2c58-e124-22d2-d91d-62a6e831c880@web.de> <alpine.DEB.2.22.394.2007180841520.2538@hadrien> <cf2bd604-3094-f90a-52a8-ff5a44cf3850@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Jul 2020, Denis Efremov wrote:

> Hi,
>
> On 7/18/20 9:45 AM, Julia Lawall wrote:
> > This on is indeed a problem.  I think it was not detected in testing,
> > because in the current kernel the rule never applies.  But Denis, in
> >
> > -  to = \(kmalloc\|kzalloc\)
> >                 (size,\(GFP_KERNEL\|GFP_USER\|
> >                       \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
> >
> > you do indeed need to put - in front of the second and third lines as
> > well.
>
> Thanks, Markus, Julia. I will send v3. Julia, is it ok with you, if I will
> drop the last patch with "selfcheck" this time?

That would be perfect, thanks.

julia
