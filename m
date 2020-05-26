Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204991BC7F7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgD1S2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 14:28:14 -0400
Received: from ms.lwn.net ([45.79.88.28]:41316 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgD1S2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:28:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4732044A;
        Tue, 28 Apr 2020 18:28:02 +0000 (UTC)
Date:   Tue, 28 Apr 2020 12:28:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Chao Yu <chao@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Perret <qperret@qperret.net>,
        Jayachandran C <c.jayachandran@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mailmap: Add entry for Leonardo Bras
Message-ID: <20200428122801.7a7ee743@lwn.net>
In-Reply-To: <20200428024439.215806-1-leobras.c@gmail.com>
References: <20200428024439.215806-1-leobras.c@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 23:44:40 -0300
Leonardo Bras <leobras.c@gmail.com> wrote:

> Add an entry to connect my email addresses.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index db3754a41018..4600dcfed0d3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -152,6 +152,7 @@ Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
>  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>  Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
>  Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
> +Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
>  Leonid I Ananiev <leonid.i.ananiev@intel.com>

Applied, thanks.

jon
