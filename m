Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4349D2C5752
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbgKZOqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:46:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:34411 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391146AbgKZOqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606401988;
        bh=PRPNpMotUvpI10D++S5LFr1UmaR0xe7HyImbRCwZYkw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Gyb0lhvajV2RPyZjMV/h9ppl36nVqF35GjmRebdaR/oKYGvtZtEzjxb/QSxgL4cXn
         t3IKF+leZe6ej7onXwNYZRF0+wsZzwAJ3FJ4GcxU7WL1c+1l3lO7G3chkO0X9yPoNl
         zHreug2yKEH3+v3S/f7+Bze2DWJbPHIhusqqHMX8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.153.204]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M59C2-1khC4m1u8y-0018ye; Thu, 26
 Nov 2020 15:46:28 +0100
Subject: Re: [PATCH] parisc: signal: remove _SA_SIGGFAULT
To:     Anders Roxell <anders.roxell@linaro.org>,
        James.Bottomley@HansenPartnership.com
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201126130606.2290438-1-anders.roxell@linaro.org>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <8affd609-f037-8b21-853a-8b87299db044@gmx.de>
Date:   Thu, 26 Nov 2020 15:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201126130606.2290438-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pqPtU/hef+goOxKEsRO2KLDKrJ1uubwjMDWW825keVpZNQ0eTYy
 /7FczKafA7cE1ER+E4lghnTFGdHVeCzA3PiNkgovKwBr/Xom9T6mQHa8ekcCloNjfm6uwZ2
 hyF1aimnuKoMU5B0Tj3TJGAOwdBDmwvnT+UreA+1oYVWJToPponXq/azMflRhu9TQXjCc9k
 51jBhi7k9paxSTPK0HGvg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JJAEomwW6K0=:TTZXePlxc3ANVjRvfzYcEX
 xLxghHZJ9hvl8lHWvTm4nISbKeW4R8rY0r+gUIs8NYIB6qMWyTUa+TfDSPzp7MqKIJHAUxpZV
 sx/wgu/EnunWidh/zYfG8vRKzLlbSRd4xMtXZ3RV4fQqELOJI0Xef6l7Z1efUnPbv99tzqWJO
 350AX3cl2UZf64uBGdBlBiJjVJ1YJMXPhDNn8tfJrn5+40VsobEtogA1gNMNYXtjqsBKsPKFV
 gNncQWKrCORCm1Pev/EQQs3UI32Eoip8ab+bMaZViR5Ts0unV8e76e/RgWmXG/o59WSHXXCH0
 bfke/2InLUmsppZf7k1vYvzygXwApYcvBvssHJRLe7k0LWRAAVfmEpQH1BvFxWS96BANMsgil
 vQgoYpLDihn976Z0EDcguJVleCHCIIsFUir5rajFqzg3wLnOACK1Tn/psKVijjQLzVPfTx870
 mRmFhcgTj+NMQA9HuhxuW+iEh6n9p3+YeT96PV9dA8iUBLoasUqNX+v/F0YlbfnTKCPG5pcmW
 zyNYVPTkiZ+rkE8pY3Z4hfoF5NMoGPb30xvcp27b52rlmoRymm6ALLDDzb4jmnLBaRVb+pDF8
 GgBpd2t5IER2VS6DJPYJzZT4cgp68nz0Cdc+ySsB1Byx5W3KIprXU3ZcK3w23q7n5PX6tDrR7
 zK+6THD7VgoPAiclQseIcinw7b7H0DvlgFuhGZwHPTaM4R9+2ShJfSJsW+Ky+tL3JjS7DDf88
 nVyJ1q4J0OOF6LUts2EzPQ21vUF1CJUqfkwmiQW+Xt0tP3cnw2za5rKXgGdUVyJysuJ/Zt+Lb
 qL9zlPrUYR9pCuanfnS15J1wRQZqHgMZGErSrsVoOX+evPWSpL1tT3Fz1PTnA1F0Nw15xQK+a
 lb6sJCdso0UikX/GCSuA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/20 2:06 PM, Anders Roxell wrote:
> When building tinyconfig on parisc the following error shows up:
>
> /tmp/kernel/signal.c: In function 'do_sigaction':
> /tmp/arch/parisc/include/asm/signal.h:24:30: error: '_SA_SIGGFAULT' unde=
clared (first use in this function); did you mean 'SIL_FAULT'?
>  #define __ARCH_UAPI_SA_FLAGS _SA_SIGGFAULT
>                               ^~~~~~~~~~~~~
>
> The changes in the two individual patches listed in 'Fixes' below are
> OK.  Remove the _SA_SIGGFAULT define since PH-UX isn't going to be
> supported according to commit 41f5a81c07cd ("parisc: Drop HP-UX specific
> fcntl and signal flags").
>
> Fixes: 23acdc76f179 ("signal: clear non-uapi flag bits when passing/retu=
rning sa_flags")
> Fixes: 41f5a81c07cd ("parisc: Drop HP-UX specific fcntl and signal flags=
")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/parisc/include/asm/signal.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/parisc/include/asm/signal.h b/arch/parisc/include/asm/=
signal.h
> index 30dd1e43ef88..715c96ba2ec8 100644
> --- a/arch/parisc/include/asm/signal.h
> +++ b/arch/parisc/include/asm/signal.h
> @@ -21,8 +21,6 @@ typedef struct {
>  	unsigned long sig[_NSIG_WORDS];
>  } sigset_t;
>
> -#define __ARCH_UAPI_SA_FLAGS	_SA_SIGGFAULT
> -

Which kernel are you testing?
I don't see this line in current git head...?!?

Helge

>  #include <asm/sigcontext.h>
>
>  #endif /* !__ASSEMBLY */
>

