Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38042D38EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgLICp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:45:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbgLICp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607481869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4jgdijS0C1lI8z3HE4fifcsU85m3/IComKA3GzeTSg=;
        b=GWM9Y6THmAM71uhwhNXF3ybk3IPdroMJpDM31Qa8mf/dt4eZNUdsrwvWXg9PnzGk1TKknS
        kENc/8wGPUMZ8dfb0L9HM92Mwd7d5FW0XFrFsLUFxBefjr1WJ2q253S2KM6RR4ibE1gLOQ
        JOguRXUAnMiJjWzIrbLnuNzFYkkMU8A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-yrDEzib3PIiwzZTbPbhVPQ-1; Tue, 08 Dec 2020 21:44:28 -0500
X-MC-Unique: yrDEzib3PIiwzZTbPbhVPQ-1
Received: by mail-pg1-f199.google.com with SMTP id n16so154635pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 18:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w4jgdijS0C1lI8z3HE4fifcsU85m3/IComKA3GzeTSg=;
        b=o+Y5pxLXl+V2JqMnFVdrooJD9mNYWx4tb6AOfxNywPk4utOZkTAIq6CJrigsfqV2dW
         ARzQDWGU47vQmojNqVt3rPfAXkDRF4leWrlWr98NALR3Hm5/jbnMfJ1bOGVC5xamZ25w
         g/szRFU8++Yx15mxYF8QyN88P7acqYuTDNYBATBXVCe7Uft6kBI0wEYrxMJCplP+s1+R
         EaWa//PQ/iPRF5WGsHACqVlE1/wBsoycx8r0phDne/BP7Fvc2RZNbP8BAB0gAdaowAo8
         +t5rQTmy7/Cv+1oXFNSSoaq0tCYCkUX7HJzNqea4lzVV9pK60B6y6RerSDJWsHyfTuFo
         7ecA==
X-Gm-Message-State: AOAM532m3UjLDth24n20lCT2y9YIbsPlYGy56Bryjl2zZE1VwgjBuhfm
        tBOeySLIx50z02LRMSI0fztYFg1+hnh5Q4sM9FsBGmIgsF2nssIQGjJzsCery6D7b+1HYkvCELI
        Pf3AkwnQ/vt9kG5hoCqMhEx7y
X-Received: by 2002:aa7:957c:0:b029:19e:3b88:de7e with SMTP id x28-20020aa7957c0000b029019e3b88de7emr360511pfq.31.1607481867023;
        Tue, 08 Dec 2020 18:44:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwMA3nZaD1PHUZhLI+Wkx8wEq55n9kh/F/ycdNZ/qmy5jdTrb7Mdm1OYixeCFytHfe3JRZhCw==
X-Received: by 2002:aa7:957c:0:b029:19e:3b88:de7e with SMTP id x28-20020aa7957c0000b029019e3b88de7emr360494pfq.31.1607481866787;
        Tue, 08 Dec 2020 18:44:26 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y24sm177397pfn.176.2020.12.08.18.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 18:44:26 -0800 (PST)
Date:   Wed, 9 Dec 2020 10:44:15 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Huang Jianan <huangjianan@oppo.com>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, guoweichao@oppo.com,
        zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: avoiding using generic_block_bmap
Message-ID: <20201209024415.GA33948@xiangao.remote.csb>
References: <20201208131108.7607-1-huangjianan@oppo.com>
 <c71fe6a9-06ba-3871-6e0b-104f58df1df7@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c71fe6a9-06ba-3871-6e0b-104f58df1df7@oppo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianan and Chao,

On Wed, Dec 09, 2020 at 10:34:54AM +0800, Huang Jianan wrote:
> 
> 在 2020/12/8 21:11, Huang Jianan 写道:

...

> > -
> >   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> >   {
> >   	struct inode *inode = mapping->host;
> > +	struct erofs_map_blocks map = {
> > +		.m_la = blknr_to_addr(iblock),
> 
> Sorry for my mistake, it should be:
> 
> .m_la = blknr_to_addr(block),
>

Sigh, since my ro_fsstress doesn't cover bmap interface... I mean do we need
to add some testcase for this? (But it needs to be fixed anyway, plus this patch
looks good to me....)

Hi Chao,
could you kindly leave some free slot for this patch and

erofs: force inplace I/O under low memory scenario
https://lore.kernel.org/r/20201208054600.16302-1-hsiangkao@aol.com

Since I'd like to merge these all for 5.11-rc1 (so we could have more time to
test until the next LTS version), since 5.10 is a LTS version, I tend to not
introduce any big modification (so in the past months, "erofs: force inplace
I/O under low memory scenario" never upstreamed at all.)

Thanks,
Gao Xiang


