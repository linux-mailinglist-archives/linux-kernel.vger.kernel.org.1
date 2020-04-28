Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41E1BBD56
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 14:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgD1MSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 08:18:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36639 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD1MSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:18:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id d15so22764075wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTlw31zRjoLT85wRz+voXIuSEjbFXJwzYKMzq0JdG5o=;
        b=m5jPGIeVeSIDzv42thpWDx4IAMg4J8qwgZB6+/ia0/T/7lJgmftQFjRWvr44gg+wPV
         kZSXpnVznul9rMAnmV7q/+dBQd3t/DYIl6E1V1zXj2KDpPggONjB2/FUrTAWDPKta3Vi
         31OLDOkdZQEHBxWM7hfwaFEqKE6YOkSWA1yumKxELneaaupCK+VkkB9vbhLJ/9flnat7
         mNfKNiq3mpp+o8wdL5U+Jmu2aSLSdy5r/ziqGzoRuVBBLcHX0iqQ9o3iiIbBbblviJTE
         bJAJYGnonGs5RPU4NrSitVVTdTmOLEE7/X8cri3IxJlRA2+hLtzDwvNpxOvrhxZDBQVn
         4ogA==
X-Gm-Message-State: AGi0Pub+MRTTCghKZR4KLMTqogdxyxCM/2rCGvk8BYYM11m85Yffk7po
        KoZkiIwUjwPWdYDdYnyS2Zs=
X-Google-Smtp-Source: APiQypKN/xIOpwoxNBlnVyTPp2GIfbIVgJeU2bVIhWDH1sdrfxJyjBWSixoYUzkp9/7OhRSNUS5DLw==
X-Received: by 2002:adf:9d8b:: with SMTP id p11mr32589178wre.322.1588076311193;
        Tue, 28 Apr 2020 05:18:31 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id a205sm3325989wmh.29.2020.04.28.05.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:18:30 -0700 (PDT)
Date:   Tue, 28 Apr 2020 14:18:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200428121828.GP28637@dhcp22.suse.cz>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-04-20 20:33:21, Tetsuo Handa wrote:
> On 2020/04/27 15:21, Sergey Senozhatsky wrote:
> >> KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
> >> important but "printed for immediate notification" is not important.
> >> In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
> >> immediate notification" is important.
> > 
> > per-console loglevel is a user configurable parameter.
> > KERN_NO_CONSOLES is a hard-coded policy.
> 
> But given that whether to use KERN_NO_CONSOLES is configurable via e.g. sysctl,
> KERN_NO_CONSOLES will become a user configurable parameter. What's still wrong?

How do I as a kernel developer know that KERN_NO_CONSOLES should be
used? In other words, how can I assume what a user will consider
important on the console?

-- 
Michal Hocko
SUSE Labs
