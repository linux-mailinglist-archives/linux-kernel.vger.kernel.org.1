Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC51121D202
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgGMInc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 04:43:32 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:63913
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgGMInb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:43:31 -0400
X-IronPort-AV: E=Sophos;i="5.75,346,1589234400"; 
   d="scan'208";a="354298904"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 10:43:28 +0200
Date:   Mon, 13 Jul 2020 10:43:28 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Takashi Iwai <tiwai@suse.de>
cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive
 Terminology
In-Reply-To: <s5hlfjnzvu7.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2007131043070.2322@hadrien>
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com> <s5hlfjnzvu7.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jul 2020, Takashi Iwai wrote:

> On Wed, 08 Jul 2020 20:14:27 +0200,
> Dan Williams wrote:
> >
> > +Recommended replacements for 'blacklist/whitelist' are:
> > +    'denylist / allowlist'
> > +    'blocklist / passlist'
>
> I started looking through the tree now and noticed there are lots of
> patterns like "whitelisted" or "blacklisted".  How can the words fit
> for those?  Actually, there are two cases like:
>
> - Foo is blacklisted
> - Allow to load the non-whitelisted cards
>
> Currently I'm replacing the former with "Foo is in denylist", but not

In the denylist?

julia


> sure about the latter case.  I thought Kees mentioned about this, but
> don't remember the proposal...
>
> In anyway, I'm for the action:
>   Acked-by: Takashi Iwai <tiwai@suse.de>
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss
>
