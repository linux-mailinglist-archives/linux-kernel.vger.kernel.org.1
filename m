Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C8C2F5796
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbhANCCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbhAMXWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:22:33 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE4DC0617BE;
        Wed, 13 Jan 2021 15:21:28 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B6685612C;
        Wed, 13 Jan 2021 23:21:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B6685612C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610580088; bh=HtK7neyREhRZnKo1DhkVntwSDPRKPQbMPmFOCpss7rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=obh38bPaqzYcTE+AkjRqELraIkpT6q8jJP8Ed0Rzmn2DICtaA5SScy+nTH/9RvK5c
         /KVQNcyT51sn3d5GWhSWq7joqCMWdcpQoGpe5ucwEo517GYIU2H7DdIahUZRNRGDDo
         mwMjp3DzRPMpP1MWppbm2PYx2+rZrGiDUpdeS0Ue8q6nmnWc6vjeIUw/7hyZ7k+RYb
         CR3gijmMBdf2fT68IEEsRvH2WWHSSIPXy10qx0wbKHfdxqm/nP4xrvftHMUo7ZICpB
         Wx8byEXRenXDz2p1YQGjtefrICL39vcRtYBlslI6Ot8Z/3M3vY5+DGjh5d0GcVe1iE
         JK2CajB9pXkaQ==
Date:   Wed, 13 Jan 2021 16:21:26 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for doc-next] doc/zh_CN: adjust table markup in
 mips/ingenic-tcu.rst
Message-ID: <20210113162126.62e36bd3@lwn.net>
In-Reply-To: <20210113070023.25064-1-lukas.bulwahn@gmail.com>
References: <20210113070023.25064-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 08:00:23 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 419b1d4ed1cb ("doc/zh_CN: add mips ingenic-tcu.rst translation")
> introduces a warning with make htmldocs:
> 
>   ./Documentation/translations/zh_CN/mips/ingenic-tcu.rst:
>     61: WARNING: Malformed table. Text in column margin in table line 6.
> 
> Adjust the table markup to address this warning.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210113
> 
> Yanteng, please ack.
> 
> Jonathan, please pick this doc warning fixup on your -next tree. 

Not waiting for the ack, I've applied this (with an added Fixes tag),
thanks.

jon
