Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5D22B6F96
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgKQUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgKQUGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:06:50 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B90AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:06:50 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id k27so3807346ejs.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gs7R2ev+GdvZkSQzyJKlOzGhV1YIG/geSIkcbosi9pE=;
        b=SFN5xJOiz2XcXHz3OFDRYlyYwt7CLXtwyLFD9t/jgtx2R4I6SqUtSNFKGyVnXuNP3U
         mqJcSQRqIIPqMLfz8gIHoCGG0tBdBJGnrB58UfgFMLDfjxL/YttrUPW5EPsXEnw/zOBl
         3S3svsw6LdCWPwOj3gf5VEHkJ+Atbmee4/EYugZy1ZBHF3kcuYaazFkTGRyqw5csgJiP
         NFL1SllAnbKorUOgYYcKvrZBKeoq4j2QqNPHn5n2xyIdiLtcpsOQEuATGUlMa85IETnY
         IrQToDk/aJKuP6ZTx5lZqjKKY4iUKkFisE/WkNxFpf82J9gn5Tz43OJqIgEKkJZxDvj1
         5qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gs7R2ev+GdvZkSQzyJKlOzGhV1YIG/geSIkcbosi9pE=;
        b=nWDNXKPUAtkCV9sg3qS0oPZgvVXdeGQM0S9r9C8q/Gk6e7UG++GvE4hKPP1mZT9xkK
         2QAETWoNj4qLi+fXh02fDeq2YWyjsPSYpj68Zq1L6yzt1X/8h3ivaVy9QJiu/Y4g7d0D
         D2U6iKEb+sPkPFy3wOhw+XnJ7SMq1pbBk7CLm0697PHEkIEFkaQnIG+7UMPj672oGsjs
         JUCogkFQTOGoRt6spqjj0n4Yos5bXNlNAfdd7CRnwiDJkR32Nf+3T2U1BINI0yPtBsN4
         BGgq1+ulHF2zSjiCFNfKNxL87ILDcJguNyrXjDMkEMaNctnqtbFq3AjMHuQHvtKM/eDl
         aORw==
X-Gm-Message-State: AOAM5301tuIHja9nT5rddUfMIcpi0QZOytHA1qiObP4CQKe0VS2GjaUL
        ZeNh3skh5gBWBLEIjCKgNZ2oZg==
X-Google-Smtp-Source: ABdhPJyw0TAxMlvDFPbO5r0vaRxG3Do/B02IFkrtB4Ds+fgy9DAGN4O9NkmbIQXxlPyRpdRAKA0hZQ==
X-Received: by 2002:a17:906:ee2:: with SMTP id x2mr10069840eji.326.1605643609131;
        Tue, 17 Nov 2020 12:06:49 -0800 (PST)
Received: from netronome.com ([2001:982:7ed1:403:9eeb:e8ff:fe0d:5b6a])
        by smtp.gmail.com with ESMTPSA id f18sm12345754edt.32.2020.11.17.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 12:06:48 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:06:47 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, oss-drivers@netronome.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] nfp: tls: Fix unreachable code issue
Message-ID: <20201117200646.GA10136@netronome.com>
References: <20201117171347.GA27231@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117171347.GA27231@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:13:47AM -0600, Gustavo A. R. Silva wrote:
> Fix the following unreachable code issue:
> 
>    drivers/net/ethernet/netronome/nfp/crypto/tls.c: In function 'nfp_net_tls_add':
>    include/linux/compiler_attributes.h:208:41: warning: statement will never be executed [-Wswitch-unreachable]
>      208 | # define fallthrough                    __attribute__((__fallthrough__))
>          |                                         ^~~~~~~~~~~~~
>    drivers/net/ethernet/netronome/nfp/crypto/tls.c:299:3: note: in expansion of macro 'fallthrough'
>      299 |   fallthrough;
>          |   ^~~~~~~~~~~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <simon.horman@netronome.com>
