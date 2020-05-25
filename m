Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1F1E091B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388840AbgEYIlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 04:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEYIlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:41:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32784C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:41:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b190so8555527pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0mzXarWxBBKV5YiTFm3eZ7M/Fqe7bfckpl5g6k+Pyyg=;
        b=e5U64KOTcb902jIdhoHukS+7m8s4pppfZyqRU+HzA5l4bNpOYfzALa4Ocw3R/jPxh3
         PKweMy1cG2NNCOQiPGIby/hEPhUwoMMxQR24Kgf1Mrowbo6z4YxrNSbvTCL9U6iGUMZp
         U/fJaANlXoAwyLpqUugZbwxlxhbOFgu/JFRff6PZmqtOIFGc1f4HETwjg+C/QbiU1rwO
         inc1ewAdROkKmsIxvbAanyBq1Ydh/a0KyivURz+F2g6ljD301YBhaQQY1IY8HmO+k9wo
         xtJn2t3KNfuX/93HnWTrjWR7CY+9qWdT0QD6ZwzK57yRzXyVzieKlHojPH0+23Dc3oXC
         2tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0mzXarWxBBKV5YiTFm3eZ7M/Fqe7bfckpl5g6k+Pyyg=;
        b=eQHf2GFtxlNWKwvTcJPyzbD2qBNrUTyIqAa4BR+qYcxyy9g9LEYaDMz/GM7PkLKNTh
         xJX5BUA/opbXDSxiH9P7iZLjytG5Hfbq5jzJ9g7vh4eOviKg9zkBiyjkUCGyBkmGIjwj
         O70g/AznGRQRmMelgDQCvA2i3/k75nypPnT33U6SlfwK5UcGQyMaxDksiskM1trOQXzb
         /bJ0hvy9SU41xkKxO6oWIlrni+/xNyk1L7FO1OMz30V9OHrCxhGgdjxYKJAHWuj70/NH
         jDQaBkJ+/cv0XpU2hf5O3Zt86Lxw/kHnvtsg5sw4jFjDTgimULkc6y/21f1G+hmT5xh9
         CKgw==
X-Gm-Message-State: AOAM532j3QsYIKZM7bK9FBFY9/Z4G9YrMVodaY0N0ib7YbA5mQaCTq9S
        Bur//CUVtWjsFo1MxyGkZ5o=
X-Google-Smtp-Source: ABdhPJxHYn7cKVjg2x+cay3kdlWTff3peXSGsguldgNxnOiXdJIB3xzpRFC+29NSpg1baph6syIlNw==
X-Received: by 2002:a62:5209:: with SMTP id g9mr8843467pfb.287.1590396072726;
        Mon, 25 May 2020 01:41:12 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 19sm12256767pjl.52.2020.05.25.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 01:41:12 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 25 May 2020 17:41:10 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] printk: Remove pr_cont_once()
Message-ID: <20200525084110.GE755@jagdpanzerIV.localdomain>
References: <20200524153243.11690-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524153243.11690-1-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/25 00:32), Tetsuo Handa wrote:
> pr_cont_once() does not make sense; at least emitting module name using
> pr_fmt() into middle of a line (after e.g. pr_info_once()) does not make
> sense. Let's remove unused pr_cont_once().
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Joe Perches <joe@perches.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
