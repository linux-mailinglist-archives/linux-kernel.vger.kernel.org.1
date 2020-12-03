Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBEB2CD818
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgLCNmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:42:23 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:8150 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730729AbgLCNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:42:22 -0500
X-IronPort-AV: E=Sophos;i="5.78,389,1599516000"; 
   d="scan'208";a="480918393"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 14:41:40 +0100
Date:   Thu, 3 Dec 2020 14:41:40 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] crediting bug reports and fixes folded into
 original patch
In-Reply-To: <20201203103351.GR2767@kadam>
Message-ID: <alpine.DEB.2.22.394.2012031440400.2799@hadrien>
References: <ea32eb02-5e44-0469-772b-34b5cb882543@suse.cz> <20201203103351.GR2767@kadam>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Dec 2020, Dan Carpenter wrote:

> I'd like a "Fixes-from: Name email" tag for when someone spots a bug in
> a patch.
>
> I think we should not give credit for style complaints, because those
> are their own reward and we already have enough bike shedding.

I agree with Dan, although I'm quite ok with the current situation as
well.

julia
