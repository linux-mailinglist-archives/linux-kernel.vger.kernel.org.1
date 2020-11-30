Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DD2C7D38
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgK3DQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgK3DQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:16:20 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84157C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 19:15:34 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b6so9515701pfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 19:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WcD2TXtNvBqCQJM+oUDlJOGA3SSu2z0ypxmyhQD/cv0=;
        b=SO4my8/fI4PBGLCHXwpf1XmmECok6zuisqWt6lgKXSSszaXcYMLY0hwTv5rlROkURD
         dZaBxb0nBwbpgaJb79KxP5yZ2KbqAN4EBkabfizS1M5kr4ZoQ/f8sfLl6mIFazWvJmWj
         Bg2RoCg0astOyIup6Z6Detrd4o4waFN2NozSNrNFGVXBvMQhJPARE94n5K0wyeL9YM4k
         t6egXCgAbjwbzBLaoovXfjg9s0KrU/ukvjgNcFkdAMeQ28v8BqIPL8B8jB6zvcs3+v35
         zghL1MTp/iksJ+uFVn7H5RRMARxIlkLky0HiGnexLTPHA81CyNPdgqs0b94CQmTCQ8TC
         HlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WcD2TXtNvBqCQJM+oUDlJOGA3SSu2z0ypxmyhQD/cv0=;
        b=SnzpNhbawLj8TSrwGISwDGBL+TzyVa/o6E/MIHy2DM6mp9uuiQVwqjxLEeZxMAfQ6+
         XgQagfWOHV19dpAbcPpWpBspcqMaieS9l1rl64Nk5Kw+9oYJ//qMdDw2TkdiccEm3X7b
         euzaONZF0hDY06Nuqpj4IR9QT/M51KXcDXGRC8cVKY4hGA391fhZja08CFT6YoO4khjx
         eICZdLVdRAuT9H6hD99ct9MmAT5ctiGzgidJFsNRfyTb8dNAahwXgXz+IZ/uUOAxO3Fz
         3qNDM5lLVz4C6D/AEgF7Tq5qf55QnqsAUIXQpCku9/dvjtJqod/XyqOdlDFQclmi9ToS
         fBxw==
X-Gm-Message-State: AOAM530/IBNLy0DAWqPhMw1jfLiq79T7SrkQfPm5RdNf479pCDyIjBis
        ZAuoKH+lDagaI+lfhWyk5aw=
X-Google-Smtp-Source: ABdhPJyDh4I45ZpZB7TqMZZ2nkrWIPOJ9GUGAG8vX0JRwABeCZ6hBDDxEe6I2ygYo9fx8UX6nmvPcA==
X-Received: by 2002:aa7:969d:0:b029:196:59ad:ab93 with SMTP id f29-20020aa7969d0000b029019659adab93mr16248914pfk.16.1606706133836;
        Sun, 29 Nov 2020 19:15:33 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id h7sm16390346pgi.90.2020.11.29.19.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 19:15:32 -0800 (PST)
Date:   Mon, 30 Nov 2020 12:15:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] posix_acl.h: define missing ACL functions on
 non-posix-acl build
Message-ID: <X8Rj0s/Emv9Qmv3d@jagdpanzerIV.localdomain>
References: <20201130014404.36904-1-sergey.senozhatsky@gmail.com>
 <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b015b83-f183-526a-94e7-029f4c98b30b@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/29 18:00), Randy Dunlap wrote:
> On 11/29/20 5:44 PM, Sergey Senozhatsky wrote:
> > Some functions that are declared when CONFIG_POSIX_ACL is defined
> > are not declared when CONFIG_POSIX_ACL is not defined. Add the
> > missing ones:
> >   set_posix_acl(), posix_acl_update_mode(), get_cached_acl(),
> >   get_cached_acl_rcu(), set_cached_acl(), forget_cached_acl().
> > 
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Hi,
> 
> I can't find CONFIG_POSIX_ACL in the kernel source tree.
> Should it be CONFIG_FS_POSIX_ACL ?

Oh, yes, CONFIG_POSIX_ACL. My bad.

> How did you test this?

You know what - scratch this patch. Sorry for the noise.

Some of the posix_acl.h functions are guarded by ifdef/ifndef
CONFIG_FS_POSIX_ACL, and some are not. This can break the build
if the code in question doesn't use ifdef CONFIG_FS_POSIX_ACL
(which happens with our code). But this patch is not enough,
apparently, we need to add ifdef CONFIG_FS_POSIX_ACL to our
code anyway, because of, for instance, posix_acl_alloc() which
is undefined for !FS_POSIX_ACL builds. Sorry for the noise.

	-ss
