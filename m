Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C22A5D26
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgKDDif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgKDDif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:38:35 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46182C061A4D
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 19:38:35 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i26so15372259pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 19:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YLtmPSq/gZaYtW23BxWonT+DULm5kLo0W0DpjwAsfhI=;
        b=iqaci2K8GKT+RZlJ/Pksv05GhtiAxp8bHyQoZszQtMUaCO6BH5cms2EbKD2OysZGb9
         V73C5TWcNBY1I4NUN8CKsTFm49C6l9C/zcuuNuQVwv06uQPZYfWyJQ0AKlBG2t1FKPeo
         GGdDSipkg1PZeIQu63PLZoBYHCXWP6aJsTiAG2TKb8w0L2horqjE6difU4OgtbIHqScY
         bkhO3LcVt8rg2luyvsD1UsgoD7I0KuSXptcFqLofFePYKi7vrQOvRQZFypmyjyU75WDE
         WczEt+atAEXlwp9lC7eSIgP+WfXGzZjDGNZUU7gf9u7tyyybSUmCCm1VKwMBYD0KsOU3
         pkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLtmPSq/gZaYtW23BxWonT+DULm5kLo0W0DpjwAsfhI=;
        b=BcB0T0qoegi3IKbGRR1QXgs5HAdTS6F8Qxo37B2sh+g39770w+uDUxpDZzOmY5ar2r
         xrZaBsIokoqh+hJifupb44eSsgvoyslMTpicvtRcvqoqbNbv2v4gIiU/22Iijagy5JEh
         nku6ZXA0S9u6zyhKe+C3P3bAcQxKcspokyPmLyA8prlS03sj8q8MySd8Z1c+dzFnA07L
         O93xTGOaY4j7x+KQLvW4zTcTPSPJFcIp4maUcPECMyPNAooaJMY1XrqUUClrBJ+heWny
         m2MDscKgLgw2uNLznmpNMhPI1opjBGx9eo7Gq7aT7k3ZELf5r6+taFGd5guLDKatuQa8
         15SQ==
X-Gm-Message-State: AOAM53045g7uJt0w+FWHI8aC0Ad3nXDI5MG1eUfufyoxh2MFXGR2s14n
        rDw8ttr81YEzdmxuW7R8NSM=
X-Google-Smtp-Source: ABdhPJyj/PWwv3HfM+i3uhqsjzily+vtLgiW5mjiAvEgecpDxNnv+S2fvt+3xdYfwDphYqjBF0kg1w==
X-Received: by 2002:a63:6547:: with SMTP id z68mr19838680pgb.411.1604461114808;
        Tue, 03 Nov 2020 19:38:34 -0800 (PST)
Received: from [10.230.28.234] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z10sm518189pjz.49.2020.11.03.19.38.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 19:38:34 -0800 (PST)
Subject: Re: [PATCH 13/23] mtd: nand: raw: brcmnand: brcmnand: Demote
 non-conformant kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20201102115406.1074327-1-lee.jones@linaro.org>
 <20201102115406.1074327-14-lee.jones@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e9e6773f-ceab-1732-cd21-ca4230c16bd2@gmail.com>
Date:   Tue, 3 Nov 2020 19:38:32 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102115406.1074327-14-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2020 3:53 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'host' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'addr' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'buf' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'len' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'cmd' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'host' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'desc' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'addr' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'buf' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'len' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'dma_cmd' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'begin' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'end' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'next_desc' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'host' not described in 'brcmnand_dma_run'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'desc' not described in 'brcmnand_dma_run'
> 
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
