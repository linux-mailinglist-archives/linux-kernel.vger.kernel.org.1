Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BA72C7178
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbgK1Vvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbgK1S4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:56:42 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB12AC08E864
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 22:33:17 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id t8so6316501pfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DUSXiXpwL9MYF0t7RCjJUFWrXmRSwKXVWWmDaBGz+RY=;
        b=l0m95lfOh2p2gTNq86P9XdpQe4EgjiSgD+fMOwTWGe2MQSvXM1FxkNdJBDB23ey3h4
         OjFd97Lnkuc7vKHajeA7Ynn/vLmCIHK6NqOhdUK6jWalkAc41MjLuoIArnqLyoP1Us+W
         XpbfeNb1npDJix6WRqkgikX/xusLuWpbcezpWQYFqO5mS0/al9lR4x0T0X2RJbXG8xzr
         C/e7vqsvVNNWYPBaMiSXkR2XTcKEqIzqtvlaLdBpdQwA00FUMpKQlsh+pRCgxEtC7aIH
         ImrWerzMYm7z9XlZQmMxj54d1dOXN8E/aiPbF6zJb/ryL4D4D3NQux42IJ3uZWgNzkBd
         gMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DUSXiXpwL9MYF0t7RCjJUFWrXmRSwKXVWWmDaBGz+RY=;
        b=gmshn/fw2vCTF9pRtUugk6KkXzQkMY31AdqPjv6qz697epHLhihFJIT+N2cdKJuHHh
         OOaZ7NXVPpZYMWB6cx2AiKlqwmg/P7t+z9TsLPqAnnwfa0FLrB+IUrXHP9AMdoZyoZZu
         /00ACFgTsBI0apzG0h2kjkLbQktlRAjFaBLSUT8YHu0gH24joB5YeT8rxbGA5dOTJ1Tw
         B1A8VN7zEZGEFsZgYYG/uiLl9ijnhSx0U9nDt0gsHXIJ/usxgzGW1rabfplELbsSRtrc
         MnyjflZBOauEM5She6YHvPBD/3tIDFBZ4tqVKJZubYuh1HbU3op6b+o8a04rspF/rIBH
         3BaQ==
X-Gm-Message-State: AOAM530zQwXMzbjv6J6jRg/tYHB6dmD3SmTNWvTb4TSvile/Gpd7I0db
        Zr7sLzQgj1eAPr+Ywtk3tqk=
X-Google-Smtp-Source: ABdhPJxM/SXPGPZ5djj5fAwxjN+Jh9s7zxv9s3a25Ft18C879ZH9k1/q1oN6VZt3zBjJhQEIz/9luw==
X-Received: by 2002:a17:90b:1888:: with SMTP id mn8mr15055780pjb.158.1606545197284;
        Fri, 27 Nov 2020 22:33:17 -0800 (PST)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id k21sm8730687pfu.7.2020.11.27.22.33.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 22:33:16 -0800 (PST)
Date:   Sat, 28 Nov 2020 14:33:13 +0800
From:   sunjunyong <sunjy516@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ttyprintk: optimize tpk_close flush code
Message-ID: <20201128063313.GA31258@mi-OptiPlex-7050>
References: <1605579667-16573-1-git-send-email-sunjunyong@xiaomi.com>
 <X7N2A+i22d6sC0lH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X7N2A+i22d6sC0lH@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg:

Sorry for the late reply.
> Why did you not make the change to tpk_printk() as well that I asked you
> to?
> 
> It is a static function, you control the callers, so the extra "is this
> NULL, if so flush" logic makes no sense to keep around anymore, right?
tpk_printk have logic to judge whether the input parameter is NULL.But for
below removed line, we already have known the input parameter is null, so
we don't need call logic of judge NULL, just call tpk_flush to flush is enough.
This is just a little optimization.
----------------------------
-	tpk_printk(NULL, 0);
----------------------------

Brs.
Junyong
