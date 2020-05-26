Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074301CA876
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEHKkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 06:40:18 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:28123 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgEHKkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:40:18 -0400
X-IronPort-AV: E=Sophos;i="5.73,367,1583190000"; 
   d="scan'208";a="448810012"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2020 12:40:08 +0200
Date:   Fri, 8 May 2020 12:40:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Jeremy Kerr <jk@ozlabs.org>
cc:     kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>
Subject: Re: [PATCH] powerpc/spufs: adjust list element pointer type
In-Reply-To: <4c9cc9184213ded65489cb95050046c8904ddad8.camel@ozlabs.org>
Message-ID: <alpine.DEB.2.21.2005081237210.5307@hadrien>
References: <1588929176-28527-1-git-send-email-Julia.Lawall@inria.fr> <4c9cc9184213ded65489cb95050046c8904ddad8.camel@ozlabs.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 May 2020, Jeremy Kerr wrote:

> Hi Julia,
>
> > Other uses of &gang->aff_list_head, eg in spufs_assert_affinity, indicate
> > that the list elements have type spu_context, not spu as used here.  Change
> > the type of tmp accordingly.
>
> Looks good to me; we could even use ctx there, rather than the separate
> tmp variable.

I thought about that, but it seemed a little bit abusive, since ctx is
used in an iteration over another list.  But if you prefer that I can
change it.

julia

>
> Reviewed-by: Jeremy Kerr <jk@ozlabs.org>
>
> Cheers,
>
>
> Jeremy
>
>
