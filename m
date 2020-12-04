Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A82CE7F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgLDGOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:14:34 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440A7C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 22:13:54 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id f14so2479694pju.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 22:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ikYQZkKBQlj1XLSG/m2Nj6ANcmyaZPlsohkob6g2/r4=;
        b=rZE1jJcBEfuG+w14l8I2r44kc5Pg4JFzND0yoE31dNmKJ4ykxnxel2jzxhbO6Hvmk3
         TItDEHjF5tLTrfIhOTdCgZY2DmqUglJd3BuxS2N709P2uBoy+fM87mf0JspDGQBEp2Fk
         tgUxJRqUEmqvisMIZG0vQWVFMn+0HoyCD+7iIJYbltHuOqunVvtId7lHKPUFIPmNkntK
         6c5icC+nMhb/f2TIQcXm997Kxdxza2ZC/Xts7ybnTrjU4gvx9Dh0zCyr8dgh70gK6MiS
         NejFBHJduar/zyNmg2ilV2RSnrbcv2+bJXQk0KGxGsEzG8YhZwz5aqzcNbXzyPP7te2j
         Lutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ikYQZkKBQlj1XLSG/m2Nj6ANcmyaZPlsohkob6g2/r4=;
        b=d4lLILV4LtQdlD4ChujVuHqMkoEOY8dMP4IHawT4OTTOmn5al241CQCLrRZ9RPhwMI
         sxhuSI7D/NHxP0oE6dUPQAzbL6agJIz60rPG0f5I3y7HZz/caC49xjYVHCuYnsO5DSSS
         kS1r2oZzcpVpMvjMD/YKfSJILQTL9qIIZiNke3ryVwRU99Wuau2fnu6ak1GlUynzcW5i
         L2HLqOxlAtSOGB7cWDpjpf7wz4CCLNwAq6rhrtwfO6C9qGkoYRufC7GBSSygADb/+/Dc
         TWWnnlFGlgzSiKgPW5karI5fdjoqDQsMblhe3HVDCUnxqbG9VA7z73BD++ayG9udRvfV
         iZCw==
X-Gm-Message-State: AOAM530nYfGCtTb4r6kT+nFVZl3VISWRb8H7IZLvT52Q9Ba8MUobQFFZ
        b0Iw1ExxDCHURchzdsovhjQ=
X-Google-Smtp-Source: ABdhPJxCjn9XW3a5kRGdYCs6/II0FtD0efgUeCzxQRzr3tV08svi1jkdAulP7KGAqenXASnXJ9QT4g==
X-Received: by 2002:a17:90a:f40e:: with SMTP id ch14mr2691241pjb.172.1607062433800;
        Thu, 03 Dec 2020 22:13:53 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id kb12sm1025642pjb.2.2020.12.03.22.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:13:51 -0800 (PST)
Date:   Fri, 4 Dec 2020 15:13:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/3] printk: inline log_output(),log_store() in
 vprintk_store()
Message-ID: <X8nTmyKZRAbhIxST@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-2-john.ogness@linutronix.de>
 <X8kK5nC/uWJhc4Z0@alley>
 <87v9diyhza.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9diyhza.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/03 17:31), John Ogness wrote:
[..]
> >> +	if (!prb_reserve(&e, prb, &r)) {
> >> +		/* truncate the message if it is too long for empty buffer */
> >> +		truncate_msg(&text_len, &trunc_msg_len);
> >> +
> >> +		prb_rec_init_wr(&r, text_len + trunc_msg_len);
> >> +		if (!prb_reserve(&e, prb, &r))
> >> +			return 0;
> >> +	}
> >> +
> >> +	/* fill message */
> >> +	memcpy(&r.text_buf[0], text, text_len);
> >> +	if (trunc_msg_len)
> >> +		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
> >> +	r.info->text_len = text_len + trunc_msg_len;
> >> +	r.info->facility = facility;
> >> +	r.info->level = level & 7;
> >> +	r.info->flags = lflags & 0x1f;
> >> +	r.info->ts_nsec = ts_nsec;
> >
> > This is the only location where ts_nsec is used. I would remove the
> > variable and call:
> >
> > 	r.info->ts_nsec = local_clock();
> 
> My reason for grabbing the clock at the beginning is so that the
> timestamp is as close to the printk() call as possible. IMHO it is a
> more deterministic timestamp than if it is taken after reservation(s)
> and sprint'ing. I prefer to keep it as it is, but will not object if
> such a change is necessary for mailine acceptance.

Sounds reasonable

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
