Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF6F1CDF50
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 17:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgEKPpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 11:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgEKPpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:45:04 -0400
Received: from linux-8ccs.fritz.box (p57A239F2.dip0.t-ipconnect.de [87.162.57.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44B93206A3;
        Mon, 11 May 2020 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589211904;
        bh=Dn5xsd49kG0h2c2CrnzZeVPVNAk3al24vvTB0Sc2m0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4TBHeUOcbjQPuLM1SPMnGs/lByNxC7FONLY6cQMwCuoMn2VLo1q3W/mNi1Ey7Xsn
         xX/vlLJhGaVyh4NjREfDaUziNvuxEaoxjb4DRt+mdWLaka8u8YwbAXkvXBZNwreFUU
         AJEwdcc5i7A6prvHmgLpK0a0UmJgke8Ta04bdjFE=
Date:   Mon, 11 May 2020 17:45:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 1/2] module: allow arch overrides for .init section
 names
Message-ID: <20200511154459.GA26699@linux-8ccs.fritz.box>
References: <20200511114803.4475-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200511114803.4475-1-vincent.whitchurch@axis.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Vincent Whitchurch [11/05/20 13:48 +0200]:
>ARM stores unwind information for .init.text in sections named
>.ARM.extab.init.text and .ARM.exidx.init.text.  Since those aren't
>currently recognized as init sections, they're allocated along with the
>core section, and relocation fails if the core and the init section are
>allocated from different regions and can't reach other.
>
>  final section addresses:
>        ...
>        0x7f800000 .init.text
>        ..
>        0xcbb54078 .ARM.exidx.init.text
>        ..
>
> section 16 reloc 0 sym '': relocation 42 out of range (0xcbb54078 ->
> 0x7f800000)
>
>Allow architectures to override the section name so that ARM can fix
>this.
>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>---
>v2: Add comment and move module_init_section() next to module_exit_section().

Thanks, this patch looks fine to me. You could add my:

   Acked-by: Jessica Yu <jeyu@kernel.org>

Alternatively, I can take this through modules-next if the second
patch gets a review and ack from an ARM maintainer.
