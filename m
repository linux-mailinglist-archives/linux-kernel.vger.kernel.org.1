Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9A1F0174
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgFEVTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 17:19:36 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10401 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728253AbgFEVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:19:34 -0400
X-IronPort-AV: E=Sophos;i="5.73,477,1583190000"; 
   d="scan'208";a="453259960"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 23:19:33 +0200
Date:   Fri, 5 Jun 2020 23:19:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kvfree script
In-Reply-To: <43cead50-05f8-67ce-c1de-ce3acefb0dec@linux.com>
Message-ID: <alpine.DEB.2.21.2006052318310.28300@hadrien>
References: <20200605204237.85055-1-efremov@linux.com> <alpine.DEB.2.21.2006052249160.28300@hadrien> <43cead50-05f8-67ce-c1de-ce3acefb0dec@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jun 2020, Denis Efremov wrote:

> On 6/5/20 11:51 PM, Julia Lawall wrote:
> > Is there a strong reason for putting the choice rule first?  It may make
> > things somewhat slower than necessary, if it matches in many places,
> > because the opportunity rule will have to detect that it doesn't care
> > about all of those places.
>
> No, I didn't know that order of rules matters. I just checked it, my PC
> shows no difference in exec time if I swap these rules.

OK, probably choice doesn't match in very many places, so there is not
much impact.

julia

>
> "choice" doesn't check the size. "opportunity" is more strict.
> The motivation for adding 2 rules is that we could recommend to use
> kvmalloc* only when there is a size condition. At the same time, we
> should skip all if (...) {kmalloc()} else {vmalloc()},
> res = kmalloc() if (!res) {vmalloc()} cases as false positives.
>
> It seems that it's not possible to use subexpression rule
> "expression size <= choice.E" in this case.
>
> > Also, there is no need to exceed 80 characters here.  You can put a
> > newline in the middle of a \( ... \)
>
> Ok, I will fix it in v2 after all comments/suggestions.
>
> Thanks,
> Denis
>
