Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F82E1A4B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgLWJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbgLWJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:05:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608714245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OaC3p3G7D+OAUePrA9tt4mZlNk2KETCOwvVfWCYaUNw=;
        b=SCRHa3Za1aZ79bJxetLUmP+MbIbRrhXCPl1kogGP7gDQZ6U9MO31sS6mIDcqYSenlsmVlP
        GjDNu3K2BIp4BwG/Zbacw9YHmvTvVI1KfT3LQJ+6foKVa78pwPCZpd9SgkeSYDEc6TmitR
        GfZfjC0B6KKwm6JVqvh4l5n93YySup4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-HBCpAXLGNbe2T9I1PhlyFg-1; Wed, 23 Dec 2020 04:04:03 -0500
X-MC-Unique: HBCpAXLGNbe2T9I1PhlyFg-1
Received: by mail-pf1-f200.google.com with SMTP id y2so8226022pfr.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 01:04:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OaC3p3G7D+OAUePrA9tt4mZlNk2KETCOwvVfWCYaUNw=;
        b=eZdSGXU//EPyUvCvJ65WcLfouyEy7luSRPoBm+oBzi4mUCXe9EFUZvbHWszb3/OuEf
         kBmQQX4wao2BIC3jnCt7RNdJOkIGqqTp4/QQtvTlUxptMsaP02/kstsL0MzuCVv/+vQO
         XTmcsDOrFH9jwj+ZyUjmyfdl5A5LSgC4pWokz40xKcLanJ6HdQtWXdwbnea5oCyGpDDp
         EZXObA9IkJWBH59MQbvoKWpxBCCB/nz8SzsoaPgrRA38upKDy8L32+xst7lS9EcZ02PK
         UyT6SoUINypeTpzZdP20nr4OjppEyYcyZIlPIxsESIrCxZ8tMk4O6/G03cNHrqx8LMDK
         HmGw==
X-Gm-Message-State: AOAM5311dtMdEf+kmHBnY9TcNm9XNZoYFTAEXDylu8Sc4vJenab5GcyG
        /SfUTz0BSib29TK2WeTaViMVT+Yh/rlg77//UcVmElMNS83ZPJEoqRDLOKUFbP8WADAAsH0/l1r
        oefCjNtpNStgMTNJM8RaBXFSR
X-Received: by 2002:a17:90a:c085:: with SMTP id o5mr26263187pjs.210.1608714242257;
        Wed, 23 Dec 2020 01:04:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIKfS4YxdIIJVZA9uuysC0+hLnyPpVrMJbFMUBiUUXAj0mYc5Xq/Vqz7vigPuhlVA8c9opkw==
X-Received: by 2002:a17:90a:c085:: with SMTP id o5mr26263176pjs.210.1608714242074;
        Wed, 23 Dec 2020 01:04:02 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b19sm22034409pfo.24.2020.12.23.01.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 01:04:01 -0800 (PST)
Date:   Wed, 23 Dec 2020 17:03:51 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Huang Jianan <huangjianan@oppo.com>, guoweichao@oppo.com,
        linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
Message-ID: <20201223090351.GD1831635@xiangao.remote.csb>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
 <20201222193901.GA1892159@xiangao.remote.csb>
 <20201223074455.GA14729@infradead.org>
 <dc4452e9-83eb-90e7-f001-d39d0ecdd105@oppo.com>
 <20201223085401.GA336@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201223085401.GA336@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 08:54:01AM +0000, Christoph Hellwig wrote:
> On Wed, Dec 23, 2020 at 04:48:20PM +0800, Huang Jianan wrote:
> > Hi Christoph,
> > 
> > The reason we use dio is because we need to deploy the patch on some early
> > kernel versions, and we don't pay much attention to the change of iomap.
> 
> No, that is never an excuse for upstream development.

Ok, personally I also agree this, let's go further in this way.

Thanks,
Gao Xiang

> 

