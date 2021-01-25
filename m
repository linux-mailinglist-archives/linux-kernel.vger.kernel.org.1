Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325BB30311A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbhAYTms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:42:48 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53083 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbhAYTVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:01 -0500
Received: by mail-wm1-f43.google.com with SMTP id m187so429110wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+VM9tYuZi9TFiT89C4HXiMuE6/oY1MSRRS/fHaTXpt4=;
        b=l84nqeCgZj7kVI0VZlc/rjKZDYCQzjkPLQkYPBgMyHcIlmMuUng6oK/EDuF9vVXhAV
         yQ729ao5drf258jvORZfzWb8nBBnjbwKYJ9+f52GwNgJGpOvOE8OlU4sqddMkJEUkLJ1
         2KIa1VcxeFfrC8maQRqPfnPci+5NmraMXjNtQ8Tay/A2AGx9JuYb6oCgGSuRs+Hg/kL1
         rwDHcNmtnY8iq98j8SBn/C1hrG+1kbbl+dpSemWx0Po0nxxPpWnFE9LMPqZ7/szAqmsr
         TSvhcXqQbrMd3xK0EGv168hENXOzbpgExf+3369BFpetvgzSAU4QTfVjXNFJ1w0pEXU0
         zSTQ==
X-Gm-Message-State: AOAM530gRdVIfXkOrkIEMjCPYmvfwDWEJVTyCBCB9T8Y9toqqZvCkCus
        V+bTPk3SRIXnwFIAdLy6Zpk=
X-Google-Smtp-Source: ABdhPJy8EN1TBaLnmzEwu+GRJkeqUP6Xvpa54hML6+2oEu0hhHdQ8uG7nxWJzimxSp/yCy6HAGtREA==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr1483778wme.53.1611602419513;
        Mon, 25 Jan 2021 11:20:19 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id j7sm257561wmb.40.2021.01.25.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:20:18 -0800 (PST)
Date:   Mon, 25 Jan 2021 20:20:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pan Bian <bianpan2016@163.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: ti-aemif: Drop child node when jumping out loop
Message-ID: <20210125192017.l3w7hd5ntnqp4gyr@kozik-lap>
References: <20210121090359.61763-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121090359.61763-1-bianpan2016@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 01:03:59AM -0800, Pan Bian wrote:
> Call of_node_put() to decrement the reference count of the child node
> child_np when jumping out of the loop body of
> for_each_available_child_of_node(), which is a macro that increments and
> decrements the reference count of child node. If the loop is broken, the
> reference of the child node should be dropped manually.
> 
> Fixes: 5a7c81547c1d ("memory: ti-aemif: introduce AEMIF driver")
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/memory/ti-aemif.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Thanks, applied.

Best regards,
Krzysztof

