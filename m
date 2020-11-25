Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10022C4086
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgKYMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgKYMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:49:47 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC08C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:49:47 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id f93so1437007qtb.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZwS1O1QRPESovvA5etFTf/pcxDHt/UhBIA5zL8tN+Pg=;
        b=vbK93vvrZhpXDwAcJRtdLaMnCfc/uZ+KT800wAHHYdFjGi6Bt7DFYqn/3nUo5hLCHI
         EIBBEurVt9bYxKbJrOceBP3Tg2X2cLyR77OVChBZl7BnaEE5ityesyXui5gfeT7Ut5GC
         pYAyVrGVEUC5uRswEQnkLcLmw8wv7NGGsY6JxO5r6bl1P4vCCc71P4qICm6EO0u6ch8l
         7YGPb4iY0XyZaMd6q0jMXlgoUh005SpSVttoxhJqiA1Ec/wEKQDxwDdNkadcJSRYGRaI
         z+rZKt/oFuAKUaihQ5Xl4kvAYZ9ehNj1To8D7c4kigdrVfZ05u0HFBC2CO8GXO6/BUSg
         sNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZwS1O1QRPESovvA5etFTf/pcxDHt/UhBIA5zL8tN+Pg=;
        b=p3FJ5fIeSWXfZUPuvBBOg3nlrjxTMOByD+Q2OQo6j/GDYlK1w3MJ60/CxHcyd4UGX3
         FZbGIf9jOK2Ma3uq0Ey+25OLDp1bsvOYg+CGFLf9tHaVBoITsadAW5ScCPBTUeSrCNnh
         2wUFRMe1zgQr3S/NeA9fxin4uAGUGJP8IMvzs4uDFex/tAg+vIcOJkZ7xV1dhPjAcevQ
         mjv6s7Ex9y+mAZqwya/JGzjAgZ4+PS7U80FV/CVihbtw60kEDmoP/EyVhzb4pNdHQQK2
         MTxzH3sVVxZPrgnKv0ZZTXICizP9HKeS/usVvtqk4P6qpbLW17Js08iAY4arLqgAFppM
         Cs6Q==
X-Gm-Message-State: AOAM531ut1PKKu87oj5GV0rdJ1n9J0EH94rC+ArUXARKuyyYKv34kRaf
        ZxP7fBjOP+rx2EW9BL1ggIg=
X-Google-Smtp-Source: ABdhPJxoE+YoHwb2IuVeBB2WxiPq0EqTXK1jaU3bircQxX9xvToZ8JK+7El9iIK01iOR96LGEOQi/w==
X-Received: by 2002:ac8:6a16:: with SMTP id t22mr2863001qtr.304.1606308586313;
        Wed, 25 Nov 2020 04:49:46 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id r127sm2448216qke.64.2020.11.25.04.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:49:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 07:49:23 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Hui Su <sh_def@163.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/kernfs: remove the double check of dentry->inode
Message-ID: <X75S00hif93gcd/q@mtj.duckdns.org>
References: <20201113132143.GA119541@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113132143.GA119541@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 09:21:43PM +0800, Hui Su wrote:
> In both kernfs_node_from_dentry() and in
> kernfs_dentry_node(), we will check the dentry->inode
> is NULL or not, which is superfluous.
> 
> So remove the check in kernfs_node_from_dentry().
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
