Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E41B39F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 10:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgDVIYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVIYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:24:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD184C03C1A6;
        Wed, 22 Apr 2020 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6eF1L5yo0KiLrIH7uBDYUbucZy9aXiDJ2Jm6kAlHojs=; b=NgeR6qbVcrImXGvZHtTc3U0wes
        1o3iMhNk54urcCjOPbOxdhDMmcFF7NMFE3YVZxt2fX6U84VVeYz5JMT2JbsDDQhSS9wMtBYIEfAm7
        V928Ax1tax7PVmJXtxZB0llZBU8/A+580Plbz9u+WDfIyzEo1p+cKMeOcWg+cvjZLuL+ykqD25fZl
        auNPnO/wQuVk1ESEl/MQvKKhMUtC06X8TIEwC39l6F7mp4m01jYdPLI1XrGhNq0rq42lPyDuEgZya
        1zdlhAgEt+PsMVin+bdTDKK7xETV6FIwa0alQuIOlbtVi+SHOXgXpOmPi1bJcg4Ss52D7KuXtBgHR
        DIlI4Qng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRAfo-00089f-4G; Wed, 22 Apr 2020 08:24:00 +0000
Date:   Wed, 22 Apr 2020 01:24:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Message-ID: <20200422082400.GA30239@infradead.org>
References: <20200421125722.58959-1-efremov@linux.com>
 <20200421125722.58959-4-efremov@linux.com>
 <20200422070921.GA19116@infradead.org>
 <20200422071756.GA16814@1wt.eu>
 <c2cc742d-23f9-ce03-c326-7df648161427@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2cc742d-23f9-ce03-c326-7df648161427@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 11:20:23AM +0300, Denis Efremov wrote:
> What do you think about changing it this way?
> 
> struct floppy_raw_cmd {
>  
>         unsigned char rate;
>  
> -#define FD_RAW_CMD_SIZE 16
> +#define FD_RAW_CMD_SIZE 33
>  #define FD_RAW_REPLY_SIZE 16
>  
>         unsigned char cmd_count;
> -       unsigned char cmd[FD_RAW_CMD_SIZE];
> -       unsigned char reply_count;
> -       unsigned char reply[FD_RAW_REPLY_SIZE];
> +       union {
> +               struct {
> +                       unsigned char reserved[16];
> +                       unsigned char reply_count;
> +                       unsigned char reply[FD_RAW_REPLY_SIZE];
> +               };
> +               unsigned char cmd[FD_RAW_CMD_SIZE];
> +       };

I don't think we can just change FD_RAW_CMD_SIZE or cmd as that could
break userspace. But otherwise, yes something very much like that:

>  #define FD_RAW_CMD_SIZE 16
>  #define FD_RAW_REPLY_SIZE 16
> +#define FD_RAW_FULL_CMD_SIZE (FD_RAW_CMD_SIZE + 1 + FD_RAW_CMD_SIZE)
>  
>         unsigned char cmd_count;
> -       unsigned char cmd[FD_RAW_CMD_SIZE];
> -       unsigned char reply_count;
> -       unsigned char reply[FD_RAW_REPLY_SIZE];
> +       union {
> +               struct {
> +                       unsigned char cmd[FD_RAW_CMD_SIZE];
> +                       unsigned char reply_count;
> +                       unsigned char reply[FD_RAW_REPLY_SIZE];
> +               };
> +               unsigned char full_cmd[FD_RAW_FULL_CMD_SIZE];
> +       };

>         int track;
> 
> Denis
---end quoted text---
