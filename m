Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1754D1A0DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgDGMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 08:53:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aepFZdwloQbse+rSl/5D2c4bJ4JNDDeUhJa+t/r8qFA=; b=uK6rpj/IHqJZzPhVKilSgGk3b3
        cgvFBQf043PVyfJcdz7h+yDis3442KITV+QoShsc1gs4mHWbm8Ot+zPHwreNLvPmPQtnDIJ56n4Ze
        ZGY3ooICNxHSPbrbreMshLmswIDzvRwT7meyvmL44Zut8KCAgSWWArp/nBX+s3xyk6c8yILWgBP+z
        XoUZjUTe/sJ0rHYtrNM/sB3gZ7cfplnrAGRlzxFsK4oXu/iVq7OGfAXbUSaufOYutWgrhejtbdg4+
        viNj+ljul8fKbdl0LBRToqIzQXJqwwgSOvM4sCSoxfdEeVCKurwBNaRiu/fU74wUuMUwZlpA9NbID
        hijjj5sA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLnjJ-0007jV-ER; Tue, 07 Apr 2020 12:53:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC0383010C8;
        Tue,  7 Apr 2020 14:53:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96A252B907A90; Tue,  7 Apr 2020 14:53:23 +0200 (CEST)
Date:   Tue, 7 Apr 2020 14:53:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V2 1/9] objtool: Introduce HINT_RET_OFFSET
Message-ID: <20200407125323.GY20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-2-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407073142.20659-2-alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:31:34AM +0200, Alexandre Chartre wrote:
> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
> index 6d875ca6fce0..7a91497fee7e 100644
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -33,9 +33,12 @@ struct instruction {
>  	unsigned int len;
>  	enum insn_type type;
>  	unsigned long immediate;
> -	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> +	unsigned int alt_group;

^^ that wants to be in a later patch I'm thinking

> +	bool dead_end, ignore, ignore_alts;
> +	bool hint, save, restore;
>  	bool retpoline_safe;
>  	u8 visited;
> +	u8 ret_offset;
>  	struct symbol *call_dest;
>  	struct instruction *jump_dest;
>  	struct instruction *first_jump_src;
> -- 
> 2.18.2
> 
