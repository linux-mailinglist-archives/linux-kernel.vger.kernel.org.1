Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C222CEFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 22:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgGXUC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 16:02:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:16289
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgGXUCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:02:25 -0400
X-IronPort-AV: E=Sophos;i="5.75,391,1589234400"; 
   d="scan'208";a="355246789"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 22:02:08 +0200
Date:   Fri, 24 Jul 2020 22:02:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Update memdup_user.cocci
In-Reply-To: <20200720162216.13248-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007242201550.2396@hadrien>
References: <20200720162216.13248-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 Jul 2020, Denis Efremov wrote:

> Add GFP_USER to the allocation flags and handle vmemdup_user().
>
> Changes in v2:
>  - memdup_user/vmemdup_user matching suppressed
>  - PoC for selfcheck virtual rule
> Changes in v3:
>  - add missing '-' for patch rule in kmalloc/kzalloc call args
>  - selfcheck rule dropped from patchset
>
> Denis Efremov (3):
>   coccinelle: api: extend memdup_user transformation with GFP_USER
>   coccinelle: api: extend memdup_user rule with vmemdup_user()
>   coccinelle: api: filter out memdup_user definitions

All three applied.  Thanks.

julia

>
>  scripts/coccinelle/api/memdup_user.cocci | 64 ++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 3 deletions(-)
>
> --
> 2.26.2
>
>
