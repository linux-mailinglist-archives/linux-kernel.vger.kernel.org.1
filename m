Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4D2CCB08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgLCAe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgLCAe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:34:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015BAC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 16:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=BSqvkZ6qretH2eghiZ1Eez1JnJWG5PoN6DJJDepZGPE=; b=yVheqf9B5iEktBwp6BUsG9CQdX
        TuL0Ilx6ZialiPlU22DsLj68lbeU056cobFrz1l28/kZSBitfwejWMA5wQr0n+9cy0n2swy4XI27/
        e6rR8sL9HKWQcy1Fql8GtH3K8Q5x+Oyiw7SD6+dw62nIcplOoJ6pRLA8JltOy6NfetnLX3shADGYX
        9X1zvst/73jo7/ac5zyKbCW5GlWNCqcvmgp/RGf4dU3Yqw7yqySUBOQr8VCKlDMHqlk8bcl5Hqyzt
        DLIbpKKCcy5tXO881OCOA0Dxuekyhi3BqMTQwUlyPMY5GcURrVllLt3wesmDQ/WDBK2jilrrduXoU
        qAxbSWVw==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkcZa-0000Em-Tn; Thu, 03 Dec 2020 00:34:15 +0000
Subject: Re: [PATCH] Documentation: fix typos found in process, dev-tools, and
 doc-guide subdirectories
To:     Andrew Klychkov <andrew.a.klychkov@gmail.com>, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org
References: <20201202075438.GA35516@spblnx124.lan>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <45b007e6-9001-9018-49bf-1e1907686241@infradead.org>
Date:   Wed, 2 Dec 2020 16:34:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202075438.GA35516@spblnx124.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 11:54 PM, Andrew Klychkov wrote:
> Fix four typos in kcov.rst, sphinx.rst, clang-format.rst, and embargoed-hardware-issues.rst
> 
> Signed-off-by: Andrew Klychkov <andrew.a.klychkov@gmail.com>
> ---
>  Documentation/dev-tools/kcov.rst                    | 2 +-
>  Documentation/doc-guide/sphinx.rst                  | 2 +-
>  Documentation/process/clang-format.rst              | 2 +-
>  Documentation/process/embargoed-hardware-issues.rst | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

