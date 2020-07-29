Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0604D2322E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgG2QsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 12:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2QsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:48:04 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DF820809;
        Wed, 29 Jul 2020 16:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596041283;
        bh=yHrC5HQOUk5Y7gT6GTdE36nk5tu2EZikXrmHSHeTyeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtQFz4u9SvE8K2F0Zsz4xsll5bLgcjbpJKwx4jPVrlLPbma7WzR4/D/tgMyj42IxD
         ZMkiQX5QSyrG14Oc4J0AyAyUJMqakBiAMXSYmWCKe75tOBbKILVSLcZKBPTqMyhPhx
         lFsFUd3sm9K0Ltiy+e7v+a3l7y6h81y/dmvMTQDU=
Date:   Wed, 29 Jul 2020 18:48:00 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] modules: return licensing information from
 find_symbol
Message-ID: <20200729164759.GA17594@linux-8ccs>
References: <20200729062711.13016-1-hch@lst.de>
 <20200729062711.13016-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200729062711.13016-7-hch@lst.de>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Christoph Hellwig [29/07/20 08:27 +0200]:
>Report the GPLONLY status through a new argument.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> include/linux/module.h |  2 +-
> kernel/module.c        | 16 +++++++++++-----
> 2 files changed, 12 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/module.h b/include/linux/module.h
>index b79219eed83c56..c9bc3412ae4465 100644
>--- a/include/linux/module.h
>+++ b/include/linux/module.h
>@@ -582,7 +582,7 @@ struct module *find_module(const char *name);
> struct symsearch {
> 	const struct kernel_symbol *start, *stop;
> 	const s32 *crcs;
>-	enum {
>+	enum mod_licence {
> 		NOT_GPL_ONLY,
> 		GPL_ONLY,
> 		WILL_BE_GPL_ONLY,
>diff --git a/kernel/module.c b/kernel/module.c
>index 54e853c7212f72..a907bc57d343f9 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -495,6 +495,7 @@ struct find_symbol_arg {
> 	struct module *owner;
> 	const s32 *crc;
> 	const struct kernel_symbol *sym;
>+	enum mod_licence licence;

Just a small nit. Most of module.c uses license rather than licence -
could we unify the spelling to remain consistent? Sigh, American vs.
British English.. :)

