Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDF22C646
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgGXNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:24:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46505 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbgGXNYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:24:47 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgJ1wMzz9sTR; Fri, 24 Jul 2020 23:24:43 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     colin@colino.net, "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        benh@kernel.crashing.org
In-Reply-To: <20200717182940.75484-1-grandmaster@al2klimov.de>
References: <20200717182940.75484-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH] macintosh/therm_adt746x: Replace HTTP links with HTTPS ones
Message-Id: <159559696822.1657499.18409103323748931249.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:24:43 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 20:29:40 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Applied to powerpc/next.

[1/1] macintosh/therm_adt746x: Replace HTTP links with HTTPS ones
      https://git.kernel.org/powerpc/c/1666e5ea2f838f4266e50e4f3d973c0824256429

cheers
