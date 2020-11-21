Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D04E2BC207
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgKUUXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 15:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 15:23:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3902CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 12:23:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so14438261wrg.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 12:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cIlxWROZ/jX5ijD+ybZzGsb8o4y9rDeaqVRFhgzbx8g=;
        b=msdPTscNk+AowY88OkPMriDrcY+kF7FKyh51+fIQt2YRMsFqgoC2B0Q7SghAW7fT/C
         jrP/M2DObSziClBGpkgg+e2qhbZn4Ct9QkrE8jhnhay0L/x9DQU9QVUGsxVyDLmdzJWZ
         OdVipyqu8GK95LKmXuZ/Almi6C+07psKaH147C3rD/7P7XsTZHwn4VGeo9N9yzpjS5BG
         413wcAJVO/L2qfAVRM3mYyT2e2sTgH07RHdQ0ljKQxS52EJIuVW7HYXdq+WnZGeO7rvJ
         woqFiepWAxd1AVvJqkLXFie0JU1hkelaSUhv9ouw4YRyNZMZCyTCyLN1TotYM5oYaBsk
         SD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cIlxWROZ/jX5ijD+ybZzGsb8o4y9rDeaqVRFhgzbx8g=;
        b=dfdBraHxGVVGhaf3W83udsCpX6GEIdl7sOyAJfQ9BClTxtnHVxFStL2oAmSVUqTplh
         DJ01YEXl6+cadhp0RXngJwMC3ZhwplN4PEPMY6e9fBUeSUOFNWcnymNlj/PHMPy4wYpu
         HLtNNqJCAjkIdcdclstF3xKvyJQ8M3qcUhVOBT4A0Fxz2igy5A2bskDUly69wh5C3/Bf
         EMMxkDtQh+E84kX5KMcS2pfQavkJpyLip6BT7JGCppwbK1YH9HJlXisVLary53wmkDDs
         IUVESJ6RHuilYagN1TEKQN+6YzhUFXyueoM/eB3oDaTqc9Lut+AiFzFBIhlnsDDA4RM7
         XpZw==
X-Gm-Message-State: AOAM533ilB/G7gP6LfTHry37zVnAlH3/a6OBiDcd69bX5aPooCFAZdkx
        6PcfwBCg9AYG5wAQ/b80Kbg=
X-Google-Smtp-Source: ABdhPJxn3A10sAdX6/QNRSK1Er2Q4pxoUy2ASowkByzqEjGI1dggOmK4yLk/ev/+GGGZE/pVwmEW0w==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr23804900wrp.156.1605990191909;
        Sat, 21 Nov 2020 12:23:11 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id v189sm8821276wmg.14.2020.11.21.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:23:11 -0800 (PST)
Date:   Sat, 21 Nov 2020 21:23:10 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        Jakub Jelinek <jakub@redhat.com>, rdunlap@infradead.org
Subject: Re: [PATCH] ilog2: Improve ilog2 for constant arguments
Message-ID: <20201121202310.lx2iqqebal3fmmmo@ltop.local>
References: <20201120125154.GB3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120125154.GB3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:51:54PM +0100, Peter Zijlstra wrote:
> 
> Other option would be to change the const_ilog2 macro, though as the
> description says it is meant to be used also in C constant expressions,
> and while GCC will fold it to constant with constant argument even in
> those, perhaps it is better to avoid using extensions in that case.

Just for info, the description is outdated and Sparse is just fine with
__builtin_clzll() and friends in constant expressions (since Feb 2017)
 
-- Luc
