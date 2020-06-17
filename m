Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D11FD663
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 22:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFQUwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 16:52:18 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:49844
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbgFQUwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:52:18 -0400
X-IronPort-AV: E=Sophos;i="5.73,523,1583190000"; 
   d="scan'208";a="351906721"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 22:52:16 +0200
Date:   Wed, 17 Jun 2020 22:52:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Kees Cook <keescook@chromium.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
In-Reply-To: <7c7b22f8-722c-60f5-db5d-290bea2b499c@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006172252080.3083@hadrien>
References: <20200615102045.4558-1-efremov@linux.com> <alpine.DEB.2.22.394.2006172229550.3083@hadrien> <7c7b22f8-722c-60f5-db5d-290bea2b499c@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Jun 2020, Denis Efremov wrote:

>
>
> On 6/17/20 11:30 PM, Julia Lawall wrote:
> >
> >
> > On Mon, 15 Jun 2020, Denis Efremov wrote:
> >
> >> Detect an opencoded expression that is used before or after
> >> array_size()/array3_size()/struct_size() to compute the same size.
> >
> > This would benefit from the assignemnt operator metavariables as well.
> >
> > Also, it could be better to put the python rules up next the SmPL pattern
> > matching rules that they are associated with.
> >
>
> Thanks, I will send v2.
> Here is the KSPP ticket with patches https://github.com/KSPP/linux/issues/83

Thanks!

julia
