Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E77233997
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 22:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgG3UPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 16:15:31 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56696 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgG3UPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:15:31 -0400
X-IronPort-AV: E=Sophos;i="5.75,415,1589234400"; 
   d="scan'208";a="461955542"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 22:15:26 +0200
Date:   Thu, 30 Jul 2020 22:15:26 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] coccinelle: api: add kvfree script
In-Reply-To: <20200730140751.8635-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007302214160.2548@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <20200730140751.8635-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, the message looks fine.  Sorry for the noise about that.

However there is a problem in the kfree case:

> +@kfree depends on !patch@
> +expression E;
> +position v != choice.vok;
> +position p;
> +@@
> +
> +* E = \(vmalloc@v\|vzalloc@v\|vmalloc_user@v\|vmalloc_node@v\|vzalloc_node@v\|
> +        vmalloc_exec@v\|vmalloc_32@v\|vmalloc_32_user@v\|__vmalloc@v\|
> +        __vmalloc_node_range@v\|__vmalloc_node@v\)(...)
> +  ... when != !is_vmalloc_addr(E)
> +      when any
> +* \(kfree\|kzfree\|kvfree\)(E)

p is not used.  The last line should be (E)@p.

julia
