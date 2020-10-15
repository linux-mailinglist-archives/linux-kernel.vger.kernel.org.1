Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B0F28F2F3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgJONMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbgJONMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602767524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAf/KQ6TAdYo1Wm4S00yfTFLig9CeJngAorlemy7WXc=;
        b=AHB1/DTuknTF1tulbY5RCGYT+VPa9xN6UwG5sKlTQdwttoTjx7R4t8tO0sZNVOfqcCYLmB
        W1Ooty3rm76QWLlf3LELxv99D8iI2/y4RPQQBrS5eC/ctSRdRenk/XLnlXZb9Asg4Lv9Xp
        aANtiSH92d17iDFHsk4Co/roSG5r0Uk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-V7xQ4Fh9OEua9Mj1uF9hng-1; Thu, 15 Oct 2020 09:12:00 -0400
X-MC-Unique: V7xQ4Fh9OEua9Mj1uF9hng-1
Received: by mail-wr1-f71.google.com with SMTP id m20so1862102wrb.21
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uAf/KQ6TAdYo1Wm4S00yfTFLig9CeJngAorlemy7WXc=;
        b=H+OrZRTzo2LSruPcpnnNEM3on3N5al30hQ7uMv8A202a4Y3iNGymJSIUfRVhqvDjZW
         drcblyaLYUKt9sD8LtMmC65PJ/qEJy7axITUwe0g5bt1pCqCJafUbRwtZ9Xs7fqcGLZr
         P8ie6O6dURaJQKPD1ujrUnSTl92zA/7PeDh5v3HHoPrEPkQMohhnBRNAn3F3CXxWjdN4
         dBrcE8G9fYpUFWO8G/pAVtSOSDvOTFXEAlwHFXL/8++IgUOxdKlE16rev1xcqzuuTD21
         SHRG5iADndbwhKWkhtU5sm+YgqCYU9vE+R88KqhcWFask+5Yn+DMpPUQaJlU3R022+F/
         o56w==
X-Gm-Message-State: AOAM533WucHeF6eaarnRp0D3ePlbU50ZE0AYFgQ55ZoZRc/LL5qHNCks
        1sjnxQejljHTEKQZ2VlOWObabMu0daj0NQ0C95eivHaRqH1xMBVKOXethN/r43L20ypSCBfEWYc
        a81x5hw1OPW2wyOhbCZUEK6AY
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3896329wmi.135.1602767519257;
        Thu, 15 Oct 2020 06:11:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLn1GAiAp1rVzj+T97VT2N5UZGZv+k9R+BhLp1TRQ1j526UPewTS8smKxID+OGAzZGSt3Z4g==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3896295wmi.135.1602767519019;
        Thu, 15 Oct 2020 06:11:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id y7sm4331656wmg.40.2020.10.15.06.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:11:58 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:11:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     si-wei liu <si-wei.liu@oracle.com>, lingshan.zhu@intel.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vhost-vdpa: fix page pinning leakage in error path
Message-ID: <20201015091150-mutt-send-email-mst@kernel.org>
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
 <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
 <5F863B83.6030204@oracle.com>
 <835e79de-52d9-1d07-71dd-d9bee6b9f62e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <835e79de-52d9-1d07-71dd-d9bee6b9f62e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 02:15:32PM +0800, Jason Wang wrote:
> 
> On 2020/10/14 上午7:42, si-wei liu wrote:
> > > 
> > > 
> > > So what I suggest is to fix the pinning leakage first and do the
> > > possible optimization on top (which is still questionable to me).
> > OK. Unfortunately, this was picked and got merged in upstream. So I will
> > post a follow up patch set to 1) revert the commit to the original
> > __get_free_page() implementation, and 2) fix the accounting and leakage
> > on top. Will it be fine?
> 
> 
> Fine.
> 
> Thanks

Fine by me too.

