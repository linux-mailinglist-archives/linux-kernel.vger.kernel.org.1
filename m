Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0027C187
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgI2JpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgI2JpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:45:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464FFC061755;
        Tue, 29 Sep 2020 02:45:01 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id y14so3396837pgf.12;
        Tue, 29 Sep 2020 02:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GjNJiX6u6EA7eCAwaVO4jYqA+BXpH7vsjCBaaqrjlA8=;
        b=rIxjL/9RpTiJTUUFnwxmMMYOivzFHiq515t+RsiYdY6dT+h2GOWFuXkti572v4SAGR
         UmH9cCZG3/qonGEPbAWTzfgRtTLIdzEB+aeL5i3uaGmSrq+IqvmarqckwSBcg3+R2Z6u
         anaZadOfqIswrlR2BCehr3EatM8iB2OMkHB/EtXEEMZhQMQSZmcIzo/1F9pDOf4j1v2L
         qCLxLcw6FNuXoTl7207NrZUIueG93Qc0/UjN8WCgSyXrQWnG8aUH6uNOUM869MI9+imP
         6qgbzeuLw6r6m1+Fv6Oaowj44IG9uFRMkHkPil0Z9KraN5Jfd1zlXmdL9R15EP8Cy3U/
         4rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GjNJiX6u6EA7eCAwaVO4jYqA+BXpH7vsjCBaaqrjlA8=;
        b=cxSwrd3xXC3FUiZWVNPuhLvNuteih/2CHS+i/roOsRi8nOb9MObMjPhwcKRqcusI8x
         YvKh7hrMZiBtUlHpeJefxpYrNYxGK0cnLMwg1YvSl87E0arpJcLqMeN9FG8ZmtN0mlgJ
         1gMC8aJcWH41aHEV8Twz8voF5jHvQ3+xY5EjvqYgbARnzVm4tdBMUNZLLotVsIYqhyIG
         neSLDw5lTkP7Tv3uyF89QBFFwNu1ZOxbqSfU5uiOg+v+t7TIzSgRkTrrwMmktKCslpli
         yhKcsYDlhGPsdW39sXNr/z0FB2ubWj1TyigdD2UZ1Rz//T7po6sywJtjObiyuzCdO8eE
         sF1Q==
X-Gm-Message-State: AOAM532abuhR4tkTigquXa5hm+QiU6WCTwEmDti6yLmY9hSGVp1Pn/je
        rtx4MKzENvEYXKI+S4asBg==
X-Google-Smtp-Source: ABdhPJwdIxwVS1bO6zBzLCzQiN9q63SxQYJU2R5dXf10DiEk1uWsHbyMV9xL37r9CgP/NLOyo+JvYw==
X-Received: by 2002:a63:50e:: with SMTP id 14mr2553275pgf.443.1601372700871;
        Tue, 29 Sep 2020 02:45:00 -0700 (PDT)
Received: from PWN ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id l79sm4674865pfd.210.2020.09.29.02.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 02:45:00 -0700 (PDT)
Date:   Tue, 29 Sep 2020 05:44:52 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200929094452.GA1137889@PWN>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200925153509.GA895804@PWN>
 <20200929090945.GH438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929090945.GH438822@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 11:09:45AM +0200, Daniel Vetter wrote:
> If you want to follow along a bit I think would be good to subscribe to
> the dri-devel mailing list. At least for all the fbcon/fbdev/gpu stuff.
> 
> I don't think there's a dedicated list for vt/console stuff, aside from
> Greg's inbox :-)

Ah, I've been checking lore.kernel.org/dri-devel/ once a while. Sure!
I'll subscribe right now :)

Peilin Ye

