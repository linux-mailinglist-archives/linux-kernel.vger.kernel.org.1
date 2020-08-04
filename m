Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB38B23B60B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgHDHty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 03:49:54 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:25031 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgHDHty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:49:54 -0400
X-IronPort-AV: E=Sophos;i="5.75,433,1589234400"; 
   d="scan'208";a="462364097"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 09:49:52 +0200
Date:   Tue, 4 Aug 2020 09:49:52 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: api: add kvmalloc script
In-Reply-To: <12b09b8f-7c73-1827-8bf3-63e6041b63fd@web.de>
Message-ID: <alpine.DEB.2.22.394.2008040949360.2575@hadrien>
References: <12b09b8f-7c73-1827-8bf3-63e6041b63fd@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Aug 2020, Markus Elfring wrote:

> > Changes in v3:
> > - kvfree rules added
>
> I find it interesting to you found such an addition needed for this SmPL script.
> I imagine that it can be helpful to support such a source code search by
> a separate script for the semantic patch language.
>
> I am curious if my patch review comments for the second version got also a bit
> of your software development attention.
>
> Another implementation detail is relevant for further clarification.
> The SmPL rules for patch generation differ in search functionality
> which is provided for other operation modes.
> Can these deviations influence the confidence level?

I see no useful information in this review, nor in the v2 review.

julia
