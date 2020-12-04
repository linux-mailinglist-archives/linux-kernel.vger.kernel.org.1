Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD612CF66A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 22:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgLDVwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 16:52:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbgLDVwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 16:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607118672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xLlTqncBwZwcHkWwNvJzuIr6WcBCoeYcPybWMXBu9Ks=;
        b=VaLB8+uKK1RkhnhSgpt+vKDl/SqNrv/HS6QAUeTEmynWuVR9LU7fdEKchccSEUiPzdM/j+
        v1V2/fiv4Qq/lWgfFHg5ZNU44fjUz6J/D8SeoWAAm1osyA53oRAXXWn6xug3FGSPQerFXE
        Mk9zQDsxopQc2XYN7kHZ2J47CBYOtCE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-lc30WkUmPUyLlrAQ0s93sg-1; Fri, 04 Dec 2020 16:51:09 -0500
X-MC-Unique: lc30WkUmPUyLlrAQ0s93sg-1
Received: by mail-qt1-f199.google.com with SMTP id f33so5844641qtb.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 13:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xLlTqncBwZwcHkWwNvJzuIr6WcBCoeYcPybWMXBu9Ks=;
        b=qMQamVskhpsY5PfbCmuVRt/2q9ClqZQFM+UUp+SrXSpuT55Gj44d3+6zoYNap2r+GO
         s6CWfRhSSwvuVXYoaSh5TqtbKV+KkpubepSqD2CLrESohDdj+kg2G24KAiDMt72rNhQ/
         MeAfCtmi7GZv8IRXXgucs/0nO+MbKXxqPvpDEvEM+GOM+IWX/MmdBSMu5KlQ9kgR8510
         Df7tKMGtvPT39uNWriao7nNI4iC+PMkA4XWyYVYMQahsoZWNvP3O6xrRNKpiLF9i4Dc5
         4mbc1fXYEyv50Epz1Kb6ehhRPK3FJNuF6PRk2g4UCI9K0SCkqhCzQB19EYuIWDk7IS/W
         vz/g==
X-Gm-Message-State: AOAM531GyZFfGLRogHfOjKEzXMz31I5EFYxBnRjeWUIZfJ7mV+GtINH4
        rYx4xTnUExqcaawqxl+3EWrIvduD4+10QRf56mcvrQEMcPXlysO1nzFfV4IEp6PYhT/HfqOHe8A
        CLwC3z7daJqdojnvhHv6UwjW6
X-Received: by 2002:aed:2f64:: with SMTP id l91mr11895051qtd.363.1607118668665;
        Fri, 04 Dec 2020 13:51:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmL3y7OiZ51x7xGIzxhm3KuqMNE96ZPjRd9yq+9AcHjVWyLBlmrQ7/ll36YGACBnBwBdyhFw==
X-Received: by 2002:aed:2f64:: with SMTP id l91mr11895008qtd.363.1607118668388;
        Fri, 04 Dec 2020 13:51:08 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id s30sm2263183qte.44.2020.12.04.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 13:51:07 -0800 (PST)
References: <20201130232338.106892-1-jsnitsel@redhat.com>
 <20201201025807.162241-1-jsnitsel@redhat.com> <87czzujjg1.fsf@redhat.com>
 <878sahmh5w.fsf@redhat.com> <20201202164931.GA91318@kernel.org>
 <87sg8noixh.fsf@redhat.com> <87lfefe7vm.fsf@redhat.com>
 <87ft4mpryt.fsf@redhat.com>
 <8a7d2fda891e45b098b603064d45dd7d53898fd4.camel@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@google.com>,
        "Hans de Goede" <hdegoede@redhat.com>
Subject: Re: [PATCH v2] tpm_tis: Disable interrupts if interrupt storm detected
In-reply-to: <8a7d2fda891e45b098b603064d45dd7d53898fd4.camel@HansenPartnership.com>
Date:   Fri, 04 Dec 2020 14:51:05 -0700
Message-ID: <87czzpw88m.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


James Bottomley @ 2020-12-03 14:05 MST:

> On Thu, 2020-12-03 at 13:14 -0700, Jerry Snitselaar wrote:
>> Jerry Snitselaar @ 2020-12-02 23:11 MST:
> [...]
>> > The interrupt storm detection code works on the T490s. I'm not sure
>> > what is going on with the L490. I will see if I can get access to
>> > one.
>> > 
>> > Jerry
>> 
>> Lenovo verified that the L490 hangs.
>
> Just to confirm, that's this system:
>
> https://www.lenovo.com/us/en/laptops/thinkpad/thinkpad-l/ThinkPad-L490/p/22TP2TBL490
>
> We could ask if lenovo will give us one, but if not we could pull a
> Jens.  [the backstory is that when Jens was doing queueing in the block
> layer, there were lots of SATA devices that didn't work quite right but
> you couldn't tell unless you actually tried them out.  Getting
> manufacturers to send samples is rather arduous, so he took to ordering
> them online, testing them out, and then returning them for a full
> refund within the allowed window]
>
> It looks like Lenovo has a nice christmas returns policy:
>
> https://www.lenovo.com/us/en/shopping-faq/#returns
>
> James

Yes, that is the one. I'm seeing if we have any located somewhere, or if
Lenovo will loan me one. I think for the time being the patch that
disabled interrupts for the T490s could be changed to it for the L490
instead. I'll post a v3 of my current patchset. It would probably make
sense for it to go in with your patches when they land.

