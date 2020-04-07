Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907481A1270
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 19:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgDGRJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 13:09:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:36004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726365AbgDGRJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:09:41 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2020 13:09:41 EDT
Received: (qmail 2806 invoked by uid 109); 7 Apr 2020 17:02:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Apr 2020 17:02:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29535 invoked by uid 111); 7 Apr 2020 17:13:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2020 13:13:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Apr 2020 13:02:57 -0400
From:   Jeff King <peff@peff.net>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
Message-ID: <20200407170257.GA1844923@coredump.intra.peff.net>
References: <20200407154046.GA15368@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407154046.GA15368@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 05:40:46PM +0200, Olaf Hering wrote:

> For me sending patches via git send-email fails because email address
> conversion is failing. Something appends a ')' to x86/lkml@kernel.org.
> I suspect the double '))' in MAINTAINERS is confusing the command.
> I tried to send the trivial patch from v5.0 and v5.6 tag.
> 
> Is this a failure in ./scripts/get_maintainer.pl,
> or is this something git does internally?
> I'm sure others use such command on a daily basis, so likely something on
> my end became broken at some point in the past.

It's a bug in send-email's hand-rolled address parser, which was fixed
in bd869f67b9 (send-email: add and use a local copy of Mail::Address,
2018-01-05). Upgrade to Git v2.17.0 or newer.

-Peff
