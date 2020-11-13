Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8E2B1E72
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKMPTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55403 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgKMPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605280781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHJT/KxC9UflTtlT4GoLBO8EiIooNA+DFVx6WDlT85M=;
        b=OqUbPRRV5E7pldy6l+yIBltZZvaNG/Su0dblnuAPeN1JS2LVlsCEovsrOP0gckV5UUfSgi
        dpjT55kp31mjpJ5FdR2/O3EvxXORVI5ENBSs/cN+rggd9Z9K0vijs1bUXhFF7h1BQdwt1f
        oAGSYrlv/AxgOYVh71ar6lidv3qgINs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-n-SNhnt4O2eTJ01dqWezoA-1; Fri, 13 Nov 2020 10:19:40 -0500
X-MC-Unique: n-SNhnt4O2eTJ01dqWezoA-1
Received: by mail-wm1-f70.google.com with SMTP id 8so3396366wmg.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UHJT/KxC9UflTtlT4GoLBO8EiIooNA+DFVx6WDlT85M=;
        b=nN0p3e8bhDNkyrNpuMKb7aEG220E1JrC68HW53luUazhhAuVII6ih0KsQ+m5h/e637
         QsWEM8BdkFNDfrZ7Z0h1KtbwC7bWv8LpYC7fq/fIxBYNQhU+AghvgbmglHaa1fHorRpA
         VeHStKtrF8mXDTAcmeGoQYLOT0O8VrtmSwCt2Yjs8i0xxFYLB8eJDyVS/wDt5+jIlp3m
         eBc6/kUbWDHYFHneZbqf6hcfiGMSWd2P94rDYAGwXZAUK6MX3YELwjgTqO6owxKHfqxt
         KIVEvWdqhVDZ5xrdeNLUjuuUYNFXkPjqzZjYPX9pDg8prOM4UDOZFJVhQgOeHD9I1RCL
         91zg==
X-Gm-Message-State: AOAM532Eo9SjdVzBVW8TTq+/Nw2asqSPdHgJYaZ/3XmjlPAGR+tjmppn
        H9CWI8m44doSQvgKOC8IWQ/80So0AzmwKBhlYg2jC4mQv0AH7uYONA2o7f+rqKC62/pGIpab2kJ
        uOx+HinzuzFCb45smfUkdCMZ/
X-Received: by 2002:a05:6000:10cd:: with SMTP id b13mr4356995wrx.220.1605280778140;
        Fri, 13 Nov 2020 07:19:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXdCmDHXPDiP0L9s48SYyelkFHjC4qhS23m8YbtZtIoferpKQFhzSqZ/wju2D9Ci7tPJN06A==
X-Received: by 2002:a05:6000:10cd:: with SMTP id b13mr4356499wrx.220.1605280773040;
        Fri, 13 Nov 2020 07:19:33 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id s188sm10690094wmf.45.2020.11.13.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:19:32 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:19:29 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ERROR: modpost: "mac_pton" undefined!
Message-ID: <20201113101817-mutt-send-email-mst@kernel.org>
References: <202011131937.7Fy1Jnv1-lkp@intel.com>
 <71f5ec23-a1a7-8981-b924-412f4bbed9f6@redhat.com>
 <CAHp75Ve14rt_xDS40-bE2PGzo9JGKzqU0nPz_kbwngkn-upGVw@mail.gmail.com>
 <87d01fe1-1746-d31b-80aa-6adf286884c8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d01fe1-1746-d31b-80aa-6adf286884c8@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 02:19:31PM +0100, Laurent Vivier wrote:
> On 13/11/2020 14:12, Andy Shevchenko wrote:
> > On Fri, Nov 13, 2020 at 2:42 PM Laurent Vivier <lvivier@redhat.com> wrote:
> > 
> > ...
> > 
> >>> If you fix the issue, kindly add following tag as appropriate
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>>
> >>> All errors (new ones prefixed by >>, old ones prefixed by <<):
> >>>
> >>>>> ERROR: modpost: "mac_pton" [drivers/vdpa/vdpa_sim/vdpa_sim.ko] undefined!
> >>
> >> I think something like this might fix the problem.
> > 
> > ...
> > 
> >> +       select NET
> >>         default n
> > 
> > You may also drop 'default n' :-)
> > 
> > But what I want to say is that API is under NET_UTILS, I dunno if the
> > driver requires full NET to be selected. And IIRC NET_UTILS is
> > selected by NET.
> 
> I think GENERIC_NET_UTILS might be enough.

Yes that is ok to select.
But really vdpa sim is a fake ethernet device, nothing
much is lost if it depends on NET too.

> The problem I have for the moment is to find or1k-linux-gcc for my Fedora 33...
> 
> Thanks,
> Laurent

