Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB52814C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgJBONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:13:52 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:6201 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387908AbgJBONv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:13:51 -0400
X-IronPort-AV: E=Sophos;i="5.77,327,1596492000"; 
   d="scan'208";a="360697799"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 16:13:50 +0200
Date:   Fri, 2 Oct 2020 16:13:49 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: kzfree script
In-Reply-To: <7bf57afe-43d6-1288-cd8b-951079a35fa9@linux.com>
Message-ID: <alpine.DEB.2.22.394.2010021612200.2707@hadrien>
References: <alpine.DEB.2.22.394.2010021600120.2707@hadrien> <7bf57afe-43d6-1288-cd8b-951079a35fa9@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Oct 2020, Denis Efremov wrote:

> Hi,
>
> On 10/2/20 5:01 PM, Julia Lawall wrote:
> > Denis,
> >
> > In the rule proposing kzfree_sensitive, I think it would be helpful to
> > also highlight the memset line.
>
> What do you mean? It's "highlighted" in context mode. Do you mean adding
> position argument to memset call and showing this position in the warning
> messages?

Yes, that seems to be what I mean.  0-day generated a message from the
script, and I had to hunt around for the reason why it was doing that.  So
it would be nice to have the memset highlighted.  It seems that the
non-patch 0-day messages are generated from the report mode.

thanks,
julia
