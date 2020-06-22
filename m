Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B54C2041FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 22:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgFVUai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 16:30:38 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:35320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728361AbgFVUah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:30:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1ACF5180431F9;
        Mon, 22 Jun 2020 20:30:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:4250:4321:4605:5007:7875:7903:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13095:13138:13231:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21990:30030:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: coach14_36080fd26e35
X-Filterd-Recvd-Size: 2596
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jun 2020 20:30:34 +0000 (UTC)
Message-ID: <6b0649c53e853fd2a35e9996f13e702daa0d7e2f.camel@perches.com>
Subject: Re: [PATCH] trivial: fix kerneldoc comments
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>, trivial@kernel.org
Cc:     kernel-janitors@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 13:30:33 -0700
In-Reply-To: <1592854669-20606-1-git-send-email-Julia.Lawall@inria.fr>
References: <1592854669-20606-1-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-22 at 21:37 +0200, Julia Lawall wrote:
> Fix the parameter names in the comment to correspond to those in the
> function header.
> 
> Drop comments about return values when there is no return value.

Done by hand or script?

[]
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
[]
> @@ -69,9 +69,7 @@ static cvmx_spi_callbacks_t cvmx_spi_callbacks = {
>  /**
>   * Get current SPI4 initialization callbacks
>   *
> - * @callbacks:	Pointer to the callbacks structure.to fill
> - *
> - * Returns Pointer to cvmx_spi_callbacks_t structure.
> + * @callbacks:	Pointer to the callbacks structure, to fill.

If scripted, odd comma after structure

> diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
[]
> @@ -519,7 +519,7 @@ u32 spum_assoc_resp_len(enum spu_cipher_mode cipher_mode,
>   * spu_aead_ivlen() - Calculate the length of the AEAD IV to be included
>   * in a SPU request after the AAD and before the payload.
>   * @cipher_mode:  cipher mode
> - * @iv_ctr_len:   initialization vector length in bytes
> + * @iv_len:   initialization vector length in bytes
>   *
>   * In Linux ~4.2 and later, the assoc_data sg includes the IV. So no need
>   * to include the IV as a separate field in the SPU request msg.
> @@ -917,7 +917,7 @@ u16 spum_cipher_req_init(u8 *spu_hdr, struct spu_cipher_parms *cipher_parms)
>   * setkey() time in spu_cipher_req_init().
>   * @spu_hdr:         Start of the request message header (MH field)
>   * @spu_req_hdr_len: Length in bytes of the SPU request header
> - * @isInbound:       0 encrypt, 1 decrypt
> + * @is_inbound:       0 encrypt, 1 decrypt

odd alignments

etc...


