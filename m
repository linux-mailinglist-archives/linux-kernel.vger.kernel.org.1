Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4502105EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 10:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGAIPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 04:15:35 -0400
Received: from mout.web.de ([217.72.192.78]:38697 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728188AbgGAIPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593591322;
        bh=LsbgrN+XbOhH1YYBuyAJlJARrHXNo7sXYiwieN7tSUQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=chq0FyjS2nN4JEFWKftqPr0N1OtdhMvKlJt382LWzxsNLOrLyyPCAumgFEMkcAXbJ
         2P5gPgJczoOQI4dubwc7530bqbbubKpIL5PPUy/L8HpYkmUWbk4eajM5GDLOmUJuCE
         0it7CdFwICSgQ+83w+nPyL/Or03EaOJt8Rg3puHY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOm0r-1jS1Yr0pR9-00QEpa; Wed, 01
 Jul 2020 10:15:22 +0200
Subject: Re: [PATCH v4 04/14] irqchip/davinci-aintc: Fix potential resource
 leaks
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-5-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <08cad331-0a17-586c-07a7-6e3843cb61a1@web.de>
Date:   Wed, 1 Jul 2020 10:15:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593569786-11500-5-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Icnu5aEb3po0rBvNg7cDRQrqF+/3jZzVKct0fb/Ue2DliZMVxX
 a+qCDr2WU+sL9ASuw9NAKciHCDJH0Kv+YMU51lxA9bgeAc3b70mYFbyU3Wwc5YzuMFdbYWn
 S8Ro7fNuuahr5LSi44/Na54nDzSud0uG6EuPRYtVjdxzLTuvCths1YV/1scmfBzqRiCcG9b
 YrYmm+L5DTB93xogL5PDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+YDvWG6y2lQ=:N5niptZWb7Bb9sbeGe8I/9
 uI/K88dbtyD6x2ehT7wHHcpjHrGn+/nFgFyOmL+ys9i3yUGyu1jfPdxPqYdi9nnYvPCteY7bH
 gy1ZqI/nSzuK1gS24kB4FTKvtC42mGCQrgf74ZIAUyR67hz4OiuGREnjttRVOrTGMUkvb+gZ+
 NPL3UfGptfXk45q96pW8Kjdk8kB4lPMJ+IPnbvjHFhc67c1zYgVKMKJ3lABmq83OTBukHluYx
 DWFi/79A5mRdetYXQISnxdTwo9e2NHy1XelmVccftVgYhIz6veSEXvWw3v9bIc19TjRnw8ct+
 uFyRkRHD6aHzZ0e70DqJHRWY9PxZ4imr+hjkp+c/pSUX9tWUxZLzn9LuhcHM1Obl6d/xx1MyY
 IQ9KmZAE5yxRk/o24yNIXWKF/kNTUHA7Cg+R5fHeVaNuuddIwY+i5U77+ErgeUaG8tCLeWKDH
 joDTUTDsyG0QhfOiteFoQtzDyiFhFRVZgUBcqQZ3ee8JxOdBFjqjrOMGepkl+e2unDpDkVEAt
 kfL04YANjDNaDCC73E9YfpquZryIVskLFwO0yQkowDxE7XYZak5xBd5JAghnoahp7MThIusLB
 vxwPVUu6gn3ns7X+Brw6cLoq9mTBfOfLRqOQ0eTkw26+sBUqztl77R9WnnSwGLb62J8p0S1Ys
 CWfFIfvmN8Y9iHhv7eSqYZ4t+kR37hOskh2t4vJaSRJqfn2A/A+CsRU9GqhBrfTZ++9sgHoR1
 pBMDzOeFERtNNfr5Z6TNzE20m+onbxFSNVzLpqTngYqsvqWP1G5pNYsq/8TiWb6xKp7T79NKe
 DlMuBy9zV+Xeoqwi+V+YDN08CaKKDACUB6rQahrblL6qYsF5Y4BpZ/a0zDJzwwNDzQ5qrcjvR
 mvUCnqcaFFCmZnPR6RZLxz7RaZ260arEzI74LgAKrmuSZQ3pUVOKztVilpqk5dhrK8LrmsJlU
 shKE5g/z/IwPTkoFNfyFyM8jnKhRb1sVM/V4+wTEt3IJqAp3JPoPNXC4gZZI4CoEopyDFFE4k
 20uk7DPADEXrKH5TQi/w0wf9qyO+v8RJ2RflyUaRGdAbK2QkWBjP0+janrszR15efePsMYHs2
 HYEscfgfSFTsqnRAIabHUzYu6lgkjdf5IMKwKrF1EtnZsRyLi3yQDxTnRwKT3r/H0frouT/HN
 pbYO9daSQgYdSlPI4NgTQd0IMt48dpsAEFp4hP7+1/OY64wqAu61ahjr/leNk4SjtVe4y0Wbg
 8bUj4UAHjCWcI/YKI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/drivers/irqchip/irq-davinci-aintc.c
> @@ -96,7 +96,7 @@ void __init davinci_aintc_init(const struct davinci_ai=
ntc_config *config)
>  				     resource_size(&config->reg));
>  	if (!davinci_aintc_base) {
>  		pr_err("%s: unable to ioremap register range\n", __func__);
> -		return;
> +		goto err_release;
>  	}
=E2=80=A6

Can it help to return any error codes?
Would you like to reconsider the function return type?

Regards,
Markus
