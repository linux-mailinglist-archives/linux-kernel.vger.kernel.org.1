Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD501EF3DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgFEJRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 05:17:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:35734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgFEJRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:17:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D03DAD33;
        Fri,  5 Jun 2020 09:17:18 +0000 (UTC)
Date:   Fri, 5 Jun 2020 11:17:14 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, mhelsley@vmware.com
Subject: Re: [PATCH 4/4] objtool: orc_gen: Move orc_entry out of instruction
 structure
In-Reply-To: <20200604163938.21660-5-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2006051115020.10354@pobox.suse.cz>
References: <20200604163938.21660-1-jthierry@redhat.com> <20200604163938.21660-5-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

a nit below...

On Thu, 4 Jun 2020, Julien Thierry wrote:

> One orc_entry is associated with each instruction in the object file,
> but having the orc_entry contained by the instruction structure forces
> architectures not implementing the orc subcommands to provide a dummy
> definition of the orc_entry.
> 
> Avoid that by having orc_entries in a separate list, part of the
> objtool_file.

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
> +
> +		if (!insn->sec->text)
> +			continue;

You have the same check added by the previous check a couple of lines 
below.

> +		od = calloc(1, sizeof(*od));
> +		if (!od)
> +			return -1;
> +		od->insn = insn;
> +		list_add_tail(&od->list, &file->orc_data_list);
> +
> +		orc = &od->orc;
>  
>  		if (!insn->sec->text)
>  			continue;

Here.

The rest looks good to me, but I should probably check again with a 
clearer head.

Overall, the patch set is a nice improvement.

Miroslav
