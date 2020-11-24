Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC92C343E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 23:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgKXWxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 17:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgKXWxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 17:53:47 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:53:46 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 62so519800pgg.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 14:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ljL3CSoYdqarb5zTCYLNXdzPywfy0T6TGMxzOFscvWg=;
        b=kn29kPKXk0w1xKEGzswS4Qbp/mxMrUyauVm+1Pk3+ZM6N2cfG0m8wHJGVeG2Q3qSm0
         xqmH+2wZOe3kk0UT1JbayqwkC5pLhbvygAZWXike68g0YcPoWZHRkRvFMPfeSDsMBb2G
         xFxnXHknNVhmi1Mb8fm6TXUJaRP0pFX8lN5PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljL3CSoYdqarb5zTCYLNXdzPywfy0T6TGMxzOFscvWg=;
        b=I/85ZPoifonLzCzyTIm7q0hu7dZv7bstXqTDq9eO1yc664nsGQ8CaRGIk2CsRGbyjb
         HtP14HL1AW9lQ3SX/Rq8AVFm26OsqlCr0UAQZiNqEQ0m2TEh9Rhavpl2r4MsB1SV52uA
         vPNTKXOy70Pwc+76JowW5MCkfz9dSrcabLfnJpR8bJUFs2/z64sb8cYjxAYf1F8u61LI
         +pP2EXBuW0ro42yqpA0a3WNhZwSTj5dXigyaF2SUt743fpDBXRTdvqXvOknzGJBEVIKB
         qn3dSO0IdTUe388tjhgmcJC3VQ/RNa7mmYO54NfQ5c9IQMF7S2GyYhaFJl3LPQK1eHJn
         lhDg==
X-Gm-Message-State: AOAM5328IdymgzpDqJBgjVBRYjNZzuHpZ9QSybMn0cibvclEDtGA02V9
        poFyAK5rWTccZseiex1U7O2w/zHNZIzjUgcU
X-Google-Smtp-Source: ABdhPJyC/XDxu1EwO7/8id4vpauYSl9LTEPc/I4hsO9GT/OEDtEPp92l3ey2Mgy7T2gbunujS4AakQ==
X-Received: by 2002:a63:1a02:: with SMTP id a2mr507553pga.359.1606258425853;
        Tue, 24 Nov 2020 14:53:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c28sm85700pfj.108.2020.11.24.14.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 14:53:44 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:53:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: simplify pstore-blk
Message-ID: <202011241452.603BC5B@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <202010161553.F2BA6CF@keescook>
 <20201123145331.GA778@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123145331.GA778@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 03:53:31PM +0100, Christoph Hellwig wrote:
> On Fri, Oct 16, 2020 at 03:54:25PM -0700, Kees Cook wrote:
> > On Fri, Oct 16, 2020 at 03:20:38PM +0200, Christoph Hellwig wrote:
> > > this series cleans up and massively simplifies the pstore-blk code,
> > > please take a look.
> > 
> > Cool! Thanks for doing this work. I have a few things I'd like to see
> > done differently, and while I'm not a huge fan of the general reduction
> > in utility, I can live with it as long as it doesn't make other things
> > worse. :) I'll get this reviewed with specific feedback soon, but I'm
> > about to be EOW. ;)
> 
> Any progress on this in the last five weeks?

Hi! Sorry, no, I keep getting distracted by other stuff. I'll try to
make time for it again next week (I'm soon AFK for Turkey Day).

-- 
Kees Cook
