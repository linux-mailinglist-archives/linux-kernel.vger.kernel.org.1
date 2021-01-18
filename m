Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7FD2F9CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbhARKRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389368AbhARJzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:55:50 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F9AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:54:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g10so13210322wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=cFqP/8RJv1Qo9WGknss0Qphbrf47nZAWivkAs8FjOj0=;
        b=f7h0sur3QGmAxGDFgywlU7UvH91myHS7u2TDv/WcQX9e+5GdxTPxbM/nCeABQPBsQv
         DgUhKpfLf9xvXARxdipr0vZ8+NoVofM7hxrXFdNCt0VjzYBciRqunH8xxkF17H1WKqNA
         aVd0wxudIAG/j/vuiypXoMdGSxdUEvqEnWFzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=cFqP/8RJv1Qo9WGknss0Qphbrf47nZAWivkAs8FjOj0=;
        b=H4JHCeQYrMFs7Ve1OD589ymnak2dQnfC1spbPfu8mBej/cULZkkwIY6tHOFqIcFN47
         I9Pj8vqQE8L7hB1oTh33M0eLDsTsgGyUaJ8/sx6rKxh0dnQYjDsh8ar96c4lGcUHjx/3
         +fJ8X/twCG2zcYv6/4tJmDaoIiW5wKpVmGlRGARoO1lOpoOjzq+Wro8gzgLagbj1EQAc
         z4Uxap6oCeHCGMTJhh+BoDmH+hCrDCuIW/B8tFOw3hrrPz6Q9YWbpn6JbNcXh/R5ociG
         8kd5KQOH1TVG6nS1/Z7x3CDq898ugiK+4cA7CTs5VoI6JMMMsfUkmy4ht6XmQIw8i/8a
         8ycw==
X-Gm-Message-State: AOAM5306Z+XElkrrndUtelVOR3PlBmpu1T36JxVo3jIwNEG9+EKHEpTn
        JNpP/tPkS0NBtiEPLvA25kiToQ==
X-Google-Smtp-Source: ABdhPJxHj4DMhuWe1Sq4Q8jMTzzNRKQBOelzaSYvh2hz8Lsj3032M4rxfMUJp49dKZulqO+yY3Pglw==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr2150339wmc.67.1610963690170;
        Mon, 18 Jan 2021 01:54:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 17sm23730019wmk.48.2021.01.18.01.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 01:54:49 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:54:47 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Yue Zou <zouyue3@huawei.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgaarb: Remove unneeded semicolons
Message-ID: <YAVa54YVVH37ZnXf@phenom.ffwll.local>
Mail-Followup-To: Yue Zou <zouyue3@huawei.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210118010356.214491-1-zouyue3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118010356.214491-1-zouyue3@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 01:03:55AM +0000, Yue Zou wrote:
> Remove superfluous semicolons after function definitions.
> 
> Signed-off-by: Yue Zou <zouyue3@huawei.com>

Thanks for your patch, applied.
-Daniel

> ---
>  include/linux/vgaarb.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/vgaarb.h b/include/linux/vgaarb.h
> index 977caf96c8d2..fc6dfeba04a5 100644
> --- a/include/linux/vgaarb.h
> +++ b/include/linux/vgaarb.h
> @@ -121,9 +121,9 @@ extern struct pci_dev *vga_default_device(void);
>  extern void vga_set_default_device(struct pci_dev *pdev);
>  extern int vga_remove_vgacon(struct pci_dev *pdev);
>  #else
> -static inline struct pci_dev *vga_default_device(void) { return NULL; };
> -static inline void vga_set_default_device(struct pci_dev *pdev) { };
> -static inline int vga_remove_vgacon(struct pci_dev *pdev) { return 0; };
> +static inline struct pci_dev *vga_default_device(void) { return NULL; }
> +static inline void vga_set_default_device(struct pci_dev *pdev) { }
> +static inline int vga_remove_vgacon(struct pci_dev *pdev) { return 0; }
>  #endif
>  
>  /*
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
