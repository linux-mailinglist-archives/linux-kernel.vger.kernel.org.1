Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC36426FCC6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIRMnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:43:52 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E6BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:43:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so5207298wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQfmsBiXwX2Es8GDES7bQUFNVTPhBrL2A0QXzeBgz/I=;
        b=UDK3HdbI0cXRlxDUsemZ+pnULj6vEFVLk+iiN2KIdATS7YIWMLOXRnNd4xoGd3idMe
         I3XtsNxgNeh5qUVPfSshLfYMEvuXy5UR1rMR9kiuarIh3ygUwiehnKTt6dgOY1hDT9oV
         i7PavFuiplJdlVUf8kDYJ42VNvqCyEDjGjGZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=IQfmsBiXwX2Es8GDES7bQUFNVTPhBrL2A0QXzeBgz/I=;
        b=HedTQomInyjoGThjJJxbk2iRLbje9dky17Bae/jw6qt2u22OXODgVZHwLlp7DfH6aV
         64YRj8kIJ/ty2cucoDMf71/KcqqHGfMzbJLB2DDqpp/+V8VQ2pyVCLcfHp9chUTx1QWd
         dZq3G5BQgvvDD4aOCjm9Cc5cQspVLhz1jBG5gFMK84u88hoY26MNnBvDkCnvIaJ5mI90
         Jt9oOIdKvFu09N0YK8m+l8N5C7J+WfyUXIi4GFT6GGIL5iR8PMy6Hlgax+2NaSU/2PEy
         35zHcxqmsFm+Bhaj4HDiAh69AjwSZUfPNMGcDSgUQeuBzTaU8fU1PMUvwwZbOd4HPvTF
         3mqw==
X-Gm-Message-State: AOAM530F6qPRd5Q+Mg8bHKbnqSgLDMpAyY1/Jcqu0OenJqZB6/V/z9GT
        Ma7WYaW7O/BQ9xhZNivJ3cRBHzXTV9kWD/uW
X-Google-Smtp-Source: ABdhPJzhzhGMpyvkb890HEdyRSEQK5FynG/CTfFDdSBz/5TJ+zjC3MVLkcodfQHLYw1wf6ov1b18xQ==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr15997863wmh.71.1600433028952;
        Fri, 18 Sep 2020 05:43:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c25sm4808543wml.31.2020.09.18.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:43:48 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:43:46 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, jirislaby@kernel.org,
        ndesaulniers@google.com, natechancellor@gmail.com,
        george.kennedy@oracle.com, peda@axentia.se,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbcon: Remove the superfluous break
Message-ID: <20200918124346.GZ438822@phenom.ffwll.local>
Mail-Followup-To: Jing Xiangfeng <jingxiangfeng@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        b.zolnierkie@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ndesaulniers@google.com,
        natechancellor@gmail.com, george.kennedy@oracle.com,
        peda@axentia.se, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200917131515.147029-1-jingxiangfeng@huawei.com>
 <86015b42-1f87-9f0c-cb34-9d30e8da98a4@embeddedor.com>
 <5F6404B2.3080602@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F6404B2.3080602@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 08:52:02AM +0800, Jing Xiangfeng wrote:
> 
> 
> On 2020/9/18 2:52, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 9/17/20 08:15, Jing Xiangfeng wrote:
> > > Remove the superfuous break, as there is a 'return' before it.
> > > 
> > > Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> > 
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > 
> > Also, the following Fixes tag should be included in the changelog text:
> > 
> > Fixes: bad07ff74c32 ("fbcon: smart blitter usage for scrolling")
> 
> OK, I'll send a v2 with this tag.

Please also collect all the r-b tags you received so I can just apply
everything.
-Daniel

> 
> > 
> > Thanks
> > --
> > Gustavo
> > 
> > > ---
> > >   drivers/video/fbdev/core/fbcon.c | 2 --
> > >   1 file changed, 2 deletions(-)
> > > 
> > > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > > index 0b49b0f44edf..623359aadd1e 100644
> > > --- a/drivers/video/fbdev/core/fbcon.c
> > > +++ b/drivers/video/fbdev/core/fbcon.c
> > > @@ -1727,7 +1727,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> > >   				    vc->vc_video_erase_char,
> > >   				    vc->vc_size_row * count);
> > >   			return true;
> > > -			break;
> > > 
> > >   		case SCROLL_WRAP_MOVE:
> > >   			if (b - t - count > 3 * vc->vc_rows >> 2) {
> > > @@ -1818,7 +1817,6 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
> > >   				    vc->vc_video_erase_char,
> > >   				    vc->vc_size_row * count);
> > >   			return true;
> > > -			break;
> > > 
> > >   		case SCROLL_WRAP_MOVE:
> > >   			if (b - t - count > 3 * vc->vc_rows >> 2) {
> > > 
> > .
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
