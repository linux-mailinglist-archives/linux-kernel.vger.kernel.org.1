Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAE227EA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgI3NhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgI3NhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:37:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD51C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:37:00 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id u25so1817894otq.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3aFqXFO+NLq8jQNvT6AGie5erexmt0zMVH/IIMbYsOA=;
        b=DoLcBSuGhYboqTS0XokS0HnCQU8dDLYnIHfnIp1ZRUjK2/Fe5JfEQdVien1WTtimLd
         Vn6lsJsA27I/4WlAKxKtNJdpAZNJ2QK9CeMqC4MRvioBRXHXszAx+qMGLygQiis3s37C
         CUdHvH7xbM9KK5MUG5vPoP4RvGXcSMVlbfRSvpDST6IBVxQBfZpwKTro4jqId83RZ2qs
         TEnXdKWt8KhtgbnKv8OxEPN0pxoLX4gNy4Ll/8I4+P1Yd27k1OaY7ZvTBxlLXWIe2nxe
         NWnau4iZCARxisUx83lAg+Ws49W2qDsuCMi/rWjtfCtkj8ywfc6h7ykK1TrKWjiaplyk
         6tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=3aFqXFO+NLq8jQNvT6AGie5erexmt0zMVH/IIMbYsOA=;
        b=I3E/3c08JgWu0AzYZ3EP9kU+/CS6x/K7PTHCqw/Bf6AoOmP3+p81XgEpjvpcqBw10d
         DVdsRBt9LyKpHW/sODgWYRQXtd3nL9bwrvmdImoT+g3Up7vw/79IzNosUSerGd2DKl5W
         vcXWN1/xrVwzb5Xsm0bNJ2UI1BnA9SVG3GSvknEd/TVjcHyPzdbFHbnXJ8aMtavfZJbs
         rxFjBwV2rgh/5ZGAD5cE9XvtQob6/eiRlytgW413YFSCjQw7cX4lJflBGdOseitaKKRh
         MrqJy6yGhSAI02o7xNg0D3/26sFQ588GM+14B4G9k9j5LsCbD5h+dyf6rKjlIZIRy3Az
         JDGg==
X-Gm-Message-State: AOAM532TUrfBglVTCBzpuUXcy2zoO7oafwPMz4EKx/2ZsHyVhfcZsadu
        284VieIBochENItTJxvBKg==
X-Google-Smtp-Source: ABdhPJy/GRW+nCkwKlwfqZFonL63a9aNCtZz6geMrEYcJ6A/c2tmQuQgRc+P+2sON+VjpMT9baj+3A==
X-Received: by 2002:a05:6830:610:: with SMTP id w16mr1478266oti.353.1601473020315;
        Wed, 30 Sep 2020 06:37:00 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id p1sm373593otq.7.2020.09.30.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 06:36:59 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:39:f0c4:8e9f:b46b])
        by serve.minyard.net (Postfix) with ESMTPSA id E8CCC180056;
        Wed, 30 Sep 2020 13:36:57 +0000 (UTC)
Date:   Wed, 30 Sep 2020 08:36:56 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] MAINTAINERS: exclude char maintainers from things they
 do not maintain
Message-ID: <20200930133656.GY3674@minyard.net>
Reply-To: minyard@acm.org
References: <20200930121007.GA1615300@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930121007.GA1615300@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 02:10:07PM +0200, Greg Kroah-Hartman wrote:
> There are a number of subdirectories and files in drivers/char/ that
> have their own maintainers and developers and ways of getting patches to
> Linus.  This includes random.c, IPMI, hardware random drivers, TPM
> drivers, and agp drivers.  Instead of sending those patches to Arnd and
> myself, who can't do anything with them, send them to the proper
> developers instead.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Yes, please do.  No reason for you to get all the noise from these.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6b9445649e5..a6f0a3ec0047 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4101,6 +4101,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>  F:	drivers/char/
>  F:	drivers/misc/
>  F:	include/linux/miscdevice.h
> +X:	drivers/char/agp/
> +X:	drivers/char/hw_random/
> +X:	drivers/char/ipmi/
> +X:	drivers/char/random.c
> +X:	drivers/char/tpm/
>  
>  CHECKPATCH
>  M:	Andy Whitcroft <apw@canonical.com>
