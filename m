Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB62CA286
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgLAMSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgLAMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:18:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7090C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 04:17:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so2414465wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 04:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g0cu2xo3t8omk7h4Os6v19y0TCwy8mGGWLP5k1GCMgQ=;
        b=KcwrvHs5/3AUPjLyRvtTzh5o6y3YII7uhGJzAOCAprPrbdySnDD+0Wvsq6g9I2XlbS
         K080wgYe7nMSOCN+o1rDVdXFMu9JoNg5HJ4o/KZW2X/8EqORS2Dz6GyhSQd5r3LhOeE3
         qLcPqbOzXXfQoKVQN7bDM7Jev2WOOCB5jgTEot0W9e3nv/5Yq5Gu/bZw92L9DdqmTKcy
         GPyE1KaiTfsnr2wjJHqIfXOG/LgiOYJK7bUr0bTLRCyGnEbrxQzgqWUfcKCiH9kQA9zi
         IFIr4573HxBCt4Y8/sMExGzo2cZ67Ui1KW9cjwXPVdTgG1RQGLm8o4IgOPHsRvgrLlfZ
         QusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g0cu2xo3t8omk7h4Os6v19y0TCwy8mGGWLP5k1GCMgQ=;
        b=DZX3KQO//5uPPQMk7zRufhPSJKg6MejMKk0XGA3PP1J1FhBAiGcvAVclRdYeL/Xc/Y
         JtXlWhMG9aj7BX6b319n3uHrOmbZFY1eChrXi0HKcuZwKvfW5ivZaraxydzGj911pxki
         UAGsa1rj/jKO63Oyi1k1b/dqO5b5vxXBYIjAEYD7asEdiFOF4gu9YA3ln4QffRyapVBQ
         5SmmUtT2yn3CYef8SYjRRepzKrrYeRZZy/XgpMo8kp9ZYmgK9QPCfUrA3tkjZfZ6AsFf
         iymEQuSL7GyhAl2aQM44SEP+AW2ULOoAKqWIjFD0eVgcGLZNPWoAg0vWKOoF37yKYQte
         t67w==
X-Gm-Message-State: AOAM532xHQonFScklRD7W7ixQXdV44UQqXr2+FWNMDjDdrO1nZrgCMYG
        d8sfQ0NnILfYOR5ST8rxnq2zNQ==
X-Google-Smtp-Source: ABdhPJy9EIekG3TlvoW2O3Hz23f+5RM5bW0HXYn6PqrVA8kKOHAzWARThJOoKGZMiaC9bjJDaHHatQ==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr2474685wmg.189.1606825051432;
        Tue, 01 Dec 2020 04:17:31 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id d8sm3020167wrp.44.2020.12.01.04.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:17:30 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:17:26 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 05/13] bpf: Rename BPF_XADD and prepare to
 encode other atomics in .imm
Message-ID: <20201201121726.GC2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-6-jackmanb@google.com>
 <bdc90ccd-e017-b7b1-7ba8-f5e261ad7296@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc90ccd-e017-b7b1-7ba8-f5e261ad7296@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 07:43:46PM -0800, Yonghong Song wrote:
> 
> 
> On 11/27/20 9:57 AM, Brendan Jackman wrote:
> > diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
> [...]
> > diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> > index 0a721f6e8676..1c9efc74edfc 100644
> > --- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> > +++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
> > @@ -3109,13 +3109,19 @@ mem_xadd(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta, bool is64)
> >   	return 0;
> >   }
> > -static int mem_xadd4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> > +static int mem_atomic4(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> >   {
> > +	if (meta->insn.off != BPF_ADD)
> > +		return -EOPNOTSUPP;
> 
> You probably missed this change. it should be meta->insn.imm != BPF_ADD.
> 
> > +
> >   	return mem_xadd(nfp_prog, meta, false);
> >   }
> > -static int mem_xadd8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> > +static int mem_atomic8(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
> >   {
> > +	if (meta->insn.off != BPF_ADD)
> 
> same as above.

Dang. Many thanks for the careful review!
