Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22FA232FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgG3KDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgG3KDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 06:03:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D91C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BgjZFLVZ+P18ybLwjgbK/HQlkTCOq0tI5B4QJDlfbao=; b=QA7XOjB+9uGf/ab1zj9pLVYUOO
        m7QDuUN/jNsny1ngsxEWggQHwO+SI+zclGHU2eEG2jrxsnhIZ/ReEm4mmJxA9d/s+CzMuUBQpi1ry
        /ecbZfN4MtIrBcalkGXqcOm+RGuUM4XelfmHeWijKlwAfeDV+Vndkg80OIEleq6szc6PaBSaPrSkK
        cmV3ZCLAxpfgtStHlOpWH4b7sqi2JOcoDUCVryO8n9+W7ydaLay/dai6McwmEmPzby1lDzxT5BD6m
        MBlCvla+UsexkrAMQ8o46cIwMDAdc/1DMFYWdjqSsV4gE/fFJ0PgcIPtULNVhbwxexaPXTDyKer8U
        FKmZl5vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k15Oz-0003t6-HV; Thu, 30 Jul 2020 10:03:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 941E53056DE;
        Thu, 30 Jul 2020 12:03:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D1E6210ECD0D; Thu, 30 Jul 2020 12:03:04 +0200 (CEST)
Date:   Thu, 30 Jul 2020 12:03:04 +0200
From:   peterz@infradead.org
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mhelsley@vmware.com, mbenes@suse.cz
Subject: Re: [PATCH v3 4/4] objtool: orc_gen: Move orc_entry out of
 instruction structure
Message-ID: <20200730100304.GI2655@hirez.programming.kicks-ass.net>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-5-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730094143.27494-5-jthierry@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:41:43AM +0100, Julien Thierry wrote:
> One orc_entry is associated with each instruction in the object file,
> but having the orc_entry contained by the instruction structure forces
> architectures not implementing the orc subcommands to provide a dummy
> definition of the orc_entry.
> 
> Avoid that by having orc_entries in a separate list, part of the
> objtool_file.
> 

> diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
> index 66fd56c33303..00f1efd05653 100644
> --- a/tools/objtool/orc_gen.c
> +++ b/tools/objtool/orc_gen.c
> @@ -9,18 +9,33 @@
>  #include "check.h"
>  #include "warn.h"
>  
> +struct orc_data {
> +	struct list_head list;
> +	struct instruction *insn;
> +	struct orc_entry orc;
> +};
> +
>  int create_orc(struct objtool_file *file)
>  {
>  	struct instruction *insn;
>  
>  	for_each_insn(file, insn) {
> -		struct orc_entry *orc = &insn->orc;
>  		struct cfi_reg *cfa = &insn->cfi.cfa;
>  		struct cfi_reg *bp = &insn->cfi.regs[CFI_BP];
> +		struct orc_entry *orc;
> +		struct orc_data *od;
>  
>  		if (!insn->sec->text)
>  			continue;
>  
> +		od = calloc(1, sizeof(*od));
> +		if (!od)
> +			return -1;
> +		od->insn = insn;
> +		list_add_tail(&od->list, &file->orc_data_list);
> +
> +		orc = &od->orc;
> +
>  		orc->end = insn->cfi.end;
>  
>  		if (cfa->base == CFI_UNDEFINED) {

This will dramatically increase the amount of allocation calls, what, if
anything, does this do for the performance of objtool?
