Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A14D2945CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 02:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439503AbgJUAOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439457AbgJUAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 20:14:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B921C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:14:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id e7so381210pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xAJaMbwaxxvFezOZ3VpNxWnppUzUipeo4rRvlxsypRw=;
        b=UsKlgwaIWbYSYcrdVUnBnkMc63VqqvshZTzfBhTUyRAxNvWPDu85rOOy3pqstTdUcu
         0JbCdDKq4zxvP1+F93wa6fqSj1DsEdRBnwoY9OaP2ct+2nfhASW4epZ4/HtGcfK2yC+z
         ZpmspPOBVNx0/5J5uPEmWffTJjI1e9Z/9I7e3qEOoP56CMvzUMDWSP6asfPGnGZHFOyl
         EvQ8ucDY6oARb1NHBTbHUKMdoqb26qu+3mdBfzGpOlrTNbRlM/j7A/TITOJtA8Q/yZ6M
         w+Yv8gtzUHwEW20FUOcDSUTUTbRKzpTGjNb4alrIFs+UsW11xRWFSPE0d5ah1oW0Vt1m
         vyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xAJaMbwaxxvFezOZ3VpNxWnppUzUipeo4rRvlxsypRw=;
        b=cPMC0IyhFLK8EQoRcupJXQlOxdud5Z/EkCHeVs8t4fO8JXY2bEkk6iPgOyyB7V6nPh
         21bBRuuZizjFV/VTiG1HC7skPR1C+kFRZP/FxdnE7CLuTJcLOTaF26eAGnva+LJWo/kX
         4udkg7/I30YtreZ3mWB+NmNFC4FV5xBc3AESu+IJktTKU5URx5/OgJZLfC4Gtfmw2UNy
         B8+uUjqyjb+oWT4/o1gzDd2yRxsRPRt3XXibgQYM+eAnZaExUb7FaPHwFIfdcYrDvp1R
         PiKlGmN++cghYKb3XhaojKQiD81fszZDGJ5G61ZjNnVb0MP1abtl+hjxpNX+Tygx5Bve
         qbWg==
X-Gm-Message-State: AOAM530Pbh0FcmwNrde8/F35IZntUZRgqSVgJtYYihxP/zm28Ne2+c78
        9ksJtbu/C8t7BHXOwOjvM44=
X-Google-Smtp-Source: ABdhPJwR+fJ8WWVo8i0Nk/4uIfitNi9b9Rekw7oKedjmZwqNS09tDrLc+hdcNHUSK1ZC5+CAQddNkQ==
X-Received: by 2002:aa7:95a6:0:b029:155:336c:3494 with SMTP id a6-20020aa795a60000b0290155336c3494mr484435pfk.17.1603239291216;
        Tue, 20 Oct 2020 17:14:51 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id ep13sm230537pjb.49.2020.10.20.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 17:14:50 -0700 (PDT)
Date:   Wed, 21 Oct 2020 09:14:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, rajekumar@google.com,
        amosbianchi@google.com, joaodias@google.com,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2] zram: support a page writeback
Message-ID: <20201021001448.GC2412725@google.com>
References: <20201020190506.3758660-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020190506.3758660-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/20 12:05), Minchan Kim wrote:
> There is a demand to writeback specific pages on process to backing store
> instead of all idles pages in the system due to storage wear out concern
> and launching latency of apps which are most of time idle but critical
> for resume latency.
> 
> This patch extends the writeback knob to support a specific page
> writeback.
> 
> Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Hi Minchan,

LGTM

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
