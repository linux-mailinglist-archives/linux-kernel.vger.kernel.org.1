Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C42346F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 15:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbgGaNbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 09:31:33 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40586 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbgGaNbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:31:31 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1V7H-00018b-Id; Fri, 31 Jul 2020 23:30:32 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 23:30:31 +1000
Date:   Fri, 31 Jul 2020 23:30:31 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, mpm@selenic.com,
        robh+dt@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        hadar.gat@arm.com, prasannatsmkumar@gmail.com, krzk@kernel.org,
        masahiroy@kernel.org, rdunlap@infradead.org, xuzaibo@huawei.com,
        daniel.thompson@linaro.org, tmaimon77@gmail.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: Re: [PATCH v2 0/2] Add support for the RNG in Ingenic JZ4780 and
 X1000.
Message-ID: <20200731133031.GG14360@gondor.apana.org.au>
References: <20200723062446.84013-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723062446.84013-1-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 02:24:44PM +0800, 周琰杰 (Zhou Yanjie) wrote:
> v1->v2:
> Use "help" instead "---help---" in Kconfig.
> 
> 周琰杰 (Zhou Yanjie) (2):
>   dt-bindings: RNG: Add Ingenic RNG bindings.
>   crypto: Ingenic: Add hardware RNG for Ingenic JZ4780 and X1000.
> 
>  .../devicetree/bindings/rng/ingenic,rng.yaml       |  36 +++++
>  drivers/char/hw_random/Kconfig                     |  15 ++
>  drivers/char/hw_random/Makefile                    |   1 +
>  drivers/char/hw_random/ingenic-rng.c               | 154 +++++++++++++++++++++
>  4 files changed, 206 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/ingenic,rng.yaml
>  create mode 100644 drivers/char/hw_random/ingenic-rng.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
