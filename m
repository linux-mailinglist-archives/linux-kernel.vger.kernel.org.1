Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCB2D7781
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395477AbgLKOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:12:10 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:10615 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390593AbgLKOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1607695713;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
        Subject:Sender;
        bh=B/LBAUjjfTRgH46xG4Nbin5AyWdAJwByXke5lnj2Egw=;
        b=CBGBYHJ/iKJU4EnEnL/OfhH5NFyJmPBukRnxuzU9xFo+fKmrG8H62Q7WGS+XBGbRsg
        ino0Feqrk/54BYnKuLPQboJ0JQroqHXsUPx7mrywfTGGXx2+kzFZNCqry5uOnhc1wCEb
        veDSsSkSBqhBigiUNZ/+hjhtYnBpxof2hUN9qMAX8QBSOoIC25p5qjc14Jo1O/EBB4Yk
        3329jF7sR0c9g8FfnzBSXVDooRZGDQSlcJj6YilWm+S0xwoF+ANzsTJ9/aiygPxMwdt0
        mWaLLwsMScobGk/7jxAPvOnBwyPyUeHX5fob/WplUK2Xl+s7jn9wXjGtXagNjJvnLPN1
        ni+A==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884EC0GFGHev6G4xuq1eJ0Y="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 47.7.1 DYNA|AUTH)
        with ESMTPSA id L0a6acwBBE8N0pb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Dec 2020 15:08:23 +0100 (CET)
Message-ID: <13db294664a6b2e26a892dd544c714d3e385b0cc.camel@chronox.de>
Subject: Re: [PATCH v4 4/5] crypto: hisilicon/hpre - add 'ECDH' algorithm
From:   Stephan Mueller <smueller@chronox.de>
To:     Meng Yu <yumeng18@huawei.com>, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Date:   Fri, 11 Dec 2020 15:08:22 +0100
In-Reply-To: <1607668234-46130-5-git-send-email-yumeng18@huawei.com>
References: <1607668234-46130-1-git-send-email-yumeng18@huawei.com>
         <1607668234-46130-5-git-send-email-yumeng18@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 11.12.2020, 14:30 +0800 schrieb Meng Yu:
> 
> +/* size in bytes of the n prime */
> +#define HPRE_ECC_NIST_P128_N_SIZE      16

Do we truly need P-128? Besides, I do not see that curve being defined in
contemporary cipher specs.

> +#define HPRE_ECC_NIST_P192_N_SIZE      24
> +#define HPRE_ECC_NIST_P224_N_SIZE      28
> +#define HPRE_ECC_NIST_P256_N_SIZE      32
> +#define HPRE_ECC_NIST_P320_N_SIZE      40

Do we truly need P-320? Besides, I do not see that curve being defined in
contemporary cipher specs.

> +#define HPRE_ECC_NIST_P384_N_SIZE      48
> +#define HPRE_ECC_NIST_P521_N_SIZE      66
> +
> +/* size in bytes */
> +#define HPRE_ECC_HW256_KSZ_B   32
> +#define HPRE_ECC_HW384_KSZ_B   48
> +#define HPRE_ECC_HW576_KSZ_B   72
> +
> +#define HPRE_ECDH_MAX_SZ       HPRE_ECC_HW576_KSZ_B]

Ciao
Stephan

