Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBD1EE96B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgFDR21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 13:28:27 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:30588 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730094AbgFDR21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:28:27 -0400
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; 
   d="scan'208";a="453044118"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 19:28:25 +0200
Date:   Thu, 4 Jun 2020 19:28:25 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kzfree script
In-Reply-To: <65dee3e0-7df9-5b38-fe4c-5de3f70380a0@linux.com>
Message-ID: <alpine.DEB.2.21.2006041927020.2577@hadrien>
References: <20200604140805.111613-1-efremov@linux.com> <alpine.DEB.2.21.2006041614300.2577@hadrien> <a188acce-348b-b106-9180-708c3050ef8d@linux.com> <alpine.DEB.2.21.2006041749520.2577@hadrien> <65dee3e0-7df9-5b38-fe4c-5de3f70380a0@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> After all it seems reasonable to me to add forall and memset_explicit rather
> than handle all these false positives. Something like this for v2?
>
> @r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
> expression *E;
> position p;
> @@
>
> * \(memset\|memset_explicit\)(E, 0, ...);
>   ... when != E
> * kfree(E)@p;
>
> Do I need to add "when strict" with forall or it's already enabled in this case?
> Do I need to enable forall for pathing "-/+"?

forall seems entirely reasonable.  You don't need it in the -/+ case.  I
would put when strict in both cases.

julia
