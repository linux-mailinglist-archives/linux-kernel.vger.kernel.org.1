Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1653B22C647
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGXNYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgGXNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:24:50 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1259CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:24:50 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgG5TRBz9sTC; Fri, 24 Jul 2020 23:24:41 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     benh@kernel.crashing.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200717183522.77605-1-grandmaster@al2klimov.de>
References: <20200717183522.77605-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH] macintosh/adb: Replace HTTP links with HTTPS ones
Message-Id: <159559696801.1657499.3725120568145731432.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:24:41 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 20:35:22 +0200, Alexander A. Klimov wrote:
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

[1/1] macintosh/adb: Replace HTTP links with HTTPS ones
      https://git.kernel.org/powerpc/c/a7beab413e2e67dd1abe6bdd0001576892a89e81

cheers
