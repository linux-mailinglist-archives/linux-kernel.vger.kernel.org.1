Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF542CEC9B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgLDK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387968AbgLDK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:58:12 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB556C061A54
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:56:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CnV5G5JtCz9sWP;
        Fri,  4 Dec 2020 21:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1607079411;
        bh=sE981+GdvNkIMZp6vrNdrmV1a1lR1GRVRUonAPEMia8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=L74eRVt4sW7Znta5a2ABIdr+qJRbBu3DFGXznuWnC7CEm+xnK8/oJLG4NtsZPhn8Q
         J1+O35GAgkdws8ZFaSJJB1ANBCq5wT89DCiFce4YarMXKYA6znhXQZZEzTZwUcO32d
         M5THBCdbQIg6NNyB8+uOMZT4I7FmY68x+j1L4aTKxQIgi4Gkb9HuKIj4KQ9HTivUru
         NlEq1HBraTYc6PnQS+lEzvXqR5BClDM4cofr2IkFqDgZz9p0LBlBZcpkiBYErxV4UG
         HyzhYlvVdlU3tfe4labwDy4TzXTxAM9V9psVnV8hvCtODh2wf+cDL2VUHMpNza6LcH
         hJ8hl58g5wvbQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xmon: Change printk() to pr_cont()
In-Reply-To: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
References: <c8a6ec704416ecd5ff2bd26213c9bc026bdd19de.1607077340.git.christophe.leroy@csgroup.eu>
Date:   Fri, 04 Dec 2020 21:56:49 +1100
Message-ID: <87h7p1vnym.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Since some time now, printk() adds carriage return, leading to
> unusable xmon output:
>
> [   54.288722] sysrq: Entering xmon
> [   54.292209] Vector: 0  at [cace3d2c]
> [   54.292274]     pc:
> [   54.292331] c0023650

...

> diff --git a/arch/powerpc/xmon/nonstdio.c b/arch/powerpc/xmon/nonstdio.c
> index 5c1a50912229..9b0d85bff021 100644
> --- a/arch/powerpc/xmon/nonstdio.c
> +++ b/arch/powerpc/xmon/nonstdio.c
> @@ -178,7 +178,7 @@ void xmon_printf(const char *format, ...)
>  
>  	if (n && rc == 0) {
>  		/* No udbg hooks, fallback to printk() - dangerous */
> -		printk("%s", xmon_outbuf);
> +		pr_cont("%s", xmon_outbuf);
>  	}

Ah OK, in the case where there's no udbg backend. We basically always
have a udbg backend on 64-bit, via hvc console. Which explains why we
haven't noticed it.

Will pick up the patch.

cheers
