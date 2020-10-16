Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE3290DE7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393101AbgJPWy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391461AbgJPWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:54:28 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BB1C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:54:28 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id b19so2048388pld.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ICYd57CoaTy1qGFozzh5HtqQudKTXEKY66Y/KKwo8Lk=;
        b=VqlJmJeJpWv0jfshqm7uw5p/d/Crrw98Z+oE10biAfMK6x+/MB1Ue4y9OrUuMb1S19
         NVBf0YH72PGjn6trqTsPBQU4VAblvBvPpx/VlhpjqfSCx9LzyiIz4rmKGiHcPvEhRPf3
         aAvMrYjW2k0Ii1ot6r1dmHtwQoFpgg+DRFVY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ICYd57CoaTy1qGFozzh5HtqQudKTXEKY66Y/KKwo8Lk=;
        b=MXKvXhX4JNQiMpI/WHVv12lYEIBOo488HZkWnlFSbUiUTJPIVvmZBSjoYFqlAj+49G
         kYPthugZCr5rhed9DCB76YCUPoLlu4clBswSOKQG+a/3ptFmWdrxrOa2RiyRCB4XEK7D
         qUP0W5XVjCfuCf7KTKs+8jFReZxJfZkl9Rl1FwJ+Wnq93GNuR/U8HGBqYa1iFgKTkyx+
         KA9AvGyeunD45t8aJwswKagJrQrvgKk0qIrtw1V8OHNtNe1ahOCb3laJ/kh4LUtSc01Z
         z0K4rioRHHj87C/s9hh8G0pCj3HVMpakOaDZGUHs7AYxmTOlVj+PvimzKWFHME1LIKHt
         WGAA==
X-Gm-Message-State: AOAM532p08iLLN4zzF+XYe74yxJES8XYQ5xvu4eqr81EXWSLeY7xJkWt
        5ls7dH6fJa8jaTlYuLa0yky6xQ==
X-Google-Smtp-Source: ABdhPJztu1BrcI2AvRp/VvjJLHuh4P7B1CW+afiAMTqbl51L8NnUyyWVOosqEGO8gUPez74J93eSuw==
X-Received: by 2002:a17:90b:4a10:: with SMTP id kk16mr6428298pjb.77.1602888867778;
        Fri, 16 Oct 2020 15:54:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm3788262pga.49.2020.10.16.15.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:54:26 -0700 (PDT)
Date:   Fri, 16 Oct 2020 15:54:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: simplify pstore-blk
Message-ID: <202010161553.F2BA6CF@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:38PM +0200, Christoph Hellwig wrote:
> this series cleans up and massively simplifies the pstore-blk code,
> please take a look.

Cool! Thanks for doing this work. I have a few things I'd like to see
done differently, and while I'm not a huge fan of the general reduction
in utility, I can live with it as long as it doesn't make other things
worse. :) I'll get this reviewed with specific feedback soon, but I'm
about to be EOW. ;)

-- 
Kees Cook
