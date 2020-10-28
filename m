Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C97329DA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390410AbgJ1XXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732910AbgJ1XXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:23:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4C9C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:23:07 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id p15so1060741ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+6fUclNsrtm5gMXmrEHSQ5gd6ZSjUYsqvc8uCaTtZP0=;
        b=fU9AFtJP9N9ZrEkU32WW+ZW2hKYhgxdDWveN+vqd0EA9koblqxwLbEL1SGmEJRjgbr
         A3OclRlUTb68Dr0/FZWDZP8u8/W9vYBAjQXLNsl4QN5NaDo279ETxSQ72fIkwo7lOw+m
         JBHli4x7ihkigeBqgyY6l2oeWmRE3yXwlWvyIiUkYPmxyLl7LgToDG0Tlleff8ZCQD+/
         giA0UimlRXh8AzOxecDoMDnFTjfPEFu92uteMrHOyGq60Y2UXDMoPQsPTmnNH5GpqF9T
         FgK+aRg6lASTLTqTFixV3a5kHSIZXUfi3hgpLRX+pOxOHyeNzovThMTEz3lBq8QeU0iN
         Dwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+6fUclNsrtm5gMXmrEHSQ5gd6ZSjUYsqvc8uCaTtZP0=;
        b=HowYJfosgOJMJVXDCN5MNqwoRJLXnr5Qud1/n0+x+aAbkd1fiQqyF6TLxE46ungi1a
         ir2AKZ/sZiHy0mWJOVMzL9y2R3kvqLZQyhrQmF3Va76flyFXrpNlT7y1gzZ33j/4gP7f
         HymME1niYEI58rCFgvMS2Ai41ripdU0G0qe97N8d0HspakcT/jGpbPlmWa8XgPVGiyNj
         Y8E2t9W5zfIrQNfIlj//CjJ6Sp6pRkJvtCEF7iJ35MEv9x6oBxp0dakqEbfBexPOk/6G
         ILjd/ebeBoLCksC50svOqdQYa2hjvm7Og6jSvBUFFsFOwJ1ISoS2wpe6rIPCE+04VYyv
         1m7A==
X-Gm-Message-State: AOAM532s3/obIcrh1UoyxHkMSZ9s2PN4JxJFnw+6D4SxHVzEvpRe1HNJ
        jggiNCmE5zn9GYSaNR3Hjiy1+pK4ZRU=
X-Google-Smtp-Source: ABdhPJx7nHQSeOffaFW7QGp1T0qmSUpnn1BwR3U0hx5uKJ38CFWJ/R5YTJQOq4Nu6fLxSIqc/y3Qhg==
X-Received: by 2002:a17:906:1804:: with SMTP id v4mr5876544eje.201.1603860154714;
        Tue, 27 Oct 2020 21:42:34 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:14ec:85cd:eb33:2a5c])
        by smtp.gmail.com with ESMTPSA id v14sm2104156ejh.6.2020.10.27.21.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 21:42:34 -0700 (PDT)
Date:   Wed, 28 Oct 2020 05:42:32 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e, rtl8192u: use correct notation to
 define pointer
Message-ID: <20201028044232.qtzsnrrh7xgdzsoc@ltop.local>
References: <20201026121435.GA782465@LEGION>
 <20201027112303.GA405023@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027112303.GA405023@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 12:23:03PM +0100, Greg KH wrote:
> 
> Are you sure these changes are correct?  This isn't just a list of
> structures after this at the end of the structure?
> 
> Please look at commit 5979afa2c4d1 ("staging: Replace zero-length array
> with flexible-array member") which made most of these flexible arrays.
> 
> This is not a pointer, it really is an array, I think sparse is really
> wrong here, be careful.

Sparse's warning is not about changing the definition of this member
as if it was the argument of a function. It's about how can you use
an array of structure when this structure has a flexible member.
It's a recent warning, added purposely to catch this.
See https://lore.kernel.org/r/CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com

-- Luc
