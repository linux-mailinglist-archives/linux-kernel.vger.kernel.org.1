Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93C52DF5DE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgLTPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 10:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgLTPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 10:30:17 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F2C0617B0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 07:29:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so17732155lfr.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p5NOTE254vm73Lsu62t4gF2fTVdlTH1aZ94SNqxQ8GA=;
        b=D8tXd1I+MQFSuLn4t1MdD78KrSSBwywZmReYQRhr2ieSTwOLazBjAYdmCiRljQYzdU
         Da87xyaFugXVyyJPf+iIOZBJ6IzAr6jovF7FLoMwH9wc5ohGgjh6JPUEIShH/WlQDoMF
         odMbbDUxhMK28vXD4QHORAXhhY2MxcIbgg7FQvQzKcFvR20yjWdJlNkI7L8CW+MIv/79
         4qfju58NCyDXBatNXKNQv4CLhXxdFOSs4BQO12sDhihNIMnXvqBJJKWlf55FTbtIb0W4
         Y5piQXCxHKU8yiqyT4mQ0PjHRWIPU4sa50FbKyNHcBmxdu44BPFzplftKkt+Li+Z1VLt
         9gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p5NOTE254vm73Lsu62t4gF2fTVdlTH1aZ94SNqxQ8GA=;
        b=dIPsyU6u/KYhBTdFZIEAOyzMnE2caMxJ5HUEv5JC4Yzx9AKvYfLCAnUr+B9tXRE16m
         1qucR1cMpbJgrQThcyyG5q0BSfDN6eWOt+QMBa3lo/Fl7hjdzIctzky8zssKSpssS4Oi
         HAXqqVfapulWhuzXB7JBoSgoJvPVlBIW5OHbilESF7xcpYFyM+NJYVS8QBjVhH1B5U8I
         JZUUlwSN1YbtPbsP9b9M1saF64PQ2OtJZJ4fRmhdAA0sqJFxSw5oiccYbq6qVk8oV0YX
         6Q6E1H+YThAF4/6RQrSd5gmUy9Qpa1iHMgDxmfG8kdRQJ+uDfC3kqsry9TIn6bfxYW4h
         J/6A==
X-Gm-Message-State: AOAM530OJOtj6W65EBlZsS+oFcBvUkMpTbWbSbZ5UeWhYbslXZOrsDK4
        O72A1VoinMNvMJD6IPLuZwZbdiyL6X6jWA==
X-Google-Smtp-Source: ABdhPJw4tClKnnNkIgEKdhj9k5r+cHGbdWL90UhAmX7lv3ttm+vfAyLPggT33xdYKT2Dw1QzGE0y7w==
X-Received: by 2002:a2e:760c:: with SMTP id r12mr5432858ljc.11.1608478164083;
        Sun, 20 Dec 2020 07:29:24 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id f23sm1677699lfk.298.2020.12.20.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 07:29:23 -0800 (PST)
Date:   Sun, 20 Dec 2020 17:29:21 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Daniel West <daniel.west.dev@gmail.com>
Cc:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        insafonov@gmail.com, gustavoars@kernel.org,
        andrealmeidap1996@gmail.com, yepeilin.cs@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8455/8455] staging: rtl8188eu: core: fixed a comment
 format issue.
Message-ID: <20201220152921.dqlsmqfvygtpzj5b@kari-VirtualBox>
References: <20201219224312.380126-1-daniel.west.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219224312.380126-1-daniel.west.dev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 02:43:12PM -0800, Daniel West wrote:
> Fixed a checkpatch warning:
> 
> WARNING: Block comments use * on subsequent lines
>  #4595: FILE: drivers/staging/rtl8188eu/core/rtw_mlme_ext.c:4595:
> +/****************************************************************************
> +
> 
> The code is full of comments like this. Should the coding style
> be inforced here, even when there is a logic to the way the code
> was broken up?

You should make one patch which atleast fix one file at ones. It would
be even better if it fixes whole stuff (example one driver) right a way.
Also note that you should not but this kind messages to your patch
message. If you want to note this kind of thing you can use --- and
after that it will not included in patch itself. You can read it online
more.

Also where does this [PATCH 8455/8455] even come from? Good thing is
that you really didn't send so many patches or atleast I won't see them.

And it seems that you are new so welcome a board :)

--
Kari Argillander
