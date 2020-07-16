Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972FC222305
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgGPM4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgGPM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:56:06 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 05:56:05 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4B6vPp1gQVz9sV6; Thu, 16 Jul 2020 22:55:57 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     oss@buserror.net, linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        benh@kernel.crashing.org
In-Reply-To: <20200713192656.37443-1-grandmaster@al2klimov.de>
References: <20200713192656.37443-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH] powerpc/Kconfig: Replace HTTP links with HTTPS ones
Message-Id: <159490401741.3805857.15601592351577773975.b4-ty@ellerman.id.au>
Date:   Thu, 16 Jul 2020 22:55:57 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 21:26:56 +0200, Alexander A. Klimov wrote:
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

[1/1] powerpc/Kconfig: Replace HTTP links with HTTPS ones
      https://git.kernel.org/powerpc/c/9a3e3dccbf4317d02d28f8f99a5d1ccce42f9922

cheers
