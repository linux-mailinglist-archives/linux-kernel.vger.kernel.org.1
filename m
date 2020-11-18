Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8542B86F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgKRVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:43:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgKRVn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605735834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kj+T92G6A6K+o1IZ4t+vCMxhoP7c5ZhdFJiFe+XOOlQ=;
        b=WrRZqOVTiDVXpf8q0RSSRRx49taJbN/qe+CnevSOpA9lwJGKCKzsi7SukEDzfQFcLvRA4K
        DTYlYGyEEktUxhuzpDCJDKoBOJ1Irmu9IHsVFQT41naLiyJOXB54Ne93kKKeTiIqzFEBnv
        njadv9tzbNtbU5KBle63k7i16nVn0B8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-TZFd2_PQMbGsEn_PXJZmzQ-1; Wed, 18 Nov 2020 16:43:52 -0500
X-MC-Unique: TZFd2_PQMbGsEn_PXJZmzQ-1
Received: by mail-ej1-f70.google.com with SMTP id v21so1450123ejy.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kj+T92G6A6K+o1IZ4t+vCMxhoP7c5ZhdFJiFe+XOOlQ=;
        b=EhgAAf5lbeZNaVjIOA5HHGo5Qj+7GrTqTAjUJQ1m1dS+0g2NyldGEJeSpZc4ZMa97t
         D3/59Li7UvKGC4bAXwl4B29yuTeQ1BzS2BfE51oCV6yvTZCzWySjVMSGLJqvthmbIQut
         +RRoYIAQXiuniCcOLVfJNnlGc9rB19lCeXIcpIo8jOCA50JBOvb8bAFfy93nHX0I+Qzr
         gEbz0Wc4dhQF4suv4whVrwSg95J+3f/kKV35AlxaY3sHDW2oyArz3nZj5f7tESnMHAHs
         yGzrt9XxcDVTUXBmd6kogfeVgOxWUQwM9Sjo8qOrADmUt4/4vqKT+7S74wdIWDtnTdUy
         GJkg==
X-Gm-Message-State: AOAM532NbUqa/jMVLE29X/OAAtDvRkLnKstxrNkpLRz74+m/J70mHmkc
        HdplRV+YD39FFvavop8xZ2ZDtVR3GKM8WT6DfAc6SYl/vIO4jNqtHj4pX0249T9bnzWTGoiwc60
        3NAJy78qXOTphiUoPAgvL8qmX
X-Received: by 2002:a17:906:6d13:: with SMTP id m19mr26056410ejr.345.1605735831306;
        Wed, 18 Nov 2020 13:43:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpVTOf712ePIqYNELgIb8+P2/JMA5z4qnKUkPQe6/OfuUT8AvEkwzkF3JEh0SALlmcAFbsSg==
X-Received: by 2002:a17:906:6d13:: with SMTP id m19mr26056392ejr.345.1605735831110;
        Wed, 18 Nov 2020 13:43:51 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id a26sm14131213edt.74.2020.11.18.13.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:43:50 -0800 (PST)
Subject: Re: 5.10 regression, many XHCI swiotlb buffer is full / DMAR: Device
 bounce map failed errors on thunderbolt connected XHCI controller
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com>
Message-ID: <a2dd7f53-aeff-bf4d-67a7-5eb5f809da8b@redhat.com>
Date:   Wed, 18 Nov 2020 22:43:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b046dd04-ac4f-3c69-0602-af810fb1b365@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 11/10/20 12:36 PM, Hans de Goede wrote:
> Hi All,
> 
> Not sure if this is a XHCI driver problem at all, but I needed to start
> somewhere with reporting this so I went with:
> 
> scripts/get_maintainer.pl -f drivers/usb/host/xhci-pci.c
> 
> And added a Cc: linux-pci@vger.kernel.org as bonus.
> 
> I'm seeing the following errors and very slow network performance with
> the USB NIC in a Lenovo Thunderbolt gen 2 dock.
> 
> Note that the USB NIC is connected to the XHCI controller which is
> embedded inside the dock and is connected over thunderbolt!

Ping? This is still happening and although the errors are not fatal,
outgoing network performance is very bad.

I know a lot of Linux users use thunderbolt docks and for some
reason almost all thunderbolt docks seem to be using USB attached
nics inside, so this is going to hit a lot of users if we do not
get this fixed before 5.10 gets released!

Regards,

Hans





> So the errors are:
> 
> [ 1148.744205] swiotlb_tbl_map_single: 6 callbacks suppressed
> [ 1148.744210] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1148.744218] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 16ea@1411c0000 dir 1 --- failed
> [ 1148.744226] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1148.744368] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1148.744375] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 16ea@10aabc000 dir 1 --- failed
> [ 1148.744381] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1148.745141] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1148.745148] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 118e@1411c0000 dir 1 --- failed
> [ 1148.745155] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1148.951282] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1148.951388] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 118e@140988000 dir 1 --- failed
> [ 1148.951420] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1151.013342] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1151.013357] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 1d2a@1411c0000 dir 1 --- failed
> [ 1151.013373] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1151.018660] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 18 (slots)
> [ 1151.018696] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 11da@1411c0000 dir 1 --- failed
> [ 1151.018711] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1151.223022] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1151.223102] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 11da@10aabc000 dir 1 --- failed
> [ 1151.223133] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1151.228810] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1151.228870] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 11da@10aabc000 dir 1 --- failed
> [ 1151.228898] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> [ 1151.234792] xhci_hcd 0000:0a:00.0: swiotlb buffer is full (sz: 8192 bytes), total 32768 (slots), used 16 (slots)
> [ 1151.234852] xhci_hcd 0000:0a:00.0: DMAR: Device bounce map: 11da@10aabc000 dir 1 --- failed
> [ 1151.234882] r8152 4-2.1.2:1.0 ens1u2u1u2: failed tx_urb -11
> 
> etc.
> 
> This happens as soon as I generate any serious amount of outgoing network traffic. E.g. rsyncing files
> to another machine.
> 
> Regards,
> 
> Hans
> 

